/*
 * 版本： 4.0
 * 日期：2019/10/24 10:37:22
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 OnLinePayOrder  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class OnLinePayOrder
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "OnLinePayOrder";

        #endregion 

        #region 私有变量

        private string p_orderid;
        private int p_gameid;
        private int p_userid;
        private string p_nickname;
        private decimal p_amount;
        private decimal p_presentscore;
        private byte p_paytype;
        private int p_channelid;
        private byte p_orderstates;
        private int p_masterid;
        private DateTime p_paytime;
        private DateTime? p_calltime;
        private string p_addrstr;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化OnLinePayOrder
        /// </summary>
        public OnLinePayOrder()
        {
            p_orderid = string.Empty;
            p_gameid = 0;
            p_userid = 0;
            p_nickname = string.Empty;
            p_amount = 0;
            p_presentscore = 0;
            p_paytype = 0;
            p_channelid = 0;
            p_orderstates = 0;
            p_masterid = 0;
            p_paytime = DateTime.Now;
            p_calltime = null;
            p_addrstr = string.Empty;
        }

        #endregion

        #region 公共属性 

        /// <summary>
        /// OrderID
        /// </summary>
        public string OrderID
        {
            set
            {
                p_orderid = value;
            }
            get
            {
                return p_orderid;
            }
        }

        /// <summary>
        /// GameId
        /// </summary>
        public int GameId
        {
            set
            {
                p_gameid = value;
            }
            get
            {
                return p_gameid;
            }
        }

        /// <summary>
        /// UserId
        /// </summary>
        public int UserId
        {
            set
            {
                p_userid = value;
            }
            get
            {
                return p_userid;
            }
        }

        /// <summary>
        /// NickName
        /// </summary>
        public string NickName
        {
            set
            {
                p_nickname = value;
            }
            get
            {
                return p_nickname;
            }
        }

        /// <summary>
        /// Amount
        /// </summary>
        public decimal Amount
        {
            set
            {
                p_amount = value;
            }
            get
            {
                return p_amount;
            }
        }

        /// <summary>
        /// PresentScore
        /// </summary>
        public decimal PresentScore
        {
            set
            {
                p_presentscore = value;
            }
            get
            {
                return p_presentscore;
            }
        }

        /// <summary>
        /// PayType
        /// </summary>
        public byte PayType
        {
            set
            {
                p_paytype = value;
            }
            get
            {
                return p_paytype;
            }
        }

        /// <summary>
        /// ChannelId
        /// </summary>
        public int ChannelId
        {
            set
            {
                p_channelid = value;
            }
            get
            {
                return p_channelid;
            }
        }

        /// <summary>
        /// OrderStates
        /// </summary>
        public byte OrderStates
        {
            set
            {
                p_orderstates = value;
            }
            get
            {
                return p_orderstates;
            }
        }

        /// <summary>
        /// MasterId
        /// </summary>
        public int MasterId
        {
            set
            {
                p_masterid = value;
            }
            get
            {
                return p_masterid;
            }
        }

        /// <summary>
        /// PayTime
        /// </summary>
        public DateTime PayTime
        {
            set
            {
                p_paytime = value;
            }
            get
            {
                return p_paytime;
            }
        }

        /// <summary>
        /// CallTime
        /// </summary>
        public DateTime? CallTime
        {
            set
            {
                p_calltime = value;
            }
            get
            {
                return p_calltime;
            }
        }

        /// <summary>
        /// Addrstr
        /// </summary>
        public string Addrstr
        {
            set
            {
                p_addrstr = value;
            }
            get
            {
                return p_addrstr;
            }
        }

        #endregion
    }
}

