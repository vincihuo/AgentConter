/*
 * 版本： 4.0
 * 日期：2019/10/25 10:27:07
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 signtype  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class signtype
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "signtype";

        #endregion 

        #region 私有变量

        private int p_id;
        private string p_keyname;
        private string p_signarray;
        private byte p_splicetype;
        private string p_joiner1;
        private string p_joiner2;
        private byte p_type;
        private byte p_updown;
        private string p_mappos;
        private string p_cyphertext;
        private byte p_cyptype;
        private string p_name;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化signtype
        /// </summary>
        public signtype() 
        {
            p_id = 0;
            p_keyname = string.Empty;
            p_signarray = string.Empty;
            p_splicetype = 0;
            p_joiner1 = string.Empty;
            p_joiner2 = string.Empty;
            p_type = 0;
            p_updown = 0;
            p_mappos = string.Empty;
            p_cyphertext = string.Empty;
            p_cyptype = 0;
            p_name = string.Empty;
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
        /// keyName
        /// </summary>
        public string keyName
        {
            set
            {
                p_keyname=value;
            }
            get
            {
                return p_keyname;
            }
        }

        /// <summary>
        /// signArray
        /// </summary>
        public string signArray
        {
            set
            {
                p_signarray=value;
            }
            get
            {
                return p_signarray;
            }
        }

        /// <summary>
        /// splicetype
        /// </summary>
        public byte splicetype
        {
            set
            {
                p_splicetype=value;
            }
            get
            {
                return p_splicetype;
            }
        }

        /// <summary>
        /// joiner1
        /// </summary>
        public string joiner1
        {
            set
            {
                p_joiner1=value;
            }
            get
            {
                return p_joiner1;
            }
        }

        /// <summary>
        /// joiner2
        /// </summary>
        public string joiner2
        {
            set
            {
                p_joiner2=value;
            }
            get
            {
                return p_joiner2;
            }
        }

        /// <summary>
        /// type
        /// </summary>
        public byte type
        {
            set
            {
                p_type=value;
            }
            get
            {
                return p_type;
            }
        }

        /// <summary>
        /// updown
        /// </summary>
        public byte updown
        {
            set
            {
                p_updown=value;
            }
            get
            {
                return p_updown;
            }
        }

        /// <summary>
        /// mapPos
        /// </summary>
        public string mapPos
        {
            set
            {
                p_mappos=value;
            }
            get
            {
                return p_mappos;
            }
        }

        /// <summary>
        /// cyphertext
        /// </summary>
        public string cyphertext
        {
            set
            {
                p_cyphertext=value;
            }
            get
            {
                return p_cyphertext;
            }
        }

        /// <summary>
        /// cypType
        /// </summary>
        public byte cypType
        {
            set
            {
                p_cyptype=value;
            }
            get
            {
                return p_cyptype;
            }
        }

        /// <summary>
        /// name
        /// </summary>
        public string name
        {
            set
            {
                p_name=value;
            }
            get
            {
                return p_name;
            }
        }

        #endregion
    }
}

