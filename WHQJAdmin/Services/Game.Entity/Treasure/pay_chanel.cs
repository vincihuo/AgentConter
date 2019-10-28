/*
 * 版本： 4.0
 * 日期：2019/10/26 14:34:44
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 pay_chanel  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class pay_chanel
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "pay_chanel";

        #endregion 

        #region 私有变量

        private int p_id;
        private string p_sendpamar;
        private byte p_moneypre;
        private string p_singpos;
        private byte p_method;
        private string p_respsign;
        private string p_respcode;
        private string p_successcode;
        private string p_infoname;
        private byte p_infotype;
        private string p_orderkey;
        private string p_signkey;
        private string p_moneykey;
        private string p_codekey;
        private string p_codesuccess;
        private string p_backstring;
        private int p_sendsign;
        private int p_backsign;
        private int p_callsign;
        private string p_name;
        private byte p_banktype;
        private string p_bankmappn;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化pay_chanel
        /// </summary>
        public pay_chanel()
        {
            p_id = 0;
            p_sendpamar = string.Empty;
            p_moneypre = 0;
            p_singpos = string.Empty;
            p_method = 0;
            p_respsign = string.Empty;
            p_respcode = string.Empty;
            p_successcode = string.Empty;
            p_infoname = string.Empty;
            p_infotype = 0;
            p_orderkey = string.Empty;
            p_signkey = string.Empty;
            p_moneykey = string.Empty;
            p_codekey = string.Empty;
            p_codesuccess = string.Empty;
            p_backstring = string.Empty;
            p_sendsign = 0;
            p_backsign = 0;
            p_callsign = 0;
            p_name = string.Empty;
            p_banktype = 0;
            p_bankmappn = string.Empty;
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
                p_id = value;
            }
            get
            {
                return p_id;
            }
        }

        /// <summary>
        /// sendpamar
        /// </summary>
        public string sendpamar
        {
            set
            {
                p_sendpamar = value;
            }
            get
            {
                return p_sendpamar;
            }
        }

        /// <summary>
        /// moneyPre
        /// </summary>
        public byte moneyPre
        {
            set
            {
                p_moneypre = value;
            }
            get
            {
                return p_moneypre;
            }
        }

        /// <summary>
        /// singpos
        /// </summary>
        public string singpos
        {
            set
            {
                p_singpos = value;
            }
            get
            {
                return p_singpos;
            }
        }

        /// <summary>
        /// method
        /// </summary>
        public byte method
        {
            set
            {
                p_method = value;
            }
            get
            {
                return p_method;
            }
        }

        /// <summary>
        /// respSign
        /// </summary>
        public string respSign
        {
            set
            {
                p_respsign = value;
            }
            get
            {
                return p_respsign;
            }
        }

        /// <summary>
        /// respCode
        /// </summary>
        public string respCode
        {
            set
            {
                p_respcode = value;
            }
            get
            {
                return p_respcode;
            }
        }

        /// <summary>
        /// successCode
        /// </summary>
        public string successCode
        {
            set
            {
                p_successcode = value;
            }
            get
            {
                return p_successcode;
            }
        }

        /// <summary>
        /// infoName
        /// </summary>
        public string infoName
        {
            set
            {
                p_infoname = value;
            }
            get
            {
                return p_infoname;
            }
        }

        /// <summary>
        /// infoType
        /// </summary>
        public byte infoType
        {
            set
            {
                p_infotype = value;
            }
            get
            {
                return p_infotype;
            }
        }

        /// <summary>
        /// orderkey
        /// </summary>
        public string orderkey
        {
            set
            {
                p_orderkey = value;
            }
            get
            {
                return p_orderkey;
            }
        }

        /// <summary>
        /// signkey
        /// </summary>
        public string signkey
        {
            set
            {
                p_signkey = value;
            }
            get
            {
                return p_signkey;
            }
        }

        /// <summary>
        /// moneykey
        /// </summary>
        public string moneykey
        {
            set
            {
                p_moneykey = value;
            }
            get
            {
                return p_moneykey;
            }
        }

        /// <summary>
        /// codekey
        /// </summary>
        public string codekey
        {
            set
            {
                p_codekey = value;
            }
            get
            {
                return p_codekey;
            }
        }

        /// <summary>
        /// codeSuccess
        /// </summary>
        public string codeSuccess
        {
            set
            {
                p_codesuccess = value;
            }
            get
            {
                return p_codesuccess;
            }
        }

        /// <summary>
        /// backstring
        /// </summary>
        public string backstring
        {
            set
            {
                p_backstring = value;
            }
            get
            {
                return p_backstring;
            }
        }

        /// <summary>
        /// sendSign
        /// </summary>
        public int sendSign
        {
            set
            {
                p_sendsign = value;
            }
            get
            {
                return p_sendsign;
            }
        }

        /// <summary>
        /// backSign
        /// </summary>
        public int backSign
        {
            set
            {
                p_backsign = value;
            }
            get
            {
                return p_backsign;
            }
        }

        /// <summary>
        /// callSign
        /// </summary>
        public int callSign
        {
            set
            {
                p_callsign = value;
            }
            get
            {
                return p_callsign;
            }
        }

        /// <summary>
        /// name
        /// </summary>
        public string name
        {
            set
            {
                p_name = value;
            }
            get
            {
                return p_name;
            }
        }

        /// <summary>
        /// bankType
        /// </summary>
        public byte bankType
        {
            set
            {
                p_banktype = value;
            }
            get
            {
                return p_banktype;
            }
        }

        /// <summary>
        /// bankMappn
        /// </summary>
        public string bankMappn
        {
            set
            {
                p_bankmappn = value;
            }
            get
            {
                return p_bankmappn;
            }
        }

        #endregion
    }
}

