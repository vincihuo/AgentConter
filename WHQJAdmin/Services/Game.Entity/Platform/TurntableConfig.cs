/*
 * 版本： 4.0
 * 日期：2019/12/20 17:41:59
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
        private string p_menuname;
        private Int64 p_menuvaule;
        private Int64 p_value1;
        private Int64 p_value2;
        private Int64 p_value3;
        private Int64 p_value4;
        private Int64 p_value5;
        private Int64 p_value6;
        private Int64 p_value7;
        private Int64 p_value8;
        private Int64 p_value9;
        private Int64 p_value10;
        private Int64 p_value11;
        private Int64 p_value12;
        private Int64 p_value13;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化TurntableConfig
        /// </summary>
        public TurntableConfig() 
        {
            p_id = 0;
            p_menuname = string.Empty;
            p_menuvaule = 0;
            p_value1 = 0;
            p_value2 = 0;
            p_value3 = 0;
            p_value4 = 0;
            p_value5 = 0;
            p_value6 = 0;
            p_value7 = 0;
            p_value8 = 0;
            p_value9 = 0;
            p_value10 = 0;
            p_value11 = 0;
            p_value12 = 0;
            p_value13 = 0;
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
        /// MenuName
        /// </summary>
        public string MenuName
        {
            set
            {
                p_menuname=value;
            }
            get
            {
                return p_menuname;
            }
        }

        /// <summary>
        /// MenuVaule
        /// </summary>
        public Int64 MenuVaule
        {
            set
            {
                p_menuvaule=value;
            }
            get
            {
                return p_menuvaule;
            }
        }

        /// <summary>
        /// Value1
        /// </summary>
        public Int64 Value1
        {
            set
            {
                p_value1=value;
            }
            get
            {
                return p_value1;
            }
        }

        /// <summary>
        /// Value2
        /// </summary>
        public Int64 Value2
        {
            set
            {
                p_value2=value;
            }
            get
            {
                return p_value2;
            }
        }

        /// <summary>
        /// Value3
        /// </summary>
        public Int64 Value3
        {
            set
            {
                p_value3=value;
            }
            get
            {
                return p_value3;
            }
        }

        /// <summary>
        /// Value4
        /// </summary>
        public Int64 Value4
        {
            set
            {
                p_value4=value;
            }
            get
            {
                return p_value4;
            }
        }

        /// <summary>
        /// Value5
        /// </summary>
        public Int64 Value5
        {
            set
            {
                p_value5=value;
            }
            get
            {
                return p_value5;
            }
        }

        /// <summary>
        /// Value6
        /// </summary>
        public Int64 Value6
        {
            set
            {
                p_value6=value;
            }
            get
            {
                return p_value6;
            }
        }

        /// <summary>
        /// Value7
        /// </summary>
        public Int64 Value7
        {
            set
            {
                p_value7=value;
            }
            get
            {
                return p_value7;
            }
        }

        /// <summary>
        /// Value8
        /// </summary>
        public Int64 Value8
        {
            set
            {
                p_value8=value;
            }
            get
            {
                return p_value8;
            }
        }

        /// <summary>
        /// Value9
        /// </summary>
        public Int64 Value9
        {
            set
            {
                p_value9=value;
            }
            get
            {
                return p_value9;
            }
        }

        /// <summary>
        /// Value10
        /// </summary>
        public Int64 Value10
        {
            set
            {
                p_value10=value;
            }
            get
            {
                return p_value10;
            }
        }

        /// <summary>
        /// Value11
        /// </summary>
        public Int64 Value11
        {
            set
            {
                p_value11=value;
            }
            get
            {
                return p_value11;
            }
        }

        /// <summary>
        /// Value12
        /// </summary>
        public Int64 Value12
        {
            set
            {
                p_value12=value;
            }
            get
            {
                return p_value12;
            }
        }

        /// <summary>
        /// Value13
        /// </summary>
        public Int64 Value13
        {
            set
            {
                p_value13=value;
            }
            get
            {
                return p_value13;
            }
        }

        #endregion
    }
}

