/*
 * 版本： 4.0
 * 日期：2019/11/29 19:27:23
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
        private string p_payurl;
        private string p_md5key;
        private string p_privatekey;
        private string p_publickey;
        private string p_shoutcut;
        private Int64 p_maxamount;
        private Int64 p_minamount;
        private byte p_payidentity;
        private int p_sortid;
        private Int64 p_fristpresent;
        private Int64 p_presentscore;
        private int p_chanelid;
        private string p_chanelname;
        private string p_attachstr1;
        private string p_attachstr2;
        private string p_attachstr3;
        private string p_attachstr4;

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
            p_payurl = string.Empty;
            p_md5key = string.Empty;
            p_privatekey = string.Empty;
            p_publickey = string.Empty;
            p_shoutcut = string.Empty;
            p_maxamount = 0;
            p_minamount = 0;
            p_payidentity = 0;
            p_sortid = 0;
            p_fristpresent = 0;
            p_presentscore = 0;
            p_chanelid = 0;
            p_chanelname = string.Empty;
            p_attachstr1 = string.Empty;
            p_attachstr2 = string.Empty;
            p_attachstr3 = string.Empty;
            p_attachstr4 = string.Empty;
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
                p_id=value;
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
                p_paytype=value;
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
                p_payname=value;
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
                p_uid=value;
            }
            get
            {
                return p_uid;
            }
        }

        /// <summary>
        /// PayUrl
        /// </summary>
        public string PayUrl
        {
            set
            {
                p_payurl=value;
            }
            get
            {
                return p_payurl;
            }
        }

        /// <summary>
        /// Md5key
        /// </summary>
        public string Md5key
        {
            set
            {
                p_md5key=value;
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
                p_privatekey=value;
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
                p_publickey=value;
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
                p_shoutcut=value;
            }
            get
            {
                return p_shoutcut;
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
        /// PayIdentity
        /// </summary>
        public byte PayIdentity
        {
            set
            {
                p_payidentity=value;
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
                p_sortid=value;
            }
            get
            {
                return p_sortid;
            }
        }

        /// <summary>
        /// FristPresent
        /// </summary>
        public Int64 FristPresent
        {
            set
            {
                p_fristpresent=value;
            }
            get
            {
                return p_fristpresent;
            }
        }

        /// <summary>
        /// PresentScore
        /// </summary>
        public Int64 PresentScore
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
        /// ChanelID
        /// </summary>
        public int ChanelID
        {
            set
            {
                p_chanelid=value;
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
                p_chanelname=value;
            }
            get
            {
                return p_chanelname;
            }
        }

        /// <summary>
        /// AttachStr1
        /// </summary>
        public string AttachStr1
        {
            set
            {
                p_attachstr1=value;
            }
            get
            {
                return p_attachstr1;
            }
        }

        /// <summary>
        /// AttachStr2
        /// </summary>
        public string AttachStr2
        {
            set
            {
                p_attachstr2=value;
            }
            get
            {
                return p_attachstr2;
            }
        }

        /// <summary>
        /// AttachStr3
        /// </summary>
        public string AttachStr3
        {
            set
            {
                p_attachstr3=value;
            }
            get
            {
                return p_attachstr3;
            }
        }

        /// <summary>
        /// AttachStr4
        /// </summary>
        public string AttachStr4
        {
            set
            {
                p_attachstr4=value;
            }
            get
            {
                return p_attachstr4;
            }
        }

        #endregion
    }
}

