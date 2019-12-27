/*
 * 版本： 4.0
 * 日期：2019/12/26 14:28:08
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Platform
{
    /// <summary>
    /// 实体类 UserMail  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class UserMail
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "UserMail";

        #endregion 

        #region 私有变量

        private int p_id;
        private int p_userid;
        private byte p_mstate;
        private string p_title;
        private string p_msg;
        private Int64 p_goldnum;
        private int p_diamnum;
        private int p_valibet;
        private DateTime? p_sendtime;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化UserMail
        /// </summary>
        public UserMail() 
        {
            p_id = 0;
            p_userid = 0;
            p_mstate = 0;
            p_title = string.Empty;
            p_msg = string.Empty;
            p_goldnum = 0;
            p_diamnum = 0;
            p_valibet = 0;
            p_sendtime = null;
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
        /// UserID
        /// </summary>
        public int UserID
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
        /// MState
        /// </summary>
        public byte MState
        {
            set
            {
                p_mstate=value;
            }
            get
            {
                return p_mstate;
            }
        }

        /// <summary>
        /// Title
        /// </summary>
        public string Title
        {
            set
            {
                p_title=value;
            }
            get
            {
                return p_title;
            }
        }

        /// <summary>
        /// Msg
        /// </summary>
        public string Msg
        {
            set
            {
                p_msg=value;
            }
            get
            {
                return p_msg;
            }
        }

        /// <summary>
        /// GoldNum
        /// </summary>
        public Int64 GoldNum
        {
            set
            {
                p_goldnum=value;
            }
            get
            {
                return p_goldnum;
            }
        }

        /// <summary>
        /// DiamNum
        /// </summary>
        public int DiamNum
        {
            set
            {
                p_diamnum=value;
            }
            get
            {
                return p_diamnum;
            }
        }

        /// <summary>
        /// Valibet
        /// </summary>
        public int Valibet
        {
            set
            {
                p_valibet=value;
            }
            get
            {
                return p_valibet;
            }
        }

        /// <summary>
        /// SendTime
        /// </summary>
        public DateTime? SendTime
        {
            set
            {
                p_sendtime=value;
            }
            get
            {
                return p_sendtime;
            }
        }

        #endregion
    }
}

