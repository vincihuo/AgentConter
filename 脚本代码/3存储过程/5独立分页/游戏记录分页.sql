/*********************************************************************************
*      Function:  WEB_PageView_DrawInfo									         *
*      Description:                                                              *
*             Sql2008分页存储过程												 *
*      Finish DateTime:                                                          *
*             2018/6/8														     *          
*********************************************************************************/
USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WEB_PageView_DrawInfo]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WEB_PageView_DrawInfo]
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.WEB_PageView_DrawInfo
	@TableName		NVARCHAR(50),			-- 表名
	@ReturnFields	NVARCHAR(200) = '*',	-- 查询列数
	@PageSize		INT = 10,				-- 每页数目
	@PageIndex		INT = 1,				-- 当前页码
	@Where			NVARCHAR(500) = '',		-- 查询条件
	@Order			NVARCHAR(100),			-- 排序字段
	@PageCount		INT OUTPUT,				-- 页码总数
	@RecordCount	INT OUTPUT	        	-- 记录总数
WITH ENCRYPTION AS

--设置属性
SET NOCOUNT ON

-- 变量定义
DECLARE @TotalRecord INT
DECLARE @TotalPage INT
DECLARE @CurrentPageSize INT
DECLARE @TotalRecordForPageIndex INT
CREATE TABLE #Tb_DrawInfo_Cache
(
	DrawID INT,
	KindID INT,
	ServerID INT,
	TableID INT,
	UserCount INT,
	AndroidCount INT,
	Waste INT,
	Revenue INT,
	StartTime DATETIME,
	ConcludeTime DATETIME,
	InsertTime DATETIME,
	RowID INT
)

BEGIN
	IF @Where IS NULL SET @Where=N''
	
	-- 记录总数
	DECLARE @countSql NVARCHAR(4000)  
	
	IF @RecordCount IS NULL
	BEGIN
		SET @countSql='SELECT @TotalRecord=Count(*) FROM RecordDrawInfo(NOLOCK) '+@Where
		EXECUTE sp_executesql @countSql,N'@TotalRecord int out',@TotalRecord OUT
	END
	ELSE
	BEGIN
		SET @TotalRecord=@RecordCount
	END		
	
	SET @RecordCount=@TotalRecord
	SET @TotalPage=(@TotalRecord-1)/@PageSize+1	
	SET @CurrentPageSize=(@PageIndex-1)*@PageSize

	-- 返回总页数和总记录数
	SET @PageCount=@TotalPage
	SET @RecordCount=@TotalRecord
	IF @PageCount IS NULL SET @PageCount = 0
	IF @RecordCount IS NULL SET @RecordCount = 0

	-- 返回记录
	SET @TotalRecordForPageIndex=@PageIndex*@PageSize
	
	INSERT INTO #Tb_DrawInfo_Cache EXEC ('SELECT * FROM (SELECT TOP '+@TotalRecordForPageIndex+
			' DrawID,KindID,ServerID,TableID,UserCount,AndroidCount,Waste,Revenue,StartTime,ConcludeTime,InsertTime,
			ROW_NUMBER() OVER ('+@Order+') AS PageView_RowNo
			FROM RecordDrawInfo(NOLOCK) ' + @Where +' ) AS TempPageViewTable
			WHERE TempPageViewTable.PageView_RowNo > '+ @CurrentPageSize)

	EXEC ('SELECT * FROM #Tb_DrawInfo_Cache')
	EXEC ('SELECT DrawID,UserID,ChairID,Score,Grade,Revenue,PlayTimeCount,InsertTime FROM RecordDrawScore(NOLOCK) WHERE DrawID IN(SELECT DrawID FROM #Tb_DrawInfo_Cache)')
	EXEC ('SELECT UserID,GameID,Accounts,NickName,IsAndroid FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE UserID IN(SELECT UserID FROM RecordDrawScore(NOLOCK) WHERE DrawID IN(SELECT DrawID FROM #Tb_DrawInfo_Cache))')
	
	DROP TABLE #Tb_DrawInfo_Cache
END
RETURN 0
GO
