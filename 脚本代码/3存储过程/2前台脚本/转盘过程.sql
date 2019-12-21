USE [WHQJTreasureDB]
GO
IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_TurnTable') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_TurnTable
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PW_TurnTable
    @dwUserID			INT,
    -- 操作用户
    @Reward             BIGINT,
    @Score              BIGINT,
    @TableIndex         INT,
    @Open               INT,
    @TableName          NVARCHAR(20),
    --兑换数量
    @strErrorDescribe	NVARCHAR(127) OUTPUT
--	输出信息
WITH
    ENCRYPTION
AS
SET NOCOUNT ON
BEGIN
    IF EXISTS(SELECT 1 FROM GameScoreLocker WHERE UserID=@dwUserID)
    BEGIN
        SET @strErrorDescribe=N'抱歉！游戏中不能启动转盘'
        RETURN 1001
    END

    DECLARE @BeforScore BIGINT
    SELECT @BeforScore=GrandScore FROM UserValidBet WHERE UserID=@dwUserID
    IF @BeforScore<@Score
    BEGIN
        SET @strErrorDescribe=N'抱歉！积分不足'
        RETURN 1002
    END
    UPDATE UserValidBet SET GrandScore=GrandScore-@Score WHERE UserID=@dwUserID
    DECLARE @BeforMoney BIGINT
    DECLARE @BeforeInsure BIGINT
    SELECT @BeforMoney = Score, @BeforeInsure=InsureScore FROM WHQJTreasureDB.DBO.GameScoreInfo(NOLOCK) WHERE UserID = @dwUserID 
    UPDATE GameScoreInfo SET Score = Score + @Reward WHERE UserID = @dwUserID
    --写入转盘记录
    INSERT INTO WHQJRecordDB.dbo.RecordTurntable(UserId,TurntableName,Reward,Score,OpenPos,TableIndex,Opentime)
    VALUES(@dwUserID,@TableName,@Reward,@Score,@Open,@TableIndex,GETDATE())
    --写入流水
	INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
		(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
	VALUES(dbo.WF_GetSerialNumber(), 0, @dwUserID, 13, @BeforMoney, @BeforeInsure, @Reward, '0.0.0.0', GETDATE())
    --增加打码量
    DECLARE @TurnMultiple INT
    SELECT @TurnMultiple=CONVERT(INT,Field9) FROM WHQJNativeWebDB.dbo.ConfigInfo (NOLOCK) WHERE ConfigID=5
    DECLARE @VileBet BIGINT
    SET @VileBet=@TurnMultiple* @Reward
    DECLARE @ErrorDescribe	NVARCHAR(127)
	DECLARE @Return INT
	EXEC @Return=NET_PB_Deposit 5,@dwUserID,1,N'转盘',@VileBet,@ErrorDescribe OUTPUT
END
RETURN 0
GO