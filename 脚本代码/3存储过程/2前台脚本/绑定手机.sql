USE [WHQJAccountsDB]
GO

----------------------------------------------------------
--绑定手机号
IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].NET_PW_BindMolible') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].NET_PW_BindMolible
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_NULLS ON
GO
CREATE PROCEDURE NET_PW_BindMolible
@Userid  int,  ---用户id
@Molible nvarchar(20),  ---手机号
@Code    nvarchar(10),   ---验证码
@time    int,    ---验证码过期时间（单位：秒）
@strErrorDescribe NVARCHAR(127) OUTPUT			-- 输出信息
as
 -- 属性设置
SET NOCOUNT ON

-- 基本信息
DECLARE @createtime datetime---验证码插入时间
DECLARE @RS INT-----操作结果 -1验证码错误-2验证码过期1绑定成功
declare @intervaltime int----输入验证码和获取验证码间隔时间（单位：秒）
declare @BindMolibleReward int ---绑定手机号奖励
declare @Gameid int----游戏id 
declare @PreScore int ---赠送前金币
declare @PreInsureScore int ---赠送前银行金币
set @RS=-1
select @BindMolibleReward=StatusValue from  SystemStatusInfo where StatusName='BindMolibleReward' 

select @createtime=CollectTime FROM dbo.CheckCode where PhoneNum=@Molible and CheckCode=@Code
select @Gameid=isnull(Gameid,0) from AccountsInfo where UserID=@Userid

IF EXISTS(SELECT * FROM dbo.AccountsInfo WHERE RegisterMobile=@Molible)
BEGIN
	SET  @strErrorDescribe='手机号码存在绑定账号'
	RETURN 1001
END

   if @Gameid>0 and @createtime is not null
    begin
	select @PreScore=Score,@PreInsureScore=InsureScore from [WHQJTreasureDB].dbo.[GameScoreInfo] where UserID=@UserID

  set @intervaltime=DATEDIFF(ss,@createtime,getdate());
  ---判断验证码是否过期
  if @time<@intervaltime
    begin
	set  @RS=-2
	end
	---绑定手机号
  else
   begin
        update AccountsInfo set RegisterMobile=@Molible where UserID=@Userid
		if @BindMolibleReward>0
		begin
		update [WHQJTreasureDB].dbo.[GameScoreInfo] set Score=Score+@BindMolibleReward where UserID=@Userid
		-- 流水帐
		 INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
      (SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
      VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 16, @PreScore, @PreInsureScore, @BindMolibleReward, '', GETDATE())
       DELETE FROM  dbo.CheckCode where PhoneNum=@Molible and CheckCode=@Code
	   end
       set  @RS=1
   end
   end
  set @strErrorDescribe=@RS