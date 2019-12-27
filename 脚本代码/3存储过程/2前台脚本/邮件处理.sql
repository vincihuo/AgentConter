USE [WHQJPlatformDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_DealMail') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_DealMail
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PW_DealMail
    @dwUserID			INT,
    @mId                INT,
    @state		        TINYINT,
    @strErrorDescribe	NVARCHAR(127) OUTPUT
-- 输出信息
WITH
    ENCRYPTION
AS
SET NOCOUNT ON

DECLARE @mState          TINYINT
DECLARE @GoldNum         BIGINT
DECLARE @DimaoNum        INT
DECLARE @Multiple        INT
DECLARE @RegisterIP      NVARCHAR(15)
DECLARE @RegisterDate    DATETIME
DECLARE @RegisterMachine NVARCHAR(32)

BEGIN
    SELECT @mState=MState, @GoldNum=GoldNum, @DimaoNum=DiamNum, @Multiple=Valibet
    FROM UserMail
    WHERE UserID=@dwUserID AND id=@mId
    IF @mState IS NULL
    BEGIN
        SET @strErrorDescribe='邮件不存在'
        RETURN 1001
    END
    IF @mState>1
    BEGIN
        SET @strErrorDescribe='邮件已经删除'
        RETURN 1002
    END

    DECLARE @CheckOut TINYINT
    IF EXISTS(SELECT 1
    FROM WHQJTreasureDB.dbo.GameScoreLocker
    WHERE UserID=@dwUserID)
    BEGIN
        SET @strErrorDescribe='游戏中不能领取'
        RETURN 1003
    END
    IF @mState=0
    BEGIN
        SELECT @RegisterIP=RegisterIP, @RegisterDate=RegisterDate, @RegisterMachine=RegisterMachine
        FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK)
        WHERE UserID = @dwUserID
        IF @GoldNum>0
    BEGIN
            DECLARE @BeforeScore BIGINT
            DECLARE @BeforeInsure BIGINT
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
            UPDATE WHQJTreasureDB.DBO.GameScoreInfo SET Score=Score+@GoldNum WHERE UserID = @dwUserID
            INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
                (SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
            VALUES(dbo.WF_GetSerialNumber(), 0, @dwUserID, 15, @BeforeScore, @BeforeInsure, @GoldNum, '0.0.0.0', GETDATE())
            --打码量
            IF @Multiple>0
        BEGIN
                DECLARE @ErrorDescribe	NVARCHAR(127)
                DECLARE @Return INT
                DECLARE @Valibet BIGINT
                SET @Valibet=@Multiple*@GoldNum
                EXEC @Return=WHQJTreasureDB.DBO.NET_PB_Deposit 9,@dwUserID,1,'邮件',@Valibet,@ErrorDescribe OUTPUT
            END
        END

        IF @DimaoNum>0
    BEGIN
            DECLARE @BeforeDiamond   INT
            SELECT @BeforeDiamond=Diamond
            FROM WHQJTreasureDB.DBO.UserCurrency WITH(ROWLOCK)
            WHERE UserID=@dwUserID
            IF @BeforeDiamond IS NULL
	    BEGIN
                INSERT WHQJTreasureDB.DBO.UserCurrency
                    (UserID,Diamond,AwardTicket)
                VALUES
                    (@dwUserID, 0, 0)
                SET @BeforeDiamond=0
            END
            UPDATE WHQJTreasureDB.DBO.UserCurrency SET Diamond = Diamond + @DimaoNum WHERE UserID = @dwUserID

            INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial
                (SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
            VALUES(dbo.WF_GetSerialNumber(), 0, @dwUserID, 13, @BeforeDiamond, @DimaoNum, '0.0.0.0', GETDATE())
        END
    END
    UPDATE UserMail SET MState=@state WHERE UserID=@dwUserID AND id=@mId
    SET @strErrorDescribe='操作成功'
END
RETURN 0
GO