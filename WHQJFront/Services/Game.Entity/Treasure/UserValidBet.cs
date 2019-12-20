/*
 * 版本： 4.0
 * 日期：2019/12/20 12:33:55
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 UserValidBet  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class UserValidBet
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "UserValidBet";

        #endregion 

        #region 私有变量

        private int p_userid;
        private Int64 p_currentvalidbet;
        private Int64 p_targetbet;
        private Int64 p_spillbet;
        private Int64 p_todayvalibet;
        private Int64 p_grandscore;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化UserValidBet
        /// </summary>
        public UserValidBet() 
        {
            p_userid = 0;
            p_currentvalidbet = 0;
            p_targetbet = 0;
            p_spillbet = 0;
            p_todayvalibet = 0;
            p_grandscore = 0;
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
        /// CurrentValidBet
        /// </summary>
        public Int64 CurrentValidBet
        {
            set
            {
                p_currentvalidbet=value;
            }
            get
            {
                return p_currentvalidbet;
            }
        }

        /// <summary>
        /// TargetBet
        /// </summary>
        public Int64 TargetBet
        {
            set
            {
                p_targetbet=value;
            }
            get
            {
                return p_targetbet;
            }
        }

        /// <summary>
        /// SpillBet
        /// </summary>
        public Int64 SpillBet
        {
            set
            {
                p_spillbet=value;
            }
            get
            {
                return p_spillbet;
            }
        }

        /// <summary>
        /// TodayValiBet
        /// </summary>
        public Int64 TodayValiBet
        {
            set
            {
                p_todayvalibet=value;
            }
            get
            {
                return p_todayvalibet;
            }
        }

        /// <summary>
        /// GrandScore
        /// </summary>
        public Int64 GrandScore
        {
            set
            {
                p_grandscore=value;
            }
            get
            {
                return p_grandscore;
            }
        }

        #endregion
    }
}

