/*
 * 版本： 4.0
 * 日期：2020/1/3 14:52:03
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
        private decimal p_fresh;
        private decimal p_week;
        private decimal p_month;
        private decimal p_day1;
        private decimal p_day2;
        private decimal p_day3;
        private decimal p_day4;
        private decimal p_day5;
        private decimal p_day6;
        private decimal p_day7;

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
        public decimal Fresh
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
        public decimal Week
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
        public decimal Month
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
        public decimal Day1
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
        public decimal Day2
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
        public decimal Day3
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
        public decimal Day4
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
        public decimal Day5
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
        public decimal Day6
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
        public decimal Day7
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

