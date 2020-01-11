USE [WHQJRecordDB]
GO
IF EXISTS (SELECT *FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_TurnTableCount') AND OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_TurnTableCount
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE NET_PW_TurnTableCount
WITH ENCRYPTION AS
SET NOCOUNT ON
DECLARE @Faild1 BIGINT
DECLARE @Faild2 BIGINT
DECLARE @Faild3 BIGINT
DECLARE @Faild4 BIGINT
DECLARE @Faild5 BIGINT
DECLARE @Faild6 BIGINT
DECLARE @Faild7 BIGINT
DECLARE @Faild8 BIGINT
DECLARE @Faild9 BIGINT
DECLARE @Faild10 BIGINT
DECLARE @Faild11 BIGINT
DECLARE @Faild12 BIGINT
DECLARE @Faild13 BIGINT
DECLARE @CountPerson1 INT
DECLARE @TatleMoney1 BIGINT
DECLARE @CountPerson2 INT
DECLARE @TatleMoney2 BIGINT
DECLARE @CountPerson3 INT
DECLARE @TatleMoney3 BIGINT
BEGIN
    SELECT @Faild1= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=1 AND TableIndex=0;
    SELECT @Faild2= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=2 AND TableIndex=0;
    SELECT @Faild3= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=3 AND TableIndex=0;
    SELECT @Faild4= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=4 AND TableIndex=0;
    SELECT @Faild5= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=5 AND TableIndex=0;
    SELECT @Faild6= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=6 AND TableIndex=0;
    SELECT @Faild7= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=7 AND TableIndex=0;
    SELECT @Faild8= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=8 AND TableIndex=0;
    SELECT @Faild9= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=9 AND TableIndex=0;
    SELECT @Faild10= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=10 AND TableIndex=0;
    SELECT @Faild11= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=11 AND TableIndex=0;
    SELECT @Faild12= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=12 AND TableIndex=0;
    SELECT @Faild13= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=13 AND TableIndex=0;
    SELECT @CountPerson1= COUNT(*) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND TableIndex=0;
    SELECT @TatleMoney1= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND TableIndex=0;

    INSERT INTO RecordCountTurn (TurnType,CountTime,Faild1,Faild2,Faild3,Faild4,Faild5,Faild6,Faild7,Faild8,Faild9,Faild10,Faild11,Faild12,Faild13,MoneyCount,PersonCount)
    VALUES(0,GETDATE(),@Faild1,@Faild2,@Faild3,@Faild4,@Faild5,@Faild6,@Faild7,@Faild8,@Faild9,@Faild10,@Faild11,@Faild12,@Faild13,@TatleMoney1,@CountPerson1)

    SELECT @Faild1= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=1 AND TableIndex=1;
    SELECT @Faild2= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=2 AND TableIndex=1;
    SELECT @Faild3= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=3 AND TableIndex=1;
    SELECT @Faild4= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=4 AND TableIndex=1;
    SELECT @Faild5= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=5 AND TableIndex=1;
    SELECT @Faild6= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=6 AND TableIndex=1;
    SELECT @Faild7= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=7 AND TableIndex=1;
    SELECT @Faild8= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=8 AND TableIndex=1;
    SELECT @Faild9= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=9 AND TableIndex=1;
    SELECT @Faild10= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=10 AND TableIndex=1;
    SELECT @Faild11= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=11 AND TableIndex=1;
    SELECT @Faild12= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=12 AND TableIndex=1;
    SELECT @Faild13= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=13 AND TableIndex=1;
    SELECT @CountPerson2= COUNT(*) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND TableIndex=1;
    SELECT @TatleMoney2= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND TableIndex=1;
    INSERT INTO RecordCountTurn (TurnType,CountTime,Faild1,Faild2,Faild3,Faild4,Faild5,Faild6,Faild7,Faild8,Faild9,Faild10,Faild11,Faild12,Faild13,MoneyCount,PersonCount)
    VALUES(1,GETDATE(),@Faild1,@Faild2,@Faild3,@Faild4,@Faild5,@Faild6,@Faild7,@Faild8,@Faild9,@Faild10,@Faild11,@Faild12,@Faild13,@TatleMoney2,@CountPerson2)

    SELECT @Faild1= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=1 AND TableIndex=2;
    SELECT @Faild2= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=2 AND TableIndex=2;
    SELECT @Faild3= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=3 AND TableIndex=2;
    SELECT @Faild4= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=4 AND TableIndex=2;
    SELECT @Faild5= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=5 AND TableIndex=2;
    SELECT @Faild6= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=6 AND TableIndex=2;
    SELECT @Faild7= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=7 AND TableIndex=2;
    SELECT @Faild8= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=8 AND TableIndex=2;
    SELECT @Faild9= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=9 AND TableIndex=2;
    SELECT @Faild10= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=10 AND TableIndex=2;
    SELECT @Faild11= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=11 AND TableIndex=2;
    SELECT @Faild12= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=12 AND TableIndex=2;
    SELECT @Faild13= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND OpenPos=13 AND TableIndex=2;
    SELECT @CountPerson3= COUNT(*) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND TableIndex=2;
    SELECT @TatleMoney3= ISNULL(SUM(Reward),0) FROM RecordTurntable (NOLOCK) WHERE DATEDIFF(dd,Opentime,GETDATE())=0 AND TableIndex=2;
    INSERT INTO RecordCountTurn (TurnType,CountTime,Faild1,Faild2,Faild3,Faild4,Faild5,Faild6,Faild7,Faild8,Faild9,Faild10,Faild11,Faild12,Faild13,MoneyCount,PersonCount)
    VALUES(2,GETDATE(),@Faild1,@Faild2,@Faild3,@Faild4,@Faild5,@Faild6,@Faild7,@Faild8,@Faild9,@Faild10,@Faild11,@Faild12,@Faild13,@TatleMoney3,@CountPerson3)

    INSERT INTO RecordCountTurn (TurnType,CountTime,Faild1,Faild2,Faild3,Faild4,Faild5,Faild6,MoneyCount,PersonCount)
    VALUES(3,GETDATE(),@TatleMoney1,@CountPerson1,@TatleMoney2,@CountPerson2,@TatleMoney3,@CountPerson3,@TatleMoney1+@TatleMoney2+@TatleMoney3,@CountPerson1+@CountPerson2+@CountPerson3)
END
RETURN 0
GO