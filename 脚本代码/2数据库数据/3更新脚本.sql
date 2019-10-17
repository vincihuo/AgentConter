----2018-8-31整理
-----每日分享相关
USE [WHQJNativeWebDB]
GO
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--drop table ShareConfig
CREATE TABLE [dbo].[ShareConfig](
	[ID] [int] NOT NULL IDENTITY(1,1),
	[DayShareLmt] [int] NULL,
	[TimeShareGold] [int] NULL,
    [TimeShareDiamond] [int] NULL,
	[Nullity] [int] null,
 CONSTRAINT [PK_T_ShareConfig] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
   insert ShareConfig(DayShareLmt,TimeShareGold,TimeShareDiamond,Nullity) values(1,10,10,0)
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ShareLog](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UserID] [bigint] NOT NULL,
	[LogType] [smallint] NULL,
	[DateID] [int] NULL,
	[TimeShareGold] [int] NULL,
	[TimeShareDiamond] [int] NULL,
	[Remark] [nvarchar](100) NULL,
	[LogTime] [datetime] NULL,
 CONSTRAINT [PK_ShareLog] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[ShareLog] ADD  DEFAULT (getdate()) FOR [LogTime]
GO
----------------------
------------------------排行榜相关字段添加
alter table [dbo].[RankingConfig] add AwardTicket int not null default(0)
alter table [dbo].[CacheRankAward] add AwardTicket int not null default(0)

-----------
---------手机绑定短信验证相关
------添加绑定手机奖励
 USE [WHQJAccountsDB]
GO
insert into SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values('BindMolibleReward',0,'绑定手机奖励','绑定手机奖励','键值：绑定手机号赠送奖励数',700)
insert into SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values('MolibleNum',0,'获取验证码限制次数','验证码限制','键值：获取验证码限制次数,0不限制',701)
go
------短信验证信息表
create table SMSInfo
 (
    id int PRIMARY key identity,
	Userid int,
	Mobile nvarchar(20),
	Code   nvarchar(10),
	date  datetime
 )
 go
 create table SMSLog
 (
    id int PRIMARY key identity,
	Mobile nvarchar(20),
	date  datetime
 )
 go
 ----------
 ----------兑换中心
------添加兑换中心开关
insert into SystemStatusInfo(StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID) values('IsRedemptionCenter',0,'手机兑换中心','手机兑换中心','键值：手机兑换中心开关，0-开启，1关闭',701)
go
-----------
----------首冲相关
INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'ISFirstType',3,'首充开关','首充开关','键值：0关闭，1开启账号首冲，2开启每日首充，3开启账号首冲、开启每日首充',200)
GO
----------------
----------------签到相关
INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'OpenGameSignIn',0,'是否开启手机签到','手机签到','键值：0-开启，1-关闭',15)
go
-------
------------增加奖券字段
use [WHQJTreasureDB]
go
alter table UserCurrency add [AwardTicket] int not null default(0)
go
use [WHQJAccountsDB]
go
---------系统配置修改
delete [dbo].[SystemStatusInfo] where StatusName='JJEffectiveFriendGame'
delete [dbo].[SystemStatusInfo] where StatusName='JJBindSpreadPresent'
update [SystemStatusInfo] set StatusDescription='键值：0-无，1-微信官方，2-支付宝官方，3-微信和支付宝官方，4-俊付通支付，7-全部'  where StatusName='JJPayChannel'
update [SystemStatusInfo] set StatusDescription='键值：0-无，1-每日财富，2-每日胜局，3-每日财富和每日胜局' where StatusName='JJRankingListType' 
go
-----------------
-----------------公告广告相关
use [WHQJNativeWebDB]
go
alter table [dbo].[Ads] add PlatformType int not null default(1)
alter table [dbo].[SystemNotice] add PlatformType int not null default(1)
go
------------------------------------兑换中心
insert into AwardType(TypeName,SortID,Nullity,CollectDate) values('游戏币',4,0,getdate())
insert into AwardType(TypeName,SortID,Nullity,CollectDate) values('日常',3,0,getdate())
insert into AwardType(TypeName,SortID,Nullity,CollectDate) values('数码',2,0,getdate())
insert into AwardType(TypeName,SortID,Nullity,CollectDate) values('卡券',1,0,getdate())


INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 1 , N'1万游戏币' , N'http://imagery.foxuc.net/rules/104.png' , 10,10000 , 0 ,0 , 1 ,0 ,GETDATE())
INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 1 , N'5万游戏币' , N'http://imagery.foxuc.net/rules/101.png' , 50,50000 , 0 ,0 , 2 ,0 ,GETDATE())
INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 1, N'100万游戏币' , N'http://imagery.foxuc.net/rules/105.png' , 95,1000000 , 0 ,0 , 3 ,0 ,GETDATE())
INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 1, N'500万游戏币' , N'http://imagery.foxuc.net/rules/102.png' , 490,5000000 , 0 ,0 , 4 ,0 ,GETDATE())

INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 2 , N'热水壶' , N'http://imagery.foxuc.net/rules/100.png' , 100,0 , 0 ,80 , 1 ,0 ,GETDATE())
INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 2 , N'纸巾' , N'http://imagery.foxuc.net/rules/97.png' , 40,0 , 0 ,4985 , 2 ,0 ,GETDATE())

INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 3 , N'小米耳机' , N'http://imagery.foxuc.net/rules/103.png' , 7000,0 , 0 ,50 , 1 ,0 ,GETDATE())
INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 3 , N'万能充电宝' , N'http://imagery.foxuc.net/rules/108.png' , 90,0 , 0 ,7998 , 2 ,0 ,GETDATE())
INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 3 , N'IphoneX' , N'http://imagery.foxuc.net/rules/106.png' , 99999999,0 , 0 ,10 , 3 ,0 ,GETDATE())

INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 4 , N'100元京东券' , N'http://imagery.foxuc.net/rules/96.png' , 8000,0 , 0 ,6000 , 1 ,0 ,GETDATE())
INSERT INTO dbo.AwardInfo( AwardType ,AwardName ,AwardImg ,UnitPrice ,Gold ,Diamond ,Inventory ,SortID ,Nullity ,CollectDate)
VALUES  ( 4 , N'沃尔玛100元购物券' , N'http://imagery.foxuc.net/rules/107.png' , 6000,0 , 0 ,3999 , 2 ,0 ,GETDATE())


go
-------------------U3D下载相关
alter table [dbo].[ConfigInfo] add Field9 nvarchar(128)
alter table [dbo].[ConfigInfo] add Field10 nvarchar(128)
alter table [dbo].[ConfigInfo] add Field11 nvarchar(128)
alter table [dbo].[ConfigInfo] add Field12 nvarchar(128)
alter table [dbo].[ConfigInfo] add Field13 nvarchar(128)
go

-- 1.1.10 新增配置值，代理中心版本
USE WHQJAccountsDB
GO

INSERT DBO.SystemStatusInfo (StatusName,StatusValue,StatusString,StatusTip,StatusDescription,SortID)
VALUES (N'AgentHomeVersion',1, N'代理后台的版本号，可切换新老后台',N'代理后台版本',N'键值：1-老版本房卡后台，2-新版本房卡后台',9999)
GO




