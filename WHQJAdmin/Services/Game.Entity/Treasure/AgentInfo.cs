/*
 * 版本： 4.0
 * 日期：2019/11/18 10:50:58
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 AgentInfo  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class AgentInfo
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "AgentInfo";

        #endregion 

        #region 私有变量

        private int p_userid;
        private int p_parentid;
        private Int64 p_reward;
        private Int64 p_allreward;
        private Int64 p_tax;
        private Int64 p_backmoney;
        private int p_beggarnumber;
        private int p_subnumber;
        private Int64 p_yesterdayreward;
        private string p_linkurl;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化AgentInfo
        /// </summary>
        public AgentInfo() 
        {
            p_userid = 0;
            p_parentid = 0;
            p_reward = 0;
            p_allreward = 0;
            p_tax = 0;
            p_backmoney = 0;
            p_beggarnumber = 0;
            p_subnumber = 0;
            p_yesterdayreward = 0;
            p_linkurl = string.Empty;
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
        /// ParentID
        /// </summary>
        public int ParentID
        {
            set
            {
                p_parentid=value;
            }
            get
            {
                return p_parentid;
            }
        }

        /// <summary>
        /// Reward
        /// </summary>
        public Int64 Reward
        {
            set
            {
                p_reward=value;
            }
            get
            {
                return p_reward;
            }
        }

        /// <summary>
        /// AllReward
        /// </summary>
        public Int64 AllReward
        {
            set
            {
                p_allreward=value;
            }
            get
            {
                return p_allreward;
            }
        }

        /// <summary>
        /// Tax
        /// </summary>
        public Int64 Tax
        {
            set
            {
                p_tax=value;
            }
            get
            {
                return p_tax;
            }
        }

        /// <summary>
        /// BackMoney
        /// </summary>
        public Int64 BackMoney
        {
            set
            {
                p_backmoney=value;
            }
            get
            {
                return p_backmoney;
            }
        }

        /// <summary>
        /// BeggarNumber
        /// </summary>
        public int BeggarNumber
        {
            set
            {
                p_beggarnumber=value;
            }
            get
            {
                return p_beggarnumber;
            }
        }

        /// <summary>
        /// SubNumber
        /// </summary>
        public int SubNumber
        {
            set
            {
                p_subnumber=value;
            }
            get
            {
                return p_subnumber;
            }
        }

        /// <summary>
        /// YesterDayReward
        /// </summary>
        public Int64 YesterDayReward
        {
            set
            {
                p_yesterdayreward=value;
            }
            get
            {
                return p_yesterdayreward;
            }
        }

        /// <summary>
        /// LinkUrl
        /// </summary>
        public string LinkUrl
        {
            set
            {
                p_linkurl=value;
            }
            get
            {
                return p_linkurl;
            }
        }

        #endregion
    }
}

