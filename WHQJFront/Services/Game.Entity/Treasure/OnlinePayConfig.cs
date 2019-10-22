/*
 * 版本： 4.0
 * 日期：2019/10/18 14:38:01
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 OnlinePayConfig  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class OnlinePayConfig
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "OnlinePayConfig";

        #endregion 

        #region 私有变量

        private int p_id;
        private byte p_paytype;
        private string p_payname;
        private string p_uid;
        private string p_md5key;
        private string p_privatekey;
        private string p_publickey;
        private string p_shoutcut;
        private byte p_payidentity;
        private int p_sortid;
        private int p_fristpresent;
        private int p_presentscore;
        private int p_chanelid;
        private string p_chanelname;
        private string p_attachstr;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化OnlinePayConfig
        /// </summary>
        public OnlinePayConfig()
        {
            p_id = 0;
            p_paytype = 0;
            p_payname = string.Empty;
            p_uid = string.Empty;
            p_md5key = string.Empty;
            p_privatekey = string.Empty;
            p_publickey = string.Empty;
            p_shoutcut = string.Empty;
            p_payidentity = 0;
            p_sortid = 0;
            p_fristpresent = 0;
            p_presentscore = 0;
            p_chanelid = 0;
            p_chanelname = string.Empty;
            p_attachstr = string.Empty;
        }

        #endregion

        #region 公共属性 

        /// <summary>
        /// ID
        /// </summary>
        public int ID
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
        /// PayName
        /// </summary>
        public string PayName
        {
            set
            {
                p_payname = value;
            }
            get
            {
                return p_payname;
            }
        }

        /// <summary>
        /// UID
        /// </summary>
        public string UID
        {
            set
            {
                p_uid = value;
            }
            get
            {
                return p_uid;
            }
        }

        /// <summary>
        /// Md5key
        /// </summary>
        public string Md5key
        {
            set
            {
                p_md5key = value;
            }
            get
            {
                return p_md5key;
            }
        }

        /// <summary>
        /// PrivateKey
        /// </summary>
        public string PrivateKey
        {
            set
            {
                p_privatekey = value;
            }
            get
            {
                return p_privatekey;
            }
        }

        /// <summary>
        /// PublicKey
        /// </summary>
        public string PublicKey
        {
            set
            {
                p_publickey = value;
            }
            get
            {
                return p_publickey;
            }
        }

        /// <summary>
        /// ShoutCut
        /// </summary>
        public string ShoutCut
        {
            set
            {
                p_shoutcut = value;
            }
            get
            {
                return p_shoutcut;
            }
        }

        /// <summary>
        /// PayIdentity
        /// </summary>
        public byte PayIdentity
        {
            set
            {
                p_payidentity = value;
            }
            get
            {
                return p_payidentity;
            }
        }

        /// <summary>
        /// SortID
        /// </summary>
        public int SortID
        {
            set
            {
                p_sortid = value;
            }
            get
            {
                return p_sortid;
            }
        }

        /// <summary>
        /// FristPresent
        /// </summary>
        public int FristPresent
        {
            set
            {
                p_fristpresent = value;
            }
            get
            {
                return p_fristpresent;
            }
        }

        /// <summary>
        /// PresentScore
        /// </summary>
        public int PresentScore
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
        /// ChanelID
        /// </summary>
        public int ChanelID
        {
            set
            {
                p_chanelid = value;
            }
            get
            {
                return p_chanelid;
            }
        }

        /// <summary>
        /// ChanelName
        /// </summary>
        public string ChanelName
        {
            set
            {
                p_chanelname = value;
            }
            get
            {
                return p_chanelname;
            }
        }

        /// <summary>
        /// AttaChStr
        /// </summary>
        public string AttaChStr
        {
            set
            {
                p_attachstr = value;
            }
            get
            {
                return p_attachstr;
            }
        }

        #endregion
    }
}

