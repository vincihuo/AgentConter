USE [WHQJAccountsDB]
GO

----------------------------------------------------------
--绑定手机号
IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_BindPayee') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_BindPayee
GO
SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO
CREATE PROCEDURE NET_PW_BindPayee
    @dwUserID  int,
    ---用户id
    @Type    TINYINT,
    --0支付宝 其他 银行卡
    @Acc    nvarchar(50),
    ---账号
    @strErrorDescribe NVARCHAR(127) OUTPUT
-- 输出信息
as
SET NOCOUNT ON

DECLARE @RelaName NVARCHAR(15)
DECLARE @BankAcc NVARCHAR(32)
DECLARE @AliAcc NVARCHAR(32)
DECLARE @Nullity TINYINT

BEGIN
    SELECT @Nullity=Nullity, @RelaName=Compellation, @BankAcc=BankAccount, @AliAcc=AliAccount
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
    IF @RelaName=N''
    BEGIN
        SET @strErrorDescribe=N'抱歉！先绑定真实姓名！'
        RETURN 1004
    END
    DECLARE @tID INT
    IF @Type=0
    BEGIN
        SELECT @tID=UserID FROM AccountsInfo WHERE AliAccount=@Acc
        IF @tID IS NOT NULL
        BEGIN
            SET @strErrorDescribe=N'抱歉！该支付宝已经被使用！'
            RETURN 2003
        END

        IF @AliAcc!=N''
        BEGIN
            SET @strErrorDescribe=N'抱歉！已经绑定了支付宝账号！'
            RETURN 2001
        END
        UPDATE AccountsInfo SET AliAccount=@Acc WHERE UserID = @dwUserID
        IF @@ROWCOUNT<>1
	    BEGIN
            SET @strErrorDescribe=N'抱歉，绑定异常'
            RETURN 2002
        END
        SET @strErrorDescribe=N'绑定成功11'
        RETURN 0
    END

    IF @BankAcc!=N''
    BEGIN
        SET @strErrorDescribe=N'抱歉！已经绑定了银行卡号！'
        RETURN 2001
    END

    SELECT @tID=UserID FROM AccountsInfo WHERE BankAccount=@Acc
    IF @tID IS NOT NULL
    BEGIN
        SET @strErrorDescribe=N'抱歉！该银行卡已经被使用！'
        RETURN 2003
    END

    PRINT N'到这里的'
    UPDATE AccountsInfo SET BankAccount=@Acc,BankType=@Type WHERE UserID = @dwUserID
    IF @@ROWCOUNT<>1
	BEGIN
        SET @strErrorDescribe=N'抱歉，绑定异常'
        RETURN 2002
    END
    SET @strErrorDescribe=N'绑定成功'
END
RETURN 0
GO