USE [WHQJTreasureDB]
GO
IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetAgentInfo') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetAgentInfo
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE NET_PW_GetAgentInfo
    @dwUserID			INT
WITH
    ENCRYPTION
AS
SET NOCOUNT ON

DECLARE @Allperson INT   -- 总人数
DECLARE @Immediateperson INT -- 直系下级人数

DECLARE @ImmediateMoney BIGINT   -- 昨日直系下级提供的前
DECLARE @OtherMoney BIGINT       -- 昨日其他代理提供的钱

DECLARE @CurrReward BIGINT   -- 当前可领取奖励
DECLARE @HisMoney BIGINT        -- 历史领取的所有

BEGIN
    SELECT @Allperson=BeggarNumber,@HisMoney=AllReward,@CurrReward=Reward FROM AgentInfo WHERE UserID=@dwUserID
    SELECT @Immediateperson=COUNT(*) FROM AgentInfo WHERE ParentID=@dwUserID
    SELECT @ImmediateMoney=SUM(Tax),@OtherMoney=SUM(CurrReward)  FROM [WHQJRecordDB].dbo.AgentCountRecord 
    WHERE ParentID=@dwUserID AND DATEDIFF(dd,CountTime,GETDATE())=1
    SELECT Allperson=@Allperson,Immediateperson=@Immediateperson,ImmediateMoney=@ImmediateMoney,
            OtherMoney=@OtherMoney,CurrReward=@CurrReward,HisMoney=@HisMoney
END
RETURN 0
GO