using Game.Utils;
using Game.Facade;
using System;
using System.Collections.Generic;
using System.Web;
using Game.Facade.Enum;
using Game.Facade.DataStruct;
using Game.Entity.NativeWeb;
using Game.Entity.Treasure;
using Game.Kernel;
using Game.Entity.Platform;
using Game.Web.Helper;
using System.Data;
using Game.Entity.Accounts;
using System.Text.RegularExpressions;
using System.Media;
using Game.Entity.Record;

namespace Game.Web.WS
{
    /// <summary>
    /// NewMoblieInterface 的摘要说明
    /// </summary>
    public class NewMoblieInterface : IHttpHandler
    {
        // ReSharper disable once FieldCanBeMadeReadOnly.Local
        private AjaxJsonValid _ajv;

        private int _userid;
        private string _device;
        private long _groupid;
        /// <summary>
        /// 统一处理入口（主要验证）
        /// </summary>
        /// <param name="context"></param>
        public void ProcessRequest(HttpContext context)
        {
            try
            {
                //允许跨站请求域名
                context.Response.AddHeader("Access-Control-Allow-Origin", AppConfig.MoblieInterfaceDomain);
                //接口返回数据格式
                context.Response.ContentType = "application/json";
                //接口请求类型
                string action = GameRequest.GetQueryString("action").ToLower();

                //获取参数
                _userid = GameRequest.GetQueryInt("userid", 0);
                _device = GameRequest.GetString("device");
                _groupid = !string.IsNullOrEmpty(GameRequest.GetString("groupid"))
                    ? Convert.ToInt64(GameRequest.GetString("groupid"))
                    : 0;
                _ajv = new AjaxJsonValid();

                //string sign = GameRequest.GetQueryString("sign");
                //string parama = context.Request.Url.Query;
                //int pos = parama.LastIndexOf("&sign=");
                //if (pos < 1)
                //{
                //    _ajv.code = (int)ApiCode.VertySignErrorCode;
                //    _ajv.msg = EnumHelper.GetDesc(ApiCode.VertySignErrorCode);
                //    return;
                //}

                //parama = parama.Substring(0, pos);
                //_ajv = Fetch.VerifySignData(parama, sign);
                //if (_ajv.code == (int)ApiCode.VertySignErrorCode)
                //{
                //    context.Response.Write(_ajv.SerializeToJson());
                //    return;
                //}
               // SoundPlayer sound = new SoundPlayer();


                //参数验证
                if (context.Request.QueryString["userid"] != null && _userid <= 0)
                {
                    _ajv.code = (int)ApiCode.VertyParamErrorCode;
                    _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), " userid 错误");
                    context.Response.Write(_ajv.SerializeToJson());
                    return;
                }
                //获取其他参数
                int configid = GameRequest.GetQueryInt("configid", 0);
                int typeid = GameRequest.GetQueryInt("typeid", 0);
                switch (action)
                {
                    #region 老接口
                    case "webversion":
                        _ajv.SetDataItem("apiVersion", 20171220);
                        _ajv.SetDataItem("webVersion", "V1.0.1");
                        _ajv.SetDataItem("updateAt", "2018/04/08");
                        _ajv.SetValidDataValue(true);
                        break;
                    //获取手机端登录数据
                    case "getmobilelogindata":
                        _ajv.SetDataItem("apiVersion", 20171017);
                        GetMobileLoginData();
                        break;
                    //获取手机端登录后数据
                    case "getmobileloginlater":
                        _ajv.SetDataItem("apiVersion", 20171213);
                        GetMobileLoginLater();
                        break;
                    //获取充值产品列表
                    case "getpayproduct":
                        //_ajv.SetDataItem("apiVersion", 20171028);
                        ////获取参数
                        //GetPayProduct(typeid);
                        _ajv.SetDataItem("apiVersion", 20191101);
                        BinDingPayee();

                        //_ajv.SetDataItem("apiVersion", 20191029);
                        //CreatBankPayOrder();
                        break;

                    //领取推广有效好友奖励
                    case "receivespreadaward":
                        //参数验证
                        if (configid <= 0)
                        {
                            _ajv.code = (int)ApiCode.VertyParamErrorCode;
                            _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), " configid 错误");
                            context.Response.Write(_ajv.SerializeToJson());
                            return;
                        }
                        ReceiveSpreadAward(configid);
                        break;
                    case "getgameintrolist":
                        _ajv.SetDataItem("apiVersion", 20171107);
                        GetGameIntroList();
                        break;
                    //在线充值列表
                    case "getonlinewechatlist":
                        GetOnLineWeChatList();
                        break;
                    //获取排行榜数据
                    case "getrankingdata":
                        _ajv.SetDataItem("apiVersion", 20171129);
                        //参数验证
                        if (typeid <= 0 || typeid > 7)
                        {
                            _ajv.code = (int)ApiCode.VertyParamErrorCode;
                            _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), " typeid 错误");
                            context.Response.Write(_ajv.SerializeToJson());
                            return;
                        }

                        GetRankingData(_userid, typeid);
                        //GetRankingData(typeid);
                        break;
                    //获取财富信息
                    case "getuserwealth":
                        GetUserWealth();
                        break;
                    //获取玩家信息
                    case "getuserinfo":
                        _ajv.SetDataItem("apiVersion", 20171208);
                        GetUserInfo();
                        break;
                    //领取排行奖励
                    case "receiverankingaward":
                        _ajv.SetDataItem("apiVersion", 20171213);
                        //获取参数
                        int dateid = GameRequest.GetQueryInt("dateid", 0);

                        //参数验证
                        if (dateid <= 0 || typeid <= 0)
                        {
                            _ajv.code = (int)ApiCode.VertyParamErrorCode;
                            _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), "");
                            context.Response.Write(_ajv.SerializeToJson());
                            return;
                        }
                        ReceiveRankingAward(dateid, typeid);
                        break;
                    //获取游戏列表
                    case "getgamelist":
                        GetGameList();
                        break;
                    //领取注册赠送奖励
                    case "receiveregistergrant":
                        _ajv.SetDataItem("apiVersion", 20171213);
                        ReceiveRegisterGrant();
                        break;
                    //金币流水记录
                    case "recordtreasuretrade":
                        RecordTreasureTrade();
                        break;
                    //钻石流水记录
                    case "recorddiamondstrade":
                        RecordDiamondsTrade();
                        break;
                    //钻石兑换金币
                    case "diamondexchgold":
                        _ajv.SetDataItem("apiVersion", 20171213); //for 响应规范
                        if (configid <= 0 || typeid < 0)
                        {
                            _ajv.code = (int)ApiCode.VertyParamErrorCode;
                            _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode),
                                " configid或typeid 错误");
                            context.Response.Write(_ajv.SerializeToJson());
                            return;
                        }
                        DiamondExchGold(configid, typeid);
                        break;
                    //钻石兑换金币列表
                    case "diamondexchgoldconfig":
                        DiamondExchGoldConfig();
                        break;
                    case "getpayorderstatus":
                        _ajv.SetDataItem("apiVersion", 20171127);
                        string orderid = GameRequest.GetString("orderid");
                        if (string.IsNullOrEmpty(orderid))
                        {
                            _ajv.code = (int)ApiCode.VertyParamErrorCode;
                            _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), " orderid 错误");
                            context.Response.Write(_ajv.SerializeToJson());
                            return;
                        }
                        GetPayOrderStatus(orderid);
                        break;
                    case "getquestionandanswerlist":
                        _ajv.SetDataItem("apiVersion", 20180125);
                        GetQuestionAndAnswerList();
                        break;
                    case "agentsynclogin":
                        _ajv.SetDataItem("apiVersion", 20180309);
                        AgentSyncLogin();
                        break;
                    case "getbattlerecord":
                        _ajv.SetDataItem("apiVersion", 20180424);
                        GetBattleRecord(typeid);
                        break;
                    case "getgroupbattlerecord":
                        _ajv.SetDataItem("apiVersion", 20180424);
                        if (_groupid <= 0)
                        {
                            _ajv.code = (int)ApiCode.VertyParamErrorCode;
                            _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode),
                                " groupid 错误");
                            return;
                        }
                        GetGroupBattleRecord();
                        break;
                    case "getcode":
                        GetCode(context);
                        break;
                    case "bindmobile":
                        BindMobile(context);
                        break;
                    case "bindmobileconfig":
                        BindMobileConfig(context);
                        break;
                    case "sharetimesreward":
                        ShareTimesReward(context);
                        break;
                    case "getsharereward":
                        GetShareReward(context);
                        break;
                    #endregion

                    #region 代理接口模块
                    //获取代理商用户信息
                    case "getagentinfo":
                        _ajv.SetDataItem("apiVersion", 20191108);
                        GetAgentInfo();
                        break;
                    case "getreward":
                        _ajv.SetDataItem("apiVersion", 20191108);
                        GetReward();
                        break;
                    case "rewardrecord":
                        _ajv.SetDataItem("apiVersion", 20191108);
                        RewardRecord();
                        break;
                    case "rewardrbill":
                        _ajv.SetDataItem("apiVersion", 20191108);
                        RewardDrawalBill();
                        break;
                    #endregion

                    #region 最帅的写的接口
                    //获取线上充值列表
                    case "payrecord":
                        _ajv.SetDataItem("apiVersion",20191109);
                        PayRecord();
                        break;
                    case "paylist":
                        _ajv.SetDataItem("apiVersion", 20191018);
                        //获取参数
                        GetPayList();
                        break;
                    case "bindingpayee":
                        _ajv.SetDataItem("apiVersion", 20191101);
                        BinDingPayee();
                        break;
                    case "getvilabet":
                        _ajv.SetDataItem("apiVersion", 20191101);
                        GetVilaBet();
                        break;
                    case "withdrawal":
                        _ajv.SetDataItem("apiVersion", 20191018);
                        WithDrawal();
                        break;
                    case "buydiam":
                        _ajv.SetDataItem("apiVersion", 20191031);
                        BuyDiam();
                        break;
                    case "imgpay":
                        _ajv.SetDataItem("apiVersion", 20191029);
                        CreatImgPayOrder();
                        break;
                    case "bankpay":
                        _ajv.SetDataItem("apiVersion", 20191029);
                        CreatBankPayOrder();
                        break;
                    case "hallhotfix":
                        _ajv.SetDataItem("apiVersion", 20191019);
                        SetHallHotFix();
                        break;
                    case "gamehotfix":
                        _ajv.SetDataItem("apiVersion", 20191019);
                        SetGameHotFix();
                        break;
                    case "getidbylink":
                        _ajv.SetDataItem("apiVersion", 20191109);
                        GetIdByLink();
                        break;
                    #endregion
                    default:
                        _ajv.code = (int)ApiCode.VertyParamErrorCode;
                        _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), " action 错误");
                        break;
                }
                context.Response.Write(_ajv.SerializeToJson());
            }
            catch (Exception ex)
            {
                Log4Net.WriteInfoLog("下面一条为接口故障信息", "MobileInterface");
                Log4Net.WriteErrorLog(ex, "MobileInterface");
                _ajv = new AjaxJsonValid
                {
                    code = (int)ApiCode.LogicErrorCode,
                    msg = EnumHelper.GetDesc(ApiCode.LogicErrorCode)
                };
                context.Response.Write(_ajv.SerializeToJson());
            }
            context.Response.End();
        }


        private void PayRecord()
        {
            int index = GameRequest.GetQueryInt("index", 1);
            PagerSet ps = FacadeManage.aideRecordFacade.GetList(RecordTreasureSerial.Tablename,index,6,$" WHERE UserID={_userid} AND TypeID=12 ", "ORDER BY CollectDate DESC ");
            _ajv.SetDataItem("index", ps.PageIndex);
            _ajv.SetDataItem("pageCount", ps.PageCount);

            IList<PayRecord> list = new List<PayRecord>();
            DataTable table = ps.PageSet.Tables[0];
            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow item in table.Rows)
                {
                    PayRecord stream = new PayRecord
                    {
                        PayTime= item["CollectDate"].ToString(),
                        PayMoney=Convert.ToInt64(item["ChangeScore"])
                    };
                    list.Add(stream);
                }
            }
            _ajv.SetDataItem("list", list);
        }
        private void DrawalRecord()
        {
            int index = GameRequest.GetQueryInt("index", 1);
            int type = GameRequest.GetQueryInt("type", 0);
            string cType;
            if (type == 0)
            {
                cType = " 1=1 ";
            }
            else
            {
                cType = $"OrderState = {type}";
            }
            PagerSet ps = FacadeManage.aideTreasureFacade.GetList(DrawalOrder.Tablename, index, 6, $" WHERE UserID={_userid} AND "+ cType, " ORDER BY CurrentTime DESC ");
            _ajv.SetDataItem("index", ps.PageIndex);
            _ajv.SetDataItem("pageCount", ps.PageCount);
            IList<DrawalRecord> list = new List<DrawalRecord>();
            DataTable table = ps.PageSet.Tables[0];
            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow item in table.Rows)
                {
                    DrawalRecord stream = new DrawalRecord
                    {
                        DrawalTime=item["CurrentTime"].ToString(),
                        DrawalMoney=Convert.ToInt64(item["Amount"]),
                        OrderCost= Convert.ToInt64(item["OrderCost"]),
                        OrderStatus= Convert.ToInt32(item["OrderState"])
                    };
                    list.Add(stream);
                }
            }
            _ajv.SetDataItem("list", list);
        }


        private void BinDingPayee()
        {
            int type = GameRequest.GetQueryInt("type", 0);
            string acc = GameRequest.GetQueryString("account");
            Message mm = FacadeManage.aideAccountsFacade.BandingPayee(_userid, (byte)type, acc);
            _ajv.SetValidDataValue(mm.Success);
            _ajv.msg = mm.Content;
        }
        private void GetVilaBet()
        {
            UserValidBet validBet = FacadeManage.aideTreasureFacade.GetValidBetByUid(_userid);
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("tagVilaBet", validBet.TargetBet);
            _ajv.SetDataItem("currVilaBet", validBet.CurrentValidBet);
        }

        private void WithDrawal()
        {
            int drawalType = GameRequest.GetQueryInt("drawalType", 1);
            int amount = GameRequest.GetQueryInt("amount", 1000);
            //判断玩家金币
            ConfigInfo cfg = FacadeManage.aideNativeWebFacade.GetConfigInfo("DrawalConfig");
            int p = Convert.ToInt32(cfg.Field1);
            int min = Convert.ToInt32(cfg.Field2);
            int max = Convert.ToInt32(cfg.Field3);
            if (amount < min || amount > max)
            {
                _ajv.code = (int)ApiCode.VertyParamErrorCode;
                _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), $"提现金额必须在{min}-{max}之间");
                return;
            }
            //判断打码量
            UserValidBet validBet = FacadeManage.aideTreasureFacade.GetValidBetByUid(_userid);
            if (validBet.CurrentValidBet < validBet.TargetBet)
            {
                _ajv.code = (int)ApiCode.VertyParamErrorCode;
                _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), $"打码量不足，目标打码量{validBet.TargetBet}，当前打码量{validBet.CurrentValidBet}");
                return;
            }

            //创建订单
            int cost = amount * p / 100;
            DrawalOrder order = new DrawalOrder();
            order.OrderID = Fetch.GetOrderIDByPrefix("draw");
            order.Amount = amount;
            order.OrderCost = cost;
            order.IP = GameRequest.GetUserIP();
            order.UserID = _userid;
            order.drawalType = (byte)drawalType;
            Message mm = FacadeManage.aideTreasureFacade.CreateDrawalOrder(order);
            _ajv.SetValidDataValue(mm.Success);
            _ajv.msg = mm.Content;
        }
        private void BuyDiam()
        {
            int number = GameRequest.GetQueryInt("number", 0);
            if (number <= 0)
            {
                _ajv.code = (int)ApiCode.VertyParamErrorCode;
                _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), $"兑换量必须大于0");
                return;
            }
            Message mm = FacadeManage.aideTreasureFacade.BuyDiam(_userid, number);
            _ajv.SetValidDataValue(mm.Success);
            _ajv.msg = mm.Content;
        }
        private void CreatImgPayOrder()
        {
            int cfgID = GameRequest.GetQueryInt("cfgID", 1);
            string payLink = GameRequest.GetQueryString("payLink");
            int amount = GameRequest.GetQueryInt("amount", 0);
            string payName = GameRequest.GetQueryString("payName");
            string orderID = Fetch.GetOrderIDByPrefix("QRPay");
            Message mm = FacadeManage.aideTreasureFacade.CreatImgPayOrder(_userid, cfgID, payLink, amount, payName, orderID);
            _ajv.SetValidDataValue(mm.Success);
            _ajv.msg = mm.Content;
        }

        private void CreatBankPayOrder()
        {
            int cfgID = GameRequest.GetQueryInt("cfgID", 1);
            string bankAcc = GameRequest.GetQueryString("bankAcc");
            int trsfType = GameRequest.GetQueryInt("trsfType", 1);
            string bankName = GameRequest.GetQueryString("bankAcc");
            int amount = GameRequest.GetQueryInt("amount", 0);
            string payName = GameRequest.GetQueryString("payName");
            string orderID = Fetch.GetOrderIDByPrefix("BKPay");
            Message mm = FacadeManage.aideTreasureFacade.CreatBankPayOrder(_userid, cfgID, bankAcc, amount, payName, bankName, trsfType, orderID);
            _ajv.SetValidDataValue(mm.Success);
            _ajv.msg = mm.Content;
        }
        private void SetHallHotFix()
        {
            int type = GameRequest.GetQueryInt("type", 2);
            int version = GameRequest.GetQueryInt("version", 0);
            if (type == 1 || type == 2)
            {
                int success = FacadeManage.aideNativeWebFacade.SetHallVersion(type, version);
                if (success == 1)
                {
                    _ajv.SetValidDataValue(true);
                }
                else
                {
                    _ajv.SetValidDataValue(false);
                    _ajv.code = (int)ApiCode.VertyParamErrorCode;
                    _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), " 执行sql出错了");
                }
            }
            else
            {
                _ajv.code = (int)ApiCode.VertyParamErrorCode;
                _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), " 参数错误");
            }
        }

        private void SetGameHotFix()
        {
            int gameId = GameRequest.GetQueryInt("gameId", 3);
            int version = GameRequest.GetQueryInt("version", 5);
            int success = FacadeManage.aidePlatformFacade.SetGameVerSion(gameId, version);
            if (success == 1)
            {
                _ajv.SetValidDataValue(true);
            }
            else
            {
                _ajv.SetValidDataValue(false);
                _ajv.code = (int)ApiCode.VertyParamErrorCode;
                _ajv.msg = string.Format(EnumHelper.GetDesc(ApiCode.VertyParamErrorCode), " 更新游戏版本sql出错了");
            }

        }

        /// <summary>
        /// 获取手机端登录数据
        /// </summary>
        private void GetMobileLoginData()
        {
            int PlatformType = GameRequest.GetQueryInt("PlatformType", 1);
            ConfigInfo webConfig = Fetch.GetWebSiteConfig();
            ConfigInfo MobileConfig = Fetch.GetMobileConfig();
            string imageServerHost = webConfig.Field2;
            //获取登录数据
            DataSet ds = FacadeManage.aideNativeWebFacade.GetMobileLoginInfo();
            //获取系统配置信息
            MobileSystemConfig config = GetMobileSystemConfig(ds.Tables[0]);

            GroupSystemConfig Groupconfig = GetGroupConfig(ds.Tables[9]);
            //大喇叭道具信息由道具表提供
            //GameProperty Diamonprop = FacadeManage.aidePlatformFacade.GetGameProperty(306,0);//钻石购买道具
            //GameProperty Goldprop = FacadeManage.aidePlatformFacade.GetGameProperty(306, 1);//金币购买道具

            //if (PlatformType == 1)
            //{
            //    config.GoldBuyPropCount = Convert.ToInt32(ds.Tables[6].Rows[0][0]);//金币购买道具
            //}
            //else if (PlatformType == 2)
            //{
            //    config.DiamondBuyPropCount = Convert.ToInt32(ds.Tables[5].Rows[0][0]);//钻石购买道具
            //}
            //else
            //{
            //config.GoldBuyPropCount = Convert.ToInt32(ds.Tables[6].Rows[0][0]);//金币购买道具
            // config.DiamondBuyPropCount = Convert.ToInt32(ds.Tables[5].Rows[0][0]);//钻石购买道具
            //}

            //获取客服界面配置
            MobileCustomerService mcs = DataHelper.ConvertRowToObject<MobileCustomerService>(ds.Tables[1].Rows[0]);
            mcs.Link = imageServerHost + "/site/qrcustomer.png";
            //获取系统公告配置
            IList<NoticeMobile> noticelist = DataHelper.ConvertDataTableToObjects<NoticeMobile>(ds.Tables[2]);
            //获取手机固定位广告图
            IList<AdsMobile> plate = DataHelper.ConvertDataTableToObjects<AdsMobile>(ds.Tables[3]);
            foreach (AdsMobile ads in plate)
            {
                ads.ResourceURL = ads.ResourceURL.IndexOf("http://", StringComparison.Ordinal) < 0
                    ? imageServerHost + ads.ResourceURL
                    : ads.ResourceURL;
            }
            //获取手机弹出广告图
            IList<AdsMobile> alert =
                DataHelper.ConvertDataTableToObjects<AdsMobile>(_device == "h5" ? ds.Tables[3] : ds.Tables[4]);
            foreach (AdsMobile ads in alert)
            {
                ads.ResourceURL = ads.ResourceURL.IndexOf("http://", StringComparison.Ordinal) < 0
                    ? imageServerHost + ads.ResourceURL
                    : ads.ResourceURL;
            }

            //获取手机活动广告
            IList<AdsMobile> activity =
                DataHelper.ConvertDataTableToObjects<AdsMobile>(ds.Tables[7]);
            foreach (AdsMobile ads in activity)
            {
                ads.ResourceURL = ads.ResourceURL.IndexOf("http://", StringComparison.Ordinal) < 0
                    ? imageServerHost + ads.ResourceURL
                    : ads.ResourceURL;
            }
            //获取签到配置 
            //IList<GameSignInMobile> GameSign =
            //   DataHelper.ConvertDataTableToObjects<GameSignInMobile>(ds.Tables[8]);

            //foreach (GameSignInMobile Sign in GameSign)
            //{
            //    Sign.ResourceURL = Sign.ResourceURL.IndexOf("http://", StringComparison.Ordinal) < 0
            //        ? imageServerHost + Sign.ResourceURL
            //        : Sign.ResourceURL;
            //}

            //输出数据
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("systemConfig", config);
            _ajv.SetDataItem("Groupconfig", Groupconfig);
            _ajv.SetDataItem("customerService", mcs);
            _ajv.SetDataItem("systemNotice", noticelist);
            _ajv.SetDataItem("adsList", plate);  //广告位取消
            _ajv.SetDataItem("adsAlertList", alert);
            _ajv.SetDataItem("activityList", activity);
            _ajv.SetDataItem("imageServerHost", imageServerHost);
            _ajv.SetDataItem("MobileConfig", MobileConfig);
        }

        /// <summary>
        /// 获取手机端登录后数据
        /// </summary>
        private void GetMobileLoginLater()
        {
            //获取登录成功后数据
            DataSet ds = FacadeManage.aideAccountsFacade.GetMobileLoginLaterData(_userid);
            //获取推广链接（线上版本请将第三个参数设置成true，内部版本则为false）
            string shareLink = GetSpreadLink(ds.Tables[0], false);
            string U3DShareLink = GetU3DSpreadLink(ds.Tables[0]);
            //获取注册奖励
            DataTable table = ds.Tables[1];
            int grantDiamond = (table != null && table.Rows.Count > 0)
                ? Convert.ToInt32(table.Rows[0]["GrantDiamond"])
                : 0;
            int grantGold = (table != null && table.Rows.Count > 0)
                ? Convert.ToInt32(table.Rows[0]["GrantGold"])
                : 0;
            //获取推广配置
            IList<SpreadConfigMobile> spreadList =
                DataHelper.ConvertDataTableToObjects<SpreadConfigMobile>(ds.Tables[2]);
            // 获取玩家的排行版信息 上210需注释
            IList<CacheRankAward> wealthRank =
                DataHelper.ConvertDataTableToObjects<CacheRankAward>(ds.Tables[3]);
            IList<CacheRankAward> winCountRank =
                DataHelper.ConvertDataTableToObjects<CacheRankAward>(ds.Tables[4]);
            //获取玩家的排行版信息 旧排行榜
            //IList<RankingRecevieMobile> rankList =
            //    DataHelper.ConvertDataTableToObjects<RankingRecevieMobile>(ds.Tables[3]);
            //获取有效好友
            table = ds.Tables[5];/*ds.Tables[4];*/
            int friendCount = (table != null && table.Rows.Count > 0) ? Convert.ToInt32(table.Rows[0]["Total"]) : 0;

            // 获取排行榜奖励配置 上210需注释
            IList<RankingConfig> rankconfig =
                DataHelper.ConvertDataTableToObjects<RankingConfig>(ds.Tables[6]);
            //获取提现

            ConfigInfo drawalConfig=FacadeManage.aideNativeWebFacade.GetConfigInfo("");

            //输出信息
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("drawalConfig", drawalConfig);
            _ajv.SetDataItem("sharelink", shareLink);
            _ajv.SetDataItem("U3DShareLink", U3DShareLink);
            _ajv.SetDataItem("hasGrant", grantDiamond > 0 || grantGold > 0);
            _ajv.SetDataItem("grantDiamond", grantDiamond);
            _ajv.SetDataItem("grantGold", grantGold);
            _ajv.SetDataItem("friendcount", friendCount);
            _ajv.SetDataItem("spreadlist", spreadList);
            /*_ajv.SetDataItem("ranklist", rankList);*/ //旧排行版上210
            _ajv.SetDataItem("wealthrank", wealthRank);
            _ajv.SetDataItem("wincountrank", winCountRank);
            _ajv.SetDataItem("rankconfig", rankconfig);
        }
        private void GetPayList()
        {
            //线上充值
            for (int payType = 1; payType <= 3; ++payType) {
                IList<OnlinePayConfig> list = FacadeManage.aideTreasureFacade.GetOnlinePayList(payType);
                List<AppOnlinePayConfig> pp = new List<AppOnlinePayConfig>();
                for (int i = 0; i < list.Count; ++i)
                {
                    AppOnlinePayConfig t = new AppOnlinePayConfig();
                    t.ChanelID = list[i].ChanelID;
                    t.ID = list[i].ID;
                    t.PayType = list[i].PayType;
                    t.PayName = list[i].PayName;
                    t.ShoutCut = list[i].ShoutCut;
                    t.PresentScore = list[i].PresentScore;
                    pp.Add(t);
                }
                _ajv.SetValidDataValue(true);
                _ajv.SetDataItem("list1_" + Convert.ToString(payType), pp);
            }
            IList<OfficalBankPay> list1 = FacadeManage.aideTreasureFacade.GetBankPayList();
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("list2", list1);

            IList<OfficalImgPay> list2 = FacadeManage.aideTreasureFacade.GetImgPayList();
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("list3", list2);

            IList<OnLineWeChat> list3 = FacadeManage.aideTreasureFacade.GetOnLineWeChatList();
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("List4", list3);
        }
        /// <summary>
        /// 获取充值产品列表
        /// </summary>
        /// <param name="typeId"></param>
        private void GetPayProduct(int typeId)
        {
            //获取充值数据
            DataSet ds = FacadeManage.aideTreasureFacade.GetAppPayConfigList(typeId, _userid);
            //获取首充状态
            DataTable table = ds.Tables[0];
            bool flag = (table != null && table.Rows.Count == 0);
            //获取充值产品列表
            IList<AppPayConfigMoile> list = DataHelper.ConvertDataTableToObjects<AppPayConfigMoile>(ds.Tables[1]);
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("list", list);
        }

        /// <summary>
        /// 领取推广有效好友奖励
        /// </summary>
        private void ReceiveSpreadAward(int configid)
        {
            //领取奖励
            Message msg =
                FacadeManage.aideTreasureFacade.ReceiveSpreadAward(_userid, configid, GameRequest.GetUserIP());
            _ajv.SetValidDataValue(msg.Success);
            _ajv.msg = msg.Content;
        }

        /// <summary>
        /// 获取游戏简介列表
        /// </summary>
        private void GetGameIntroList()
        {
            IList<GameRule> gameRules = FacadeManage.aideNativeWebFacade.GetGameRuleList();
            IList<MobileGameRule> ruleList = new List<MobileGameRule>();
            ConfigInfo webConfig = Fetch.GetWebSiteConfig();
            string imageServerHost = webConfig.Field2;
            if (gameRules.Count > 0)
            {
                foreach (GameRule gameRule in gameRules)
                {
                    ruleList.Add(new MobileGameRule()
                    {
                        KindID = gameRule.KindID,
                        KindName = gameRule.KindName,
                        Content = gameRule.KindIntro,
                        RuleImg = imageServerHost + gameRule.RuleImg.Replace("Upload/", ""),
                        Type = gameRule.Type,
                        LogID = gameRule.LogID
                    });
                }
            }
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("ruleList", ruleList);
        }

        /// <summary>
        /// 获取排行榜数据
        /// </summary>
        /// <param name="userid">用户标识</param>
        /// <param name="typeid">排行类型</param>上211
        private void GetRankingData(int userid, int typeid)
        {
            //获取排行榜数据
            IList<CacheWealthRank> wealthRank = null;
            IList<CacheGameRank> gameRank = null;
            bool isRank = false;
            DataSet ds = FacadeManage.aideNativeWebFacade.GetDayRankingData(userid, typeid);
            switch (typeid)
            {
                case 1:
                    wealthRank = DataHelper.ConvertDataTableToObjects<CacheWealthRank>(ds.Tables[0]);
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        isRank = true;
                        CacheWealthRank wealth = DataHelper.ConvertRowToObject(typeof(CacheWealthRank), ds.Tables[1].Rows[0]) as CacheWealthRank;
                        wealthRank.Insert(0, wealth);
                    }
                    break;
                case 2:
                    gameRank = DataHelper.ConvertDataTableToObjects<CacheGameRank>(ds.Tables[0]);
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        isRank = true;
                        CacheGameRank game = DataHelper.ConvertRowToObject(typeof(CacheGameRank), ds.Tables[1].Rows[0]) as CacheGameRank;
                        gameRank.Insert(0, game);
                    }
                    break;
            }

            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("IsRank", isRank);
            _ajv.SetDataItem("WealthRank", wealthRank);
            _ajv.SetDataItem("GameRank", gameRank);
        }


        /// <summary>
        /// 获取财富信息
        /// </summary>
        private void GetUserWealth()
        {
            //获取财富信息
            long score = 0;
            long insureScore = 0;
            long diamond = 0;
            long awardticket = 0;
            UserWealth wealth = FacadeManage.aideTreasureFacade.GetUserWealth(_userid);
            if (wealth != null)
            {
                score = wealth.Score;
                insureScore = wealth.InsureScore;
                diamond = wealth.Diamond;
                awardticket = wealth.AwardTicket;
            }

            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("diamond", diamond);
            _ajv.SetDataItem("score", score);
            _ajv.SetDataItem("insure", insureScore);
            _ajv.SetDataItem("awardticket", awardticket);
        }

        /// <summary>
        /// 获取玩家信息
        /// </summary>
        private void GetUserInfo()
        {
            //获取财富信息
            AccountsInfo userInfo = FacadeManage.aideAccountsFacade.GetAccountsInfoByUserID(_userid);
            if (userInfo == null) return;
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("UserID", userInfo.UserID);
            _ajv.SetDataItem("GameID", userInfo.GameID);
            _ajv.SetDataItem("CustomID", userInfo.CustomID);
            _ajv.SetDataItem("NickName", userInfo.NickName);
            _ajv.SetDataItem("UnderWrite", userInfo.UnderWrite);
            _ajv.SetDataItem("LastLogonIP", userInfo.LastLogonIP);
            _ajv.SetDataItem("PlaceName", userInfo.PlaceName);
        }

        /// <summary>
        ///    
        /// </summary>
        /// <param name="dateid"></param>
        /// <param name="typeid"></param>
        private void ReceiveRankingAward(int dateid, int typeid)
        {
            //领取排行榜奖励
            Message msg =
                FacadeManage.aideNativeWebFacade.ReceiveRankingAward(_userid, dateid, typeid, GameRequest.GetUserIP());
            if (msg.Success)
            {
                _ajv.SetValidDataValue(true);
                Entity.NativeWeb.ReceiveRankAward currency = msg.EntityList[0] as Entity.NativeWeb.ReceiveRankAward;
                _ajv.SetDataItem("score", currency.Score);
                _ajv.SetDataItem("diamond", currency.Diamond);
            }
            _ajv.msg = msg.Content;
        }

        /// <summary>
        /// 获取游戏列表
        /// </summary>
        private void GetGameList()
        {
            //获取游戏列表
            DataSet ds = FacadeManage.aidePlatformFacade.GetMobileGameAndVersion();
            //获取大厅版本
            string version = "";
            string downloadUrl = "";
            string resVersion = "";
            string iosUrl = "";
            DataRow row = (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0) ? ds.Tables[0].Rows[0] : null;
            if (row != null)
            {
                downloadUrl = row["Field1"].ToString();
                version = row["Field2"].ToString();
                resVersion = row["Field3"].ToString();
                iosUrl = row["Field4"].ToString();
            }
            //获取游戏列表
            IList<MobileKindItem> list = DataHelper.ConvertDataTableToObjects<MobileKindItem>(ds.Tables[1]);

            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("downloadurl", downloadUrl);
            _ajv.SetDataItem("clientversion", version);
            _ajv.SetDataItem("resversion", resVersion);
            _ajv.SetDataItem("ios_url", iosUrl);
            _ajv.SetDataItem("gamelist", list);
        }

        /// <summary>
        /// 领取注册赠送奖励
        /// </summary>
        private void ReceiveRegisterGrant()
        {
            //领取注册奖励
            Message msg = FacadeManage.aideTreasureFacade.ReceiveRegisterAward(_userid, GameRequest.GetUserIP());
            if (msg.Success)
            {
                _ajv.SetValidDataValue(true);
                UserWealth wealth = msg.EntityList[0] as UserWealth;
                _ajv.SetDataItem("score", wealth?.Score ?? 0);
                _ajv.SetDataItem("insure", wealth?.InsureScore ?? 0);
                _ajv.SetDataItem("diamond", wealth?.Diamond ?? 0);
            }
            _ajv.msg = msg.Content;
        }

        /// <summary>
        /// 金币流水记录
        /// </summary>
        private void RecordTreasureTrade()
        {
            //获取参数
            int pageIndex = GameRequest.GetQueryInt("page", 1);
            int pageSize = GameRequest.GetQueryInt("size", 10);

            //获取流水记录
            IList<TreasureStream> list = new List<TreasureStream>();
            string where = $" WHERE UserID={_userid}";
            PagerSet ps = FacadeManage.aideRecordFacade.GetGoldStreamList(where, pageIndex, pageSize);
            DataTable table = ps.PageSet.Tables[0];
            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow item in table.Rows)
                {
                    TreasureStream stream = new TreasureStream
                    {
                        SerialNumber = item["SerialNumber"].ToString(),
                        SerialTime = Convert.ToDateTime(item["CollectDate"]).ToString("yyyy-MM-dd HH:mm:ss"),
                        BeforeGold = Convert.ToInt64(item["CurScore"]) + Convert.ToInt64(item["CurInsureScore"]),
                        ChangeGold = Convert.ToInt32(item["ChangeScore"]),
                        AfterGold = Convert.ToInt64(item["CurScore"]) + Convert.ToInt64(item["CurInsureScore"]) +
                                    //银行存取操作不需要加上变化值
                                    ((RecordTreasureType)item["TypeID"] == RecordTreasureType.存入银行 ||
                                     (RecordTreasureType)item["TypeID"] == RecordTreasureType.银行取出
                                        ? 0
                                        : Convert.ToInt32(item["ChangeScore"])),
                        Type = Convert.ToInt32(item["TypeID"])
                    };
                    list.Add(stream);
                }
            }

            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("list", list);
        }

        /// <summary>
        /// 钻石流水记录
        /// </summary>
        private void RecordDiamondsTrade()
        {
            int pageIndex = GameRequest.GetQueryInt("page", 1);
            int pageSize = GameRequest.GetQueryInt("size", 10);

            //获取流水记录
            IList<DiamondStream> list = new List<DiamondStream>();
            string where = $" WHERE UserID={_userid}";
            PagerSet ps = FacadeManage.aideRecordFacade.GetDiamondStreamList(where, pageIndex, pageSize);
            DataTable table = ps.PageSet.Tables[0];
            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow item in table.Rows)
                {
                    DiamondStream stream = new DiamondStream
                    {
                        SerialNumber = item["SerialNumber"].ToString(),
                        SerialTime = Convert.ToDateTime(item["CollectDate"]).ToString("yyyy-MM-dd HH:mm:ss"),
                        BeforeDiamond = Convert.ToInt64(item["CurDiamond"]),
                        ChangeDiamond = Convert.ToInt32(item["ChangeDiamond"]),
                        AfterDiamond = Convert.ToInt64(item["CurDiamond"]) + Convert.ToInt32(item["ChangeDiamond"]),
                        TypeName = EnumHelper.GetDesc((RecordDiamondType)item["TypeID"])
                    };
                    list.Add(stream);
                }
            }

            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("list", list);
        }


        private void DiamondExchGoldConfig()
        {
            IList<CurrencyExchConfig> Configlist = FacadeManage.aideTreasureFacade.GetDiamondExchangeGoldConfig();
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("list", Configlist);
        }
        /// <summary>
        /// 钻石兑换金币
        /// </summary>
        /// <param name="configid"></param>
        /// <param name="typeid"></param>
        private void DiamondExchGold(int configid, int typeid)
        {
            //Message msg =
            //    FacadeManage.aideTreasureFacade.DiamondExchangeGold(_userid, configid, typeid, GameRequest.GetUserIP());
            //if (msg.Success)
            //{
            //    var dataSet = msg.EntityList[0] as DataSet;
            //    if (dataSet != null)
            //    {
            //        DiamondExchRecord record =
            //            DataHelper.ConvertRowToObject<DiamondExchRecord>(dataSet.Tables[0].Rows[0]);
            //        if (record == null) return;
            //        _ajv.SetValidDataValue(true);
            //        _ajv.SetDataItem("afterDiamond", record.AfterDiamond);
            //        _ajv.SetDataItem("afterInsure", record.AfterInsureScore);
            //        _ajv.SetDataItem("afterScore", record.AfterScore);
            //        _ajv.SetDataItem("exchDiamond", record.ExchDiamond);
            //        _ajv.SetDataItem("presentGold", record.PresentGold);
            //    }
            //}
            //_ajv.msg = msg.Content;
        }

        /// <summary>
        /// 充值通用查询接口
        /// </summary>
        /// <param name="orderid"></param>
        private void GetPayOrderStatus(string orderid)
        {
            OnLinePayOrder olOrder = FacadeManage.aideTreasureFacade.GetPayOnLinePayOrder(orderid);
            UserWealth userwealth = FacadeManage.aideTreasureFacade.GetUserWealth(olOrder.UserId);


            //if (olOrder == null || olOrder.OrderStatus != 1)
            //{
            //    _ajv.SetDataItem("OrderID", orderid);
            //    _ajv.SetDataItem("PayStatus", olOrder != null ? "未支付" : "订单不存在");
            //}
            //else
            //{
            //    _ajv.SetDataItem("OrderID", orderid);
            //    _ajv.SetDataItem("PayStatus", "已支付");
            //    _ajv.SetDataItem("PayAmount", olOrder.Amount);
            //    _ajv.SetDataItem("ScoreType", olOrder.ScoreType);
            //    _ajv.SetDataItem("Score", olOrder.Score);
            //    _ajv.SetDataItem("CurScore", userwealth.Score);
            //    _ajv.SetDataItem("CurDiomand", userwealth.Diamond);
            //}
            _ajv.SetValidDataValue(true);
        }

        /// <summary>
        /// 常见问题接口
        /// </summary>
        private void GetQuestionAndAnswerList()
        {
            IList<Question> list = FacadeManage.aideNativeWebFacade.GetQAList();
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("list", list);
        }

        /// <summary>
        /// 代理同步登录接口
        /// </summary>
        private void AgentSyncLogin()
        {
            AccountsInfo aai = FacadeManage.aideAccountsFacade.GetAccountsInfoByUserID(_userid);
            if (aai?.AgentID > 0)
            {
                string clientParams = Fetch.DESEncrypt($"<>,<{aai.UserUin}>,<{aai.NickName}>,<>,<>",
                    AppConfig.WxUrlKey);
                _ajv.SetDataItem("link",
                    string.IsNullOrEmpty(Fetch.GetWebSiteConfig().Field5)
                        ? $"/Card/?w={clientParams}"
                        : Fetch.GetWebSiteConfig().Field5 + $"/?w={clientParams}");
                _ajv.SetValidDataValue(true);
            }
            else
            {
                _ajv.code = 2003;
                _ajv.msg = "抱歉，您的账号不是代理账号";
            }
        }

        /// <summary>
        /// 获取大厅战绩
        /// </summary>
        /// <param name="typeId"></param>
        private void GetBattleRecord(int typeId)
        {
            List<HallBattleInfo> bList = null;
            List<HalllScoreInfo> sList = null;

            DataSet ds = FacadeManage.aidePlatformFacade.GetHallBattleRecord(_userid, typeId);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                if (typeId >= 2)
                {
                    sList = new List<HalllScoreInfo>();
                    DataTable dscore = ds.Tables[0];
                    DataTable draw = ds.Tables[1];
                    DataTable game = ds.Tables[2];
                    HalllScoreInfo info = null;
                    foreach (DataRow item in dscore.Rows)
                    {
                        info = new HalllScoreInfo();
                        info.GameTime = Convert.ToDateTime(item["InsertTime"]);
                        DataRow[] kinds = game.Select("KindID=" + item["KindID"]);
                        info.KindID = Convert.ToInt32(item["KindID"]);
                        info.KindName = kinds != null && kinds.Length > 0 ? kinds[0]["KindName"].ToString() : "";
                        info.Score = Convert.ToInt32(item["Score"]);
                        DataRow[] draws = draw.Select("DrawID=" + item["DrawID"]);
                        info.UserCount = draws != null && draws.Length > 0 ? Convert.ToInt32(draws[0]["UserCount"]) : 0;
                        sList.Add(info);
                    }
                }
                else
                {
                    bList = new List<HallBattleInfo>();
                    DataTable battleinfo = ds.Tables[0];
                    DataTable game = ds.Tables[1];
                    DataTable user = ds.Tables[2];
                    DataTable battle = ds.Tables[4];
                    DataTable host = ds.Tables[3];

                    if (battle != null && battle.Rows.Count > 0)
                    {
                        //获取战绩
                        HallBattleInfo hall = null;
                        foreach (DataRow item in battle.Rows)
                        {
                            hall = new HallBattleInfo();
                            DataRow[] kinds = game.Select("KindID=" + item["KindID"]);
                            hall.KindID = Convert.ToInt32(item["KindID"]);
                            hall.RoomHostID = Convert.ToInt32(item["RoomHostID"]);
                            hall.KindName = kinds != null && kinds.Length > 0 ? kinds[0]["KindName"].ToString() : "";
                            hall.BaseScore = Convert.ToInt32(item["CellScore"]);
                            hall.RoomID = Convert.ToInt32(item["RoomID"]);
                            hall.Score = Convert.ToInt32(item["Score"]);
                            hall.GUID = item["PersonalRoomGUID"].ToString();
                            hall.StartTime = Convert.ToDateTime(item["StartTime"]);
                            DataRow[] rinfo = item["RoomHostID"] == null || item["RoomHostID"].ToString() == "0" ? null : host.Select("UserID=" + item["RoomHostID"]);
                            hall.GameID = rinfo != null && rinfo.Length > 0 ? Convert.ToInt32(rinfo[0]["GameID"]) : 0;
                            hall.NickName = rinfo != null && rinfo.Length > 0 ? rinfo[0]["NickName"].ToString() : "";
                            hall.PlayBackCode = Convert.ToInt32(item["PlayBackCode"]);
                            hall.ChairID = Convert.ToInt32(item["ChairID"]);

                            //获取局数
                            DataRow[] drow = battleinfo.Select("RoomID=" + item["RoomID"]);
                            List<int> gamesnum = new List<int>();
                            foreach (DataRow c in drow)
                            {
                                if (!gamesnum.Contains(Convert.ToInt32(c["GamesNum"])))
                                {
                                    gamesnum.Add(Convert.ToInt32(c["GamesNum"]));
                                }
                            }

                            List<HallGamesNum> list = new List<HallGamesNum>();
                            HallGamesNum gn = null;

                            foreach (int g in gamesnum)
                            {
                                List<HalllBattleUser> BattleUser = new List<HalllBattleUser>();
                                gn = new HallGamesNum();
                                HalllBattleUser bu = null;
                                DataRow[] rows = battleinfo.Select("GamesNum=" + g);
                                foreach (DataRow u in rows)
                                {
                                    if (u["RoomID"].ToString() == item["RoomID"].ToString())
                                    {
                                        bu = new HalllBattleUser();
                                        DataRow[] uinfo = user.Select("UserID=" + u["UserID"]);
                                        bu.GameID = uinfo != null && uinfo.Length > 0 ? Convert.ToInt32(uinfo[0]["GameID"]) : 0;
                                        bu.NickName = uinfo != null && uinfo.Length > 0 ? uinfo[0]["NickName"].ToString() : "";
                                        bu.Score = Convert.ToInt32(u["Score"]);
                                        bu.VideoNumber = u["ID"].ToString();
                                        BattleUser.Add(bu);
                                    }
                                }
                                gn.GamesNum = g;
                                gn.BattleUser = BattleUser;
                                list.Add(gn);
                            }
                            hall.GamesNum = list;
                            bList.Add(hall);
                        }
                    }
                }
            }
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("bList", bList);
            _ajv.SetDataItem("sList", sList);
        }

        /// <summary>
        /// 获取俱乐部战绩
        /// </summary>
        private void GetGroupBattleRecord()
        {
            int groupid = GameRequest.GetQueryInt("groupid", 0);
            //int typeid = GameRequest.GetQueryInt("typeid", 0);

            List<ClubBattleInfo> bList = null;

            DateTime start = DateTime.Now.AddHours(-48);
            DateTime end = DateTime.Now;

            DataSet ds = FacadeManage.aidePlatformFacade.GetClubBattleRecord(_userid, groupid, start, end);
            if (ds != null && ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
            {
                bList = new List<ClubBattleInfo>();
                DataTable battleinfo = ds.Tables[0];
                DataTable game = ds.Tables[1];
                DataTable user = ds.Tables[2];
                DataTable battle = ds.Tables[4];
                DataTable host = ds.Tables[3];

                if (battle != null && battle.Rows.Count > 0)
                {
                    //获取战绩
                    ClubBattleInfo hall = null;
                    foreach (DataRow item in battle.Rows)
                    {
                        hall = new ClubBattleInfo();
                        DataRow[] kinds = game.Select("KindID=" + item["KindID"]);
                        hall.KindID = Convert.ToInt32(item["KindID"]);
                        hall.RoomHostID = Convert.ToInt32(item["RoomHostID"]);
                        hall.KindName = kinds != null && kinds.Length > 0 ? kinds[0]["KindName"].ToString() : "";
                        hall.BaseScore = Convert.ToInt32(item["CellScore"]);
                        hall.RoomID = Convert.ToInt32(item["RoomID"]);
                        hall.Score = Convert.ToInt32(item["Score"]);
                        hall.GUID = item["PersonalRoomGUID"].ToString();
                        hall.StartTime = Convert.ToDateTime(item["StartTime"]);
                        DataRow[] rinfo = item["RoomHostID"] == null || item["RoomHostID"].ToString() == "0" ? null : host.Select("UserID=" + item["RoomHostID"]);
                        hall.GameID = rinfo != null && rinfo.Length > 0 ? Convert.ToInt32(rinfo[0]["GameID"]) : 0;
                        hall.NickName = rinfo != null && rinfo.Length > 0 ? rinfo[0]["NickName"].ToString() : "";
                        hall.PlayBackCode = Convert.ToInt32(item["PlayBackCode"]);
                        hall.PlayMode = Convert.ToInt32(item["PlayMode"]);
                        hall.ChairID = Convert.ToInt32(item["ChairID"]);

                        //获取局数
                        DataRow[] drow = battleinfo.Select("RoomID=" + item["RoomID"]);
                        List<int> gamesnum = new List<int>();
                        foreach (DataRow c in drow)
                        {
                            if (!gamesnum.Contains(Convert.ToInt32(c["GamesNum"])))
                            {
                                gamesnum.Add(Convert.ToInt32(c["GamesNum"]));
                            }
                        }

                        List<ClubGamesNum> list = new List<ClubGamesNum>();
                        ClubGamesNum gn = null;

                        foreach (int g in gamesnum)
                        {
                            List<ClubBattleUser> BattleUser = new List<ClubBattleUser>();
                            gn = new ClubGamesNum();
                            ClubBattleUser bu = null;
                            DataRow[] rows = battleinfo.Select("GamesNum=" + g);
                            foreach (DataRow u in rows)
                            {
                                if (u["RoomID"].ToString() == item["RoomID"].ToString())
                                {
                                    bu = new ClubBattleUser();
                                    DataRow[] uinfo = user.Select("UserID=" + u["UserID"]);
                                    bu.GameID = uinfo != null && uinfo.Length > 0 ? Convert.ToInt32(uinfo[0]["GameID"]) : 0;
                                    bu.NickName = uinfo != null && uinfo.Length > 0 ? uinfo[0]["NickName"].ToString() : "";
                                    bu.Score = Convert.ToInt32(u["Score"]);
                                    bu.VideoNumber = u["ID"].ToString();
                                    BattleUser.Add(bu);
                                }
                            }
                            gn.GamesNum = g;
                            gn.BattleUser = BattleUser;
                            list.Add(gn);
                        }
                        hall.GamesNum = list;
                        bList.Add(hall);
                    }
                }
            }
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("bList", bList);
        }


        /// <summary> 
        /// 获取在线充值微信账号列表
        /// </summary>
        private void GetOnLineWeChatList()
        {
            IList<OnLineWeChat> list = FacadeManage.aideTreasureFacade.GetOnLineWeChatList();
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("List", list);
        }
        /// <summary>
        /// 获取验证码
        /// </summary>
        /// <param name="context"></param>
        protected void GetCode(HttpContext context)
        {
            bool result = true;
            string Mobile = GameRequest.GetQueryString("Mobile");
            int userid = GameRequest.GetQueryInt("userid", 0);//用户标识
            int type = GameRequest.GetQueryInt("type", 0);//1注册2修改


            //电话号码非空验证
            if (string.IsNullOrEmpty(Mobile))
            {
                _ajv.SetValidDataValue(false);
                _ajv.msg = "电话号码不能为空";
                return;
            }
            //验证码时间限制
            int CheckCodeTime = FacadeManage.aideAccountsFacade.GetSystemStatusInfo("CheckCodeValidTime").StatusValue;
            if (CheckCodeTime > 0)
            {
                result = FacadeManage.aideAccountsFacade.VaildSendOnTime(Mobile, CheckCodeTime);
            }

            if (!result)
            {
                _ajv.SetValidDataValue(false);
                _ajv.msg = "已完成发送，请稍后重试";
                return;
            }

            int rs = 0;
            if (userid == 0 || type > 0)
            {
                int MolibleNum = FacadeManage.aideAccountsFacade.GetSystemStatusInfo("MolibleNum").StatusValue;
                int lognum = Convert.ToInt32(FacadeManage.aideAccountsFacade.GetSMSLogCount(Mobile));

                AccountsInfo info = FacadeManage.aideAccountsFacade.GetAccountsInfoByAccounts(Mobile);
                if (type == 1 && info != null)
                {

                    rs = -2;//账号已注册
                    _ajv.SetValidDataValue(true);
                    _ajv.SetDataItem("rs", rs);
                    return;
                }
                if (MolibleNum > 0 && lognum >= MolibleNum)
                {
                    rs = -1;//已超过获取验证码限制次数
                    _ajv.SetValidDataValue(true);
                    _ajv.SetDataItem("rs", rs);
                    return;
                }


                if (type == 2 && info == null)
                {
                    rs = -3;//账号未注册
                    _ajv.SetValidDataValue(true);
                    _ajv.SetDataItem("rs", rs);
                    return;
                }
            }

            string code = Facade.GetMobileCode.MyGetCode(Mobile);
            if (!string.IsNullOrEmpty(code))
            {
                rs = FacadeManage.aideAccountsFacade.InsertSMSInfo(userid, Mobile, code);

            }
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("rs", rs);
        }
        /// <summary>
        /// 绑定手机
        /// </summary>
        /// <param name="context"></param>
        protected void BindMobile(HttpContext context)
        {

            string code = GameRequest.GetQueryString("code");
            string Mobile = GameRequest.GetQueryString("Mobile");
            string userid = GameRequest.GetQueryString("userid");
            string time = ApplicationSettings.Get("SMS_time");
            int rs = 0;
            Message msg = new Message();
            //验证手机号

            msg = CheckingMobilePhoneNumFormat(Mobile, false);
            if (!msg.Success)
            {
                _ajv.msg = "请输入正确的手机号码!";
                return;
            }
            if (string.IsNullOrEmpty(code) || code.Length < 6)
            {
                _ajv.msg = "请填写正确的验证码!";
                return;
            }

            if (!string.IsNullOrEmpty(code) && !string.IsNullOrEmpty(Mobile) && !string.IsNullOrEmpty(userid))
            {
                Message umsg = FacadeManage.aideAccountsFacade.BindMobile(Convert.ToInt32(userid), Mobile, code, Convert.ToInt32(time));
                rs = Convert.ToInt32(umsg.Content);
            }
            if (rs == -1)
            {
                _ajv.msg = "验证码错误!";
            }
            else if (rs == -2)
            {
                _ajv.msg = "验证码过期!";
            }
            else if (rs == 1)
            {
                _ajv.msg = "绑定成功!";
            }

            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("rs", rs);
        }
        /// <summary>
        /// 获取手机绑定验证配置
        /// </summary>
        /// <param name="context"></param>
        protected void BindMobileConfig(HttpContext context)
        {
            string userid = GameRequest.GetQueryString("userid");
            AccountsInfo info = FacadeManage.aideAccountsFacade.GetAccountsInfoByUserID(Convert.ToInt32(userid));
            int isBind = 0;
            int BindMolibleReward = 0;
            if (!string.IsNullOrEmpty(info.RegisterMobile))
            {
                isBind = 1;
            }
            Entity.Accounts.SystemStatusInfo System = FacadeManage.aideAccountsFacade.GetSystemStatusInfo("BindMolibleReward");

            if (System != null)
            {
                BindMolibleReward = System.StatusValue;
            }


            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("isBind", isBind);
            _ajv.SetDataItem("BindMolibleReward", BindMolibleReward);
        }
        /// <summary>
        /// 每日分享
        /// </summary>
        /// <param name="context"></param>
        protected void ShareTimesReward(HttpContext context)
        {
            string userid = GameRequest.GetQueryString("userid");
            DataSet ds = FacadeManage.aideNativeWebFacade.GetTimesReward(Convert.ToInt32(userid), GameRequest.GetUserIP());
            DataTable dt = ds.Tables[0];
            int rs = -1;
            int TimeShareGold = 0;
            int TimeShareDiamond = 0;
            if (dt.Rows.Count > 0)
            {
                rs = Convert.ToInt32(dt.Rows[0]["rst"]);
                TimeShareGold = Convert.ToInt32(dt.Rows[0]["TimeShareGold"]);
                TimeShareDiamond = Convert.ToInt32(dt.Rows[0]["TimeShareDiamond"]);
            }
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("rs", rs);
            _ajv.SetDataItem("TimeShareGold", TimeShareGold);
            _ajv.SetDataItem("TimeShareDiamond", TimeShareDiamond);

        }

        protected void GetShareReward(HttpContext context)
        {
            DataSet ds = FacadeManage.aideNativeWebFacade.GetShareReward();
            List<ShareConfig> list = new List<ShareConfig>();
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataTable dt = ds.Tables[0];
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    ShareConfig sc = new ShareConfig();
                    sc.DayShareLmt = Convert.ToInt32(dt.Rows[i]["DayShareLmt"].ToString());
                    sc.TimeShareGold = Convert.ToInt32(dt.Rows[i]["TimeShareGold"].ToString());
                    sc.TimeShareDiamond = Convert.ToInt32(dt.Rows[i]["TimeShareDiamond"].ToString());
                    sc.Nullity = Convert.ToInt32(dt.Rows[i]["Nullity"].ToString());
                    list.Add(sc);
                }
            }

            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("list", list);

        }


        #region 代理接口模块
        /// <summary>
        /// 获取代理信息汇总
        /// </summary>
        private void GetAgentInfo()
        {

            DataSet ds = FacadeManage.aideTreasureFacade.GetAgentInfo(_userid);
            DataRow row = (ds.Tables[0] != null && ds.Tables[0].Rows.Count > 0) ? ds.Tables[0].Rows[0] : null;
            if (row != null)
            {
                _ajv.SetValidDataValue(true);
                _ajv.SetDataItem("Allperson", row["Allperson"]);
                _ajv.SetDataItem("Immediateperson", row["Immediateperson"]);
                _ajv.SetDataItem("ImmediateMoney", row["ImmediateMoney"]);
                _ajv.SetDataItem("OtherMoney", row["OtherMoney"]);
                _ajv.SetDataItem("CurrReward", row["CurrReward"]);
                _ajv.SetDataItem("HisMoney", row["HisMoney"]);
            }
            else
            {
                _ajv.SetValidDataValue(true);
            }
        }
        //领取奖励
        private void GetReward()
        { 
            Message mm= FacadeManage.aideTreasureFacade.GetReward(_userid);
            _ajv.SetValidDataValue(mm.Success);
            _ajv.msg = mm.Content;
        }
        private void RewardRecord()
        {
            int index = GameRequest.GetQueryInt("index",1);
            int uid = GameRequest.GetQueryInt("uid", _userid);

            string[] fields = { "A.GameID", "A.NickName", "R.BeggarNumber", "R.AllReward", "R.Reward" , "R.BackMoney" };
            string[] fieldAlias = { "GameID", "NickName", "BeggarNumber", "AllReward", "Reward", "BackMoney" };
            PagerSet ps = FacadeManage.aideTreasureFacade.GetList(" WHQJAccountsDB.dbo.AccountsInfo A INNER JOIN WHQJTreasureDB.dbo.AgentInfo R ON A.UserID = R.UserID ", index, 6, $" WHERE R.ParentID = {uid} ",
                " ORDER BY BackMoney DESC ", fields, fieldAlias);

            IList<AgentReward> list = new List<AgentReward>();
            DataTable table = ps.PageSet.Tables[0];
            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow item in table.Rows)
                {
                    AgentReward stream = new AgentReward
                    {
                        NicekName = item["NickName"].ToString(),
                        GameId = Convert.ToInt32(item["GameID"]),
                        person= Convert.ToInt32(item["BeggarNumber"]),
                        personMoney = Convert.ToInt32(item["AllReward"])+ Convert.ToInt32(item["Reward"]),
                        AllMoney = Convert.ToInt32(item["AllReward"]) + Convert.ToInt32(item["Reward"])+ Convert.ToInt32(item["BackMoney"]),
                    };
                    list.Add(stream);
                }
            }
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("list", list);
            _ajv.SetDataItem("Count",ps.PageCount);
            _ajv.SetDataItem("pageIndex", ps.PageIndex);
        }

        private void RewardDrawalBill()
        {
            int index = GameRequest.GetQueryInt("pageIndex",1);
            PagerSet ps = FacadeManage.aideRecordFacade.GetList(RecordAgentReward.Tablename,index,6, $" WHERE UserID={_userid} ", " ORDER BY drawalTime DESC ");
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("index",ps.PageIndex);
            _ajv.SetDataItem("page", ps.PageCount);
            IList<AgentDrawalBill> list = new List<AgentDrawalBill>();
            DataTable table = ps.PageSet.Tables[0];
            if (table != null && table.Rows.Count > 0)
            {
                foreach (DataRow item in table.Rows)
                {
                    AgentDrawalBill stream = new AgentDrawalBill
                    {
                        DrawalTime=item["drawalTime"].ToString(),
                        DrawalMoney=Convert.ToInt64(item["GetMoney"])
                    };
                    list.Add(stream);
                }
            }
            _ajv.SetDataItem("list", list);

        }
        private void GetIdByLink()
        {
            string link = GameRequest.GetQueryString("link");
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("gameid", FacadeManage.aideTreasureFacade.GetIdByLink(link));
        }
        #endregion



        #region 辅助方法

        /// <summary>
        /// 获取手机端配置
        /// </summary>
        private MobileSystemConfig GetMobileSystemConfig(DataTable table)
        {
            MobileSystemConfig config = new MobileSystemConfig();
            if (table == null || table.Rows.Count <= 0) return config;
            foreach (DataRow item in table.Rows)
            {
                // ReSharper disable once SwitchStatementMissingSomeCases
                switch (item["StatusName"].ToString())
                {
                    case "JJOpenMobileMall":
                        config.IsOpenMall = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "JJPayBindSpread":
                        config.IsPayBindSpread = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "JJBindSpreadPresent":
                        config.BindSpreadPresent = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "JJRankingListType":
                        config.RankingListType = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "JJPayChannel":
                        config.PayChannel = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "JJDiamondBuyProp":
                        config.DiamondBuyPropCount = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "JJRealNameAuthentPresent":
                        config.RealNameAuthentPresent = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "JJEffectiveFriendGame":
                        config.EffectiveFriendGame = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "IOSNotStorePaySwitch":
                        config.IOSNotStorePaySwitch = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "JJGoldBuyProp":
                        config.GoldBuyPropCount = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "EnjoinInsure":
                        config.EnjoinInsure = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "TransferStauts":
                        config.TransferStauts = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "MobileBattleRecordMask":
                        config.MobileBattleRecordMask = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "OpenGameSignIn":
                        config.IsOpenGameSignIn = Convert.ToInt32(item["StatusValue"]);
                        break;
                    case "IsRedemptionCenter":
                        config.IsOpenRedemptionCenter = Convert.ToInt32(item["StatusValue"]);
                        break;
                }
            }
            return config;
        }

        /// <summary>
        /// 获取亲友圈配置
        /// </summary>
        private GroupSystemConfig GetGroupConfig(DataTable table)
        {
            GroupSystemConfig config = new GroupSystemConfig();
            if (table == null || table.Rows.Count <= 0) return config;
            foreach (DataRow item in table.Rows)
            {
                // ReSharper disable once SwitchStatementMissingSomeCases
                switch (item["OptionName"].ToString())
                {
                    case "MaxMemberCount":
                        config.MaxMemberCount = Convert.ToInt32(item["OptionValue"]);
                        break;
                    case "MaxCreateGroupCount":
                        config.MaxCreateGroupCount = Convert.ToInt32(item["OptionValue"]);
                        break;
                    case "CreateGroupTakeIngot":
                        config.CreateGroupTakeIngot = Convert.ToInt32(item["OptionValue"]);
                        break;
                    case "CreateGroupDeductIngot":
                        config.CreateGroupDeductIngot = Convert.ToInt32(item["OptionValue"]);
                        break;
                    case "MaxJoinGroupCount":
                        config.MaxJoinGroupCount = Convert.ToInt32(item["OptionValue"]);
                        break;
                    case "GroupPayType":
                        config.GroupPayType = Convert.ToInt32(item["OptionValue"]);
                        break;
                    case "GroupPayTypeChange":
                        config.GroupPayTypeChange = Convert.ToInt32(item["OptionValue"]);
                        break;
                    case "GroupRoomType":
                        config.GroupRoomType = Convert.ToInt32(item["OptionValue"]);
                        break;
                }
            }
            return config;
        }



        /// <summary>
        /// 获取推广链接
        /// </summary>
        private string GetSpreadLink(DataTable table, bool flag)
        {
            string shareLink = string.Empty;
            if (table != null && table.Rows.Count > 0)
            {
                DataRow row = table.Rows[0];
                //获取分享域名，没有则取当前域名
                ConfigInfo webConfig = Fetch.GetWebSiteConfig();
                string domain = string.IsNullOrEmpty(webConfig.Field4)
                    ? GameRequest.GetCurrentFullHost()
                    : webConfig.Field4;
                //线上版本
                if (flag)
                {
                    if (Convert.ToInt32(row["AgentID"]) > 0)
                    {
                        shareLink = "http://" + row["AgentDomain"] + "/Mobile/ShareLink.aspx";
                    }
                    else
                    {
                        string[] domainStr = domain.Split('.');
                        shareLink = domainStr.Length != 3
                            ? (domain + "/Mobile/ShareLink.aspx?g=" + row["GameID"])
                            : ("http://" + row["GameID"] + "." + domainStr[1] + "." + domainStr[2] +
                               "/Mobile/ShareLink.aspx");
                    }
                }
                else
                {
                    if (Convert.ToInt32(row["AgentID"]) > 0)
                    {
                        shareLink = domain + "/Mobile/AgentShareLinkLua.aspx?g=" + row["GameID"];
                    }
                    else
                    {
                        shareLink = domain + "/Mobile/ShareLinkNew.aspx?g=" + row["GameID"];
                    }

                }
            }
            return shareLink;
        }

        /// <summary>
        /// 获取U3D推广链接
        /// </summary>
        private string GetU3DSpreadLink(DataTable table)
        {
            string shareLink = string.Empty;
            if (table != null && table.Rows.Count > 0)
            {
                DataRow row = table.Rows[0];
                //获取分享域名，没有则取当前域名
                ConfigInfo webConfig = Fetch.GetWebSiteConfig();
                string domain = string.IsNullOrEmpty(webConfig.Field4)
                    ? GameRequest.GetCurrentFullHost()
                    : webConfig.Field4;

                if (Convert.ToInt32(row["AgentID"]) > 0)
                {
                    shareLink = domain + "/Mobile/AgentShareLink.aspx?g=" + row["GameID"] + "&y=u3d";
                }
                else
                {
                    shareLink = domain + "/Mobile/ShareLinkNew.aspx?g=" + row["GameID"] + "&y=u3d";
                }
            }
            return shareLink;
        }

        /// <summary>
        /// 获取微信预支付信息包
        /// </summary>
        /// <returns></returns>
        private string GetWxPayPackage(OnLinePayOrder orderReturn, string paytype, string openid,
            string authority)
        {
            string domain = string.IsNullOrEmpty(AppConfig.FrontSiteDomain) ? authority : AppConfig.FrontSiteDomain;
            WxPayInfo wx = new WxPayInfo
            {
                AppID = ApplicationSettings.Get(paytype == "wx" ? "WXAPPID" : "WXNATIVEAPPID"),
                AppSecret = ApplicationSettings.Get(paytype == "wx" ? "WXAPPSECRET" : "WXNATIVESECRET"),
                // ReSharper disable once SpecifyACultureInStringConversionExplicitly
                Body = orderReturn.Amount.ToString(),
                Key = ApplicationSettings.Get(paytype == "wx" ? "WXAPPKEY" : "WXNATIVEKEY"),
                Mchid = ApplicationSettings.Get(paytype == "wx" ? "WXAPPMCHID" : "WXNATIVEMCHID"),
                NotifyUrl = "http://" + domain + "/Notify/" + (paytype == "wx" ? "WxApp.aspx" : "WxWeb.aspx"),

                OpenId = openid,
                OutTradeNo = orderReturn.OrderID,
                TotalFee = (orderReturn.Amount * 100).ToString("F0"),
                TradeType = paytype == "wx" ? "APP" : "JSAPI"
            };
            WxPayHelper helper = new WxPayHelper(wx);
            return helper.GetPrepayIDSign();
        }
        /// <summary>
        /// 验证移动电话号码
        /// </summary>
        /// <param name="mobilePhoneNum"></param>
        /// <returns></returns>
        public Message CheckingMobilePhoneNumFormat(string mobilePhoneNum, bool isAllowNull)
        {
            Message msg = new Message();
            if (isAllowNull && string.IsNullOrEmpty(mobilePhoneNum))
            {
                return msg;
            }
            if (!isAllowNull && string.IsNullOrEmpty(mobilePhoneNum))
            {
                msg.Success = false;
                msg.Content = "电话号码不能为空";
                return msg;
            }

            Regex isMobile = new Regex(@"^\d{11}$", RegexOptions.Compiled);
            if (!isMobile.IsMatch(mobilePhoneNum))
            {
                msg.Success = false;
                msg.Content = "移动电话格式不正确";
                return msg;
            }
            return msg;
        }



        /// <summary>
        /// 验证安全密码是否正确
        /// </summary>
        /// <param name="pass"></param>
        /// <returns></returns>
        protected bool IsPassChecked(string pass)
        {
            AccountsInfo userInfo = FacadeManage.aideAccountsFacade.GetAccountsInfoByUserID(_userid);
            Entity.Agent.AgentInfo agentInfo =
               FacadeManage.aideAgentFacade.GetAgentInfo(userInfo.AgentID, _userid);
            return pass.ToLower() == agentInfo.Password.ToLower();
        }
        #endregion



        public bool IsReusable => false;
    }
}
