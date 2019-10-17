USE WHQJAgentDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PB_AgentRevenueRebate]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PB_AgentRevenueRebate]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------	
--
CREATE PROC [NET_PB_AgentRevenueRebate]

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 操作信息
DECLARE @DateID INT
DECLARE @DateTime DATETIME
DECLARE @Count INT
DECLARE @UserID INT
DECLARE @Revenue BIGINT
DECLARE @Descript NVARCHAR(32)
DECLARE @strErrorDescribe NVARCHAR(127)

BEGIN
	
	-- 时间信息
	SET @DateTime = GETDATE()
	SET @DateID = CAST(CAST(DATEADD(DAY,-1,@DateTime) AS FLOAT) AS INT)

	-- 查询返利用户
	SELECT ROW_NUMBER() OVER(ORDER BY UserID ASC) AS RowID,UserID,Revenue INTO #AgentRevenueRebate FROM WHQJTreasureDB.dbo.StreamScoreInfo(NOLOCK) WHERE DateID=@DateID
	SELECT @Count=COUNT(UserID) FROM #AgentRevenueRebate
	SET @Descript = CONVERT(VARCHAR(10),DATEADD(DAY,-1,@DateTime),120) + N'税收返利'
	WHILE @Count>0
	BEGIN
		SELECT @UserID=UserID,@Revenue=Revenue FROM #AgentRevenueRebate WHERE RowID=@Count
		-- 税收返利
		EXEC WHQJAgentDB.dbo.[NET_PB_RecordAgentAward] @UserID,@Revenue,2,@Descript,@strErrorDescribe OUTPUT
		SET @Count = @Count-1
	END
	
END
RETURN 0
GO