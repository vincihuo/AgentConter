/*
 * 版本： 4.0
 * 日期：2019/12/20 10:14:27
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Platform
{
    /// <summary>
    /// 实体类 TurntableConfig  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class TurntableConfig
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "TurntableConfig";

        #endregion 

        #region 私有变量

        private int p_id;
        private string p_turnname;
        private Int64 p_money1;
        private Int64 p_money2;
        private Int64 p_money3;
        private Int64 p_money4;
        private Int64 p_money5;
        private Int64 p_money6;
        private Int64 p_money7;
        private Int64 p_money8;
        private Int64 p_money9;
        private Int64 p_money10;
        private Int64 p_money11;
        private Int64 p_money12;
        private Int64 p_money13;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化TurntableConfig
        /// </summary>
        public TurntableConfig() 
        {
            p_id = 0;
            p_turnname = string.Empty;
            p_money1 = 0;
            p_money2 = 0;
            p_money3 = 0;
            p_money4 = 0;
            p_money5 = 0;
            p_money6 = 0;
            p_money7 = 0;
            p_money8 = 0;
            p_money9 = 0;
            p_money10 = 0;
            p_money11 = 0;
            p_money12 = 0;
            p_money13 = 0;
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
        /// TurnName
        /// </summary>
        public string TurnName
        {
            set
            {
                p_turnname=value;
            }
            get
            {
                return p_turnname;
            }
        }

        /// <summary>
        /// Money1
        /// </summary>
        public Int64 Money1
        {
            set
            {
                p_money1=value;
            }
            get
            {
                return p_money1;
            }
        }

        /// <summary>
        /// Money2
        /// </summary>
        public Int64 Money2
        {
            set
            {
                p_money2=value;
            }
            get
            {
                return p_money2;
            }
        }

        /// <summary>
        /// Money3
        /// </summary>
        public Int64 Money3
        {
            set
            {
                p_money3=value;
            }
            get
            {
                return p_money3;
            }
        }

        /// <summary>
        /// Money4
        /// </summary>
        public Int64 Money4
        {
            set
            {
                p_money4=value;
            }
            get
            {
                return p_money4;
            }
        }

        /// <summary>
        /// Money5
        /// </summary>
        public Int64 Money5
        {
            set
            {
                p_money5=value;
            }
            get
            {
                return p_money5;
            }
        }

        /// <summary>
        /// Money6
        /// </summary>
        public Int64 Money6
        {
            set
            {
                p_money6=value;
            }
            get
            {
                return p_money6;
            }
        }

        /// <summary>
        /// Money7
        /// </summary>
        public Int64 Money7
        {
            set
            {
                p_money7=value;
            }
            get
            {
                return p_money7;
            }
        }

        /// <summary>
        /// Money8
        /// </summary>
        public Int64 Money8
        {
            set
            {
                p_money8=value;
            }
            get
            {
                return p_money8;
            }
        }

        /// <summary>
        /// Money9
        /// </summary>
        public Int64 Money9
        {
            set
            {
                p_money9=value;
            }
            get
            {
                return p_money9;
            }
        }

        /// <summary>
        /// Money10
        /// </summary>
        public Int64 Money10
        {
            set
            {
                p_money10=value;
            }
            get
            {
                return p_money10;
            }
        }

        /// <summary>
        /// Money11
        /// </summary>
        public Int64 Money11
        {
            set
            {
                p_money11=value;
            }
            get
            {
                return p_money11;
            }
        }

        /// <summary>
        /// Money12
        /// </summary>
        public Int64 Money12
        {
            set
            {
                p_money12=value;
            }
            get
            {
                return p_money12;
            }
        }

        /// <summary>
        /// Money13
        /// </summary>
        public Int64 Money13
        {
            set
            {
                p_money13=value;
            }
            get
            {
                return p_money13;
            }
        }

        #endregion
    }
}

