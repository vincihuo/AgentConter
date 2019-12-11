USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PB_AgentRevenueRebate]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PB_AgentRevenueRebate]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------	
--
CREATE PROC [NET_PB_AgentRevenueRebate]

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

DECLARE @TempUser INT

BEGIN
    UPDATE AgentInfo SET YesterDayReward=NULL
    WHILE EXISTS(SELECT UserID FROM AgentInfo WHERE YesterDayReward IS NULL)
    BEGIN
        DECLARE @tCurr BIGINT
        SELECT TOP 1 @TempUser = UserID FROM AgentInfo WHERE YesterDayReward IS NULL
        EXEC NET_PJ_CountReward @TempUser,@tCurr OUTPUT
    END
    EXEC NET_PJ_RankAgent 1
    IF DATEPART(weekday,GETDATE())='2'
    BEGIN
    EXEC NET_PJ_RankAgent 2
    END
    IF DATEPART(DD,GETDATE())='1'
    BEGIN
    EXEC NET_PJ_RankAgent 3
    END
END
RETURN 0
GO