/*
 * 版本： 4.0
 * 日期：2020/1/6 10:43:44
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Platform
{
    /// <summary>
    /// 实体类 DomainName  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class DomainName
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "DomainName";

        #endregion 

        #region 私有变量

        private int p_id;
        private string p_urlname;
        private string p_url;
        private int p_agentid;
        private int p_number;
        private byte p_type;
        private byte p_state;
        private int p_mode;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化DomainName
        /// </summary>
        public DomainName() 
        {
            p_id = 0;
            p_urlname = string.Empty;
            p_url = string.Empty;
            p_agentid = 0;
            p_number = 0;
            p_type = 0;
            p_state = 0;
            p_mode = 0;
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
        /// UrlName
        /// </summary>
        public string UrlName
        {
            set
            {
                p_urlname=value;
            }
            get
            {
                return p_urlname;
            }
        }

        /// <summary>
        /// Url
        /// </summary>
        public string Url
        {
            set
            {
                p_url=value;
            }
            get
            {
                return p_url;
            }
        }

        /// <summary>
        /// AgentId
        /// </summary>
        public int AgentId
        {
            set
            {
                p_agentid=value;
            }
            get
            {
                return p_agentid;
            }
        }

        /// <summary>
        /// Number
        /// </summary>
        public int Number
        {
            set
            {
                p_number=value;
            }
            get
            {
                return p_number;
            }
        }

        /// <summary>
        /// Type
        /// </summary>
        public byte Type
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
        /// State
        /// </summary>
        public byte State
        {
            set
            {
                p_state=value;
            }
            get
            {
                return p_state;
            }
        }

        /// <summary>
        /// Mode
        /// </summary>
        public int Mode
        {
            set
            {
                p_mode=value;
            }
            get
            {
                return p_mode;
            }
        }

        #endregion
    }
}

