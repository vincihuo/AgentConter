USE WHQJAgentDB
GO

IF EXISTS (SELECT * FROM DBO.SYSOBJECTS WHERE ID = OBJECT_ID(N'[dbo].[NET_PB_RecordAgentAward]') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].[NET_PB_RecordAgentAward]
GO


SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO

--------------------------------------------------------------------	
--
CREATE PROC [NET_PB_RecordAgentAward]
(
	@dwUserID			INT,					--用户标识
	@dwReturnBase	INT,			-- 返利基准
	@dwAwardType TINYINT,       -- 返利类型：1、充值返利【钻石】；2、游戏税收返利【金币】
  @strExtraField NVARCHAR(32),  --扩展字段：充值返利记录充值【充值订单号】；游戏税收返利记录【游戏名称(房间名称)】

	@strErrorDescribe NVARCHAR(127) OUTPUT		--输出信息
)

WITH ENCRYPTION AS

-- 属性设置
SET NOCOUNT ON

-- 用户信息
DECLARE @UserID INT
DECLARE @Nullity TINYINT
DECLARE @AboveAgentID INT


BEGIN
	-- 数据验证
	IF @dwReturnBase<=0
	BEGIN
		SET @strErrorDescribe=N'抱歉，您没有可返利数额！'
		RETURN 1001
	END

	-- 查询用户	
	SELECT @UserID=UserID,@Nullity=Nullity FROM WHQJAccountsDB.DBO.AccountsInfo WITH(NOLOCK) WHERE UserID=@dwUserID

	-- 用户存在
	IF @UserID IS NULL
	BEGIN
		SET @strErrorDescribe=N'抱歉，您的帐号不存在！'
		RETURN 1001
	END	

	-- 帐号禁止
	IF @Nullity=1
	BEGIN
		SET @strErrorDescribe=N'抱歉，您的帐号已冻结！'
		RETURN 1002
	END	

  SELECT @AboveAgentID = AgentID FROM AgentBelowInfo WHERE UserID = @dwUserID

  IF @AboveAgentID = 0 
  BEGIN
    SET @strErrorDescribe=N'抱歉，帐号未被代理，无奖励返利'
    RETURN 1003
  END

  DECLARE @AgentAwardType TINYINT
  SELECT @AgentAwardType=StatusValue FROM WHQJAgentDB.DBO.SystemStatusInfo WHERE StatusName = N'AgentAwardType'
  IF @AgentAwardType IS NULL 
  BEGIN
    -- 无配置时 默认不开启
    SET @AgentAwardType = 0
  END
  IF @AgentAwardType & @dwAwardType <> @dwAwardType
  BEGIN
    SET @strErrorDescribe=N'抱歉，该返利模式未开启'
    RETURN 1004
  END
	
    -- 如果存在返利配置，写入返利记录
	IF EXISTS (SELECT 1 FROM ReturnAwardConfig WHERE Nullity = 0 AND AwardType = @dwAwardType)
	BEGIN

    DECLARE @DateTime DateTime
	DECLARE @DateID INT
	DECLARE @I INT
	DECLARE @PUserID INT
	DECLARE @AwardScale DECIMAL(18,6)
	DECLARE @AwardValue BIGINT
    SET @DateTime = GETDATE()
	SET @DateID = CAST(CAST(@DateTime AS FLOAT) AS INT)

	SELECT LevelID,UserID INTO #Tb_AgentAbove_Cache FROM [dbo].[WF_GetAgentAboveAgent](@AboveAgentID) ORDER BY LevelID ASC
	SELECT @I=COUNT(UserID) FROM #Tb_AgentAbove_Cache
	IF @I>3 SET @I=3
	IF @I=0
	BEGIN
		SET @strErrorDescribe=N'抱歉，无返利上线'
		RETURN 1005
	END
	WHILE @I>0
	BEGIN
		SELECT @PUserID=UserID FROM #Tb_AgentAbove_Cache WHERE LevelID=@I
		SELECT @AwardScale=AwardScale FROM ReturnAwardConfig(NOLOCK) WHERE AwardType=@dwAwardType AND AwardLevel=@I AND Nullity=0
		IF @AwardScale IS NULL SET @AwardScale=0
		SET @AwardValue = CAST((@dwReturnBase*@AwardScale) AS BIGINT)
		INSERT INTO ReturnAwardRecord(SourceUserID,TargetUserID,ReturnBase,Awardlevel,AwardScale,Award,AwardType,CollectDate,ExtraField) 
		VALUES(@UserID,@PUserID,@dwReturnBase,@I,@AwardScale,@AwardValue,@dwAwardType,@DateTime,@strExtraField)

		IF EXISTS(SELECT DateID FROM ReturnAwardSteam(NOLOCK) WHERE DateID=@DateID AND UserID=@PUserID AND AwardType=@dwAwardType AND AwardLevel=@I)
		BEGIN
			UPDATE ReturnAwardSteam SET Award=Award+@AwardValue,UpdateTime=@DateTime WHERE DateID=@DateID AND UserID=@PUserID AND AwardType=@dwAwardType AND AwardLevel=@I
		END
		ELSE
		BEGIN
			INSERT INTO ReturnAwardSteam VALUES(@DateID,@PUserID,@dwAwardType,@I,@AwardValue,@DateTime,@DateTime)
		END
		IF @dwAwardType=1
		BEGIN
			UPDATE AgentInfo SET DiamondAward=DiamondAward+@AwardValue WHERE UserID=@PUserID
		END
		ELSE
		BEGIN
			UPDATE AgentInfo SET GoldAward=GoldAward+@AwardValue WHERE UserID=@PUserID
		END
		SET @I=@I-1
	END

	END

END
RETURN 0
GO