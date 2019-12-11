USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PJ_RankAgent') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PJ_RankAgent
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PJ_RankAgent
    @t	INT
WITH
    ENCRYPTION
AS
SET NOCOUNT ON
BEGIN
    INSERT AgentRank(UserID) (SELECT UserID FROM AgentInfo(NOLOCK) WHERE UserID NOT IN (SELECT UserID FROM AgentRank(NOLOCK)))
    IF @t=1
    BEGIN
    UPDATE AgentRank SET DayReward=A.Reward+A.AllReward-DayRecord,DayRecord=A.Reward+A.AllReward FROM AgentInfo A WHERE AgentRank.UserID=A.UserID
    END

    IF @t=2
    BEGIN
    UPDATE AgentRank SET WeekReward=A.Reward+A.AllReward-WeekRecord,WeekRecord=A.Reward+A.AllReward FROM AgentInfo A WHERE AgentRank.UserID=A.UserID
    END

    IF @t=3
    BEGIN
    UPDATE AgentRank SET MonthReward=A.Reward+A.AllReward-MonthRecord,MonthRecord=A.Reward+A.AllReward FROM AgentInfo A WHERE AgentRank.UserID=A.UserID
    END
END