/*********************************************************************************
*      Function:  WEB_PageView_AgentReturn									     *
*      Description:                                                              *
*             Sql2008分页存储过程												 *
*      Finish DateTime:                                                          *
*             2018/6/8														     *          
*********************************************************************************/
USE WHQJAgentDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WEB_PageView_AgentReturn]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WEB_PageView_AgentReturn]
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON 
GO

CREATE PROCEDURE dbo.WEB_PageView_AgentReturn
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
CREATE TABLE #Tb_AgentReturn_Cache
(
	SourceUserID INT,
	TargetUserID INT,
	ReturnBase BIGINT,
	AwardLevel INT,
	AwardType TINYINT,
	AwardScale DECIMAL(18,6),
	Award INT,
	CollectDate DATETIME,
	ExtraField NVARCHAR(32),
	RowID INT
)

BEGIN
	IF @Where IS NULL SET @Where=N''
	
	-- 记录总数
	DECLARE @countSql NVARCHAR(4000)  
	
	IF @RecordCount IS NULL
	BEGIN
		SET @countSql='SELECT @TotalRecord=Count(*) FROM ReturnAwardRecord(NOLOCK) '+@Where
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
	
	INSERT INTO #Tb_AgentReturn_Cache EXEC ('SELECT * FROM (SELECT TOP '+@TotalRecordForPageIndex+
			' SourceUserID,TargetUserID,ReturnBase,AwardLevel,AwardType,AwardScale,Award,CollectDate,ExtraField,
			ROW_NUMBER() OVER ('+@Order+') AS PageView_RowNo
			FROM ReturnAwardRecord(NOLOCK) ' + @Where +' ) AS TempPageViewTable
			WHERE TempPageViewTable.PageView_RowNo > '+ @CurrentPageSize)

	EXEC ('SELECT * FROM #Tb_AgentReturn_Cache')
	EXEC ('SELECT UserID,GameID,Accounts,NickName FROM WHQJAccountsDB.dbo.AccountsInfo(NOLOCK) WHERE UserID IN(SELECT SourceUserID FROM #Tb_AgentReturn_Cache) OR UserID IN(SELECT TargetUserID FROM #Tb_AgentReturn_Cache)')
	DROP TABLE #Tb_AgentReturn_Cache
END
RETURN 0
GO

