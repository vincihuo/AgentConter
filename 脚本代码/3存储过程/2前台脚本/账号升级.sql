USE [WHQJAccountsDB]
GO

IF EXISTS (SELECT *
FROM DBO.SYSOBJECTS
WHERE ID = OBJECT_ID(N'[dbo].PW_MbileAccountBind') and OBJECTPROPERTY(ID, N'IsProcedure') = 1)
DROP PROCEDURE [dbo].PW_MbileAccountBind
GO

SET QUOTED_IDENTIFIER ON 
GO

SET ANSI_NULLS ON 
GO
CREATE PROCEDURE PW_MbileAccountBind
    @dwUserid  int,
    ---用户id
	@Password nvarchar(32),
    -- 密码
    @Accounts nvarchar(32),
    ---手机号
    @Code    nvarchar(10),
    ---验证码
	@NickName nvarchar(32),
    @strErrorDescribe NVARCHAR(127) OUTPUT
-- 输出信息
as
-- 属性设置
SET NOCOUNT ON
DECLARE @createtime datetime---验证码插入时间
DECLARE @OldPass nvarchar(32)
DECLARE @UserID INT
DECLARE @intervaltime INT
DECLARE @config INT
DECLARE	@strClientIP NVARCHAR(15)
DECLARE	@strMachineID NCHAR(32)

BEGIN
    SELECT @config=CONVERT(INT,Field7) FROM WHQJNativeWebDB.dbo.ConfigInfo WHERE ConfigID=1

    SELECT @OldPass=LogonPass, @UserID=UserID,@strClientIP=RegisterIP,@strMachineID=RegisterMachine FROM AccountsInfo WHERE UserID=@dwUserid
    IF @UserID IS NULL
    BEGIN
        SET @strErrorDescribe=N'账号不存在'
        RETURN 1002
    END
    IF @OldPass <> NULL
    BEGIN
        SET @strErrorDescribe=N'已经是正式账号'
        RETURN 1003
    END
    IF @config=0
    BEGIN
        UPDATE AccountsInfo SET LogonPass=@Password,Accounts=@Accounts,NickName=@NickName WHERE UserID=@dwUserid
    END
    ELSE IF @config=1
    BEGIN
        SELECT @createtime=CollectTime
        FROM dbo.CheckCode WHERE PhoneNum=@Accounts and CheckCode=@Code
        SET @intervaltime=DATEDIFF(ss,@createtime,getdate());
        IF 60<@intervaltime
        BEGIN
            SET @strErrorDescribe=N'验证码过期'
            RETURN 1001
        END
        UPDATE AccountsInfo SET LogonPass=@Password,Accounts=@Accounts,RegisterMobile=@Accounts,NickName=@NickName WHERE UserID=@dwUserid
    END

    DECLARE @DateID INT
	SET @DateID=CAST(CAST(GETDATE() AS FLOAT) AS INT)
	UPDATE SystemStreamInfo SET GameRegisterSuccess=GameRegisterSuccess+1 WHERE DateID=@DateID
	IF @@ROWCOUNT=0 INSERT SystemStreamInfo
		(DateID, GameRegisterSuccess)
	VALUES
		(@DateID, 1)

	-- 读取变量
	DECLARE @GrantIPCount AS BIGINT
	DECLARE @GrantScoreCount AS BIGINT
	SELECT @GrantIPCount=StatusValue
	FROM SystemStatusInfo(NOLOCK)
	WHERE StatusName=N'GrantIPCount'
	SELECT @GrantScoreCount=StatusValue
	FROM SystemStatusInfo(NOLOCK)
	WHERE StatusName=N'GrantScoreCount'


	-- 赠送限制
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0 AND @GrantIPCount IS NOT NULL AND @GrantIPCount>0
	BEGIN
		-- 赠送次数
		DECLARE @GrantCount AS BIGINT
		DECLARE @GrantMachineCount AS BIGINT
		DECLARE @GrantRoomCardCount AS BIGINT
		SELECT @GrantCount=GrantCount
		FROM SystemGrantCount(NOLOCK)
		WHERE DateID=@DateID AND RegisterIP=@strClientIP
		SELECT @GrantMachineCount=GrantCount
		FROM SystemMachineGrantCount(NOLOCK)
		WHERE DateID=@DateID AND RegisterMachine=@strMachineID
		SELECT @GrantRoomCardCount=StatusValue
		FROM SystemStatusInfo(NOLOCK)
		WHERE StatusName=N'GrantRoomCardCount'

		-- 次数判断
		IF (@GrantCount IS NOT NULL AND @GrantCount>=@GrantIPCount) OR (@GrantMachineCount IS NOT NULL AND @GrantMachineCount>=@GrantIPCount)
		BEGIN
			SET @GrantScoreCount=0
		END
	END
	-- 赠送金币
	IF @GrantScoreCount IS NOT NULL AND @GrantScoreCount>0
	BEGIN
		-- 更新记录
		UPDATE SystemGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterIP=@strClientIP

		-- 插入记录
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemGrantCount
				(DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount)
			VALUES
				(@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- 更新记录
		UPDATE SystemMachineGrantCount SET GrantScore=GrantScore+@GrantScoreCount, GrantCount=GrantCount+1 WHERE DateID=@DateID AND RegisterMachine=@strMachineID

		-- 插入记录
		IF @@ROWCOUNT=0
		BEGIN
			INSERT SystemMachineGrantCount
				(DateID, RegisterIP, RegisterMachine, GrantScore, GrantCount)
			VALUES
				(@DateID, @strClientIP, @strMachineID, @GrantScoreCount, 1)
		END

		-- 查询金币
		DECLARE @CurrScore BIGINT
		DECLARE @CurrInsure BIGINT
		SELECT @CurrScore=Score, @CurrInsure=InsureScore
		FROM WHQJTreasureDBLink.WHQJTreasureDB.dbo.GameScoreInfo
		WHERE UserID=@UserID

		-- 赠送金币
		UPDATE WHQJTreasureDBLink.WHQJTreasureDB.dbo.GameScoreInfo SET Score = Score+@GrantScoreCount WHERE UserID = @UserID

		-- 流水账
		INSERT INTO WHQJTreasureDBLink.WHQJTreasureDB.dbo.RecordPresentInfo
			(UserID,PreScore,PreInsureScore,PresentScore,TypeID,IPAddress,CollectDate)
		VALUES
			(@UserID, @CurrScore, @CurrInsure, @GrantScoreCount, 1, @strClientIP, GETDATE())
		--增加稽核
		DECLARE @Multiple BIGINT
		SELECT @Multiple=CONVERT(INT,Field6)
		FROM WHQJNativeWebDB.dbo.ConfigInfo (NOLOCK)
		WHERE ConfigID=5
		DECLARE @VileBet BIGINT
		SET @VileBet =@GrantScoreCount*@Multiple/100;
		DECLARE @ErrorDescribe	NVARCHAR(127)
		DECLARE @Return INT
		EXEC @Return=WHQJTreasureDB.dbo.NET_PB_Deposit 5,@UserID,1,'注册送',@VileBet,@ErrorDescribe OUTPUT


		-- 日统计
		UPDATE WHQJTreasureDBLink.WHQJTreasureDB.dbo.StreamPresentInfo SET DateID=@DateID, PresentCount=PresentCount+1,PresentScore=PresentScore+@GrantScoreCount WHERE UserID=@UserID AND TypeID=1
		IF @@ROWCOUNT=0
		BEGIN
			INSERT WHQJTreasureDBLink.WHQJTreasureDB.dbo.StreamPresentInfo
				(DateID,UserID,TypeID,PresentCount,PresentScore)
			VALUES(@DateID, @UserID, 1, 1, @GrantScoreCount)
		END

	END
	-- 赠送钻石限制
	IF @GrantRoomCardCount IS NOT NULL AND @GrantRoomCardCount>0 AND @GrantIPCount IS NOT NULL AND @GrantIPCount>0
	BEGIN
		-- 赠送次数
		--DECLARE @GrantCount AS BIGINT
		--DECLARE @GrantMachineCount AS BIGINT
		SELECT @GrantCount=GrantCount
		FROM SystemGrantCount(NOLOCK)
		WHERE DateID=@DateID AND RegisterIP=@strClientIP
		SELECT @GrantMachineCount=GrantCount
		FROM SystemMachineGrantCount(NOLOCK)
		WHERE DateID=@DateID AND RegisterMachine=@strMachineID

		-- 次数判断
		IF (@GrantCount IS NOT NULL AND @GrantCount>=@GrantIPCount) OR (@GrantMachineCount IS NOT NULL AND @GrantMachineCount>=@GrantIPCount)
		BEGIN
			SET @GrantRoomCardCount=0
		END
	END
END
RETURN 0
GO