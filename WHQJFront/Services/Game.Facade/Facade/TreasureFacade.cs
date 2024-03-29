﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using Game.Data.Factory;
using Game.IData;
using Game.Kernel;
using Game.Utils;
using System.Data;
using Game.Entity.Treasure;

namespace Game.Facade
{
    /// <summary>
    /// 金币库外观
    /// </summary>
    public class TreasureFacade
    {
        #region Fields

        private ITreasureDataProvider treasureData;

        #endregion

        #region 构造函数

        /// <summary>
        /// 构造函数
        /// </summary>
        public TreasureFacade()
        {
            treasureData = ClassFactory.GetITreasureDataProvider();
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
            return treasureData.GetList(tableName, pageIndex, pageSize, condition, orderby);
        }

        public PagerSet GetList(string tableName, int pageIndex, int pageSize, string condition, string orderby,string[] fields, string[] fieldAlias)
        {
            return treasureData.GetList(tableName, pageIndex, pageSize, condition, orderby, fields, fieldAlias);
        }

        public PagerSet GetListLock(string tableName, string where, string order, int pageIndex, int pageSize, string fields = null)
        {
            return treasureData.GetListLock(tableName,where,order,pageIndex,pageSize,fields);
        }

        #endregion

        #region 帅逼接口
        public IList<OnlinePayConfig> GetOnlinePayList(int payType)
        {
            return treasureData.GetOnLinePayList(payType);
        }
        public IList<OfficalBankPay> GetBankPayList()
        {
            return treasureData.GetBankPayList();
        }
        public IList<OfficalImgPay> GetImgPayList()
        {
            return treasureData.GetImgPayList();
        }

        public GameScoreInfo GetGameScoreInfoByUid(int uid)
        {
            return treasureData.GetGameScoreInfoByUid(uid);
        }

        public UserValidBet GetValidBetByUid(int uid)
        {
            return treasureData.GetValidBetByUid(uid);
        }

        public Message CreateDrawalOrder(DrawalOrder order)
        {
            return treasureData.CreateDrawalOrder(order);
        }

        public Message CreatImgPayOrder(int uid,int cfgId,string payLink,int amount,string payName,string orderID)
        {
            return treasureData.CreatImgPayOrder(uid, cfgId, payLink, amount, payName, orderID);
        }

        public Message CreatBankPayOrder(int uid, int cfgId, string BankAcc, int amount, string payName, string payBank, int TransferType, string orderID)
        {
            return treasureData.CreatBankPayOrder(uid, cfgId, BankAcc, amount, payName, payBank, TransferType, orderID);
        }

        public Message BuyDiam(int uid,int number)
        {
            return treasureData.BuyDiam(uid, number);
        }

        public DataSet GetAgentRank(int uid, int type)
        {
            return treasureData.GetAgentRank(uid,type);
        }

        public Message DealTurnTable(int uid, string tableName, int index, int open,  long reward, long score)
        {
            return treasureData.DealTurnTable(uid, tableName, index, open, reward, score);
        }
        public DataSet GetUserVip(int uid)
        {
            return treasureData.GetUserVip(uid);
        }
        public decimal GetVipReward(int type, int uid,string ip)
        {
            return treasureData.GetVipReward(type,uid,ip);
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
            return treasureData.GetAppPayConfigList(typeId);
        }
        /// <summary>
        /// 获取充值产品列表
        /// </summary>
        /// <param name="typeId">充值产品类型</param>
        /// <param name="userid">首充用户</param>
        /// <returns></returns>
        public DataSet GetAppPayConfigList(int typeId, int userid)
        {
            return treasureData.GetAppPayConfigList(typeId, userid);
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
            return treasureData.IsTodayHasPay(userid);
        }
        /// <summary>
        /// 充值记录
        /// </summary>
        /// <param name="whereQuery"></param>
        /// <param name="pageIndex"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        public PagerSet GetPayDiamondRecord(string whereQuery, int pageIndex, int pageSize, string[] returnField = null)
        {
            return treasureData.GetPayDiamondRecord(whereQuery, pageIndex, pageSize, returnField);
        }

        /// <summary>
        /// 根据订单号获取充值订单
        /// </summary>
        /// <param name="orderid"></param>
        /// <returns></returns>
        public OnLinePayOrder GetPayOnLinePayOrder(string orderid)
        {
            return treasureData.GetPayOnLinePayOrder(orderid);
        }

        /// <summary>
        /// 获取在线充值列表
        /// </summary>
        /// <returns></returns>
        public IList<OnLineWeChat> GetOnLineWeChatList()
        {
            return treasureData.GetOnLineWeChatList();
        }
        #endregion

        #region 推广信息

        public DataSet GetAgentInfo(int uid)
        {
            return treasureData.GetAgentInfo(uid);
        }
        public Message GetReward(int uid)
        {
            return treasureData.GetReward(uid);
        }
        public int GetIdByLink(string link)
        {
            return treasureData.GetIdByLink(link);
        }
        /// <summary>
        /// 领取推广人有效好友奖励
        /// </summary>
        /// <param name="userid">用户标识</param>
        /// <param name="configid">推广配置标识</param>
        /// <param name="ip">领取地址</param>
        /// <returns></returns>
        public Message ReceiveSpreadAward(int userid, int configid, string ip)
        {
            return treasureData.ReceiveSpreadAward(userid, configid, ip);
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
            return treasureData.GetUserWealth(userId);
        }
        /// <summary>
        /// 获取钻石信息
        /// </summary>
        /// <param name="userId">用户标识</param>
        /// <returns></returns>
        public UserCurrency GetUserCurrency(int userId)
        {
            return treasureData.GetUserCurrency(userId);
        }
        /// <summary>
        /// 代理钻石赠送
        /// </summary>
        /// <param name="userId"></param>
        /// <param name="password"></param>
        /// <param name="presentCount"></param>
        /// <param name="gameId"></param>
        /// <param name="clientIP"></param>
        /// <returns></returns>
        public Message AgentPresentDiamond(int userId, string password, int presentCount, int gameId, string clientIP, string note="")
        {
            return treasureData.AgentPresentDiamond(userId, password, presentCount, gameId, clientIP, note);
        }

        /// <summary>
        /// 钻石兑换金币 外壳层
        /// </summary>
        /// <param name="userid"></param>
        /// <param name="configid"></param>
        /// <param name="typeid"></param>
        /// <param name="clientIp"></param>
        /// <returns></returns>
        public Message DiamondExchangeGold(int userid, int configid, int typeid, string clientIp)
        {
            return treasureData.DiamondExchangeGold(userid, configid, typeid, clientIp);
        }
       
        /// <summary>
        /// 获取钻石兑换金币配置
        /// </summary>
        /// <returns></returns>
        public IList<CurrencyExchConfig> GetDiamondExchangeGoldConfig() {
            return treasureData.GetDiamondExchangeGoldConfig();
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
            return treasureData.GetVideoDataByVNumber(number);
        }
        #endregion

        #region 注册奖励
        /// <summary>
        /// 领取注册奖励
        /// </summary>
        /// <param name="UserID">用户标识</param>
        /// <param name="IP">领取地址</param>
        /// <returns></returns>
        public Message ReceiveRegisterAward(int UserID, string IP)
        {
            return treasureData.ReceiveRegisterAward(UserID, IP);
        }
        #endregion
    }
}
