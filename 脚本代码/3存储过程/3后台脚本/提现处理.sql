USE [WHQJTreasureDB]
GO
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_DealDrawarOrder') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_DealDrawarOrder
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PW_DealDrawarOrder
	@masterID			INT,						
    -- 操作用户
	@strOrdersID		NVARCHAR(32),
	--	订单编号
	@State		        TINYINT,
    @strClientIP        NVARCHAR(15),
	@strErrorDescribe	NVARCHAR(127) OUTPUT
	--	输出信息
WITH
	ENCRYPTION
AS
--提现信息
DECLARE @UserID INT
DECLARE @Amount DECIMAL(18,2)
DECLARE @OrderState TINYINT

BEGIN
    SELECT @UserID=UserID,@Amount=Amount, @OrderState=OrderState
	FROM DrawalOrder WITH(NOLOCK)
	WHERE OrderID = @strOrdersID
    IF @UserID IS NULL
    BEGIN
	SET @strErrorDescribe=N'抱歉！充值订单不存在!'
	RETURN 1001
	END
    IF @OrderState <>0
    BEGIN
	SET @strErrorDescribe=N'订单已经GGtry了!'
	RETURN 1002
	END
    IF @State=1
    BEGIN
    UPDATE DrawalOrder SET OrderState = 1,MasterID = @masterID,DealTime=GETDATE() WHERE  OrderID = @strOrdersID
    IF @@ROWCOUNT<>1
        BEGIN
        SET @strErrorDescribe=N'订单处理异常稍后重试'
        RETURN 1003
        END
    SET @strErrorDescribe=N'提现通过'
	RETURN 0
    END
    --拒绝订单
    IF @State=2
    BEGIN
        IF EXISTS(SELECT 1 FROM GameScoreLocker WHERE UserID=@UserID) 
	    BEGIN
		SET @strErrorDescribe=N'提现时请玩家离开游戏房间'
		RETURN 2001
	    END

        DECLARE @CurScore BIGINT
        DECLARE @CurInsureScore BIGINT
        SELECT @CurScore=Score,@CurInsureScore=InsureScore FROM GameScoreInfo WHERE UserID = @UserID

        BEGIN TRAN        
        UPDATE DrawalOrder SET OrderState = 2 ,MasterID = @masterID,DealTime=GETDATE() WHERE OrderID = @strOrdersID
        IF @@ROWCOUNT<>1
	    BEGIN
		SET @strErrorDescribe=N'订单处理异常，重试'
		ROLLBACK TRAN
		RETURN 2002
	    END
        --加钱
	    UPDATE GameScoreInfo SET Score = Score + @Amount WHERE UserID = @UserID
	    IF @@ROWCOUNT<>1
	    BEGIN
		SET @strErrorDescribe=N'抱歉，提款异常，请稍后重试'
		ROLLBACK TRAN
		RETURN 2003
	    END
        --金币流水
	    INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
	    VALUES(dbo.WF_GetSerialNumber(),@masterID,@UserID,7,@CurScore,@CurInsureScore,0-@Amount,@strClientIP,GETDATE())
	    IF @@ROWCOUNT<>1
	    BEGIN
		SET @strErrorDescribe=N'抱歉，提款异常，请稍后重试'
		ROLLBACK TRAN
		RETURN 2004
	    END
        COMMIT TRAN
    END
END
RETURN 0
GO