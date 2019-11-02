USE [WHQJTreasureDB]
GO
IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GoldExchangeDiamond') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GoldExchangeDiamond
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PW_GoldExchangeDiamond
    @dwUserID			INT,
    -- 操作用户
    @Number             INT,
    --兑换数量
    @strErrorDescribe	NVARCHAR(127) OUTPUT
--	输出信息
WITH
    ENCRYPTION
AS
SET NOCOUNT ON
--账号信息
DECLARE @Nullity TINYINT
DECLARE @BeforeScore BIGINT
DECLARE @BeforeInsure BIGINT
DECLARE @BeforeDiamond BIGINT

DECLARE @RegisterIP NVARCHAR(15)
DECLARE @RegisterDate DATETIME
DECLARE @RegisterMachine NVARCHAR(32)
DECLARE @DateTime DATETIME

BEGIN
    SELECT @Nullity=Nullity, @RegisterIP=RegisterIP, @RegisterDate=RegisterDate, @RegisterMachine=RegisterMachine
    FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK)
    WHERE UserID = @dwUserID
    IF @Nullity IS NULL
	BEGIN
        SET @strErrorDescribe=N'抱歉！账号不存在！'
        RETURN 1004
    END
    IF @Nullity=1
	BEGIN
        SET @strErrorDescribe=N'抱歉！账号已冻结状态！'
        RETURN 1005
    END

    IF EXISTS(SELECT 1
    FROM GameScoreLocker
    WHERE UserID=@dwUserID) 
	BEGIN
        SET @strErrorDescribe=N'购买时请离开游戏房间'
        RETURN 1003
    END
    
    DECLARE @Cost BIGINT
    SET @Cost = @Number*1000

    --获取用户金额
    SELECT @BeforeScore = Score, @BeforeInsure=InsureScore
    FROM WHQJTreasureDB.DBO.GameScoreInfo(NOLOCK)
    WHERE UserID = @dwUserID
    IF @BeforeScore IS NULL 
	BEGIN
        INSERT WHQJTreasureDB.DBO.GameScoreInfo
            (UserID,Score,RegisterIP,RegisterDate,RegisterMachine)
        VALUES
            (@dwUserID, 0, @RegisterIP, @RegisterDate, @RegisterMachine)
        SET @BeforeScore = 0
        SET @BeforeInsure =0
    END

    IF @Cost>@BeforeScore
    BEGIN
        SET @strErrorDescribe=N'抱歉！金币不足！'
        RETURN 1006
    END

    SELECT @BeforeDiamond=Diamond
    FROM UserCurrency WITH(ROWLOCK)
    WHERE UserID=@dwUserID
    IF @BeforeDiamond IS NULL
	BEGIN
        INSERT WHQJTreasureDB.DBO.UserCurrency
            (UserID,Diamond,AwardTicket)
        VALUES
            (@dwUserID, 0, 0)
        SET @BeforeDiamond=0
    END

    BEGIN TRAN
    --减金币
    UPDATE GameScoreInfo SET Score = Score - @Cost WHERE UserID = @dwUserID
    IF @@ROWCOUNT<>1
	BEGIN
        SET @strErrorDescribe=N'抱歉，购买异常，请稍后重试'
        ROLLBACK TRAN
        RETURN 2003
    END
    --加钻石
    UPDATE [UserCurrency] SET Diamond = Diamond + @Number WHERE UserID = @dwUserID
    IF @@ROWCOUNT<=0
	BEGIN
        SET @strErrorDescribe=N'抱歉，购买异常，请稍后重试'
        ROLLBACK TRAN
        RETURN 2004
    END
    --写兑换记录
    INSERT INTO WHQJRecordDB.DBO.RecordCurrencyExch
        (UserID,TypeID,CurDiamond,ExchDiamond,CurScore,CurInsureScore,PresentGold,ClientIP,CollectDate)
    VALUES(@dwUserID, 0, @BeforeDiamond, @Number, @BeforeScore, @BeforeInsure, 0, '0.0.0.0', GETDATE())
    IF @@ROWCOUNT<=0
	BEGIN
        SET @strErrorDescribe=N'抱歉，购买异常，请稍后重试'
        ROLLBACK TRAN
        RETURN 2005
    END
    --写钻石记录
    INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial
        (SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
    VALUES(dbo.WF_GetSerialNumber(), 0, @dwUserID, 12, @BeforeDiamond, @Number, '0.0.0.0', GETDATE())
    IF @@ROWCOUNT<=0
	BEGIN
        SET @strErrorDescribe=N'抱歉，购买异常，请稍后重试'
        ROLLBACK TRAN
        RETURN 2006
    END
    --金币流水
    INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
        (SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
    VALUES(dbo.WF_GetSerialNumber(), 0, @dwUserID, 5, @BeforeScore, @BeforeInsure, -@Cost, '0.0.0.0', GETDATE())
    IF @@ROWCOUNT<=0
	BEGIN
        SET @strErrorDescribe=N'抱歉，购买异常，请稍后重试'
        ROLLBACK TRAN
        RETURN 2007
    END
    --修改打码量
    DECLARE @TVileBet BIGINT
    DECLARE @CVileBet BIGINT
    DECLARE @Spli BIGINT
    SELECT @TVileBet=TargetBet, @CVileBet=CurrentValidBet
    FROM UserValidBet
    WHERE UserID=@dwUserID
    IF @TVileBet IS NULL
    BEGIN
        INSERT INTO UserValidBet
            (UserID)
        VALUES(@dwUserID)
        SET @TVileBet =0
        SET @CVileBet =0
    END
    SET @Spli=0
    SET @CVileBet+=@Cost
    IF @CVileBet>@TVileBet
    BEGIN
        SET @Spli=@CVileBet-@TVileBet
        SET @CVileBet=@TVileBet
    END
    UPDATE UserValidBet SET CurrentValidBet=@CVileBet,TargetBet=@TVileBet,SpillBet=SpillBet+@Spli WHERE UserID=@dwUserID
    COMMIT TRAN
END
RETURN 0
GO