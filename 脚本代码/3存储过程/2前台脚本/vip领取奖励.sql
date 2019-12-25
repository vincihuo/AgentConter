USE [WHQJTreasureDB]
GO
IF EXISTS (SELECT *FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetVipReward') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetVipReward
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PW_GetVipReward
    @dwUserID			INT,
    -- 操作用户
    @Type               INT,
    @Ip                 NVARCHAR(15),
    @Reward             BIGINT OUTPUT,
    @strErrorDescribe	NVARCHAR(127) OUTPUT
    -- 输出信息
WITH
    ENCRYPTION
AS
SET NOCOUNT ON

DECLARE @Fresh       BIGINT
DECLARE @Week        BIGINT
DECLARE @Month       BIGINT
DECLARE @Day         BIGINT
DECLARE @VipLevel    INT
DECLARE @LastTime    DATE
DECLARE @DayIndex    INT

DECLARE @RecordType  INT
BEGIN
    SET @Reward=0
    SELECT @VipLevel=VipLevel,@LastTime=LastTime,@DayIndex=DayIndex,@Fresh=FreshReward,@Week=WeekReward,@Month=MonthReward,@Day=CheckInReward FROM UserVipInfo WHERE UserID=@dwUserID
    IF @VipLevel IS NULL
    BEGIN
    SET @strErrorDescribe=N'没有奖励可以领取！'
    RETURN 100
    END

    IF EXISTS(SELECT 1 FROM GameScoreLocker WHERE UserID=@dwUserID)
    BEGIN
        SET @strErrorDescribe=N'游戏中不能领取奖励！'
        RETURN 1011
    END

    --领取晋级奖励
    SET @RecordType=@Type
    IF @Type>10
    BEGIN
        DECLARE @LevelIndex    INT
        SET @LevelIndex=@Type-10
        IF @Fresh&POWER(2,@LevelIndex)>0
        BEGIN
            UPDATE UserVipInfo SET FreshReward=FreshReward-POWER(2,@LevelIndex) WHERE UserID=@dwUserID
            SELECT @Reward=Fresh FROM  WHQJPlatformDB.dbo.VipConfig WHERE VipLevel=@LevelIndex
        END
        ELSE
        BEGIN
            SET @strErrorDescribe=N'没有奖励可以领取！'
            RETURN 1001
        END
        SET @RecordType=1
    END
    --周奖励
    IF @Type=2
    BEGIN
        IF @Week=0
        BEGIN
        SET @strErrorDescribe=N'没有奖励可以领取！'
        RETURN 102
        END
        UPDATE UserVipInfo SET WeekReward=0 WHERE UserID=@dwUserID
        SET @Reward=@Week 
    END
    --月奖励
    IF @Type=3
    BEGIN
        IF @Month=0
        BEGIN
        SET @strErrorDescribe=N'没有奖励可以领取！'
        RETURN 103
        END
        UPDATE UserVipInfo SET MonthReward=0 WHERE UserID=@dwUserID
        SET @Reward=@Month
    END
    
    --签到奖励
    IF @Day=3
    BEGIN
        IF @Day=0
        BEGIN
        SET @strErrorDescribe=N'没有奖励可以领取！'
        RETURN 104
        END

        IF DATEDIFF(dd,@LastTime,GETDATE())>1
        BEGIN
            SET @DayIndex=1
        END 
        ELSE
        BEGIN
            SET @DayIndex=@DayIndex+1
            IF @DayIndex>7
            BEGIN
                SET @DayIndex=1
            END
        END
        UPDATE UserVipInfo SET CheckInReward=0,DayIndex=@DayIndex WHERE UserID=@dwUserID
        DECLARE @DayReward BIGINT
        DECLARE @cSql NVARCHAR(1000)
        SET @cSql='SELECT @DayReward= Day'+@DayIndex+' FROM  WHQJPlatformDB.dbo.VipConfig WHERE VipLevel='+@VipLevel
        EXECUTE sp_executesql @cSql,N'@DayReward int out',@DayReward OUT
        SET @Reward=@DayReward
        IF @Reward=0
        BEGIN
        SET @strErrorDescribe=N'没有奖励可以领取！'
        RETURN 1041
        END
        SET @RecordType=@DayIndex+3
    END
    SET @Reward=@Reward*1000
    IF @Reward=0
    BEGIN
        SET @strErrorDescribe=N'没有奖励奖励！'
        RETURN 101
    END


    --加钱
    DECLARE @BeforeScore BIGINT
    DECLARE @BeforeInsure BIGINT
    SELECT @BeforeScore = Score, @BeforeInsure=InsureScore FROM GameScoreInfo(NOLOCK) WHERE UserID = @dwUserID
    UPDATE GameScoreInfo SET Score=@Reward+Score
    --写入流水
    INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
		(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
	VALUES(dbo.WF_GetSerialNumber(), 0, @dwUserID, 17, @BeforeScore, @BeforeInsure,@Reward, @Ip, GETDATE())
    --打码量
    DECLARE @Multiple INT
    DECLARE @Valibet INT

    SELECT  @Multiple=CONVERT(INT,Field10) FROM WHQJNativeWebDB.dbo.ConfigInfo (NOLOCK) WHERE ConfigID=5
    DECLARE @ErrorDescribe	NVARCHAR(127)
	DECLARE @Return INT
    SET @Valibet=@Multiple*@Reward
	EXEC @Return=NET_PB_Deposit 10,@dwUserID,1,'vip奖励',@Valibet,@ErrorDescribe OUTPUT

    --写入领取记录
    INSERT INTO WHQJRecordDB.dbo.RecordVIPReward(UserID,VIPLevel,RewardType,TackTime,Reward,BeForeScore,IP)
    VALUES(@dwUserID,@VipLevel,@RecordType,GETDATE(),@Reward,@BeforeScore+@BeforeInsure,@Ip)
END
RETURN 0
GO