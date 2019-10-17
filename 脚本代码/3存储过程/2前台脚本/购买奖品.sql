----------------------------------------------------------------------------------------------------
-- 版权：2013
-- 时间：2013-07-31
-- 用途：问题反馈
----------------------------------------------------------------------------------------------------
USE [WHQJNativeWebDB]
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].WSP_PW_BuyAward') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].WSP_PW_BuyAward
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

----------------------------------------------------------------------------------------------------
-- 购买商品
CREATE PROCEDURE WSP_PW_BuyAward
	@UserID	INT,					-- 用户标识
	@GameID INT,					-- 玩家游戏id
	@AwardID INT,					-- 商品标识
	@AwardType INT,					-- 商品类型标识
	@AwardName nvarchar(20),		-- 商品名称
	@AwardPrice INT,				-- 奖品价格
	@AwardCount INT,				-- 购买数量
	@TotalAmount INT,				-- 总金额
	@Gold INT,				        -- 兑换游戏币值(单个)
	@Diamond INT,				    -- 兑换钻石值（单个）
	@Compellation NVARCHAR(16),		-- 真实姓名
	@MobilePhone NVARCHAR(16),		-- 手机号码
	@Province NVARCHAR(16),					-- 省份
	@City NVARCHAR(16),						-- 城市
	@Area NVARCHAR(16),						-- 地区
	@DwellingPlace NVARCHAR(128),	-- 详细地址
	@BuyIP NVARCHAR(15),			-- 购买IP                     
	@OrderID nvarchar(128),			-- 订单号码	
	@strErrorDescribe NVARCHAR(127) OUTPUT	-- 输出信息
WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 账户信息
DECLARE @AwardTicket INT
DECLARE @SumGold BIGINT
DECLARE @SumDiamond BIGINT
DECLARE @BeforeScore BIGINT
DECLARE @BeforeDiamond BIGINT
declare @BeforeInsure BIGINT
--

-- 执行逻辑
BEGIN
	-- 验证用户
	SELECT @UserID=UserID FROM [WHQJAccountsDB].dbo.AccountsInfo 
	WHERE UserID=@UserID
	select @AwardTicket=isnull(AwardTicket,0) from [WHQJTreasureDB].dbo.UserCurrency where Userid=@UserID

	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe='用户不存在'
		RETURN 101
	END

	-- 验证奖牌
	IF @TotalAmount <= 0
	BEGIN
		SET @strErrorDescribe='兑换失败，支付元宝数异常'
		RETURN 101
	END

	IF @TotalAmount>@AwardTicket
	BEGIN
		SET @strErrorDescribe='兑换失败，奖券数不足'
		RETURN 101
	END
	 --兑换奖品为货币
	if @AwardType=1
	 begin
	 -- 兑换游戏币
	    if @Gold>0
		 begin
		 SELECT @BeforeScore = Score, @BeforeInsure=InsureScore FROM WHQJTreasureDB.DBO.GameScoreInfo(NOLOCK) WHERE UserID = @UserID
		IF @BeforeScore IS NULL 
		BEGIN
			INSERT WHQJTreasureDB.DBO.GameScoreInfo (UserID,Score,InsureScore) VALUES (@UserID,0,0)
			SET @BeforeScore = 0
			set @BeforeInsure=0
		END
		 SET @SumGold=@Gold*@AwardCount
		    update [WHQJTreasureDB].dbo.GameScoreInfo SET score=score+@SumGold WHERE UserID=@UserID
      ----金币流水
	    INSERT INTO WHQJRecordDB.dbo.RecordTreasureSerial
			(SerialNumber,MasterID,UserID,TypeID,CurScore,CurInsureScore,ChangeScore,ClientIP,CollectDate)
		VALUES(dbo.WF_GetSerialNumber(), 0, @UserID, 5, @BeforeScore, @BeforeInsure, @SumGold, @BuyIP, getdate())

		 end


		  -- 兑换钻石
	    if @Diamond>0
		 begin
		 SELECT @BeforeDiamond =Diamond FROM WHQJTreasureDB.DBO.UserCurrency(NOLOCK) WHERE UserID = @UserID
		IF @BeforeDiamond IS NULL 
		BEGIN
			INSERT WHQJTreasureDB.DBO.UserCurrency (UserID,Diamond,AwardTicket) VALUES (@UserID,0,0)
			SET @BeforeDiamond = 0
		END
		 SET @SumDiamond=@Diamond*@AwardCount
		    update [WHQJTreasureDB].dbo.UserCurrency SET Diamond=Diamond+@SumDiamond WHERE UserID=@UserID
      ----钻石流水
	    INSERT INTO WHQJRecordDB.dbo.RecordDiamondSerial(SerialNumber,MasterID,UserID,TypeID,CurDiamond,ChangeDiamond,ClientIP,CollectDate) 
		VALUES(dbo.WF_GetSerialNumber(),0,@UserID,12,@BeforeDiamond,@SumDiamond,@BuyIP,getdate())

		 end
	 end


	-- 更新奖牌
	--BEGIN TRAN
	UPDATE [WHQJTreasureDB].dbo.UserCurrency SET AwardTicket=AwardTicket-@TotalAmount

	WHERE UserID=@UserID
	
	-- 插入订单
	INSERT INTO AwardOrder(OrderID,AwardID,UserID,GameID,AwardType,AwardName,UnitPrice,BuyNum,PayTicket,Gold,Diamond,Compellation,
		MobilePhone,Province,City,Area,DetailAddress,ClinetIP)
	VALUES(@OrderID,@AwardID,@UserID,@GameID,@AwardType,@AwardName,@AwardPrice,@AwardCount,@TotalAmount,@Gold,@Diamond,@Compellation,
		@MobilePhone,@Province,@City,@Area,@DwellingPlace,@BuyIP)

    ----奖券流水
	  
	    INSERT INTO WHQJRecordDB.dbo.RecordAwardTicketSerial(SerialNumber,MasterID,UserID,TypeID,CurAwardTicket,ChangeAwardTicket,ClientIP,CollectDate) 
		VALUES(dbo.WF_GetSerialNumber(),0,@UserID,10,@AwardTicket,0-@TotalAmount,@BuyIP,getdate())


	SELECT @OrderID AS OrderID
		
	--更新奖品
	if @AwardType<>1
	UPDATE AwardInfo SET Inventory=Inventory-@AwardCount WHERE AwardID=@AwardID
	--COMMIT TRAN
	
	RETURN 0
END
RETURN 0
GO