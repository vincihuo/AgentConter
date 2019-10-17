----------------------------------------------------------------------
-- 时间：2011-10-20
-- 用途：数据汇总统计。
----------------------------------------------------------------------
USE WHQJTreasureDB
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PM_StatInfo') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PM_StatInfo
GO

----------------------------------------------------------------------
CREATE PROC NET_PM_StatInfo
			
WITH ENCRYPTION AS

-- 时间数据
DECLARE @CurentTime NVARCHAR(10)
DECLARE @StartTime DATETIME
DECLARE @EndTime DATETIME

-- 统计数据
DECLARE @TotalUser BIGINT
DECLARE @WebRegisterUser INT
DECLARE @GameRegisterUser INT
DECLARE @H5RegisterUser INT

DECLARE @Score BIGINT
DECLARE @InsureScore BIGINT
DECLARE @PayScoreAmount DECIMAL(18,2)
DECLARE @PayScore BIGINT

DECLARE @Diamond BIGINT
DECLARE @PayDiamondAmount DECIMAL(18,2)
DECLARE @PayDiamond BIGINT

DECLARE @Revenue BIGINT
DECLARE @TotalRevenue BIGINT
DECLARE @InsureRevenue BIGINT
DECLARE @TotalInsureRevenue BIGINT

DECLARE @Waste BIGINT
DECLARE @TotalWaste BIGINT

DECLARE @ScoreRoomCount BIGINT
DECLARE @GoldRoomCount BIGINT

DECLARE @TotalAmount DECIMAL(18,2)
DECLARE @Amount DECIMAL(18,2)

BEGIN
	-- 时间设置
	SET @CurentTime = CONVERT(VARCHAR(10),GETDATE(),120) 
	SET @StartTime = CAST((@CurentTime + ' 00:00:00') AS DATETIME)
	SET @EndTime = CAST((@CurentTime + ' 23:59:59') AS DATETIME)

	-- 用户信息
	SELECT @TotalUser=COUNT(UserID) FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE IsAndroid=0
	SELECT @WebRegisterUser=COUNT(UserID) FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE RegisterDate>=@StartTime AND RegisterDate<=@EndTime 
	AND IsAndroid=0 AND RegisterOrigin>=80 AND RegisterOrigin<90
	SELECT @H5RegisterUser=COUNT(UserID) FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE RegisterDate>=@StartTime AND RegisterDate<=@EndTime 
	AND IsAndroid=0 AND RegisterOrigin=90
	SELECT @GameRegisterUser=COUNT(UserID) FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE RegisterDate>=@StartTime AND RegisterDate<=@EndTime 
	AND IsAndroid=0 AND RegisterOrigin<80

	-- 游戏币信息
	SELECT @Score=ISNULL(SUM(Score),0),@InsureScore=ISNULL(SUM(InsureScore),0) FROM GameScoreInfo(NOLOCK) 
	SELECT @PayScore=ISNULL(SUM(Score),0),@PayScoreAmount=ISNULL(SUM(Amount),0) FROM OnLinePayOrder(NOLOCK) WHERE OrderDate>=@StartTime AND OrderDate<=@EndTime AND ScoreType=0 AND OrderStatus>0

	-- 钻石信息
	SELECT @Diamond=ISNULL(SUM(Diamond),0) FROM UserCurrency(NOLOCK) 
	SELECT @PayDiamond=ISNULL(SUM(Score),0),@PayDiamondAmount=ISNULL(SUM(Amount),0) FROM OnLinePayOrder(NOLOCK) WHERE OrderDate>=@StartTime AND OrderDate<=@EndTime AND ScoreType=1 AND OrderStatus>0

	-- 充值信息
	SELECT @Amount=ISNULL(SUM(Amount),0) FROM OnLinePayOrder(NOLOCK) WHERE OrderDate>=@StartTime AND OrderDate<=@EndTime AND OrderStatus>0
	SELECT @TotalAmount=ISNULL(SUM(Amount),0) FROM OnLinePayOrder(NOLOCK) WHERE OrderStatus>0

	-- 税收信息
	SELECT @TotalRevenue=ISNULL(SUM(Revenue),0),@TotalWaste=ISNULL(SUM(Waste),0) FROM RecordDrawInfo(NOLOCK)
	SELECT @Revenue=ISNULL(SUM(Revenue),0),@Waste=ISNULL(SUM(Waste),0) FROM RecordDrawInfo(NOLOCK) WHERE StartTime>=@StartTime AND StartTime<=@EndTime
	SELECT @InsureRevenue=ISNULL(SUM(Revenue),0) FROM RecordInsure(NOLOCK) WHERE CollectDate>=@StartTime AND CollectDate<=@EndTime
	SELECT @TotalInsureRevenue=ISNULL(SUM(Revenue),0) FROM RecordInsure(NOLOCK) 

	-- 开房信息
	SELECT @ScoreRoomCount=COUNT(RecordID) FROM WHQJPlatformDB.dbo.StreamCreateTableFeeInfo(NOLOCK) WHERE CreateDate>=@StartTime AND CreateDate<=@EndTime AND PlayMode=0 AND RoomScoreInfo IS NOT NULL
	SELECT @GoldRoomCount=COUNT(RecordID) FROM WHQJPlatformDB.dbo.StreamCreateTableFeeInfo(NOLOCK) WHERE CreateDate>=@StartTime AND CreateDate<=@EndTime AND PlayMode=1 AND RoomScoreInfo IS NOT NULL

	-- 输出数据
	SELECT	 @TotalUser AS TotalUser,
			 @WebRegisterUser AS WebRegisterUser,
			 @GameRegisterUser AS GameRegisterUser,
			 @H5RegisterUser AS H5RegisterUser,
			 @Score AS Score,
			 @InsureScore AS InsureScore,
			 @PayScoreAmount AS PayScoreAmount,
			 @PayScore AS PayScore,
			 @Diamond AS Diamond,
			 @PayDiamondAmount AS PayDiamondAmount,
			 @PayDiamond AS PayDiamond,
			 @Revenue AS Revenue,
			 @TotalRevenue AS TotalRevenue,
			 @InsureRevenue AS InsureRevenue,
			 @TotalInsureRevenue AS TotalInsureRevenue,
			 @ScoreRoomCount AS ScoreRoomCount,
			 @GoldRoomCount AS GoldRoomCount,
			 @TotalAmount AS TotalAmount,
			 @Amount AS Amount,
			 @TotalWaste AS TotalWaste,
			 @Waste AS Waste

END
