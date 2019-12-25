/*
 * 版本： 4.0
 * 日期：2019/12/24 11:10:53
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 UserVipInfo  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class UserVipInfo
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "UserVipInfo";

        #endregion 

        #region 私有变量

        private int p_userid;
        private Int64 p_score;
        private int p_viplevel;
        private Int64 p_freshreward;
        private Int64 p_weekreward;
        private Int64 p_monthreward;
        private Int64 p_checkinreward;
        private string p_lasttime;
        private int p_dayindex;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化UserVipInfo
        /// </summary>
        public UserVipInfo() 
        {
            p_userid = 0;
            p_score = 0;
            p_viplevel = 0;
            p_freshreward = 0;
            p_weekreward = 0;
            p_monthreward = 0;
            p_checkinreward = 0;
            p_lasttime = string.Empty;
            p_dayindex = 0;
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
        /// Score
        /// </summary>
        public Int64 Score
        {
            set
            {
                p_score=value;
            }
            get
            {
                return p_score;
            }
        }

        /// <summary>
        /// VipLevel
        /// </summary>
        public int VipLevel
        {
            set
            {
                p_viplevel=value;
            }
            get
            {
                return p_viplevel;
            }
        }

        /// <summary>
        /// FreshReward
        /// </summary>
        public Int64 FreshReward
        {
            set
            {
                p_freshreward=value;
            }
            get
            {
                return p_freshreward;
            }
        }

        /// <summary>
        /// WeekReward
        /// </summary>
        public Int64 WeekReward
        {
            set
            {
                p_weekreward=value;
            }
            get
            {
                return p_weekreward;
            }
        }

        /// <summary>
        /// MonthReward
        /// </summary>
        public Int64 MonthReward
        {
            set
            {
                p_monthreward=value;
            }
            get
            {
                return p_monthreward;
            }
        }

        /// <summary>
        /// CheckInReward
        /// </summary>
        public Int64 CheckInReward
        {
            set
            {
                p_checkinreward=value;
            }
            get
            {
                return p_checkinreward;
            }
        }

        /// <summary>
        /// LastTime
        /// </summary>
        public string LastTime
        {
            set
            {
                p_lasttime=value;
            }
            get
            {
                return p_lasttime;
            }
        }

        /// <summary>
        /// DayIndex
        /// </summary>
        public int DayIndex
        {
            set
            {
                p_dayindex=value;
            }
            get
            {
                return p_dayindex;
            }
        }

        #endregion
    }
}

