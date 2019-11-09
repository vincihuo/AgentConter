USE [WHQJAccountsDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].PW_MbileAccountBind') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].PW_MbileAccountBind
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
CREATE PROCEDURE PW_MbileAccountBind
    @dwUserid  int,
    ---用户id
    @Accounts nvarchar(20),
    ---手机号
    @Code    nvarchar(10),
    ---验证码
    @Password nvarchar(32),
    -- 密码
    @strErrorDescribe NVARCHAR(127) OUTPUT
-- 输出信息
as
-- 属性设置
SET NOCOUNT ON
DECLARE @createtime datetime---验证码插入时间
DECLARE @OldPass nvarchar(32)
DECLARE @UserID INT
DECLARE @intervaltime INT
DECLARE @config INT

BEGIN
    SELECT @config=CONVERT(INT,Field7) FROM WHQJNativeWebDB.dbo.ConfigInfo WHERE ConfigID=1

    SELECT @OldPass=LogonPass, @UserID=UserID FROM AccountsInfo WHERE UserID=@dwUserid
    IF @UserID IS NULL
    BEGIN
        SET @strErrorDescribe=N'账号不存在'
        RETURN 1002
    END
    IF @OldPass <> NULL
    BEGIN
        SET @strErrorDescribe=N'已经是正式账号'
        RETURN 1003
    END
    IF @config=0
    BEGIN
        UPDATE AccountsInfo SET LogonPass=@Password,Accounts=@Accounts WHERE UserID=@dwUserid
    END
    ELSE IF @config=1
    BEGIN
        SELECT @createtime=CollectTime
        FROM dbo.CheckCode WHERE PhoneNum=@Accounts and CheckCode=@Code
        SET @intervaltime=DATEDIFF(ss,@createtime,getdate());
        IF 60<@intervaltime
        BEGIN
            SET @strErrorDescribe=N'验证码过期'
            RETURN 1001
        END
        UPDATE AccountsInfo SET LogonPass=@Password,Accounts=@Accounts,RegisterMobile=@Accounts WHERE UserID=@dwUserid
    END
END
RETURN 0
GO