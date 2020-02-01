USE [WHQJTreasureDB]
GO
IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_WF_GetAgentInfo') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_WF_GetAgentInfo
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_WF_GetAgentInfo
    @dwUserID			INT
WITH
    ENCRYPTION
AS
SET NOCOUNT ON

DECLARE @ParentID INT
DECLARE @TeameNumber INT
DECLARE @SubNumber INT
DECLARE @NewSub INT
DECLARE @AliveSub INT
DECLARE @Reward BIGINT
DECLARE @AllReward BIGINT

BEGIN
    SELECT @ParentID=ParentID,@TeameNumber=BeggarNumber,@SubNumber=SubNumber,@Reward=Reward,@AllReward=AllReward FROM AgentInfo (NOLOCK) WHERE UserID=@dwUserID
    SELECT @ParentID=GameID FROM WHQJAccountsDB.dbo.AccountsInfo (NOLOCK) WHERE UserID=@ParentID
    SELECT @NewSub=@SubNumber-SubNumber FROM WHQJRecordDB.dbo.WFAgentCountRecord (NOLOCK) WHERE UserID=@dwUserID AND DateDiff(dd,CountTime,GetDate())=0
    SELECT @AliveSub= COUNT(*) FROM AgentInfo(NOLOCK) A , WHQJAccountsDB.dbo.AccountsInfo B WHERE B.UserID=A.ParentID AND DateDiff(dd,B.LastLogonDate,GetDate())=0 AND A.ParentID=@dwUserID
    SELECT @ParentID AS Parent,@TeameNumber AS Team,@SubNumber AS Sub,@NewSub AS NewSub,@AliveSub AS Alive,@Reward AS Reward,@AllReward AS AllReward
END
RETURN 0