----------------------------------------------------------------------------------------------------
-- 版权：2011
-- 时间：2012-02-23
-- 用途：手机登录数据获取
----------------------------------------------------------------------------------------------------

USE WHQJNativeWebDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetMobileLoginData') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetMobileLoginData
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_GetMobileLoginData

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 执行逻辑
BEGIN
	
	-- 获取系统配置
	SELECT StatusName,StatusValue FROM WHQJAccountsDB.dbo.SystemStatusInfo WITH(NOLOCK)

	-- 获取客服配置
	SELECT Field1 AS Link,Field2 AS Number1,Field3 AS Name1,Field4 AS Type1,Field5 AS Number2,Field6 AS Name2,Field7 AS Type2,Field8 AS Number3,Field9 AS Name3,Field10 AS Type3 FROM ConfigInfo WITH(NOLOCK) WHERE ConfigKey =N'SysCustomerService'

	-- 获取系统公告
	SELECT NoticeID,NoticeTitle,MoblieContent,PublisherTime,Publisher FROM SystemNotice WITH(NOLOCK) WHERE Nullity=0 ORDER BY IsTop DESC,SortID ASC,NoticeID DESC

	-- 获取广告资源
	SELECT Title,ResourceURL,LinkURL,SortID,PlatformType FROM Ads WITH(NOLOCK) WHERE [Type] = 3 ORDER BY SortID ASC

	SELECT Title,ResourceURL,LinkURL,SortID,PlatformType FROM Ads WITH(NOLOCK) WHERE [Type] = 4 ORDER BY SortID ASC

	---获取道具购买比例
	SELECT isnull(ExchangeRatio,0) FROM [WHQJPlatformDB].dbo.GameProperty WITH(NOLOCK) WHERE ID=306 and ExchangeType=0--钻石购买
	SELECT isnull(ExchangeRatio,0) FROM [WHQJPlatformDB].dbo.GameProperty WITH(NOLOCK) WHERE ID=306 and ExchangeType=1--金币购买
	  ----活动公告
	 SELECT Title,ResourceURL,LinkURL,Type ,SortID,PlatformType FROM Ads WITH(NOLOCK) WHERE 6 = 6 ORDER BY SortID ASC
	 ---签到物品配置
	 select GoodsID,GamePackageGoods.PackageID,GamePackageGoods.TypeID,GamePackage.TypeID as PackageTypeID, ResourceURL,Name,SortID  from  [WHQJPlatformDB].dbo.GamePackageGoods left join  [WHQJPlatformDB].dbo.[GamePackage] on GamePackageGoods.PackageID=[GamePackage].PackageID  ORDER BY SortID ASC

	 --亲友圈创建条件
	 SELECT OptionName,OptionValue FROM [WHQJGroupDB].dbo.[IMGroupOption] WITH(NOLOCK)
	   
END

RETURN 0

GO