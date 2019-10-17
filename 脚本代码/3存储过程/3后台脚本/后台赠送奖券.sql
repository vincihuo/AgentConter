----------------------------------------------------------------------
-- 时间：2018-8-14
-- 用途：赠送奖券
----------------------------------------------------------------------

USE WHQJTreasureDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[WSP_PM_GrantAwardTicket]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[WSP_PM_GrantAwardTicket]
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
----------------------------------------------------------------------

CREATE PROCEDURE WSP_PM_GrantAwardTicket
	@MasterID INT,				-- 管理员标识
	@ClientIP VARCHAR(15),		-- 赠送地址
	@UserID INT,				-- 用户标识
	@AddAwardTicket BIGINT,			-- 赠送奖券
	@TypeID INT,				-- 记录类型
	@CollectNote NVARCHAR(32)	-- 赠送备注	
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 用户奖券信息
DECLARE @CurAwardTicket BIGINT
DECLARE @Nullity TINYINT
DECLARE @DateTime DATETIME

-- 执行逻辑
BEGIN
	-- 用户验证
	SELECT @Nullity=Nullity FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID = @UserID
	IF @Nullity IS NULL
	BEGIN
		RETURN 1001
	END
	IF @Nullity = 1
	BEGIN
		RETURN 1001
	END

	-- 获取用户钻石
	SELECT @CurAwardTicket=AwardTicket FROM UserCurrency WHERE UserID = @UserID
	IF @AddAwardTicket <=0  
	BEGIN
	  if @CurAwardTicket IS NULL
	   begin
		RETURN 1001
	   end
	   else if abs(@AddAwardTicket)>@CurAwardTicket
	   begin
	     RETURN 1001
	   end
	END

	IF @CurAwardTicket IS NULL
	BEGIN
		SET @CurAwardTicket = 0
		INSERT INTO UserCurrency(UserID,AwardTicket) VALUES(@UserID,@AddAwardTicket)
	END
	ELSE
	BEGIN
		UPDATE UserCurrency SET AwardTicket = AwardTicket + @AddAwardTicket WHERE UserID=@UserID
	END

	SET @DateTime = GETDATE()
	INSERT INTO WHQJRecordDB.dbo.RecordGrantAwardTicket(MasterID,UserID,TypeID,CurAwardTicket,AddAwardTicket,ClientIP,CollectDate,CollectNote) 
	VALUES(@MasterID,@UserID,@TypeID,@CurAwardTicket,@AddAwardTicket,@ClientIP,@DateTime,@CollectNote)

	 ----奖券流水
	    INSERT INTO WHQJRecordDB.dbo.RecordAwardTicketSerial(SerialNumber,MasterID,UserID,TypeID,CurAwardTicket,ChangeAwardTicket,ClientIP,CollectDate) 
		VALUES(dbo.WF_GetSerialNumber(),0,@UserID,0,@CurAwardTicket,@AddAwardTicket,@ClientIP,getdate())

END
RETURN 0

