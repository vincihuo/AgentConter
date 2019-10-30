/*
 * 版本： 4.0
 * 日期：2019/10/28 20:00:04
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 OfficalPayOrder  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class OfficalPayOrder
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "OfficalPayOrder";

        #endregion 

        #region 私有变量

        private string p_orderid;
        private int p_gameid;
        private int p_userid;
        private string p_nickname;
        private int p_amount;
        private int p_presentscore;
        private byte p_paytype;
        private string p_payee;
        private byte p_orderstates;
        private int p_masterid;
        private string p_payaccount;
        private string p_payname;
        private string p_paybankname;
        private byte p_transfertype;
        private DateTime p_paytime;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化OfficalPayOrder
        /// </summary>
        public OfficalPayOrder() 
        {
            p_orderid = string.Empty;
            p_gameid = 0;
            p_userid = 0;
            p_nickname = string.Empty;
            p_amount = 0;
            p_presentscore = 0;
            p_paytype = 0;
            p_payee = string.Empty;
            p_orderstates = 0;
            p_masterid = 0;
            p_payaccount = string.Empty;
            p_payname = string.Empty;
            p_paybankname = string.Empty;
            p_transfertype = 0;
            p_paytime = DateTime.Now;
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
                p_orderid=value;
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
                p_gameid=value;
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
                p_userid=value;
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
                p_nickname=value;
            }
            get
            {
                return p_nickname;
            }
        }

        /// <summary>
        /// Amount
        /// </summary>
        public int Amount
        {
            set
            {
                p_amount=value;
            }
            get
            {
                return p_amount;
            }
        }

        /// <summary>
        /// PresentScore
        /// </summary>
        public int PresentScore
        {
            set
            {
                p_presentscore=value;
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
                p_paytype=value;
            }
            get
            {
                return p_paytype;
            }
        }

        /// <summary>
        /// Payee
        /// </summary>
        public string Payee
        {
            set
            {
                p_payee=value;
            }
            get
            {
                return p_payee;
            }
        }

        /// <summary>
        /// OrderStates
        /// </summary>
        public byte OrderStates
        {
            set
            {
                p_orderstates=value;
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
                p_masterid=value;
            }
            get
            {
                return p_masterid;
            }
        }

        /// <summary>
        /// PayAccount
        /// </summary>
        public string PayAccount
        {
            set
            {
                p_payaccount=value;
            }
            get
            {
                return p_payaccount;
            }
        }

        /// <summary>
        /// PayName
        /// </summary>
        public string PayName
        {
            set
            {
                p_payname=value;
            }
            get
            {
                return p_payname;
            }
        }

        /// <summary>
        /// PayBankName
        /// </summary>
        public string PayBankName
        {
            set
            {
                p_paybankname=value;
            }
            get
            {
                return p_paybankname;
            }
        }

        /// <summary>
        /// TransferType
        /// </summary>
        public byte TransferType
        {
            set
            {
                p_transfertype=value;
            }
            get
            {
                return p_transfertype;
            }
        }

        /// <summary>
        /// PayTime
        /// </summary>
        public DateTime PayTime
        {
            set
            {
                p_paytime=value;
            }
            get
            {
                return p_paytime;
            }
        }

        #endregion
    }
}

