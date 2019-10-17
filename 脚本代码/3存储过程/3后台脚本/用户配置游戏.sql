----------------------------------------------------------------------------------------------------
-- 版权：2017
-- 时间：2017-10-11
-- 用途：用户配置游戏
----------------------------------------------------------------------------------------------------

USE WHQJAccountsDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_AddUserLoadGame') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_AddUserLoadGame
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_AddUserLoadGame
	@dwUniteID		INT,    -- 标识
	@dwTypeID		INT,    -- （0 通用  1 玩家  2 代理）
	@dwKindID		INT,	-- 游戏标识
	@dwSortID		INT		-- 排序标识
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	IF @dwTypeID=0
	BEGIN
		IF EXISTS(SELECT ID FROM AccountsGame(NOLOCK) WHERE TypeID=@dwTypeID AND KindID=@dwKindID)
		BEGIN
			RETURN 1001
		END
		INSERT INTO AccountsGame(UniteID,TypeID,KindID,SortID) VALUES(0,0,@dwKindID,@dwSortID)
	END
	ELSE
	BEGIN
		IF EXISTS(SELECT ID FROM AccountsGame(NOLOCK) WHERE UniteID=@dwUniteID AND TypeID=@dwTypeID AND KindID=@dwKindID)
		BEGIN
			RETURN 1001
		END
		INSERT INTO AccountsGame(UniteID,TypeID,KindID,SortID) VALUES(@dwUniteID,@dwTypeID,@dwKindID,@dwSortID)
	END
END

RETURN 0

GO


