/*
 * 版本： 4.0
 * 日期：2019/10/23 19:41:00
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 DrawalOrder  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class DrawalOrder
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "DrawalOrder";

        #endregion 

        #region 私有变量

        private string p_orderid;
        private byte p_drawaltype;
        private int p_userid;
        private int p_gameid;
        private int p_masterid;
        private decimal p_amount;
        private byte p_orderstate;
        private decimal p_ordercost;
        private string p_ip;
        private DateTime p_currenttime;
        private DateTime? p_dealtime;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化DrawalOrder
        /// </summary>
        public DrawalOrder()
        {
            p_orderid = string.Empty;
            p_drawaltype = 0;
            p_userid = 0;
            p_gameid = 0;
            p_masterid = 0;
            p_amount = 0;
            p_orderstate = 0;
            p_ordercost = 0;
            p_ip = string.Empty;
            p_currenttime = DateTime.Now;
            p_dealtime = null;
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
        /// drawalType
        /// </summary>
        public byte drawalType
        {
            set
            {
                p_drawaltype = value;
            }
            get
            {
                return p_drawaltype;
            }
        }

        /// <summary>
        /// UserID
        /// </summary>
        public int UserID
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
        /// GameID
        /// </summary>
        public int GameID
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
        /// MasterID
        /// </summary>
        public int MasterID
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
        /// OrderState
        /// </summary>
        public byte OrderState
        {
            set
            {
                p_orderstate = value;
            }
            get
            {
                return p_orderstate;
            }
        }

        /// <summary>
        /// OrderCost
        /// </summary>
        public decimal OrderCost
        {
            set
            {
                p_ordercost = value;
            }
            get
            {
                return p_ordercost;
            }
        }

        /// <summary>
        /// IP
        /// </summary>
        public string IP
        {
            set
            {
                p_ip = value;
            }
            get
            {
                return p_ip;
            }
        }

        /// <summary>
        /// CurrentTime
        /// </summary>
        public DateTime CurrentTime
        {
            set
            {
                p_currenttime = value;
            }
            get
            {
                return p_currenttime;
            }
        }

        /// <summary>
        /// DealTime
        /// </summary>
        public DateTime? DealTime
        {
            set
            {
                p_dealtime = value;
            }
            get
            {
                return p_dealtime;
            }
        }

        #endregion
    }
}

