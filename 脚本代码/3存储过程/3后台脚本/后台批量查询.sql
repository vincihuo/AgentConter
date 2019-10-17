----------------------------------------------------------------------------------------------------
-- 版权：2011
-- 时间：2012-02-23
-- 用途：后台批量查询
----------------------------------------------------------------------------------------------------

USE WHQJAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_Batch_GetUserInfo') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_Batch_GetUserInfo
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_Batch_GetUserInfo
	@dwUserID		INT,					-- 用户I D
	@dwGameID		INT,					-- 游戏I D
	@dwAgentID		INT,					-- 代理I D
	@dwAccounts		NVARCHAR(32),			-- 用户账号
	@dwNickName		NVARCHAR(32)			-- 用户昵称
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	IF @dwUserID>0
	BEGIN
		SELECT UserID,GameID,SpreaderID,Accounts,NickName,FaceID,CustomID,AgentID FROM AccountsInfo(NOLOCK) WHERE UserID=@dwUserID
	END
	ELSE IF @dwGameID>0
	BEGIN
		SELECT UserID,GameID,SpreaderID,Accounts,NickName,FaceID,CustomID,AgentID FROM AccountsInfo(NOLOCK) WHERE GameID=@dwGameID
	END
	ELSE IF @dwAgentID>0
	BEGIN
		SELECT UserID,GameID,SpreaderID,Accounts,NickName,FaceID,CustomID,AgentID FROM AccountsInfo(NOLOCK) WHERE AgentID=@dwAgentID
	END
	ELSE IF @dwAccounts!=''
	BEGIN
		SELECT UserID,GameID,SpreaderID,Accounts,NickName,FaceID,CustomID,AgentID FROM AccountsInfo(NOLOCK) WHERE Accounts=@dwAccounts
	END
	ELSE IF @dwNickName!=''
	BEGIN
		SELECT UserID,GameID,SpreaderID,Accounts,NickName,FaceID,CustomID,AgentID FROM AccountsInfo(NOLOCK) WHERE NickName=@dwNickName
	END
END

RETURN 0

GO