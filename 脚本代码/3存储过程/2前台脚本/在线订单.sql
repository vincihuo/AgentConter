----------------------------------------------------------------------
-- 版权：2017
-- 时间：2017-04-27
-- 用途：在线订单
----------------------------------------------------------------------

USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_CreateOnLineOrder') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_CreateOnLineOrder
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

----------------------------------------------------------------------------------
-- 申请订单
CREATE PROCEDURE NET_PW_CreateOnLineOrder
	@dwUserID			INT,						-- 操作用户
	@payType			INT,						-- 充值类型
	@payChanle          INT,                        -- 充值渠道
	@amount             DECIMAL(18,2),              -- 充值金额
	@present            DECIMAL(18,2),              -- 优惠
	@strOrderID			NVARCHAR(32),				-- 订单标识
	@strIPAddress		NVARCHAR(15),				-- 支付地址
	@errCode	        INT OUTPUT		-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 帐号资料
DECLARE @Accounts NVARCHAR(31)
DECLARE @NickName NVARCHAR(31)
DECLARE @UserID INT
DECLARE @GameID INT
DECLARE @SpreaderID INT
DECLARE @Nullity TINYINT

-- 执行逻辑
BEGIN
	SET @errCode=0
	-- 获取用户信息
	SELECT @UserID=UserID,@SpreaderID=SpreaderID,@Accounts=Accounts,@NickName=NickName,@Nullity=Nullity,@GameID=GameID FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID = @dwUserID
	IF @UserID IS NULL
	BEGIN
		SET @errCode=2006
		RETURN 2006
	END
	IF @Nullity=1
	BEGIN
		SET @errCode=2007
		RETURN 2007
	END
	-- 订单重复验证
	DECLARE @OrderID NVARCHAR(32)
	SELECT @OrderID=OrderID FROM OnlinePayOrder WITH(NOLOCK) WHERE OrderID = @strOrderID
	IF @OrderID IS NOT NULL
	BEGIN
		SET @errCode=2005
		RETURN 2005
	END

	-- 写入订单信息
	INSERT INTO OnlinePayOrder(OrderID,GameId,UserId,NickName,Amount,PresentScore,ChannelId,PayType,OrderStates,MasterId,PayTime,Addrstr)
	VALUES(@strOrderID,@GameID,@UserID,@NickName,@amount,@present,@payChanle,@PayType,0,0, GETDATE(),@strIPAddress)
	IF @@ROWCOUNT<>1
	  BEGIN
        SET @errCode=1003
        RETURN 1003
       END
	SET @errCode=1
END
RETURN 0
GO