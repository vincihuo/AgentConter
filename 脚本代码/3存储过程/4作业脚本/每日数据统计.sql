----------------------------------------------------------------------
-- 时间：2011-10-20
-- 用途：数据每日统计。
----------------------------------------------------------------------
USE WHQJTreasureDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PM_DayDataStatistics') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PM_DayDataStatistics
GO

----------------------------------------------------------------------
CREATE PROC NET_PM_DayDataStatistics
			
WITH ENCRYPTION AS

-- 时间数据
DECLARE @CurentTime NVARCHAR(10)
DECLARE @Yesterday DATETIME
DECLARE @DateID INT
DECLARE @StartTime DATETIME
DECLARE @EndTime DATETIME

-- 统计数据
DECLARE @WebRegisterUser INT
DECLARE @GameRegisterUser INT
DECLARE @H5RegisterUser INT

DECLARE @Gold BIGINT
DECLARE @Diamond BIGINT
DECLARE @PayScore BIGINT
DECLARE @PayDiamond BIGINT

DECLARE @GameWaste BIGINT
DECLARE @GameRevenue BIGINT
DECLARE @InsureRevenue BIGINT

DECLARE @ScoreRoomCount BIGINT
DECLARE @GoldRoomCount BIGINT

DECLARE @TotalAmount DECIMAL(18,2)
DECLARE @Amount DECIMAL(18,2)

BEGIN
	-- 时间设置
	SET @Yesterday = DATEADD(d,-1,GETDATE())
	SET @CurentTime = CONVERT(VARCHAR(10),@Yesterday,120) 
	SET @DateID = CAST(CAST(@Yesterday AS FLOAT) AS INT)
	SET @StartTime = CAST((@CurentTime + ' 00:00:00') AS DATETIME)
	SET @EndTime = CAST((@CurentTime + ' 23:59:59') AS DATETIME)

	-- 用户信息
	SELECT @WebRegisterUser=COUNT(UserID) FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE RegisterDate>=@StartTime AND RegisterDate<=@EndTime 
	AND IsAndroid=0 AND RegisterOrigin>=80 AND RegisterOrigin<90
	SELECT @H5RegisterUser=COUNT(UserID) FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE RegisterDate>=@StartTime AND RegisterDate<=@EndTime 
	AND IsAndroid=0 AND RegisterOrigin=90
	SELECT @GameRegisterUser=COUNT(UserID) FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE RegisterDate>=@StartTime AND RegisterDate<=@EndTime 
	AND IsAndroid=0 AND RegisterOrigin<80

	-- 游戏币信息
	SELECT @Gold=ISNULL(SUM(Score+InsureScore),0) FROM GameScoreInfo(NOLOCK) 
	SELECT @PayScore=ISNULL(SUM(Score),0) FROM OnLinePayOrder(NOLOCK) WHERE OrderDate>=@StartTime AND OrderDate<=@EndTime AND ScoreType=0 AND OrderStatus>0

	-- 钻石信息
	SELECT @Diamond=ISNULL(SUM(Diamond),0) FROM UserCurrency(NOLOCK) 
	SELECT @PayDiamond=ISNULL(SUM(Score),0) FROM OnLinePayOrder(NOLOCK) WHERE OrderDate>=@StartTime AND OrderDate<=@EndTime AND ScoreType=1 AND OrderStatus>0

	-- 充值信息
	SELECT @Amount=ISNULL(SUM(Amount),0) FROM OnLinePayOrder(NOLOCK) WHERE OrderDate>=@StartTime AND OrderDate<=@EndTime AND OrderStatus>0

	-- 税收信息
	SELECT @GameRevenue=ISNULL(SUM(Revenue),0),@GameWaste=ISNULL(SUM(Waste),0) FROM RecordDrawInfo(NOLOCK) WHERE StartTime>=@StartTime AND StartTime<=@EndTime
	SELECT @InsureRevenue=ISNULL(SUM(Revenue),0) FROM RecordInsure(NOLOCK) WHERE CollectDate>=@StartTime AND CollectDate<=@EndTime

	-- 开房信息
	SELECT @ScoreRoomCount=COUNT(RecordID) FROM WHQJPlatformDB.dbo.StreamCreateTableFeeInfo(NOLOCK) WHERE CreateDate>=@StartTime AND CreateDate<=@EndTime AND PlayMode=0 AND RoomScoreInfo IS NOT NULL
	SELECT @GoldRoomCount=COUNT(RecordID) FROM WHQJPlatformDB.dbo.StreamCreateTableFeeInfo(NOLOCK) WHERE CreateDate>=@StartTime AND CreateDate<=@EndTime AND PlayMode=1 AND RoomScoreInfo IS NOT NULL

	-- 输出数据
	INSERT INTO WHQJNativeWebDB.dbo.StreamEveryDayData VALUES(@DateID,@Gold,@Diamond,@GameWaste,@GameRevenue,@InsureRevenue,@PayScore,@PayDiamond,
	@Amount,@ScoreRoomCount,@GoldRoomCount,@WebRegisterUser,@GameRegisterUser,@H5RegisterUser,@Yesterday)

END