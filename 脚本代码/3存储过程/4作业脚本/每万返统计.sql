USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_WF_CountReward') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_WF_CountReward
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_WF_CountReward
    @dwUserID			INT,
    -- 计算用户
    @Count              BIGINT OUTPUT
WITH
    ENCRYPTION
AS
SET NOCOUNT ON

DECLARE @Curr BIGINT
DECLARE @YesPF BIGINT
DECLARE @SPerformance BIGINT
DECLARE @TPerformance BIGINT
DECLARE @TempUser INT
DECLARE @Reward BIGINT
DECLARE @Parent INT
DECLARE @Beggar INT
DECLARE @Sub INT

DECLARE @TempID TABLE
(
    NId INT
)

DECLARE @TempPerformance TABLE
(
    UserID INT,
    Performance BIGINT
)


BEGIN
    SELECT @Curr=YesterDayReward,@YesPF=YesterDayPerformance,@Reward=Reward,@Parent=ParentID,@Beggar=BeggarNumber,@Sub=SubNumber FROM AgentInfo(NOLOCK) WHERE UserID=@dwUserID
    IF @YesPF IS NULL
    BEGIN
        
        DECLARE @SubPerformance BIGINT
        DECLARE @TeamPerformance BIGINT
        DECLARE @LevelDiff BIGINT

        SET @Curr=0
        SET @SubPerformance=0
        SET @TeamPerformance=0
        SET @LevelDiff=0

        INSERT @TempID(NId)
        SELECT UserID FROM AgentInfo WHERE ParentID=@dwUserID
        --计算业绩
        WHILE EXISTS(SELECT NId FROM @TempID)
        BEGIN
            SET @SPerformance=0
            SET @TPerformance=0
            SELECT TOP 1 @TempUser = NId FROM @TempID
            EXEC NET_PJ_CountReward @TempUser,@SPerformance OUTPUT
            SELECT @TPerformance = TodayValiBet FROM UserValidBet(NOLOCK) WHERE UserID=@TempUser
            UPDATE UserValidBet SET TodayValiBet=0 WHERE UserID=@TempUser
            SET @TeamPerformance+= @SPerformance
            SET @SubPerformance+= @TPerformance
            DELETE FROM @TempID WHERE NId=@TempUser
            INSERT @TempPerformance(UserID,Performance) VALUES (@TempUser,@SPerformance)
            UPDATE AgentInfo SET TotleValiBet+=@TPerformance WHERE UserID=@TempUser
        END
        --计算奖励
        DECLARE @Performance BIGINT
        SET @Performance=@SubPerformance+@TeamPerformance
        DECLARE @LevelReward BIGINT
        DECLARE @F FLOAT
        SELECt TOP 1 @LevelReward = Reward FROM WHQJPlatformDB.dbo.WFAgentConfig (NOLOCK) WHERE Limet<@Performance ORDER BY Limet

        WHILE EXISTS(SELECT UserID FROM @TempPerformance)
        BEGIN
            DECLARE @Tep BIGINT
            DECLARE @TLeveR BIGINT
            SELECT TOP 1 @TempUser = UserID,@Tep = Performance FROM @TempPerformance
            SELECt TOP 1 @TLeveR = Reward FROM WHQJPlatformDB.dbo.WFAgentConfig WHERE Limet<@Tep ORDER BY Limet
            SET @F=(@LevelReward- @TLeveR)/10000
            SET @Curr += @F*@Tep
            DELETE FROM @TempPerformance WHERE UserID=@TempUser
        END
        SET @F=@LevelReward/10000
        SET @Curr += @F*@Performance
        UPDATE AgentInfo SET YesterDayReward=@Curr,YesterDayPerformance=@SubPerformance+@TeamPerformance,Reward=Reward+@Curr,Tax=0,BackMoney=0,TeameValibet+=@SubPerformance+@TeamPerformance WHERE UserID=@dwUserID
        
        DECLARE @TodayValiBet BIGINT

        SELECT @TodayValiBet=TodayValiBet FROM UserValidBet (NOLOCK)

        INSERT [WHQJRecordDB].dbo.WFAgentCountRecord (UserID,ParentID,Valibet,BeforeReward,BeggarNumber,SubNumber,CurrReward,SubPerformance,TeamPerformance,CountTime)
        VALUES (@dwUserID,@Parent,@TodayValiBet,@Reward,@Beggar,@Sub,@Curr,@SubPerformance,@TeamPerformance,GETDATE())
        SET @Count=@SubPerformance+@TeamPerformance
    END
    SET @Count= @YesPF
END