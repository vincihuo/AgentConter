TITLE 网狐棋牌旗舰版数据库网站部分 自动安装中请勿关闭

COLOR 0A
CLS
@echo off
CLS
echo.
echo *************************************************************************
echo.
echo *******************网狐旗舰版一键安装脚本建立开始************************ 
echo.
echo *******************版权所有：深圳市网狐科技有限公司**********************
echo.
echo *************************************************************************
echo.

md D:\数据库\旗舰平台

set rootPath=1数据库创建\
osql -E -i "%rootPath%1数据库创建.sql"
osql -E -i "%rootPath%2数据表创建.sql"

set rootPath=2数据库数据\
osql -E -i "%rootPath%3更新脚本.sql"
osql -E -i "%rootPath%1系统数据.sql"
osql -E -i "%rootPath%2后台数据.sql"


set rootPath=3存储过程\1公用脚本\
osql -d WHQJAccountsDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJAgentDB -E  -n -i "%rootPath%分页过程.sql"
osql -d WHQJGroupDB -E  -n -i "%rootPath%分页过程.sql"

osql -d WHQJAccountsDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJAgentDB -E  -n -i "%rootPath%切字符串.sql"
osql -d WHQJGroupDB -E  -n -i "%rootPath%切字符串.sql"

osql -d WHQJAccountsDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJGameScoreDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJNativeWebDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJPlatformDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJPlatformManagerDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJRecordDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJTreasureDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJAgentDB -E  -n -i "%rootPath%生成流水号.sql"
osql -d WHQJGroupDB -E  -n -i "%rootPath%生成流水号.sql"

set rootPath=3存储过程\2前台脚本\
osql -E -i "%rootPath%大厅战绩详情.sql"
osql -E -i "%rootPath%代理创建代理.sql"
osql -E -i "%rootPath%代理登录.sql"
osql -E -i "%rootPath%代理返利.sql"
osql -E -i "%rootPath%代理关系查询.sql"
osql -E -i "%rootPath%代理后台登录.sql"
osql -E -i "%rootPath%代理领取返利.sql"
osql -E -i "%rootPath%代理转赠返利.sql"
osql -E -i "%rootPath%充值处理.sql"
osql -E -i "%rootPath%获取排行版数据.sql"
osql -E -i "%rootPath%充值处理.sql"
osql -E -i "%rootPath%俱乐部战绩详情.sql"
osql -E -i "%rootPath%领取排行榜奖励.sql"
osql -E -i "%rootPath%领取推广返利奖励.sql"
osql -E -i "%rootPath%领取推广好友奖励.sql"
osql -E -i "%rootPath%领取注册赠送奖励.sql"
osql -E -i "%rootPath%手机充值产品.sql"
osql -E -i "%rootPath%手机登录成功数据.sql"
osql -E -i "%rootPath%手机登录数据.sql"
osql -E -i "%rootPath%手机获取游戏数据.sql"
osql -E -i "%rootPath%玩家绑定代理.sql"
osql -E -i "%rootPath%用户代理中心.sql"
osql -E -i "%rootPath%用户注册.sql"
osql -E -i "%rootPath%用户注册微信.sql"
osql -E -i "%rootPath%在线充值.sql"
osql -E -i "%rootPath%在线订单.sql"
osql -E -i "%rootPath%在线苹果充值.sql"
osql -E -i "%rootPath%钻石兑换金币.sql"
osql -E -i "%rootPath%绑定手机.sql"
osql -E -i "%rootPath%购买奖品.sql"
osql -E -i "%rootPath%每日分享.sql"
osql -E -i "%rootPath%官方扫码入款.sql"
osql -E -i "%rootPath%官方银行入款.sql"
osql -E -i "%rootPath%入款打码量.sql"
osql -E -i "%rootPath%钻石购买.sql"
osql -E -i "%rootPath%提现下单.sql"

set rootPath=3存储过程\3后台脚本\
osql -E -i "%rootPath%菜单加载.sql"
osql -E -i "%rootPath%插入限制IP.sql"
osql -E -i "%rootPath%插入限制机器码.sql"
osql -E -i "%rootPath%管理员登录.sql"
osql -E -i "%rootPath%权限加载.sql"
osql -E -i "%rootPath%注册IP统计.sql"
osql -E -i "%rootPath%注册机器码统计.sql"
osql -E -i "%rootPath%代理钻石查询.sql"
osql -E -i "%rootPath%后台赠送钻石.sql"
osql -E -i "%rootPath%赠送靓号.sql"
osql -E -i "%rootPath%获取代理商下线.sql"
osql -E -i "%rootPath%系统创建代理.sql"
osql -E -i "%rootPath%后台赠送金币.sql"
osql -E -i "%rootPath%金币分布.sql"
osql -E -i "%rootPath%钻石分布.sql"
osql -E -i "%rootPath%数据汇总.sql"
osql -E -i "%rootPath%创建超端管理员.sql"
osql -E -i "%rootPath%后台批量查询.sql"
osql -E -i "%rootPath%查询约战详情.sql"
osql -E -i "%rootPath%用户显示游戏.sql"
osql -E -i "%rootPath%用户配置游戏.sql"
osql -E -i "%rootPath%后台赠送奖券.sql"
osql -E -i "%rootPath%官方订单处理.sql"
osql -E -i "%rootPath%提现处理.sql"

set rootPath=3存储过程\4作业脚本\
osql -E -i "%rootPath%代理返利.sql"
osql -E -i "%rootPath%每日数据统计.sql"
osql -E -i "%rootPath%财富排行榜.sql"
osql -E -i "%rootPath%胜局排行榜.sql"
osql -E -i "%rootPath%排行榜周奖励.sql"

set rootPath=3存储过程\5独立分页\
osql -E -i "%rootPath%用户列表分页.sql"
osql -E -i "%rootPath%在线玩家分页.sql"
osql -E -i "%rootPath%进出记录分页.sql"
osql -E -i "%rootPath%游戏记录分页.sql"
osql -E -i "%rootPath%银行记录分页.sql"
osql -E -i "%rootPath%用户钻石分页.sql"
osql -E -i "%rootPath%购买道具分页.sql"
osql -E -i "%rootPath%使用道具分页.sql"
osql -E -i "%rootPath%金币约战分页.sql"
osql -E -i "%rootPath%积分约战分页.sql"
osql -E -i "%rootPath%俱乐部分页.sql"
osql -E -i "%rootPath%代理返利分页.sql"
osql -E -i "%rootPath%代理列表分页.sql"
osql -E -i "%rootPath%代理转赠分页.sql"
osql -E -i "%rootPath%任务记录分页.sql"

set rootPath=4定时作业\
osql -E -i "%rootPath%每日代理税收返利定时执行.sql"
osql -E -i "%rootPath%每日数据统计定时执行.sql"
osql -E -i "%rootPath%财富排行榜执行作业.sql"
osql -E -i "%rootPath%胜局排行榜执行作业.sql"
osql -E -i "%rootPath%排行榜周奖励执行作业.sql"

echo.
echo.
echo *************************************************************************
echo.
echo *******************网狐旗舰版一键安装脚本建立完成************************ 
echo.
echo *******************版权所有：深圳市网狐科技有限公司**********************
echo.
echo *************************************************************************
echo.

pause


