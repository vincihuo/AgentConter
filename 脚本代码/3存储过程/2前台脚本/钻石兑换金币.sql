----------------------------------------------------------------------------------------------------
-- ?????2017
-- ???2017-10-11
-- ??????????????
----------------------------------------------------------------------------------------------------

USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_DiamondExchangeGold') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_DiamondExchangeGold
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_DiamondExchangeGold
	@dwUserID INT,
	@dwConfigID INT,
	@dwTypeID	INT,
	@strClientIP NVARCHAR(15),
	@strErrorDescribe	NVARCHAR(127) OUTPUT		-- ??????

WITH ENCRYPTION AS

-- ????????
SET NOCOUNT ON

DECLARE @Nullity BIT
DECLARE @CurDiamond BIGINT
DECLARE @ExchDiamond BIGINT
DECLARE @CurScore BIGINT
DECLARE @CurInsureScore BIGINT
DECLARE @PresentGold BIGINT

-- ??????
BEGIN
	-- ?????????
	SELECT @Nullity=Nullity FROM WHQJAccountsDBLink.WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID
	IF @Nullity IS NULL
	BEGIN
		SET @strErrorDescribe=N'?????????????????'
		RETURN 1001
	END
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'????????????????'
		RETURN 1002
	END

	-- ??????????
	SELECT @ExchDiamond=[Diamond], @PresentGold = [ExchGold] FROM [CurrencyExchConfig]WITH(NOLOCK) WHERE ConfigID = @dwConfigID

	IF @ExchDiamond IS NULL OR @PresentGold IS NULL
	BEGIN
		SET @strErrorDescribe = N'??????????????????????'
		RETURN 1003
	END

	SELECT @CurDiamond=Diamond FROM UserCurrency WITH(ROWLOCK) WHERE UserID=@dwUserID
	IF @CurDiamond IS NULL OR @CurDiamond < @ExchDiamond
	BEGIN
		SET @strErrorDescribe = N'???????????????'
		RETURN 1004
	END

	-- ?????????
	IF NOT EXISTS (SELECT 1 FROM [GameScoreInfo]WITH(NOLOCK) WHERE UserID = @dwUserID)
	BEGIN
		INSERT [GameScoreInfo] (UserID) VALUES (@dwUserID)
	END

	-- ????????????
	SELECT @CurScore=Score,@CurInsureScore=InsureScore FROM [GameScoreInfo]WITH(NOLOCK) WHERE UserID = @dwUserID

	-- ????????
	BEGIN TRAN

	-- ??????
	UPDATE [UserCurrency] SET Diamond = Diamond - @ExchDiamond WHERE UserID = @dwUserID
	IF @@ROWCOUNT<=0
	BEGIN
		SET @strErrorDescribe=N'?????????????????????'
		ROLLBACK TRAN
		RETURN 2003
	END

	-- ??????
	UPDATE [GameScoreInfo] SET Score = @CurScore + @PresentGold WHERE UserID = @dwUserID
 	IF @@ROWCOUNT<=0
	BEGIN
		SET @strErrorDescribe=N'?????????????????????'
		ROLLBACK TRAN
		RETURN 2003
	END

	-- §Õ???? ??????????
	INSERT INTO WHQJRecordDB.DBO.RecordCurrencyExch(UserID,TypeID,CurDiamond,ExchDiamond,CurScore,CurInsureScore,PresentGold,ClientIP,CollectDate)
	VALUES(@dwUserID,@dwTypeID,@CurDiamond,@ExchDiamond,@CurScore,@CurInsureScore,@PresentGold,@strClientIP,GETDATE())
	IF @@ROWCOUNT<=0
	BEGIN
		SET @strErrorDescribe=N'?????????????????????'
		ROLLBACK TRAN
		RETURN 2004
	END

	-- ?????? ??????????
	INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate)
	VALUES(dbo.WF_GetSerialNumber(),0,@dwUserID,12,@CurDiamond,-@ExchDiamond,@strClientIP,GETDATE())
	IF @@ROWCOUNT<=0
	BEGIN
		SET @strErrorDescribe=N'?????????????????????'
		ROLLBACK TRAN
		RETURN 2004
	END
	-- ?????? ??????????
	INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
		VALUES(dbo.WF_GetSerialNumber(),0,@dwUserID,5,@CurScore,@CurInsureScore,@PresentGold,@strClientIP,GETDATE())
	IF @@ROWCOUNT<=0
	BEGIN
		SET @strErrorDescribe=N'?????????????????????'
		ROLLBACK TRAN
		RETURN 2004
	END

	COMMIT TRAN

	SET @strErrorDescribe = N'?????????????????['+CAST(@ExchDiamond AS NVARCHAR(30))+']????????['+CAST(@PresentGold AS NVARCHAR(30))+']????'

	SELECT @CurScore + @PresentGold AS AfterScore,@CurInsureScore AS AfterInsureScore,@CurDiamond-@ExchDiamond AS AfterDiamond,@ExchDiamond AS ExchDiamond,@PresentGold AS PresentGold
END

RETURN 0

GO
