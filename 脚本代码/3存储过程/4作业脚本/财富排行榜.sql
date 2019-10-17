----------------------------------------------------------------------
-- 版本：2018
-- 时间：2018-07-04
-- 用途：财富排行榜（每日凌晨1点统计）
----------------------------------------------------------------------
USE [WHQJTreasureDB]
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PJ_WealthRanking]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PJ_WealthRanking]
GO

----------------------------------------------------------------------
CREATE PROC [NET_PJ_WealthRanking]

WITH ENCRYPTION AS

-- 属性设置

DECLARE @Yesterday DATETIME
DECLARE @DateID INT
DECLARE @ByTime NVARCHAR(20)

-- 执行逻辑
BEGIN

	-- 获取前一天时间
	SET @Yesterday = DATEADD(DAY,-1,GETDATE())
	SET @DateID = CAST(CAST(@Yesterday AS FLOAT) AS INT)
	SET @ByTime = Convert(CHAR(10),DATEADD(DAY,-7,@Yesterday),120)

	-- 清空已存在的数据
	DELETE WHQJNativeWebDB.dbo.CacheWealthRank WHERE DateID=@DateID

	-- 插入排行榜数据
	INSERT INTO WHQJNativeWebDB.dbo.CacheWealthRank(DateID,UserID,RankNum,Gold) SELECT TOP 100 @DateID AS DateID,a.UserID,ROW_NUMBER() OVER(ORDER BY (Score+InsureScore) DESC) AS RankNum,(Score+InsureScore) AS Gold  FROM GameScoreInfo(NOLOCK) a JOIN WHQJAccountsDB.dbo.AccountsInfo b ON b.UserID=a.UserID WHERE b.LastLogonDate>=@ByTime 

	-- 修改插入的数据
	UPDATE WHQJNativeWebDB.dbo.CacheWealthRank SET GameID=A.GameID,NickName=A.NickName,FaceUrl=A.CustomID,FaceID=A.FaceID,Gender=A.Gender,UnderWrite=A.UnderWrite 
	FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) AS A WHERE WHQJNativeWebDB.dbo.CacheWealthRank.DateID=@DateID AND WHQJNativeWebDB.dbo.CacheWealthRank.UserID=A.UserID

	-- 修改头像信息
	UPDATE WHQJNativeWebDB.dbo.CacheWealthRank SET FaceUrl=A.FaceUrl
	FROM WHQJAccountsDB.dbo.AccountsFace(NOLOCK) AS A WHERE WHQJNativeWebDB.dbo.CacheWealthRank.DateID=@DateID AND WHQJNativeWebDB.dbo.CacheWealthRank.FaceUrl=A.ID

END
GO