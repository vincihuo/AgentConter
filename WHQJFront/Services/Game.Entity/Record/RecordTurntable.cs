/*
 * 版本： 4.0
 * 日期：2019/12/23 16:26:35
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Record
{
    /// <summary>
    /// 实体类 RecordTurntable  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class RecordTurntable
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "RecordTurntable";

        #endregion 

        #region 私有变量

        private int p_id;
        private int p_userid;
        private string p_turntablename;
        private Int64 p_reward;
        private Int64 p_score;
        private int p_openpos;
        private int p_tableindex;
        private DateTime p_opentime;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化RecordTurntable
        /// </summary>
        public RecordTurntable() 
        {
            p_id = 0;
            p_userid = 0;
            p_turntablename = string.Empty;
            p_reward = 0;
            p_score = 0;
            p_openpos = 0;
            p_tableindex = 0;
            p_opentime = DateTime.Now;
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
        /// UserId
        /// </summary>
        public int UserId
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
        /// TurntableName
        /// </summary>
        public string TurntableName
        {
            set
            {
                p_turntablename=value;
            }
            get
            {
                return p_turntablename;
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
        /// OpenPos
        /// </summary>
        public int OpenPos
        {
            set
            {
                p_openpos=value;
            }
            get
            {
                return p_openpos;
            }
        }

        /// <summary>
        /// TableIndex
        /// </summary>
        public int TableIndex
        {
            set
            {
                p_tableindex=value;
            }
            get
            {
                return p_tableindex;
            }
        }

        /// <summary>
        /// Opentime
        /// </summary>
        public DateTime Opentime
        {
            set
            {
                p_opentime=value;
            }
            get
            {
                return p_opentime;
            }
        }

        #endregion
    }
}

