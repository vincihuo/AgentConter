using System;
using System.Collections.Generic;
using Game.Kernel;
using Game.IData;
using System.Data.Common;
using System.Data;
using Game.Entity.Treasure;

namespace Game.Data
{
    /// <summary>
    /// 金币数据访问层
    /// </summary>
    public class TreasureDataProvider : BaseDataProvider, ITreasureDataProvider
    {
        #region 构造方法

        public TreasureDataProvider(string connString)
            : base(connString)
        {
        }

        #endregion

        #region 公共分页
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <param name="pageIndex">页下标</param>
        /// <param name="pageSize">页显示数</param>
        /// <param name="condition">查询条件</param>
        /// <param name="orderby">排序</param>
        /// <returns></returns>
        public PagerSet GetList(string tableName, int pageIndex, int pageSize, string condition, string orderby)
        {
            PagerParameters pagerPrams = new PagerParameters(tableName, orderby, condition, pageIndex, pageSize);
            return GetPagerSet2(pagerPrams);
        }

        public PagerSet GetList(string tableName, int pageIndex, int pageSize, string condition, string orderby, string[] fields, string[] fieldAlias)
        {
            PagerParameters pagerPrams = new PagerParameters(tableName, orderby, condition, pageIndex, pageSize, fields, fieldAlias);
            return GetPagerSet2(pagerPrams);
        }

        public PagerSet GetListLock(string tableName, string where, string order, int pageIndex, int pageSize, string fields = null)
        {
            PagerSet ps = new PagerSet();
            ps.PageIndex = pageIndex;
            ps.PageSize = pageSize;
            var prams = new List<DbParameter>
            {
                Database.MakeInParam("TableName", tableName),
                Database.MakeInParam("ReturnFields", fields),
                Database.MakeInParam("PageSize", pageSize),
                Database.MakeInParam("PageIndex", pageIndex),
                Database.MakeInParam("Where", where),
                Database.MakeInParam("Order", order),
                Database.MakeOutParam("PageCount", typeof(int)),
                Database.MakeOutParam("RecordCount", typeof(int)),
                Database.MakeInParam("Lock ", " "),
            };
            DataSet ds = Database.ExecuteDataset(CommandType.StoredProcedure, "WEB_PageView_New", prams.ToArray());
            ps.PageSet = ds;
            ps.PageCount = Convert.ToInt32(prams[6].Value);
            ps.RecordCount = Convert.ToInt32(prams[7].Value);
            return ps;
        }



        #endregion

        #region 线上充值

        public IList<OnlinePayConfig> GetOnLinePayList(int payType)
        {
            string sqlQuery = $"SELECT * FROM OnlinePayConfig WITH(NOLOCK) WHERE PayType={payType} AND Nullity=0  ORDER BY PayIdentity DESC,SortID DESC";
            return Database.ExecuteObjectList<OnlinePayConfig>(sqlQuery);
        }

        public IList<OfficalBankPay> GetBankPayList()
        {
            string sqlQuery = "SELECT * FROM OfficalBankPay WITH(NOLOCK) WHERE Nullity=0 ORDER BY SortId DESC";
            return Database.ExecuteObjectList<OfficalBankPay>(sqlQuery);
        }
        public IList<OfficalImgPay> GetImgPayList()
        {
            string sqlQuery = "SELECT * FROM OfficalImgPay WITH(NOLOCK)WHERE Nullity=0  ORDER BY SortId DESC";
            return Database.ExecuteObjectList<OfficalImgPay>(sqlQuery);
        }

        public GameScoreInfo GetGameScoreInfoByUid(int uid)
        {
            string sql = $"SELECT * FROM GameScoreInfo where UserID={uid}";
            return Database.ExecuteObject<GameScoreInfo>(sql);
        }
        public Message CreateDrawalOrder(DrawalOrder order)
        {
            List<DbParameter> prams = new List<DbParameter>
            {
                Database.MakeInParam("dwUserID", order.UserID),
                Database.MakeInParam("DrawalType", order.drawalType),
                Database.MakeInParam("strOrdersID", order.OrderID),
                Database.MakeInParam("DrawalAmount", order.Amount),
                Database.MakeInParam("OrderCost", order.OrderCost),
                Database.MakeInParam("ClientIP", order.IP),
                Database.MakeOutParam("strErrorDescribe", typeof(string), 127)
            };
            return MessageHelper.GetMessage(Database, "NET_PW_CreateDrawarOrder", prams);
        }
        public Message CreatImgPayOrder(int uid, int cfgId, string payLink, int amount, string payName, string orderID)
        {
            List<DbParameter> prams = new List<DbParameter>
            {
                Database.MakeInParam("dwUserID", uid),
                Database.MakeInParam("cfgID", cfgId),
                Database.MakeInParam("PayLink", payLink),
                Database.MakeInParam("amount", amount),
                Database.MakeInParam("payName", payName),
                Database.MakeInParam("strOrderID", orderID),
                Database.MakeOutParam("strErrorDescribe", typeof(string), 127)
            };
            return MessageHelper.GetMessage(Database, "NET_PW_CreateImgPayOrder", prams);
        }
        public Message CreatBankPayOrder(int uid, int cfgId, string BankAcc, int amount, string payName, string payBank, int TransferType, string orderID)
        {
            List<DbParameter> prams = new List<DbParameter>
            {
                Database.MakeInParam("dwUserID", uid),
                Database.MakeInParam("cfgID", cfgId),
                Database.MakeInParam("Number", BankAcc),
                Database.MakeInParam("amount", amount),
                Database.MakeInParam("payName", payName),
                Database.MakeInParam("payBank", payBank),
                Database.MakeInParam("TransferType", TransferType),
                Database.MakeInParam("strOrderID", orderID),
                Database.MakeOutParam("strErrorDescribe", typeof(string), 127)
            };
            return MessageHelper.GetMessage(Database, "NET_PW_CreateBankPayOrder", prams);
        }
        public UserValidBet GetValidBetByUid(int uid)
        {
            string sql = $"SELECT * FROM UserValidBet where UserID={uid}";

            return Database.ExecuteObject<UserValidBet>(sql);
        }
        public Message BuyDiam(int uid, int number)
        {
            List<DbParameter> prams = new List<DbParameter>
            {
                Database.MakeInParam("dwUserID", uid),
                Database.MakeInParam("Number", number),
                Database.MakeOutParam("strErrorDescribe", typeof(string), 127)
            };
            return MessageHelper.GetMessage(Database, "NET_PW_GoldExchangeDiamond", prams);
        }

        #endregion

        #region 充值产品

        /// <summary>
        /// 获取充值产品列表
        /// </summary>
        /// <param name="typeId">充值产品类型</param>
        /// <returns></returns>
        public IList<AppPayConfig> GetAppPayConfigList(int typeId)
        {
            const string sqlQuery =
                @"SELECT * FROM AppPayConfig WITH(NOLOCK) WHERE PayType = @PayType ORDER BY PayIdentity DESC,SortID DESC";
            List<DbParameter> parms = new List<DbParameter> { Database.MakeInParam("PayType", typeId) };
            return Database.ExecuteObjectList<AppPayConfig>(sqlQuery, parms);
        }

        /// <summary>
        /// 获取充值产品列表
        /// </summary>
        /// <param name="typeId">充值产品类型</param>
        /// <param name="userid">首充用户</param>
        /// <returns></returns>
        public DataSet GetAppPayConfigList(int typeId, int userid)
        {
            List<DbParameter> parms =
                new List<DbParameter>
                {
                    Database.MakeInParam("dwUserID", userid),
                    Database.MakeInParam("PayType", typeId)
                };

            return Database.ExecuteDataset(CommandType.StoredProcedure, "NET_PW_GetMobilePayConfig", parms.ToArray());
        }

        /// <summary>
        /// 获取在线充值列表
        /// </summary>
        /// <returns></returns>
        public IList<OnLineWeChat> GetOnLineWeChatList()
        {
            const string sqlQuery =
                @"SELECT * FROM OnLineWeChat WITH(NOLOCK) WHERE Nullity <>1 ";
            return Database.ExecuteObjectList<OnLineWeChat>(sqlQuery);
        }

        #endregion


        #region 充值记录

        /// <summary>
        /// 是否今日已充值过
        /// </summary>
        /// <param name="userid">用户标识</param>
        /// <returns></returns>
        public bool IsTodayHasPay(int userid)
        {
            string sqlQuery =
                @"SELECT OnLineID FROM OnLinePayOrder WITH(NOLOCK) WHERE UserID=@UserID AND OrderStatus=1 AND OrderDate BETWEEN @StartTime AND @EndTime";
            string nowTime = DateTime.Now.ToString("yyyy-MM-dd");
            List<DbParameter> parms =
                new List<DbParameter>
                {
                    Database.MakeInParam("UserID", userid),
                    Database.MakeInParam("StartTime", nowTime + " 00:00:00"),
                    Database.MakeInParam("EndTime", nowTime + " 23:59:59")
                };

            object obj = Database.ExecuteScalar(CommandType.Text, sqlQuery, parms.ToArray());
            return obj != null;
        }

        /// <summary>
        /// 充值记录
        /// </summary>
        /// <param name="whereQuery"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <param name="returnField"></param>
        /// <returns></returns>
        public PagerSet GetPayDiamondRecord(string whereQuery, int pageIndex, int pageSize, string[] returnField = null)
        {
            const string orderQuery = "ORDER By OrderDate DESC";
            returnField = returnField ?? new[] { "Amount", "Diamond", "OtherPresent", "BeforeDiamond", "PayDate" };
            PagerParameters pager = new PagerParameters("OnLinePayOrder", orderQuery, whereQuery, pageIndex, pageSize,
                returnField)
            { CacherSize = 2 };

            return GetPagerSet2(pager);
        }

        /// <summary>
        /// 根据订单号获取充值订单
        /// </summary>
        /// <param name="orderid"></param>
        /// <returns></returns>
        public OnLinePayOrder GetPayOnLinePayOrder(string orderid)
        {
            string sqlQuery =
                @"SELECT OrderID,OrderStatus,Amount,(Score+OtherPresent) AS Score FROM OnLinePayOrder WITH(NOLOCK) WHERE OrderID=@OrderID";
            List<DbParameter> parms =
                new List<DbParameter>
                {
                    Database.MakeInParam("OrderID", orderid)
                };

            return Database.ExecuteObject<OnLinePayOrder>(sqlQuery, parms);
        }
        #endregion

        #region 推广信息

        /// <summary>
        /// 领取推广人有效好友奖励
        /// </summary>
        /// <param name="userid">用户标识</param>
        /// <param name="configid">推广配置标识</param>
        /// <param name="ip">领取地址</param>
        /// <returns></returns>
        public Message ReceiveSpreadAward(int userid, int configid, string ip)
        {
            List<DbParameter> parms =
                new List<DbParameter>
                {
                    Database.MakeInParam("UserID", userid),
                    Database.MakeInParam("ConfigID", configid),
                    Database.MakeInParam("strClientIP", ip),
                    Database.MakeOutParam("strErrorDescribe", typeof(string), 127)
                };

            return MessageHelper.GetMessage(Database, "NET_PJ_ReceiveSpreadAward", parms);
        }
        public DataSet GetAgentInfo(int uid)
        {
            List<DbParameter> parms =
            new List<DbParameter>
            {
                Database.MakeInParam("dwUserID", uid)
            };
            return Database.ExecuteDataset(CommandType.StoredProcedure, "NET_PW_GetAgentInfo", parms.ToArray());
        }
        public Message GetReward(int uid)
        {
            List<DbParameter> parms =
            new List<DbParameter>
            {
                Database.MakeInParam("dwUserID", uid),
                Database.MakeOutParam("strErrorDescribe", typeof(string), 127)
            };
            return MessageHelper.GetMessage(Database, "NET_PJ_GetReward", parms);
        }
        public int GetIdByLink(string link)
        {
            string sqlQuery =$"SELECT GameID FROM WHQJAccountsDB.dbo.AccountsInfo WITH(NOLOCK) WHERE UserID = (SELECT UserID FROM AgentInfo WITH(NOLOCK) WHERE LinkUrl={link})";
            object obj = Database.ExecuteScalar(CommandType.Text, sqlQuery);
            if (obj == null)
            {
                return 0;
            }
            return (int)obj;
        }
        public DataSet GetAgentRank(int uid, int type)
        {
            string mm = "";
            switch (type)
            {
                case 1:
                    mm = "Day";
                    break;
                case 2:
                    mm = "Week";
                    break;
                case 3:
                    mm = "Month";
                    break;
                default:
                    mm = "Day";
                    break;
            }
            string sql = $"SELECT TOP 10 B.GameID, B.NickName,A.{mm}Reward AS Reward FROM AgentRank A  INNER JOIN WHQJAccountsDB.dbo.AccountsInfo B ON A.UserID=B.UserID ORDER BY A.{mm}Reward DESC SELECT {mm}Reward AS OwnReward FROM AgentRank WHERE UserID={uid}";
            return Database.ExecuteDataset(sql);
        }

        #endregion

        #region 钻石信息

        /// <summary>
        /// 获取用户财富
        /// </summary>
        /// <param name="userId">用户标识</param>
        /// <returns></returns>
        public UserWealth GetUserWealth(int userId)
        {
            string sqlQuery = string.Format(
                @"SELECT ISNULL(G.Score,0) AS Score,ISNULL(G.InsureScore,0) AS InsureScore,ISNULL(U.Diamond,0) AS Diamond,ISNULL(U.AwardTicket,0) AS AwardTicket
                            FROM (SELECT UserID,Score,InsureScore FROM GameScoreInfo WHERE UserID={0}) AS G FULL JOIN
                            (SELECT UserID,Diamond,AwardTicket FROM UserCurrency WHERE UserID={0}) AS U ON G.UserID=U.UserID",
                userId);
            return Database.ExecuteObject<UserWealth>(sqlQuery);
        }

        /// <summary>
        /// 获取钻石信息
        /// </summary>
        /// <param name="userId">用户标识</param>
        /// <returns></returns>
        public UserCurrency GetUserCurrency(int userId)
        {
            const string sqlQuery = "SELECT * FROM UserCurrency WHERE UserID=@UserID";
            List<DbParameter> prams = new List<DbParameter> { Database.MakeInParam("UserID", userId) };
            return Database.ExecuteObject<UserCurrency>(sqlQuery, prams);
        }

        /// <summary>
        /// 代理钻石赠送
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="password"></param>
        /// <param name="presentCount"></param>
        /// <param name="gameId"></param>
        /// <param name="clientIp"></param>
        /// <param name="note"></param>
        /// <returns></returns>
        public Message AgentPresentDiamond(int userId, string password, int presentCount, int gameId, string clientIp,
            string note)
        {
            List<DbParameter> prams = new List<DbParameter>
            {
                Database.MakeInParam("dwUserID", userId),
                Database.MakeInParam("dwPresentCount", presentCount),
                Database.MakeInParam("dwGameID", gameId),
                Database.MakeInParam("strPassword", password),
                Database.MakeInParam("strNote", note),
                Database.MakeInParam("strClientIP", clientIp),
                Database.MakeOutParam("strErrorDescribe", typeof(string), 127)
            };

            return MessageHelper.GetMessage(Database, "NET_PW_AgentPresentDiamond", prams);
        }

        /// <summary>
        /// 钻石兑换金币 数据层
        /// </summary>
        /// <param name="userid"></param>
        /// <param name="configid"></param>
        /// <param name="typeid"></param>
        /// <param name="clientIp"></param>
        /// <returns></returns>
        public Message DiamondExchangeGold(int userid, int configid, int typeid, string clientIp)
        {
            List<DbParameter> prams = new List<DbParameter>
            {
                Database.MakeInParam("dwUserID", userid),
                Database.MakeInParam("dwConfigID", configid),
                Database.MakeInParam("dwTypeID", typeid),
                Database.MakeInParam("strClientIP", clientIp),
                Database.MakeOutParam("strErrorDescribe", typeof(string), 127)
            };

            return MessageHelper.GetMessageForDataSet(Database, "NET_PW_DiamondExchangeGold", prams);
        }

        /// <summary>
        /// 获取钻石兑换金币配置
        /// </summary>
        /// <returns></returns>
        public IList<CurrencyExchConfig> GetDiamondExchangeGoldConfig()
        {

            const string sqlQuery =
                @"select * from CurrencyExchConfig WITH(NOLOCK) order by SortID DESC";
            List<DbParameter> parms = new List<DbParameter>();
            return Database.ExecuteObjectList<CurrencyExchConfig>(sqlQuery);

        }

        #endregion

        #region 游戏回放

        /// <summary>
        /// 获取录像存盘数据
        /// </summary>
        /// <param name="number">录像编号</param>
        /// <returns></returns>
        public byte[] GetVideoDataByVNumber(string number)
        {
            const string sqlQuery =
                "SELECT VideoData FROM RecordVideoInfo WITH(NOLOCK) WHERE VideoNumber = @VideoNumber";
            List<DbParameter> param = new List<DbParameter> { Database.MakeInParam("VideoNumber", number) };

            object obj = Database.ExecuteScalar(CommandType.Text, sqlQuery, param.ToArray());
            return obj as byte[];
        }

        #endregion

        #region 注册奖励

        /// <summary>
        /// 领取注册奖励
        /// </summary>
        /// <param name="userId">用户标识</param>
        /// <param name="ip">领取地址</param>
        /// <returns></returns>
        public Message ReceiveRegisterAward(int userId, string ip)
        {
            var prams = new List<DbParameter>
            {
                Database.MakeInParam("dwUserID", userId),
                Database.MakeInParam("strClientIP", ip),
                Database.MakeOutParam("strErrorDescribe", typeof(string), 127)
            };

            return MessageHelper.GetMessageForObject<UserWealth>(Database, "NET_PJ_RecevieRegisterGrant", prams);
        }

        #endregion
    }
}
