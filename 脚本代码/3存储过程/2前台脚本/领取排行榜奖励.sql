----------------------------------------------------------------------
-- 版本：2013
-- 时间：2013-04-22
-- 用途：领取排行榜奖励
----------------------------------------------------------------------
USE [WHQJNativeWebDB]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_RecevieRankingAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_RecevieRankingAward]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_RecevieRankingAward]
	@dwUserID INT,
	@dwDateID INT,
	@dwTypeID INT,
	@strClientIP NVARCHAR(15),
	@strErrorDescribe NVARCHAR(127) OUTPUT	-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
DECLARE @Nullity INT
DECLARE @Diamond INT
DECLARE @Score INT
DECLARE @AwardTicket int
DECLARE @BeforeDiamond BIGINT
DECLARE @BeforeAwardTicket BIGINT
DECLARE @ValidityTime DATETIME
DECLARE @ReceiveState BIT
DECLARE @DateTimeNow DATETIME
DECLARE @BeforeScore BIGINT
DECLARE @BeforeInsureScore BIGINT

-- 执行逻辑
BEGIN
	-- 获取用户信息
	SELECT @Nullity=Nullity FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
	IF @Nullity IS NULL
	BEGIN
		SET @strErrorDescribe =N'抱歉,领取用户不存在'
		RETURN 1001
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe =N'抱歉,领取用户已冻结'
		RETURN 1002
	END
	
	-- 获取用户钻石信息
	SELECT @BeforeDiamond=Diamond,@BeforeAwardTicket=AwardTicket FROM WHQJTreasureDB.dbo.UserCurrency WHERE UserID=@dwUserID
	--获取用户金币信息
	select @BeforeScore=Score ,@BeforeInsureScore=InsureScore from WHQJTreasureDB.dbo.GameScoreInfo where UserID=@dwUserID

	 if @BeforeScore is null
	 BEGIN
		SET @BeforeScore = 0
		INSERT INTO WHQJTreasureDB.dbo.GameScoreInfo(UserID,Score,InsureScore) VALUES(@dwUserID,0,0)
	END

	IF @BeforeDiamond IS NULL
	BEGIN
		SET @BeforeDiamond = 0
		INSERT INTO WHQJTreasureDB.dbo.UserCurrency(UserID,Diamond) VALUES(@dwUserID,0)
	END

	SET @DateTimeNow = GETDATE()

	-- 获取排行榜奖励信息
	SELECT @Diamond=Diamond,@Score=Gold,@ReceiveState=ReceiveState,@AwardTicket=AwardTicket FROM [CacheRankAward] WITH(NOLOCK) WHERE DateID=@dwDateID AND UserID=@dwUserID AND TypeID=@dwTypeID
	IF @Diamond IS NULL
	BEGIN  
		SET @strErrorDescribe =N'抱歉,您暂无排行榜奖励'
		RETURN 1003
	END
	IF @ReceiveState=1
	BEGIN
		SET @strErrorDescribe =N'抱歉,排行榜奖励不能重复领取'
		RETURN 1003
	END
	--IF @ValidityTime< @DateTimeNow
	--BEGIN
	--	SET @strErrorDescribe =N'抱歉,排行榜奖励已过期'
	--	RETURN 1003
	--END

	-- 修改领取状态
	UPDATE [CacheRankAward] SET ReceiveState=1 WHERE DateID=@dwDateID AND UserID=@dwUserID AND TypeID=@dwTypeID
	IF @@ROWCOUNT <= 0
	BEGIN
		SET @strErrorDescribe=N'抱歉,排行榜奖励领取失败！'
		RETURN 6
	END
	if @Score>0
	begin
   --修改领取后金币信息
	 update WHQJTreasureDB.dbo.GameScoreInfo set  Score=Score+@Score WHERE UserID=@dwUserID
   --写入金币流水
   INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
      (SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
    VALUES(dbo.WF_GetSerialNumber(), 0, @dwUserID, 9, @BeforeScore, @BeforeInsureScore, @Score, @strClientIP, GETDATE())
	end
	if @Diamond>0
	begin
	-- 修改领取后钻石信息
	UPDATE WHQJTreasureDB.dbo.UserCurrency SET Diamond=Diamond+@Diamond WHERE UserID=@dwUserID
	
	-- 写入钻石流水记录
	INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
	VALUES(dbo.WF_GetSerialNumber(),0,@dwUserID,5,@BeforeDiamond,@Diamond,@strClientIP,@DateTimeNow)
	end
	if @AwardTicket>0
	begin
	-- 修改领取后奖券信息
	UPDATE WHQJTreasureDB.dbo.UserCurrency SET AwardTicket=AwardTicket+@AwardTicket WHERE UserID=@dwUserID
	
	-- 写入奖券流水记录
	  INSERT INTO WHQJRecordDB.dbo.RecordAwardTicketSerial(SerialNumber,MasterID,UserID,TypeID,CurAwardTicket,ChangeAwardTicket,ClientIP,CollectDate) 
		VALUES(dbo.WF_GetSerialNumber(),0,@dwUserID,3,@BeforeAwardTicket,@AwardTicket,@strClientIP,getdate())
	end

	-- 输出领取后钻石数和金币数 
	SELECT @dwUserID AS UserID,(@BeforeDiamond+@Diamond) AS Diamond,(@BeforeScore+@Score) as Score,(@BeforeAwardTicket+@AwardTicket) as AwardTicket
	SET @strErrorDescribe= N'恭喜您获得'+ CAST(@Diamond AS NVARCHAR(30)) +'钻石'+CAST(@AwardTicket AS NVARCHAR(30))+'奖券'+CAST(@Score AS NVARCHAR(30))+'金币排行奖励'

END
RETURN 0
GO
