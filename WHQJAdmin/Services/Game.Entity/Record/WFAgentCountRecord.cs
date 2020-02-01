/*
 * 版本： 4.0
 * 日期：2020/1/31 19:21:01
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Record
{
    /// <summary>
    /// 实体类 WFAgentCountRecord  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class WFAgentCountRecord
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "WFAgentCountRecord";

        #endregion 

        #region 私有变量

        private int p_id;
        private int p_userid;
        private int p_parentid;
        private Int64 p_valibet;
        private Int64 p_beforereward;
        private int p_beggarnumber;
        private int p_subnumber;
        private Int64 p_currreward;
        private Int64 p_teamperformance;
        private Int64 p_subperformance;
        private string p_counttime;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化WFAgentCountRecord
        /// </summary>
        public WFAgentCountRecord() 
        {
            p_id = 0;
            p_userid = 0;
            p_parentid = 0;
            p_valibet = 0;
            p_beforereward = 0;
            p_beggarnumber = 0;
            p_subnumber = 0;
            p_currreward = 0;
            p_teamperformance = 0;
            p_subperformance = 0;
            p_counttime = string.Empty;
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
        /// Valibet
        /// </summary>
        public Int64 Valibet
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
        /// BeforeReward
        /// </summary>
        public Int64 BeforeReward
        {
            set
            {
                p_beforereward=value;
            }
            get
            {
                return p_beforereward;
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
        /// CurrReward
        /// </summary>
        public Int64 CurrReward
        {
            set
            {
                p_currreward=value;
            }
            get
            {
                return p_currreward;
            }
        }

        /// <summary>
        /// TeamPerformance
        /// </summary>
        public Int64 TeamPerformance
        {
            set
            {
                p_teamperformance=value;
            }
            get
            {
                return p_teamperformance;
            }
        }

        /// <summary>
        /// SubPerformance
        /// </summary>
        public Int64 SubPerformance
        {
            set
            {
                p_subperformance=value;
            }
            get
            {
                return p_subperformance;
            }
        }

        /// <summary>
        /// CountTime
        /// </summary>
        public string CountTime
        {
            set
            {
                p_counttime=value;
            }
            get
            {
                return p_counttime;
            }
        }

        #endregion
    }
}

