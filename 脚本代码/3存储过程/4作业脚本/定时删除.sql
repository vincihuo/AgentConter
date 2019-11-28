USE [WHQJTreasureDB]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PB_DELETEORDER]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PB_DELETEORDER]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------	
--
CREATE PROC [NET_PB_DELETEORDER]

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

BEGIN

    DELETE OnLinePayOrder WHERE OrderStates=1 AND DateDiff(dd,PayTime,GetDate())>1
    INSERT INTO WHQJRecordDB.dbo.DrawalOrderCopy SELECT * FROM DrawalOrder WHERE DateDiff(dd,CurrentTime,GetDate())>30
    DELETE DrawalOrder WHERE DateDiff(dd,CurrentTime,GetDate())>30
    INSERT INTO WHQJRecordDB.dbo.OnLinePayOrderCopy SELECT * FROM OnLinePayOrder WHERE DateDiff(dd,PayTime,GetDate())>30
    DELETE OnLinePayOrder WHERE DateDiff(dd,PayTime,GetDate())>30
    INSERT INTO WHQJRecordDB.dbo.BankPayOrderCopy SELECT * FROM BankPayOrder WHERE DateDiff(dd,PayTime,GetDate())>30
    DELETE BankPayOrder WHERE DateDiff(dd,PayTime,GetDate())>30
    INSERT INTO WHQJRecordDB.dbo.ImgPayOrderCopy SELECT * FROM ImgPayOrder WHERE DateDiff(dd,PayTime,GetDate())>30
    DELETE ImgPayOrder WHERE DateDiff(dd,PayTime,GetDate())>30

    DELETE ValiBetRecord WHERE DateDiff(dd,DepositTime,GetDate())>30
    DELETE AgentCountRecord WHERE DateDiff(dd,CountTime,GetDate())>10
    DELETE RecordAgentReward WHERE DateDiff(dd,drawalTime,GetDate())>30
END
RETURN 0
GO