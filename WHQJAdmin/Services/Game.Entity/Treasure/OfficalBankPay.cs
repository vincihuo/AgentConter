/*
 * 版本： 4.0
 * 日期：2019/12/4 20:05:17
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 OfficalBankPay  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class OfficalBankPay
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "OfficalBankPay";

        #endregion 

        #region 私有变量

        private int p_id;
        private string p_merchantname;
        private string p_bankname;
        private string p_banknumber;
        private string p_bankaddr;
        private Int64 p_minamount;
        private Int64 p_maxamount;
        private string p_configname;
        private int p_sortid;
        private string p_description;
        private byte p_nullity;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化OfficalBankPay
        /// </summary>
        public OfficalBankPay() 
        {
            p_id = 0;
            p_merchantname = string.Empty;
            p_bankname = string.Empty;
            p_banknumber = string.Empty;
            p_bankaddr = string.Empty;
            p_minamount = 0;
            p_maxamount = 0;
            p_configname = string.Empty;
            p_sortid = 0;
            p_description = string.Empty;
            p_nullity = 0;
        }

        #endregion

        #region 公共属性 

        /// <summary>
        /// id
        /// </summary>
        public int id
        {
            set
            {
                p_id=value;
            }
            get
            {
                return p_id;
            }
        }

        /// <summary>
        /// MerchantName
        /// </summary>
        public string MerchantName
        {
            set
            {
                p_merchantname=value;
            }
            get
            {
                return p_merchantname;
            }
        }

        /// <summary>
        /// BankName
        /// </summary>
        public string BankName
        {
            set
            {
                p_bankname=value;
            }
            get
            {
                return p_bankname;
            }
        }

        /// <summary>
        /// BankNumber
        /// </summary>
        public string BankNumber
        {
            set
            {
                p_banknumber=value;
            }
            get
            {
                return p_banknumber;
            }
        }

        /// <summary>
        /// BankAddr
        /// </summary>
        public string BankAddr
        {
            set
            {
                p_bankaddr=value;
            }
            get
            {
                return p_bankaddr;
            }
        }

        /// <summary>
        /// MinAmount
        /// </summary>
        public Int64 MinAmount
        {
            set
            {
                p_minamount=value;
            }
            get
            {
                return p_minamount;
            }
        }

        /// <summary>
        /// MaxAmount
        /// </summary>
        public Int64 MaxAmount
        {
            set
            {
                p_maxamount=value;
            }
            get
            {
                return p_maxamount;
            }
        }

        /// <summary>
        /// ConfigName
        /// </summary>
        public string ConfigName
        {
            set
            {
                p_configname=value;
            }
            get
            {
                return p_configname;
            }
        }

        /// <summary>
        /// SortId
        /// </summary>
        public int SortId
        {
            set
            {
                p_sortid=value;
            }
            get
            {
                return p_sortid;
            }
        }

        /// <summary>
        /// Description
        /// </summary>
        public string Description
        {
            set
            {
                p_description=value;
            }
            get
            {
                return p_description;
            }
        }

        /// <summary>
        /// Nullity
        /// </summary>
        public byte Nullity
        {
            set
            {
                p_nullity=value;
            }
            get
            {
                return p_nullity;
            }
        }

        #endregion
    }
}

