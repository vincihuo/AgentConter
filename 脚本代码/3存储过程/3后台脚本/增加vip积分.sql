USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PB_VipSore') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PB_VipSore
GO

SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE NET_PB_VipSore
    @PayMoney           BIGINT,
    @UserID             INT
WITH
	ENCRYPTION
AS
SET NOCOUNT ON

DECLARE @OldScore    BIGINT
DECLARE @OldLevel    INT

DECLARE @CurrScore   BIGINT
DECLARE @NewLevel    BIGINT
DECLARE @Fresh       BIGINT

BEGIN
    SELECT @OldScore=Score,@OldLevel=VipLevel FROM UserVipInfo WHERE UserID=@UserID
    IF @OldScore IS NULL
    BEGIN
        INSERT INTO UserVipInfo(UserID)VALUES(@UserID)
        SET @OldScore=0
        SEt @OldLevel=0
    END
    SELECT TOP 1 @NewLevel=VipLevel FROM WHQJPlatformDB.dbo.VipConfig WHERE Integral*1000<=@OldScore+@PayMoney ORDER BY VipLevel DESC
    
    SELECT @Fresh=FreshReward FROM UserVipInfo WHERE UserID=@UserID

    IF @NewLevel>@OldLevel AND @OldLevel=0
    BEGIN
    UPDATE UserVipInfo SET WeekReward=1 , MonthReward=1,CheckInReward=1 WHERE UserID=@UserID
    END
    WHILE @NewLevel>@OldLevel
    BEGIN
        SET @OldLevel=@OldLevel+1
        SET @Fresh=@Fresh+POWER(2,@OldLevel)
    END
    UPDATE UserVipInfo SET Score=@OldScore+@PayMoney , VipLevel=@NewLevel,FreshReward=@Fresh WHERE UserID=@UserID
END
RETURN 0
GO