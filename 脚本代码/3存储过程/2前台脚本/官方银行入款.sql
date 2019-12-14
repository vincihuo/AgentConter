USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_CreateBankPayOrder') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_CreateBankPayOrder
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PW_CreateBankPayOrder
    @dwUserID			INT,
    -- 操作用户
    @cfgID              INT,
    -- 配置ID
    @Number             NVARCHAR(50),
    -- 收款账户
    @amount             BIGINT,
    -- 充值金额
    @payName            NVARCHAR(20),
    -- 存款姓名
    @payBank            NVARCHAR(50),
    -- 存款银行
    @TransferType		TINYINT,
    -- 转账类型
    @strOrderID			NVARCHAR(32),
    -- 订单标识
    @strErrorDescribe	NVARCHAR(127) OUTPUT
-- 输出信息
WITH
    ENCRYPTION
AS

SET NOCOUNT ON

-- 帐号资料
DECLARE @Accounts NVARCHAR(31)
DECLARE @NickName NVARCHAR(31)
DECLARE @UserID INT
DECLARE @GameID INT
DECLARE @SpreaderID INT
DECLARE @Nullity TINYINT

BEGIN
    -- 获取用户信息
    SELECT @UserID=UserID, @SpreaderID=SpreaderID, @Accounts=Accounts, @NickName=NickName, @Nullity=Nullity, @GameID=GameID
    FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK)
    WHERE UserID = @dwUserID
    IF @UserID IS NULL
	BEGIN
        SET @strErrorDescribe=N'抱歉，存款用户不存在'
        RETURN 2006
    END
    IF @Nullity=1
	BEGIN
        SET @strErrorDescribe=N'抱歉，存款用户已经禁用'
        RETURN 2007
    END

    DECLARE @OrderID NVARCHAR(32)
    SELECT @OrderID=OrderID FROM BankPayOrder WITH(NOLOCK) WHERE OrderID = @strOrderID
    IF @OrderID IS NOT NULL
	BEGIN
        SET @strErrorDescribe=N'抱歉，订单重复'
        RETURN 2005
    END
    --查询入款配置

    DECLARE @MinAmount BIGINT
    DECLARE @MaxAmount BIGINT
    DECLARE @PresentScore BIGINT
    SELECT @MinAmount=MinAmount,@MaxAmount=MaxAmount,@PresentScore=PresentScore FROM OfficalBankPay WHERE id=@cfgID AND BankNumber=@Number
    IF @MinAmount IS NULL
    BEGIN
        SET @strErrorDescribe=N'抱歉，存款配置不存在或者已经修改'
        RETURN 2006
    END

    IF @MinAmount>@amount
    BEGIN
        SET @strErrorDescribe=N'抱歉，存款不在限额之内'
        RETURN 2007
    END

    IF @MaxAmount<@amount
    BEGIN
        SET @strErrorDescribe=N'抱歉，存款不在限额之内'
        RETURN 2007
    END
    --写入订单
    INSERT INTO BankPayOrder (OrderID,GameId,UserId,NickName,Amount,PresentScore,Payee,OrderStates,PayName,PayBank,TransferType,PayTime)
    VALUES(@strOrderID,@GameID,@UserID,@NickName,@amount,@PresentScore*@amount/100,@Number,0,@payName,@payBank,@TransferType,GETDATE())
    IF @@ROWCOUNT<>1
	BEGIN
        SET @strErrorDescribe=N'抱歉，写入订单失败'
        RETURN 2008
    END
END
RETURN 0
GO