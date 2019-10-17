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
	@dwShareID			INT,						-- 服务类型
	@dwConfigID			INT,						-- 充值标识
	@strOrderID			NVARCHAR(32),				-- 订单标识
	@strDevice			NVARCHAR(32),				-- 产品渠道
	@strIPAddress		NVARCHAR(15),				-- 支付地址
	@strErrorDescribe	NVARCHAR(127) OUTPUT		-- 输出信息
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

-- 配置信息
DECLARE @ConfigID INT
DECLARE @BindSpread INT
DECLARE @PayChannel INT

-- 订单信息
DECLARE @OrderID NVARCHAR(32)
DECLARE @Amount DECIMAL(18,2)
DECLARE @ScoreType TINYINT
DECLARE @Score INT
DECLARE @PresentScore INT
DECLARE @FristPresent INT
DECLARE @OtherPresent INT
DECLARE @PayIdentity TINYINT
DECLARE @PayType TINYINT
DECLARE @CurrentTime DATETIME
DECLARE @STime NVARCHAR(10)
DECLARE @StartTime NVARCHAR(20)
DECLARE @EndTime NVARCHAR(20)

-- 执行逻辑
BEGIN
	-- 充值渠道验证
	SELECT @PayChannel=StatusValue FROM WHQJAccountsDB.dbo.SystemStatusInfo WITH(NOLOCK) WHERE StatusName = N'JJPayChannel'
	IF @PayChannel IS NULL OR @PayChannel=0
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值渠道未开放！'
		RETURN 2003
	END
	IF @PayChannel=1 AND @dwShareID>=200
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值渠道未开放！'
		RETURN 2003
	END
	IF @PayChannel=2 AND @dwShareID<200 AND @dwShareID>=300
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值渠道未开放！'
		RETURN 2003
	END
  IF @PayChannel=4 AND @dwShareID<300
  BEGIN
		SET @strErrorDescribe=N'抱歉！充值渠道未开放！'
		RETURN 2003
	END

	-- 充值配置验证
	SELECT @ConfigID=ConfigID,@Amount=PayPrice,@ScoreType=ScoreType,@Score=Score,@FristPresent=FristPresent,@PresentScore=PresentScore,@PayIdentity=PayIdentity,@PayType=PayType FROM AppPayConfig WHERE ConfigID = @dwConfigID
	IF @ConfigID IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值产品不存在！'
		RETURN 2004
	END
	IF @Amount <= 0 OR @Score <=0
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值产品配置异常！'
		RETURN 2004
	END
	
	-- 获取用户信息
	SELECT @UserID=UserID,@SpreaderID=SpreaderID,@Accounts=Accounts,@NickName=NickName,@Nullity=Nullity,@GameID=GameID FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID = @dwUserID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值账号不存在！'
		RETURN 2006
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值账号已冻结状态！'
		RETURN 2007
	END

	--时间计算
	SELECT @CurrentTime = GETDATE()
	SET @STime = Convert(CHAR(10),@CurrentTime,120)
	SET @StartTime = @STime + N' 00:00:00'
	SET @EndTime = @STime + N' 23:59:59'

	-- 普通赠送
	SET @OtherPresent = 0

	-- 账户按类型首充
	IF NOT EXISTS(SELECT OnLineID FROM OnLinePayOrder WHERE UserID=@UserID AND ConfigID=@ConfigID AND OrderStatus>0) and @PayIdentity=1
	BEGIN
		SET @OtherPresent = @FristPresent
	END
	--每日首充
	IF NOT EXISTS(SELECT OnLineID FROM OnLinePayOrder WHERE UserID=@UserID AND ConfigID=@ConfigID AND OrderStatus>0 AND OrderDate BETWEEN @StartTime AND @EndTime ) and @PayIdentity=2
	BEGIN
		SET @OtherPresent = @FristPresent
	END

	-- 订单重复验证
	SELECT @OrderID=OrderID FROM OnLinePayOrder WITH(NOLOCK) WHERE OrderID = @strOrderID
	IF @OrderID IS NOT NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值繁忙,请稍后重新充值！'
		RETURN 2005
	END

	

	-- 充值推广验证
  --IF @strDevice = ''
  --BEGIN
  --  SELECT @BindSpread=StatusValue FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.SystemStatusInfo WITH(NOLOCK) WHERE StatusName = N'JJPayBindSpread'
  --  IF @SpreaderID<=0 AND @BindSpread=0
  --  BEGIN
  --    SET @strErrorDescribe=N'抱歉！充值账号未绑定推广人！'
  --    RETURN 2008
  --  END
  --END

	 --首充验证
	 --IF @PayIdentity=2
	 --BEGIN
	 --	IF EXISTS(SELECT OnLineID FROM OnLinePayOrder WHERE UserID=@UserID AND OrderStatus=1 AND OrderDate BETWEEN @StartTime AND @EndTime)
	 --	BEGIN
	 --		SET @strErrorDescribe=N'抱歉！首充每天仅限充值一次！'
	 --		RETURN 2004
	 --	END
	 --END
	 --IF @PayIdentity=1
	 --BEGIN
	 --	IF EXISTS(SELECT OnLineID FROM OnLinePayOrder WHERE UserID=@UserID AND OrderStatus=1 )
	 --	BEGIN
	 --		SET @strErrorDescribe=N'抱歉！账号首充仅限充值一次！'
	 --		RETURN 2004
	 --	END
	 --END

	-- 写入订单信息
	INSERT INTO OnLinePayOrder(ConfigID,ShareID,UserID,GameID,Accounts,NickName,OrderID,OrderType,Amount,ScoreType,Score,OtherPresent,OrderStatus,OrderDate,OrderAddress)
	VALUES(@dwConfigID,@dwShareID,@UserID,@GameID,@Accounts,@NickName,@strOrderID,@PayType,@Amount,@ScoreType,@Score,@OtherPresent,0,@CurrentTime,@strIPAddress)

	-- 输出对象变量
	SELECT @dwConfigID AS ConfigID,@dwShareID AS ShareID,@UserID AS UserID,@GameID AS GameID,@Accounts AS Accounts,@NickName AS NickName,@strOrderID AS OrderID,@PayType AS OrderType,
	@Amount AS Amount,@ScoreType AS ScoreType, @Score AS Score,@OtherPresent AS OtherPresent,0 AS OrderStatus,@CurrentTime AS OrderDate,@strIPAddress AS OrderAddress

END
RETURN 0
GO



