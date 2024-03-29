/*
 * 版本： 4.0
 * 日期：2019/11/8 18:54:51
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Record
{
    /// <summary>
    /// 实体类 RecordAgentReward  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class RecordAgentReward
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "RecordAgentReward";

        #endregion 

        #region 私有变量

        private int p_userid;
        private Int64 p_getmoney;
        private Int64 p_beforemoney;
        private DateTime p_drawaltime;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化RecordAgentReward
        /// </summary>
        public RecordAgentReward() 
        {
            p_userid = 0;
            p_getmoney = 0;
            p_beforemoney = 0;
            p_drawaltime = DateTime.Now;
        }

        #endregion

        #region 公共属性 

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
        /// GetMoney
        /// </summary>
        public Int64 GetMoney
        {
            set
            {
                p_getmoney=value;
            }
            get
            {
                return p_getmoney;
            }
        }

        /// <summary>
        /// BeforeMoney
        /// </summary>
        public Int64 BeforeMoney
        {
            set
            {
                p_beforemoney=value;
            }
            get
            {
                return p_beforemoney;
            }
        }

        /// <summary>
        /// drawalTime
        /// </summary>
        public DateTime drawalTime
        {
            set
            {
                p_drawaltime=value;
            }
            get
            {
                return p_drawaltime;
            }
        }

        #endregion
    }
}

