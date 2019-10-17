----------------------------------------------------------------------------------------------------
USE [WHQJNativeWebDB]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].PW_TimesReward') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].PW_TimesReward
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

/*每天领取奖励*/
/*
DayShareLmt INT ,--每日分享次数限制
TimeShareGold INT  ,--每次分享成功的金币奖励
TimeShareDiamond INT  ,--每次分享成功的钻石奖励
*/
/*-1失败0已超当日限制1领取成功*/
CREATE PROC [dbo].[PW_TimesReward]
    @userid NVARCHAR(10) ,
	@strClientIP NVARCHAR(120)
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

    DECLARE @result SMALLINT --返回结果
    DECLARE @cnt INT --已分享次数
    DECLARE @DayShareLmt INT 
    DECLARE @TimeShareGold INT 
    DECLARE @TimeShareDiamond INT 
    DECLARE @StartMoney BIGINT	--变化前玩家的金币总数
    DECLARE @StartInsureScore BIGINT	--变化前玩家的银行金币总数
	DECLARE @StartDiamond BIGINT ---变化前玩家的钻石数
	DECLARE @Dateid int ---

    DECLARE @Gameid int
    SET @result = -1  

    SELECT  @Gameid = Gameid,@UserID=UserID
    FROM    [WHQJAccountsDB].dbo.AccountsInfo
    WHERE   UserID = @userid

    SELECT  @StartMoney = Score,@StartInsureScore= InsureScore
    FROM    [WHQJTreasureDB].dbo.GameScoreInfo
    WHERE   UserID = @userid
	if @StartMoney is null
	  begin
	 insert into [WHQJTreasureDB].dbo.GameScoreInfo(UserID,Score,InsureScore) values(@UserID,0,0)
	 set @StartMoney=0
	 set @StartInsureScore=0
	 end
	  SELECT  @StartDiamond = Diamond 
    FROM    [WHQJTreasureDB].dbo.UserCurrency
    WHERE   UserID = @userid
	if @StartDiamond is null
	   begin
	  insert into [WHQJTreasureDB].dbo.UserCurrency(UserID,Diamond,AwardTicket) values(@UserID,0,0)
	  set @StartDiamond=0
	  end
	  ---获取分享配置
    SELECT  @DayShareLmt = DayShareLmt ,
            @TimeShareGold = TimeShareGold ,
			@TimeShareDiamond = TimeShareDiamond 
    FROM    ShareConfig
    WHERE   ID = 1 and Nullity=0

	set @Dateid= CAST(CAST(getdate() AS FLOAT) AS INT)


    BEGIN 
        SELECT  @cnt = COUNT(*)
        FROM    ShareLog
        WHERE   UserID = @userid
                AND DateID = @Dateid
              
        IF   @cnt < @DayShareLmt and @TimeShareGold is not null
            BEGIN 
/*插入系统日志*/
                INSERT  INTO [dbo].[ShareLog]
                        ( [UserID] ,
                          [DateID] ,
                          [Remark] ,
                          [LogTime],
						  TimeShareGold,
						  TimeShareDiamond
                        )
                VALUES  ( @userid ,
                          @Dateid ,
                          '每日分享' ,
                          GETDATE(),
						  @TimeShareGold,
						  @TimeShareDiamond
                        )
    /*金币变化日志*/
    --更新金币
	        if @TimeShareGold>0
			   begin
                UPDATE  WHQJTreasureDB.dbo.GameScoreInfo
                 SET    Score = Score + @TimeShareGold
                WHERE   UserID = @UserID
				--插入金币变化日志
				 -- 写入金币流水记录
    INSERT INTO  [WHQJRecordDB].dbo.RecordTreasureSerial
      (SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
    VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 13, @StartMoney, @StartInsureScore, @TimeShareGold, @strClientIP, getdate())
				end
				--更新钻石
	         if @TimeShareDiamond>0
			    begin
				     UPDATE  WHQJTreasureDB.dbo.UserCurrency
                 SET    Diamond = Diamond + @TimeShareDiamond
                WHERE   UserID = @UserID
				 --插入钻石记录
				  -- 写入钻石流水记录
     INSERT INTO [WHQJRecordDB].dbo.RecordDiamondSerial
      (SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
    VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 15, @StartDiamond, @TimeShareDiamond, @strClientIP, getdate())
				 end
               
	
                SET @result = 1
            END
        ELSE 
            BEGIN
                SET @result = 0
            END        
    END
    SELECT  @result rst,@TimeShareDiamond as TimeShareDiamond,@TimeShareGold as TimeShareGold

GO


