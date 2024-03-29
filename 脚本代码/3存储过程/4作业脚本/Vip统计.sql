USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PB_VipReward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PB_VipReward]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
--------------------------------------------------------------------	
--
CREATE PROC [NET_PB_VipReward]

WITH ENCRYPTION AS
    
SET NOCOUNT ON
BEGIN
    UPDATE UserVipInfo SET CheckInReward=1
    IF DATEPART(weekday,GETDATE())='2'
    BEGIN
        UPDATE UserVipInfo SET WeekReward=1
    END
    IF DATEPART(DD,GETDATE())='1'
    BEGIN
        UPDATE UserVipInfo SET MonthReward=1
    END
END
RETURN 0
GO