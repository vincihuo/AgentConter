USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetVIPDistribute') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetVIPDistribute
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_GetVIPDistribute

WITH ENCRYPTION AS

DECLARE @AllPerson INT
-- 属性设置
SET NOCOUNT ON
BEGIN
    SELECT @AllPerson=COUNT(*) FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK)
    SELECT '普通会员' AS name, @AllPerson-COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel>0 UNION ALL
    SELECT '一级会员' AS name, COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel=1 UNION ALL
    SELECT '二级会员' AS name, COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel=2 UNION ALL
    SELECT '三级会员' AS name, COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel=3 UNION ALL
    SELECT '四级会员' AS name, COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel=4 UNION ALL
    SELECT '五级会员' AS name, COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel=5 UNION ALL
    SELECT '六级会员' AS name, COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel=6 UNION ALL
    SELECT '七级会员' AS name, COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel=7 UNION ALL
    SELECT '八级会员' AS name, COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel=8 UNION ALL
    SELECT '九级会员' AS name, COUNT(*) AS value FROM UserVipInfo WITH(NOLOCK) WHERE VipLevel=9
    SELECT @AllPerson AS AllPerson 
END
RETURN 0
GO