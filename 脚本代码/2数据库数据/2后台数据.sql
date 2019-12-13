USE WHQJPlatformManagerDB

SET NOCOUNT ON

-- 模块表
TRUNCATE TABLE [dbo].[Base_Module]
INSERT INTO [dbo].[Base_Module] VALUES (N'1', N'0', N'用户系统', N'', N'1', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'2', N'0', N'充值系统', N'', N'2', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'3', N'0', N'维护系统', N'', N'3', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'4', N'0', N'网站系统', N'', N'4', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'5', N'0', N'金币系统', N'', N'5', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'6', N'0', N'钻石系统', N'', N'6', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'7', N'0', N'统计系统', N'', N'7', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'8', N'0', N'后台系统', N'', N'20', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'9', N'0', N'亲友圈系统', N'', N'8', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'10', N'0', N'代理系统', N'', N'9', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'11', N'0', N'兑换系统', N'', N'11', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'12', N'0', N'奖券系统', N'', N'6', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'13', N'0', N'提现系统', N'', N'2', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'100', N'1', N'用户管理', N'/Module/AccountManager/AccountsList.aspx', N'1', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'101', N'1', N'在线玩家', N'/Module/AccountManager/UserPlaying.aspx', N'3', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'102', N'1', N'赠送记录', N'/Module/AccountManager/RecordGrantGoldList.aspx', N'4', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'103', N'1', N'用户游戏', N'/Module/AccountManager/GeneralGame.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'201', N'2', N'线上订单', N'/Module/FilledManager/RecordPayDiamond.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'202', N'2', N'代理入款', N'/Module/FilledManager/OnLineWeChatList.aspx', N'3', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'203', N'2', N'自动入款配置', N'/Module/FilledManager/OnLinePayPage.aspx', N'1', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'204', N'2', N'充值渠道', N'/Module/FilledManager/ChanelPage.aspx', N'4', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'205', N'2', N'加密配置', N'/Module/FilledManager/EncryptionList.aspx', N'5', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'206', N'2', N'转账渠道', N'/Module/FilledManager/OfficalBankPayList.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'207', N'2', N'固码渠道', N'/Module/FilledManager/OfficalImgPayList.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'208', N'2', N'银行订单', N'/Module/FilledManager/BankOrderList.aspx', N'4', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'209', N'2', N'固码订单', N'/Module/FilledManager/ImgOrderList.aspx', N'4', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'301', N'3', N'游戏管理', N'/Module/AppManager/GameGameItemList.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'302', N'3', N'系统消息', N'/Module/AppManager/SystemMessageList.aspx', N'3', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'303', N'3', N'系统设置', N'/Module/AppManager/SystemSet.aspx', N'4', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'305', N'3', N'排行管理', N'/Module/AppManager/RankingConfigList.aspx', N'6', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'306', N'3', N'道具管理', N'/Module/AppManager/PropertyConfigList.aspx', N'7', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'307', N'3', N'签到管理', N'/Module/AppManager/GamePackageConfigList.aspx', N'8', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'308', N'3', N'每日分享管理', N'/Module/AppManager/ShareConfigList.aspx', N'9', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'400', N'4', N'站点配置', N'/Module/WebManager/LogoSet.aspx', N'1', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'401', N'4', N'游戏规则', N'/Module/WebManager/KindRuleList.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'402', N'4', N'广告管理', N'/Module/WebManager/AdsList.aspx', N'3', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'403', N'4', N'新闻公告', N'/Module/WebManager/SystemNoticeList.aspx', N'4', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'405', N'4', N'常见问题', N'/Module/WebManager/QuestionList.aspx', N'6', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'407', N'4', N'推送消息', N'/Module/WebManager/UMessagePushAll.aspx', N'7', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'500', N'5', N'金币管理', N'/Module/GoldManager/AccountsGoldList.aspx', N'1', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'503', N'5', N'银行记录', N'/Module/GoldManager/RecordBankTrade.aspx', N'4', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'504', N'5', N'进出记录', N'/Module/GoldManager/RecordGameInOut.aspx', N'5', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'505', N'5', N'游戏记录', N'/Module/GoldManager/RecordUserGame.aspx', N'6', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'506', N'5', N'金币约战', N'/Module/GoldManager/RecordGoldBattleList.aspx', N'7', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'507', N'5', N'稽核查询', N'/Module/GoldManager/VilaBetList.aspx', N'5', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'600', N'6', N'钻石管理', N'/Module/Diamond/DiamondList.aspx', N'1', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'604', N'6', N'积分约战', N'/Module/Diamond/RecordScoreBattleList.aspx', N'5', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'700', N'7', N'每日统计', N'/Module/DataStatistics/UserRegister.aspx', N'1', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'701', N'7', N'在线统计', N'/Module/DataStatistics/UserOnline.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'705', N'7', N'分布统计', N'/Module/DataStatistics/WealthDistribute.aspx', N'6', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'706', N'7', N'全局统计', N'/Module/DataStatistics/SystemStat.aspx', N'0', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'800', N'8', N'账号管理', N'/Module/BackManager/BaseRoleList.aspx', N'1', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'801', N'8', N'安全日志', N'/Module/OperationLog/SystemSecurityList.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'901', N'9', N'亲友圈配置', N'/Module/ClubManager/SystemSet.aspx', N'1', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'902', N'9', N'亲友圈管理', N'/Module/ClubManager/GroupList.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'1001', N'10', N'代理管理', N'/Module/AgentManager/AgentList.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'1101', N'11', N'商品管理', N'/Module/MallManager/MallInfoList.aspx', N'5', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'1102', N'11', N'订单管理', N'/Module/MallManager/MallOrderList.aspx', N'10', N'0', N'1', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'1200', N'12', N'奖券管理', N'/Module/AwardTicket/AwardTicketList.aspx', N'1', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'1201', N'12', N'奖券记录', N'/Module/AwardTicket/RecordAwardTicketSerialList.aspx', N'2', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'1202', N'12', N'兑换记录', N'/Module/AwardTicket/ExchangeAwardTicketList.aspx', N'3', N'0', N'0', N'', N'0')
GO

INSERT INTO [dbo].[Base_Module] VALUES (N'1301', N'13', N'提现订单', N'/Module/DrawalManager/DrawalOrderPage.aspx', N'1', N'0', N'0', N'', N'0')
GO
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


