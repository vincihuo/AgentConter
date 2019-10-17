----------------------------------------------------------------------
-- 版本：2018
-- 时间：2018-07-04
-- 用途：胜局排行榜（每30分钟统计）
----------------------------------------------------------------------
USE [WHQJTreasureDB]
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_GameRanking]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_GameRanking]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_GameRanking]

WITH ENCRYPTION AS

-- 属性设置

DECLARE @DateID INT
DECLARE @WeekStartDay DATETIME
DECLARE @DateEndID INT

-- 执行逻辑
BEGIN
	
	-- 获取时间
	SET @WeekStartDay = DATEADD(DAY,-1,DATEADD(WEEK,DATEDIFF(WEEK,0,GETDATE()),0))
	SET @DateID = CAST(CAST(@WeekStartDay AS FLOAT) AS INT)
	SET @DateEndID = CAST(CAST(DATEADD(DAY,6,@WeekStartDay) AS FLOAT) AS INT)

	-- 清空已存在的数据
	DELETE WHQJNativeWebDB.dbo.CacheGameRank WHERE DateID=@DateID

	-- 插入排行榜数据
	INSERT INTO WHQJNativeWebDB.dbo.CacheGameRank(DateID,UserID,RankNum,WinCount) 
	SELECT TOP 100 @DateID AS DateID,UserID,ROW_NUMBER() OVER(ORDER BY ISNULL(SUM(WinCount),0) DESC) AS RankNum,ISNULL(SUM(WinCount),0) AS WinCount 
	FROM StreamScoreInfo(NOLOCK) WHERE DateID>=@DateID AND DateID<=@DateEndID AND WinCount>0 GROUP BY UserID

	-- 修改插入的数据
	UPDATE WHQJNativeWebDB.dbo.CacheGameRank SET GameID=A.GameID,NickName=A.NickName,FaceUrl=A.CustomID,FaceID=A.FaceID,Gender=A.Gender,UnderWrite=A.UnderWrite 
	FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) AS A WHERE WHQJNativeWebDB.dbo.CacheGameRank.DateID=@DateID AND WHQJNativeWebDB.dbo.CacheGameRank.UserID=A.UserID

	-- 修改头像信息
	UPDATE WHQJNativeWebDB.dbo.CacheGameRank SET FaceUrl=A.FaceUrl
	FROM WHQJAccountsDB.dbo.AccountsFace(NOLOCK) AS A WHERE WHQJNativeWebDB.dbo.CacheGameRank.DateID=@DateID AND WHQJNativeWebDB.dbo.CacheGameRank.FaceUrl=A.ID

END
GO