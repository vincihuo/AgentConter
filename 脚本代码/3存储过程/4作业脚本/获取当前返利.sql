USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PJ_CountReward') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PJ_CountReward
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PJ_CountReward
    @dwUserID			INT,
    -- 计算用户
    @Count              BIGINT OUTPUT
WITH
    ENCRYPTION
AS
SET NOCOUNT ON

DECLARE @Curr BIGINT
DECLARE @Tax BIGINT
DECLARE @tCurr BIGINT
DECLARE @TempUser INT

DECLARE @TempID TABLE
(
    NId INT
)

BEGIN
    SELECT @Curr=YesterDayReward ,@Tax=Tax FROM AgentInfo WHERE UserID=@dwUserID
    IF @Curr IS NULL
    BEGIN
        SET @Curr=0
        INSERT @TempID(NId)
        SELECT UserID FROM AgentInfo WHERE ParentID=@dwUserID
        WHILE EXISTS(SELECT NId FROM @TempID)
        BEGIN
            SET @tCurr=0
            SELECT TOP 1 @TempUser = NId FROM @TempID
            EXEC NET_PJ_CountReward @TempUser,@tCurr OUTPUT
            DELETE FROM @TempID WHERE NId=@TempUser
            SET @Curr=@Curr+@tCurr
        END
        UPDATE AgentInfo SET YesterDayReward=@Curr,Reward=Reward+@Curr,Tax=0 WHERE UserID=@dwUserID
    END
    SET @Count = @Curr*0.3+@Tax*0.3
END
RETURN 0
GO