----------------------------------------------------------------------------------------------------
-- 版权：2017
-- 时间：2017-10-11
-- 用途：用户显示游戏
----------------------------------------------------------------------------------------------------

USE WHQJAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetUserLoadGameList') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetUserLoadGameList
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_GetUserLoadGameList
	@dwUID		INT,   -- 标识
	@dwTypeID	INT     -- （0 通用  1 玩家  2 代理）
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

CREATE TABLE #Tb_BackLoadGame
(
	ID INT,
	UniteID INT,
	KindID INT,
	SortID INT,
	CollectDate DATETIME
)

-- 执行逻辑
BEGIN
	-- 通用
	IF @dwTypeID=0
	BEGIN
		INSERT INTO #Tb_BackLoadGame SELECT ID,UniteID,KindID,SortID,CollectDate FROM AccountsGame(NOLOCK) WHERE TypeID=0
		SELECT KindID,KindName FROM WHQJPlatformDB.dbo.GameKindItem(NOLOCK) WHERE KindID IN(SELECT KindID FROM #Tb_BackLoadGame)
		SELECT * FROM #Tb_BackLoadGame
	END
	ELSE IF @dwTypeID=1
	BEGIN
		INSERT INTO #Tb_BackLoadGame SELECT ID,UniteID,KindID,SortID,CollectDate FROM AccountsGame(NOLOCK) WHERE UniteID=@dwUID AND TypeID=1
		SELECT KindID,KindName FROM WHQJPlatformDB.dbo.GameKindItem(NOLOCK) WHERE KindID IN(SELECT KindID FROM #Tb_BackLoadGame)
		SELECT * FROM #Tb_BackLoadGame
	END
	ELSE IF @dwTypeID=2
	BEGIN
		INSERT INTO #Tb_BackLoadGame SELECT ID,UniteID,KindID,SortID,CollectDate FROM AccountsGame(NOLOCK) WHERE UniteID=@dwUID AND TypeID=2
		SELECT KindID,KindName FROM WHQJPlatformDB.dbo.GameKindItem(NOLOCK) WHERE KindID IN(SELECT KindID FROM #Tb_BackLoadGame)
		SELECT * FROM #Tb_BackLoadGame
		--SELECT AgentID,UserID,GameID,Accounts,NickName FROM AccountsInfo(NOLOCK) WHERE AgentID IN(SELECT UniteID FROM #Tb_BackLoadGame)
		--SELECT AgentID,UserID,AgentLevel FROM WHQJAgentDB.dbo.AgentInfo(NOLOCK) WHERE AgentID IN(SELECT UniteID FROM #Tb_BackLoadGame)
	END
	
END

RETURN 0

GO


