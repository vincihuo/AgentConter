USE [WHQJTreasureDB]
GO
IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_CreateDrawarOrder') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_CreateDrawarOrder
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PW_CreateDrawarOrder
	@dwUserID			INT,
	-- 操作用户

	@DrawalType         TINYINT,

	@strOrdersID		NVARCHAR(32),
	--	订单编号
	@DrawalAmount		DECIMAL(18,2),
	--	提款的钱
	@OrderCost          DECIMAL(18,2),
	--  手续费
	@ClientIP			NVARCHAR(15),

	@strErrorDescribe	NVARCHAR(127) OUTPUT
--	输出信息
WITH
	ENCRYPTION
AS

DECLARE @CurScore  BIGINT
DECLARE @Nullity   TINYINT
DECLARE @GameID    INT
DECLARE @CurInsureScore BIGINT
BEGIN
	-- 获取用户信息
	SELECT @Nullity=Nullity, @GameID=GameID
	FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK)
	WHERE UserID=@dwUserID
	IF @Nullity IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉，提现用户不存在'
		RETURN 1001
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'抱歉，提现用户不存在'
		RETURN 1002
	END


	IF EXISTS(SELECT 1
	FROM GameScoreLocker
	WHERE UserID=@dwUserID) 
	BEGIN
		SET @strErrorDescribe=N'提现时请离开游戏房间'
		RETURN 1003
	END
	--查询金币
	SELECT @CurScore=Score, @CurInsureScore=InsureScore
	FROM GameScoreInfo
	WHERE UserID = @dwUserID
	IF @CurScore<@DrawalAmount
	BEGIN
		SET @strErrorDescribe=N'金币不足'
		RETURN 1004
	END

	IF EXISTS(SELECT 1
	FROM DrawalOrder WITH(NOLOCK)
	WHERE UserID=@dwUserID AND OrderState=0)
	BEGIN
		SET @strErrorDescribe=N'有线上提款订单未处理'
		RETURN 1005
	END
	BEGIN TRAN
	--扣钱
	UPDATE GameScoreInfo SET Score = Score - @DrawalAmount WHERE UserID = @dwUserID
	IF @@ROWCOUNT<>1
	BEGIN
		SET @strErrorDescribe=N'抱歉，提款异常，请稍后重试'
		ROLLBACK TRAN
		RETURN 2003
	END
	--金币流水
	INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
		(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
	VALUES(dbo.WF_GetSerialNumber(), 0, @dwUserID, 11, @CurScore, @CurInsureScore, 0-@DrawalAmount, @ClientIP, GETDATE())
	IF @@ROWCOUNT<>1
	BEGIN
		SET @strErrorDescribe=N'抱歉，提款异常，请稍后重试'
		ROLLBACK TRAN
		RETURN 2004
	END
	--写订单
	INSERT INTO DrawalOrder
		(OrderID,DrawalType,UserID,GameID,MasterID,Amount,OrderState,OrderCost,IP,CurrentTime)
	VALUES(@strOrdersID, @DrawalType, @dwUserID, @GameID, 0, @DrawalAmount, 0, @OrderCost, @ClientIP, GETDATE())
	IF @@ROWCOUNT<>1
	BEGIN
		SET @strErrorDescribe=N'抱歉，提款异常，请稍后重试'
		ROLLBACK TRAN
		RETURN 2005
	END
	COMMIT TRAN
END
SET @strErrorDescribe=N'订单生成成功'
RETURN 0
Go