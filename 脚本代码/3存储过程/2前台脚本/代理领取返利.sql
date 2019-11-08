USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_GetReward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_GetReward]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

CREATE PROC [NET_PJ_GetReward]
    (
    @dwUserID			INT,
    --领取id
    @strErrorDescribe NVARCHAR(127) OUTPUT
)
WITH
    ENCRYPTION
AS

DECLARE @Nullity TINYINT
DECLARE @Reward BIGINT

DECLARE @CurScore BIGINT
DECLARE @CurInsureScore BIGINT
DECLARE @RegisterIP NVARCHAR(15)
DECLARE @RegisterDate DATETIME
DECLARE @RegisterMachine NVARCHAR(32)

SET NOCOUNT ON
BEGIN
    SELECT @Nullity=Nullity, @RegisterIP=RegisterIP, @RegisterDate=RegisterDate, @RegisterMachine=RegisterMachine
	FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK)
	WHERE UserID = @dwUserID
    IF @Nullity IS NULL
	BEGIN
        SET @strErrorDescribe=N'账号不存在'
        RETURN 1001
    END
    IF @Nullity=1
	BEGIN
        SET @strErrorDescribe=N'账号被冻结'
        RETURN 1002
    END

    SELECT @Reward=Reward FROM AgentInfo WHERE UserID=@dwUserID
    IF @Reward<1000
    BEGIN
        SET @strErrorDescribe=N'多余一元奖励才能领取'
        RETURN 2001
    END
    SELECT @CurScore=Score,@CurInsureScore=InsureScore FROM GameScoreInfo WHERE UserID = @dwUserID

    IF @CurScore IS NULL 
	BEGIN
		INSERT GameScoreInfo
			(UserID,Score,RegisterIP,RegisterDate,RegisterMachine)
		VALUES
			(@dwUserID, 0, @RegisterIP, @RegisterDate, @RegisterMachine)
		SET @CurScore = 0
		SET @CurInsureScore =0
	END

    BEGIN TRAN
    UPDATE AgentInfo SET Reward=0,AllReward=AllReward+@Reward WHERE UserID = @dwUserID
    UPDATE GameScoreInfo SET InsureScore=InsureScore+@Reward WHERE UserID = @dwUserID

    INSERT WHQJRecordDB.dbo.RecordAgentReward (UserID,GetMoney,BeforeMoney,drawalTime)
    VALUES(@dwUserID,@Reward,@CurInsureScore,GETDATE())

    INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
		(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
	VALUES(dbo.WF_GetSerialNumber(), 0, @dwUserID, 13, @CurScore, @CurInsureScore, @Reward, '0.0.0.0', GETDATE())
    IF @@Error > 0 
    BEGIN
        ROLLBACK TRAN
        SET @strErrorDescribe=N'领取失败稍后再试'
        RETURN 3001
    END
    COMMIT TRAN
	SET @strErrorDescribe=N'领取成功'
END
RETURN 0
GO
