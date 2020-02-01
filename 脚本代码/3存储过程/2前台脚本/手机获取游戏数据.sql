----------------------------------------------------------------------------------------------------
-- ��Ȩ��2011
-- ʱ�䣺2012-02-23
-- ��;���ֻ��˻�ȡ��Ϸ�б��Ͱ汾
----------------------------------------------------------------------------------------------------

USE WHQJPlatformDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_GetMobileGameAndVersion') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_GetMobileGameAndVersion
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO

----------------------------------------------------------------------------------------------------

CREATE PROCEDURE NET_PW_GetMobileGameAndVersion

WITH ENCRYPTION AS

-- ��������
SET NOCOUNT ON

-- ִ���߼�
BEGIN
	-- ��ȡ�����汾����
	SELECT Field1,Field2,Field3,Field4,Field6,Field8 FROM WHQJNativeWebDB.dbo.ConfigInfo WHERE ConfigKey=N'MobilePlatformVersion'

	-- ��ȡ��Ϸ�б�
	SELECT * FROM MobileKindItem WHERE Nullity=0 ORDER BY SortID ASC,KindID DESC
	
END

RETURN 0

GO