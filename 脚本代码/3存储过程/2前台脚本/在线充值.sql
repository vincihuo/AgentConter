----------------------------------------------------------------------
-- 版权：2017
-- 时间：2018-04-27
-- 用途：在线充值
----------------------------------------------------------------------

USE [WHQJTreasureDB]
GO

-- 在线充值
IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_FinishOnLineOrder') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_FinishOnLineOrder
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

---------------------------------------------------------------------------------------
-- 在线充值
CREATE PROCEDURE NET_PW_FinishOnLineOrder
	@strOrdersID		NVARCHAR(32),
	@callType           TINYINT,
	--	订单编号
	@PayAmount			DECIMAL(18,2),
	--	用户帐号
	@OrderAddress       NVARCHAR(15),
	@strErrorDescribe	NVARCHAR(127) OUTPUT
--	输出信息
WITH
	ENCRYPTION
AS

-- 属性设置
SET NOCOUNT ON

-- 订单信息

DECLARE @UserID INT
DECLARE @Amount DECIMAL(18,2)
DECLARE @PresentScore INT
DECLARE @OrderStatus TINYINT

--账号信息
DECLARE @Nullity TINYINT
DECLARE @BeforeScore BIGINT
DECLARE @BeforeInsure BIGINT

DECLARE @RegisterIP NVARCHAR(15)
DECLARE @RegisterDate DATETIME
DECLARE @RegisterMachine NVARCHAR(32)
DECLARE @DateTime DATETIME
-- 执行逻辑
BEGIN
	SET @DateTime=GETDATE()
	-- 订单查询
	SELECT @UserID=UserID, @Amount=Amount, @PresentScore=PresentScore, @OrderStatus=OrderStates
	FROM OnLinePayOrder WITH(NOLOCK)
	WHERE OrderID = @strOrdersID
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值订单不存在!'
		RETURN 1001
	END
	IF @OrderStatus<>0
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值订单已完成!'
		RETURN 1002
	END
	-- 获取用户信息
	SELECT @Nullity=Nullity, @RegisterIP=RegisterIP, @RegisterDate=RegisterDate, @RegisterMachine=RegisterMachine
	FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK)
	WHERE UserID = @UserID
	IF @Nullity IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值账号不存在！'
		RETURN 1004
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'抱歉！充值账号已冻结状态！'
		RETURN 1005
	END
	--刷新状态
	UPDATE OnLinePayOrder SET OrderStates = @callType,PayAmount = @PayAmount,CallTime=@DateTime WHERE OrderID = @strOrdersID AND UserID = @UserID
	--获取用户金额
	SELECT @BeforeScore = Score, @BeforeInsure=InsureScore
	FROM WHQJTreasureDB.DBO.GameScoreInfo(NOLOCK)
	WHERE UserID = @UserID
	IF @BeforeScore IS NULL 
	BEGIN
		INSERT WHQJTreasureDB.DBO.GameScoreInfo
			(UserID,Score,RegisterIP,RegisterDate,RegisterMachine)
		VALUES
			(@UserID, 0, @RegisterIP, @RegisterDate, @RegisterMachine)
		SET @BeforeScore = 0
		SET @BeforeInsure =0
	END
	--假币
	DECLARE @CheckOut TINYINT
	IF EXISTS(SELECT 1
	FROM GameScoreLocker
	WHERE UserID=@UserID)
	 	BEGIN
		--加保险箱
		UPDATE GameScoreInfo SET InsureScore = InsureScore + @Amount+@PresentScore WHERE UserID = @UserID
		SET @CheckOut=2
	END
	ELSE
		BEGIN
		--加本身
		UPDATE GameScoreInfo SET Score = Score + @Amount+@PresentScore WHERE UserID = @UserID
		SET @CheckOut=1
	END

	--刷新订单状态
	UPDATE OnLinePayOrder SET CheckOut = @CheckOut WHERE OrderID = @strOrdersID AND UserID = @UserID
	--写入流水
	INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
		(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
	VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 12, @BeforeScore, @BeforeInsure, @Amount+@PresentScore, @OrderAddress, @DateTime)
	--增加打码量

	--  充值打码量倍数
	DECLARE @PayMultiple INT
	-- 	充值送打码倍数
	DECLARE @SendMultiple INT
	SELECT @PayMultiple=CONVERT(INT,Field1) , @SendMultiple=CONVERT(INT,Field2) FROM WHQJNativeWebDB.dbo.ConfigInfo (NOLOCK) WHERE ConfigID=5
	DECLARE @VileBet BIGINT
	SET @VileBet =@Amount*@PayMultiple/100+@PresentScore*@SendMultiple/100;
	DECLARE @ErrorDescribe	NVARCHAR(127)
	DECLARE @Return INT
	EXEC @Return=NET_PB_Deposit 1,@UserID,1,@strOrdersID,@VileBet,@ErrorDescribe OUTPUT
	IF @Return!=0
	BEGIN
		SET @strErrorDescribe = @ErrorDescribe
		RETURN @Return
	END
	ELSE 
	BEGIN
		SET @strErrorDescribe = N'充值到账成功'
	END
END
RETURN 0
GO
