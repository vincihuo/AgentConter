/*
 * 版本： 4.0
 * 日期：2019/12/24 11:12:30
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Platform
{
    /// <summary>
    /// 实体类 VipConfig  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class VipConfig
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "VipConfig";

        #endregion 

        #region 私有变量

        private int p_viplevel;
        private Int64 p_integral;
        private Int64 p_fresh;
        private Int64 p_week;
        private Int64 p_month;
        private Int64 p_day1;
        private Int64 p_day2;
        private Int64 p_day3;
        private Int64 p_day4;
        private Int64 p_day5;
        private Int64 p_day6;
        private Int64 p_day7;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化VipConfig
        /// </summary>
        public VipConfig() 
        {
            p_viplevel = 0;
            p_integral = 0;
            p_fresh = 0;
            p_week = 0;
            p_month = 0;
            p_day1 = 0;
            p_day2 = 0;
            p_day3 = 0;
            p_day4 = 0;
            p_day5 = 0;
            p_day6 = 0;
            p_day7 = 0;
        }

        #endregion

        #region 公共属性 

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
        /// Integral
        /// </summary>
        public Int64 Integral
        {
            set
            {
                p_integral=value;
            }
            get
            {
                return p_integral;
            }
        }

        /// <summary>
        /// Fresh
        /// </summary>
        public Int64 Fresh
        {
            set
            {
                p_fresh=value;
            }
            get
            {
                return p_fresh;
            }
        }

        /// <summary>
        /// Week
        /// </summary>
        public Int64 Week
        {
            set
            {
                p_week=value;
            }
            get
            {
                return p_week;
            }
        }

        /// <summary>
        /// Month
        /// </summary>
        public Int64 Month
        {
            set
            {
                p_month=value;
            }
            get
            {
                return p_month;
            }
        }

        /// <summary>
        /// Day1
        /// </summary>
        public Int64 Day1
        {
            set
            {
                p_day1=value;
            }
            get
            {
                return p_day1;
            }
        }

        /// <summary>
        /// Day2
        /// </summary>
        public Int64 Day2
        {
            set
            {
                p_day2=value;
            }
            get
            {
                return p_day2;
            }
        }

        /// <summary>
        /// Day3
        /// </summary>
        public Int64 Day3
        {
            set
            {
                p_day3=value;
            }
            get
            {
                return p_day3;
            }
        }

        /// <summary>
        /// Day4
        /// </summary>
        public Int64 Day4
        {
            set
            {
                p_day4=value;
            }
            get
            {
                return p_day4;
            }
        }

        /// <summary>
        /// Day5
        /// </summary>
        public Int64 Day5
        {
            set
            {
                p_day5=value;
            }
            get
            {
                return p_day5;
            }
        }

        /// <summary>
        /// Day6
        /// </summary>
        public Int64 Day6
        {
            set
            {
                p_day6=value;
            }
            get
            {
                return p_day6;
            }
        }

        /// <summary>
        /// Day7
        /// </summary>
        public Int64 Day7
        {
            set
            {
                p_day7=value;
            }
            get
            {
                return p_day7;
            }
        }

        #endregion
    }
}

