USE [WHQJNativeWebDB]
GO

SET NOCOUNT ON

-- 网站系统配置
TRUNCATE TABLE ConfigInfo
GO

INSERT INTO ConfigInfo(ConfigKey,ConfigName,ConfigString,Field1,Field2,Field3,Field4,Field5,Field6,SortID) VALUES(N'MobilePlatformVersion',N'移动版大厅配置',
N'参数说明
字段1：热更新下载路径   
字段2：大厅版本号 
字段3：资源版本号
字段4：ios企业版本的下载地址
字段5：苹果大厅下载地址
字段6：安卓大厅下载地址
字段7：U3D苹果大厅版本号
字段8：U3D安卓大厅版本号
字段9：U3D苹果大厅下载地址
字段10：U3D安卓大厅下载地址
字段11：U3D苹果老大厅下载地址
字段12：U3D安卓老大厅下载地址
字段13：U3D资源版本号',N'http://qj.foxuc.net/Download/Phone',N'0',N'0',N'',N'itms-services://?action=download-manifest&url=https://qj.foxuc.net/Download/LuaMBClient_LY.plist',N'http://172.16.3.211:6511/Download/LuaMBClient_LY.apk',4)
INSERT INTO ConfigInfo(ConfigKey,ConfigName,ConfigString,Field1,Field2,Field3,Field4,Field5,Field6,SortID) VALUES(N'SysCustomerService',N'系统客服配置',
N'参数说明
字段1：客服电话   
字段2：客服微信 
字段3：客服QQ',
N'400-000-7043',N'4000007043',N'4000007043',N'',N'',
N'',5)

INSERT INTO ConfigInfo(ConfigKey,ConfigName,ConfigString,Field1,Field2,Field3,Field4,SortID) VALUES(N'WebSiteConfig',N'网站站点配置',
N'参数说明
字段1：网站二维码地址 
字段2：网站图片服务器地址
字段3：网站前台服务器地址
字段4：网站分享链接地址',N'http://qj.foxuc.net',N'http://imageqj.foxuc.net',N'http://qj.foxuc.net',N'http://qj.foxuc.net',6)
GO

-- 手机广告配置
TRUNCATE TABLE dbo.Ads
go

INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'大厅广告',N'/Initialize/ads_1.jpg',N'ad_to_createroom_action',3,0,N'大厅界面广告',1)
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'大厅广告',N'/Initialize/ads_2.jpg',N'ad_to_video_action',3,1,N'大厅界面广告',1)
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'大厅广告',N'/Initialize/ads_3.jpg',N'ad_to_identify_action',3,2,N'大厅界面广告',1)

INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'签到',N'/Initialize/45(1).png',N'1',6,2,N'内部看的，跳转签到系统',3)--u3d
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'优惠多多 豪礼大放送',N'/Initialize/39.png',N'4',6,4,N'内部看的，跳转商城系统',3)
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'推广分享',N'/Initialize/44(1).png',N'2',6,0,N'内部看的，跳转分享系统',3)

INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'内部看的，跳转比赛系统',N'/Initialize/40(1).png',N'3',6,4,N'内部看的，跳转比赛系统',2)--lua
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'推广分享',N'/Initialize/49.png',N'2',6,4,N'内部看的，跳转分享系统',2)
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'内部看的，跳转商城系统',N'/Initialize/41(1).png',N'4',6,3,N'内部看的，跳转商城系统',2)
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'内部看的，跳转签到系统',N'/Initialize/42(1).png',N'1',6,1,N'内部看的，跳转签到系统',2)
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'内部看的，无功能',N'/Initialize/43(1).png',N'',0,5,N'内部看的，无功能',2)

INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'H5活动广告',N'/Initialize/h51.png',N'',6,1,N'内部看的，无功能',4) --h5
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'H5活动广告',N'/Initialize/h52.png',N'',6,2,N'内部看的，无功能',4)
INSERT  Ads(Title,ResourceURL,LinkURL,Type,SortID,Remark,PlatformType) values(N'H5活动广告',N'/Initialize/h53.png',N'',6,3,N'内部看的，无功能',4)

-- 常见问题配置
TRUNCATE TABLE Question
GO

INSERT INTO Question(QuestionTitle,Answer,SortID) VALUES(N'如何获取钻石？', N'请联系客服：12345678', 1)
INSERT INTO Question(QuestionTitle,Answer,SortID) VALUES(N'如何获取游戏币？', N'请联系客服：12345678', 2)
GO

-- 系统公告配置
TRUNCATE TABLE SystemNotice
GO

INSERT INTO SystemNotice(NoticeTitle,MoblieContent,SortID,Publisher,PublisherTime,IsHot,IsTop,Nullity) 
VALUES(N'欢迎光临最新棋牌平台',N'欢迎光临最新棋牌平台,这里有最精彩、最刺激的棋牌游戏',1,N'棋牌平台',GETDATE(),1,1,0)
GO

--排行榜
truncate table RankingConfig
go
SET IDENTITY_INSERT [dbo].[RankingConfig] ON 
INSERT [dbo].[RankingConfig] ([ConfigID], [TypeID], [RankType], [Gold], [Diamond], [AwardTicket], [CollectDate]) VALUES (8, 2, 1, 10000, 100, 0, CAST(0x0000A913012F8399 AS DateTime))
INSERT [dbo].[RankingConfig] ([ConfigID], [TypeID], [RankType], [Gold], [Diamond], [AwardTicket], [CollectDate]) VALUES (10, 2, 2, 7000, 80, 0, CAST(0x0000A913012FA3F2 AS DateTime))
INSERT [dbo].[RankingConfig] ([ConfigID], [TypeID], [RankType], [Gold], [Diamond], [AwardTicket], [CollectDate]) VALUES (11, 2, 3, 5000, 70, 0, CAST(0x0000A913012FCCA2 AS DateTime))
INSERT [dbo].[RankingConfig] ([ConfigID], [TypeID], [RankType], [Gold], [Diamond], [AwardTicket], [CollectDate]) VALUES (12, 2, 4, 4000, 60, 0, CAST(0x0000A913012FDB25 AS DateTime))
INSERT [dbo].[RankingConfig] ([ConfigID], [TypeID], [RankType], [Gold], [Diamond], [AwardTicket], [CollectDate]) VALUES (13, 2, 5, 3000, 50, 0, CAST(0x0000A913012FEC1D AS DateTime))
INSERT [dbo].[RankingConfig] ([ConfigID], [TypeID], [RankType], [Gold], [Diamond], [AwardTicket], [CollectDate]) VALUES (14, 2, 6, 2000, 40, 0, CAST(0x0000A913013001F2 AS DateTime))
INSERT [dbo].[RankingConfig] ([ConfigID], [TypeID], [RankType], [Gold], [Diamond], [AwardTicket], [CollectDate]) VALUES (15, 2, 7, 1000, 10, 0, CAST(0x0000A9130130133E AS DateTime))
SET IDENTITY_INSERT [dbo].[RankingConfig] OFF
GO

--配置游戏规则
USE [WHQJNativeWebDB]
GO
truncate table GameRule
go
SET IDENTITY_INSERT [dbo].[GameRule] ON 

INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (1, 57, N'八人牛牛', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026104723.png', 2, 0, 0, CAST(0x0000A98500B1D023 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (2, 122, N'新百家乐', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026104748.png', 2, 0, 0, CAST(0x0000A98500B1EC7C AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (3, 200, N'斗地主', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026104805.png', 2, 0, 0, CAST(0x0000A98500B20178 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (4, 56, N'疯狂三张', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026104836.png', 2, 0, 0, CAST(0x0000A98500B224CF AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (5, 391, N'新广东麻将', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026104853.png', 2, 0, 0, CAST(0x0000A98500B2392F AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (6, 389, N'红中麻将', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026104909.png', 2, 0, 0, CAST(0x0000A98500B24B88 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (7, 33, N'三公', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026104932.png', 2, 0, 0, CAST(0x0000A98500B26740 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (8, 302, N'血战麻将', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026104945.png', 2, 0, 0, CAST(0x0000A98500B27685 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (9, 122, N'新百家乐', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113452.png', 1, 0, 0, CAST(0x0000A98500BEDA08 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (10, 57, N'八人牛牛', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113524.png', 1, 0, 0, CAST(0x0000A98500BEFF5F AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (11, 104, N'百人牛牛', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113535.png', 1, 0, 0, CAST(0x0000A98500BF0C55 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (12, 200, N'斗地主', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113548.png', 1, 0, 0, CAST(0x0000A98500BF1C69 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (13, 56, N'疯狂三张', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113605.png', 1, 0, 0, CAST(0x0000A98500BF2FE5 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (14, 391, N'新广东麻将', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113644.png', 1, 0, 0, CAST(0x0000A98500BF5D33 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (15, 389, N'红中麻将', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113711.png', 1, 0, 0, CAST(0x0000A98500BF7D1E AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (16, 707, N'襄阳卡五星', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113730.png', 1, 0, 0, CAST(0x0000A98500BF939B AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (17, 14, N'牌九', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113754.png', 1, 0, 0, CAST(0x0000A98500BFB01A AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (18, 33, N'三公', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113808.png', 1, 0, 0, CAST(0x0000A98500BFBFF1 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (19, 51, N'浙江十三水', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113821.png', 1, 0, 0, CAST(0x0000A98500BFCFA2 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (20, 401, N'五子棋', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113856.png', 1, 0, 0, CAST(0x0000A98500BFF7F5 AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (21, 302, N'血战麻将', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026113906.png', 1, 0, 0, CAST(0x0000A98500C003CE AS DateTime), 0)
INSERT [dbo].[GameRule] ([ID], [KindID], [KindName], [KindIcon], [KindIntro], [KindRule], [RuleImg], [Type], [LogID], [Nullity], [CollectDate], [SortID]) VALUES (22, 240, N'跑得快', N'', N'', N'', N'/Upload/RuleIoc/Rule20181026045255.png', 1, 0, 0, CAST(0x0000A985011634E5 AS DateTime), 0)
SET IDENTITY_INSERT [dbo].[GameRule] OFF

SET NOCOUNT OFF


----------------------------------------------------------------------------------------------------


USE [WHQJTreasureDB]
GO

SET NOCOUNT ON

-- 推广奖励配置
TRUNCATE TABLE SpreadConfig
GO

INSERT INTO SpreadConfig(SpreadNum,PresentDiamond,PresentPropID,PresentPropName,PresentPropNum,UpdateTime) VALUES(3,3,0,'',0,GETDATE())
INSERT INTO SpreadConfig(SpreadNum,PresentDiamond,PresentPropID,PresentPropName,PresentPropNum,UpdateTime) VALUES(6,6,0,'',0,GETDATE())
INSERT INTO SpreadConfig(SpreadNum,PresentDiamond,PresentPropID,PresentPropName,PresentPropNum,UpdateTime) VALUES(10,10,0,'',0,GETDATE())
INSERT INTO SpreadConfig(SpreadNum,PresentDiamond,PresentPropID,PresentPropName,PresentPropNum,UpdateTime) VALUES(15,15,306,'大喇叭',1,GETDATE())
INSERT INTO SpreadConfig(SpreadNum,PresentDiamond,PresentPropID,PresentPropName,PresentPropNum,UpdateTime) VALUES(20,20,306,'大喇叭',1,GETDATE())
GO

SET NOCOUNT OFF

--------------------------------------------------------------------------------------------------------------------------------------------------------------------

USE WHQJAgentDB
GO

SET NOCOUNT ON

-- 代理配置
TRUNCATE TABLE SystemStatusInfo
GO

INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'AgentAwardType',3,'代理返利模式','返利模式','键值：1代表仅开放充值返利【钻石】，2代表仅开放游戏税收返利【金币】，3代表同时开启1、2两种返利模式',10)
INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'ReceiveDiamondSave',100,'提取钻石保留','提取钻石保留','键值：0代表提取钻石时无保留，大于0代表每次提取钻石不可大于可提取值-保留值',50)
INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'ReceiveGoldSave',10000,'提取金币保留','提取金币保留','键值：0代表提取金币时无保留，大于0代表每次提取金币不可大于可提取值-保留值',51)
INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'ReceiveDiamondMin',100,'最少提取钻石','最少提取钻石','键值：每次提取钻石最少需要提取的值',52)
INSERT SystemStatusInfo ([StatusName],[StatusValue],[StatusString],[StatusTip],[StatusDescription],[SortID])
VALUES (N'ReceiveGoldMin',100,'最少金币保留','最少金币保留','键值：每次提取金币最少需要提取的值',53)
GO

-- 返利配置
TRUNCATE TABLE ReturnAwardConfig
GO

INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) VALUES (1,1,0.35,0)
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) VALUES (1,2,0.07,0)
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) VALUES (1,3,0.03,0)
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) VALUES (2,1,0.35,0)
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) VALUES (2,2,0.07,0)
INSERT ReturnAwardConfig(AwardType,AwardLevel,AwardScale,Nullity) VALUES (2,3,0.03,0)
GO

SET NOCOUNT OFF
GO


USE [WHQJAccountsDB]
GO

SET NOCOUNT ON


--配置注册奖励
truncate table RegisterGive
go
SET IDENTITY_INSERT [dbo].[RegisterGive] ON 

INSERT [dbo].[RegisterGive] ([ConfigID], [ScoreCount], [DiamondCount], [PlatformType]) VALUES (1, 1000, 100, 1)
INSERT [dbo].[RegisterGive] ([ConfigID], [ScoreCount], [DiamondCount], [PlatformType]) VALUES (2, 1000, 100, 2)
INSERT [dbo].[RegisterGive] ([ConfigID], [ScoreCount], [DiamondCount], [PlatformType]) VALUES (3, 1000, 100, 3)
SET IDENTITY_INSERT [dbo].[RegisterGive] OFF

SET NOCOUNT OFF
GO


