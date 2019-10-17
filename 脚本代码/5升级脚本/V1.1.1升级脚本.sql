--商城系统改为兑换系统
USE WHQJPlatformManagerDB
GO
UPDATE dbo.Base_Module SET Title='兑换系统' WHERE ModuleID=11

--去除代理版本
USE WHQJAccountsDB
go
DELETE FROM  dbo.SystemStatusInfo WHERE StatusName='AgentHomeVersion'
update [SystemStatusInfo] set StatusDescription='键值：0-无，1-微信官方，2-支付宝官方，3-微信,支付宝官方和在线支付，4-俊付通，7-全部' where StatusName='JJPayChannel' 
GO 


--去除注册服务
USE WHQJAccountsDB
go
DELETE FROM  dbo.SystemStatusInfo WHERE StatusName='EnjoinRegister'
GO 




