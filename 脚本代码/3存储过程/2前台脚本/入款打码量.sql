USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PB_Deposit') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PB_Deposit
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE NET_PB_Deposit
    @DepositType        TINYINT,            --入款类型
    @UserID             INT,
    @DepositID          INT,
    @DepositName        NVARCHAR(32),
    @ValidBet           BIGINT,
	@strErrorDescribe	NVARCHAR(127) OUTPUT
--	输出信息
WITH
	ENCRYPTION
AS

SET NOCOUNT ON

DECLARE @LastTarget    BIGINT
DECLARE @LastBet   BIGINT
DECLARE @Banlance   BIGINT
BEGIN
    SELECT @LastTarget=TargetBet,@LastBet=CurrentValidBet
    FROM UserValidBet WITH(NOLOCK)
	WHERE UserID = @UserID
    IF @LastTarget IS NULL
    BEGIN
    INSERT INTO UserValidBet(UserID)VALUES(@UserID)
    SET @LastTarget =0
	SET @LastBet=0
    END
	SET @Banlance=@LastTarget-@LastBet
    BEGIN TRAN
    --更新玩家打码量
    UPDATE UserValidBet SET TargetBet=@Banlance+@ValidBet,CurrentValidBet=0 WHERE UserID=@UserID
    IF @@ROWCOUNT<>1
        BEGIN
		SET @strErrorDescribe=N'订单处理异常，重试'
		ROLLBACK TRAN
		RETURN 2002
	    END
    --写入打码量记录
    INSERT INTO ValiBetRecord(DepositType,UserID,DepositID,DepositName,CurrentValidBet,LastValiBet,TotalValiBet)
    VALUES(@DepositType,@UserID,@DepositID,@DepositName,@ValidBet,@Banlance,@Banlance+@ValidBet)
    IF @@ROWCOUNT<>1
        BEGIN
		SET @strErrorDescribe=N'订单处理异常，重试'
		ROLLBACK TRAN
		RETURN 2003
	    END
    COMMIT TRAN
END
RETURN 0
GO