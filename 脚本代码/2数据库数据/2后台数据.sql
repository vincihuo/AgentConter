USE WHQJPlatformManagerDB

SET NOCOUNT ON

-- 模块表
TRUNCATE TABLE [dbo].[Base_Module]

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (1, 0, N'用户系统', N'', 1, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (2, 0, N'充值系统', N'', 2, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (3, 0, N'维护系统', N'', 3, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (4, 0, N'网站系统', N'', 4, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (5, 0, N'金币系统', N'', 5, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (6, 0, N'钻石系统', N'', 6, 0, 1, N'',0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (7, 0, N'统计系统', N'', 7, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (8, 0, N'后台系统', N'', 20, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (9, 0, N'亲友圈系统', N'', 8, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (10, 0, N'代理系统', N'', 9, 0, 1, N'', 0)


INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (100, 1, N'用户管理', N'/Module/AccountManager/AccountsList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (101, 1, N'在线玩家', N'/Module/AccountManager/UserPlaying.aspx', 0, 0, 3, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (102, 1, N'赠送记录', N'/Module/AccountManager/RecordGrantGoldList.aspx', 0, 0, 4, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (103, 1, N'用户游戏', N'/Module/AccountManager/GeneralGame.aspx', 0, 0, 2, N'', 0)
--INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (104, 1, N'任务管理', '/Module/AccountManager/TaskList.aspx',0,0,4,N'',0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (105, 1, N'注册赠送', '/Module/AccountManager/RegisterGiveList.aspx',0,0,4,N'',0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (200, 2, N'充值配置', N'/Module/FilledManager/AppPayConfigList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (201, 2, N'充值记录', N'/Module/FilledManager/RecordPayDiamond.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (202, 2, N'在线充值配置', N'/Module/FilledManager/OnLineWeChatList.aspx', 3, 0, 0, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (301, 3, N'游戏管理', N'/Module/AppManager/GameGameItemList.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (302, 3, N'系统消息', N'/Module/AppManager/SystemMessageList.aspx', 0, 0, 3, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (303, 3, N'系统设置', N'/Module/AppManager/SystemSet.aspx', 0, 0, 4, N'', 0)
--INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (304, 3, N'推广管理', N'/Module/AppManager/SpreadConfigList.aspx', 0, 0, 5, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (305, 3, N'排行管理', N'/Module/AppManager/RankingConfigList.aspx', 0, 0, 6, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (306, 3, N'道具管理', N'/Module/AppManager/PropertyConfigList.aspx', 0, 0, 7, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (307, 3, N'签到管理', N'/Module/AppManager/GamePackageConfigList.aspx', 0, 0, 8, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (308, 3, N'每日分享管理', N'/Module/AppManager/ShareConfigList.aspx', 0, 0, 9, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (400, 4, N'站点配置', N'/Module/WebManager/LogoSet.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (401, 4, N'游戏规则', N'/Module/WebManager/KindRuleList.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (402, 4, N'广告管理', N'/Module/WebManager/AdsList.aspx', 0, 0, 3, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (403, 4, N'新闻公告', N'/Module/WebManager/SystemNoticeList.aspx', 0, 0, 4, N'', 0)
--INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (404, 4, N'消息推送', N'/Module/WebManager/UMessagePushList.aspx', 0, 0, 5, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (405, 4, N'常见问题', N'/Module/WebManager/QuestionList.aspx', 0, 0, 6, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (500, 5, N'金币管理', N'/Module/GoldManager/AccountsGoldList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (503, 5, N'银行记录', N'/Module/GoldManager/RecordBankTrade.aspx', 0, 0, 4, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (504, 5, N'进出记录', N'/Module/GoldManager/RecordGameInOut.aspx', 0, 0, 5, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (505, 5, N'游戏记录', N'/Module/GoldManager/RecordUserGame.aspx', 0, 0, 6, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (506, 5, N'金币约战', N'/Module/GoldManager/RecordGoldBattleList.aspx', 0, 0, 7, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (600, 6, N'钻石管理', N'/Module/Diamond/DiamondList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (604, 6, N'积分约战', N'/Module/Diamond/RecordScoreBattleList.aspx', 0, 0, 5, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (700, 7, N'每日统计', N'/Module/DataStatistics/UserRegister.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (701, 7, N'在线统计', N'/Module/DataStatistics/UserOnline.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (705, 7, N'分布统计', N'/Module/DataStatistics/WealthDistribute.aspx', 0, 0, 6, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (706, 7, N'全局统计', N'/Module/DataStatistics/SystemStat.aspx', 0, 0, 0, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (800, 8, N'账号管理', N'/Module/BackManager/BaseRoleList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (801, 8, N'安全日志', N'/Module/OperationLog/SystemSecurityList.aspx', 0, 0, 2, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (901, 9, N'亲友圈配置', N'/Module/ClubManager/SystemSet.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (902, 9, N'亲友圈管理', N'/Module/ClubManager/GroupList.aspx', 0, 0, 2, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (1000, 10, N'代理配置', N'/Module/AgentManager/SystemSet.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (1001, 10, N'代理管理', N'/Module/AgentManager/AgentList.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (1002, 10, N'代理返利', N'/Module/AgentManager/AgentReturnConfigList.aspx', 0, 0, 3, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (11, 0, N'兑换系统', N'', 11, 0, 1, N'', 0)
--INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (1100, 11, N'类型管理', N'/Module/MallManager/MallTypeList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (1101, 11, N'商品管理', N'/Module/MallManager/MallInfoList.aspx', 5, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (1102, 11, N'订单管理', N'/Module/MallManager/MallOrderList.aspx', 10, 0, 1, N'', 0)

INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [OrderNo], [Nullity], [IsMenu], [Description], [ManagerPopedom]) VALUES (12, 0, N'奖券系统', N'', 6, 0, 1, N'',0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (1200, 12, N'奖券管理', N'/Module/AwardTicket/AwardTicketList.aspx', 0, 0, 1, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (1201, 12, N'奖券记录', N'/Module/AwardTicket/RecordAwardTicketSerialList.aspx', 0, 0, 2, N'', 0)
INSERT [dbo].[Base_Module] ([ModuleID], [ParentID], [Title], [Link], [IsMenu], [Nullity], [OrderNo], [Description], [ManagerPopedom]) VALUES (1202, 12, N'兑换记录', N'/Module/AwardTicket/ExchangeAwardTicketList.aspx', 0, 0, 3, N'', 0)

-- 模板权限表
TRUNCATE TABLE Base_ModulePermission

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'查看', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'编辑', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'赠送靓号', 256, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'冻/解', 8192, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (100, N'设置权限/取消权限', 524288, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (101, N'查看', 1, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (102, N'查看', 1, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (103, N'查看', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (103, N'添加', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (103, N'编辑', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (103, N'删除', 8, 0, 0, 1)

--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (104,'查看',1,0,0,1)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (104,'添加',2,0,0,1)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (104,'编辑',4,0,0,1)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (104,'冻/解',8192,0,0,1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (105, N'查看', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (105, N'添加', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (105, N'编辑', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (105, N'删除', 8, 0, 0, 1)


INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (200, N'查看', 1, 0, 0, 2)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (200, N'添加', 2, 0, 0, 2)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (200, N'编辑', 4, 0, 0, 2)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (200, N'删除', 8, 0, 0, 2)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (201, N'查看', 1, 0, 0, 2)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (202, N'查看', 1, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (202, N'添加', 2, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (202, N'编辑', 4, 0, 0, 1)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (202, N'删除', 8, 0, 0, 1)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (301, N'查看', 1, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (301, N'添加', 2, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (301, N'编辑', 4, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (301, N'删除', 8, 0, 0, 3)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'查看', 1, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'添加', 2, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'编辑', 4, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'删除', 8, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (302, N'冻/解', 8192, 0, 0, 3)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (303, N'查看', 1, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (303, N'编辑', 4, 0, 0, 3)

--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (304, N'查看', 1, 0, 0, 3)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (304, N'添加', 2, 0, 0, 3)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (304, N'编辑', 4, 0, 0, 3)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (304, N'删除', 8, 0, 0, 3)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (305, N'查看', 1, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (305, N'添加', 2, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (305, N'编辑', 4, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (305, N'删除', 8, 0, 0, 3)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (306, N'查看', 1, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (306, N'编辑', 4, 0, 0, 3)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (307, N'查看', 1, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (307, N'添加', 2, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (307, N'编辑', 4, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (307, N'删除', 8, 0, 0, 3)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (308, N'查看', 1, 0, 0, 3)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (308, N'编辑', 4, 0, 0, 3)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (400, N'查看', 1, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (400, N'编辑', 4, 0, 0, 4)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'查看', 1, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'添加', 2, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'编辑', 4, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'删除', 8, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (401, N'冻/解', 8192, 0, 0, 4)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (402, N'查看', 1, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (402, N'添加', 2, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (402, N'编辑', 4, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (402, N'删除', 8, 0, 0, 4)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (403, N'查看', 1, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (403, N'添加', 2, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (403, N'编辑', 4, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (403, N'删除', 8, 0, 0, 4)

--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (404, N'查看', 1, 0, 0, 4)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (404, N'编辑', 4, 0, 0, 4)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (405, N'查看', 1, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (405, N'添加', 2, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (405, N'编辑', 4, 0, 0, 4)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (405, N'删除', 8, 0, 0, 4)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (500, N'查看', 1, 0, 0, 5)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (500, N'赠送金币', 32, 0, 0, 5)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (503, N'查看', 1, 0, 0, 5)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (504, N'查看', 1, 0, 0, 5)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (505, N'查看', 1, 0, 0, 5)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (506, N'查看', 1, 0, 0, 5)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (600, N'查看', 1, 0, 0, 6)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (600, N'赠送钻石', 262144, 0, 0, 6)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (603, N'查看', 1, 0, 0, 6)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (604, N'查看', 1, 0, 0, 6)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (606, N'查看', 1, 0, 0, 6)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (700, N'查看', 1, 0, 0, 7)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (701, N'查看', 1, 0, 0, 7)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (705, N'查看', 1, 0, 0, 7)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (706, N'查看', 1, 0, 0, 7)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'查看', 1, 0, 0, 8)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'添加', 2, 0, 0, 8)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'编辑', 4, 0, 0, 8)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'删除', 8, 0, 0, 8)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (800, N'冻/解', 8192, 0, 0, 8)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (801, N'查看', 1, 0, 0, 8)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (901, N'查看', 1, 0, 0, 9)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (901, N'添加', 2, 0, 0, 9)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (901, N'编辑', 4, 0, 0, 9)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (901, N'删除', 8, 0, 0, 9)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (902, N'查看', 1, 0, 0, 9)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (902, N'冻结/解冻', 2, 0, 0, 9)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (902, N'移交群主', 4, 0, 0, 9)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (902, N'强制解散', 8, 0, 0, 9)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1000, N'查看', 1, 0, 0, 10)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1000, N'修改', 4, 0, 0, 10)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1001, N'查看', 1, 0, 0, 10)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1001, N'新增', 2, 0, 0, 10)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1001, N'修改', 4, 0, 0, 10)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1001, N'冻结', 8, 0, 0, 10)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1002, N'查看', 1, 0, 0, 10)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1002, N'新增', 2, 0, 0, 10)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1002, N'修改', 4, 0, 0, 10)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1002, N'删除', 8, 0, 0, 10)

--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1100, N'查看', 1, 0, 0, 11)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1100, N'添加', 2, 0, 0, 11)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1100, N'编辑', 4, 0, 0, 11)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1100, N'删除', 8, 0, 0, 11)
--INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1100, N'启/禁用', 32768, 0, 0, 11)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1101, N'查看', 1, 0, 0, 11)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1101, N'添加', 2, 0, 0, 11)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1101, N'编辑', 4, 0, 0, 11)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1101, N'删除', 8, 0, 0, 11)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1101, N'上架/下架', 32768, 0, 0, 11)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1102, N'查看', 1, 0, 0, 11)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1102, N'处理订单', 65536, 0, 0, 11)

INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1200, N'查看', 1, 0, 0, 12)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1200, N'赠送钻石', 262144, 0, 0, 12)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1201, N'查看', 1, 0, 0, 12)
INSERT [dbo].[Base_ModulePermission] ([ModuleID], [PermissionTitle], [PermissionValue], [Nullity], [StateFlag], [ParentID]) VALUES (1202, N'查看', 1, 0, 0, 12)

-- 用户表
TRUNCATE TABLE Base_Users

INSERT INTO Base_Users(Username,Password,RoleID) VALUES('admin','E10ADC3949BA59ABBE56E057F20F883E',1)

-- 角色表
TRUNCATE TABLE Base_Roles

INSERT INTO Base_Roles(RoleName,Description) VALUES('超级管理员','超级管理员')

SET NOCOUNT OFF


