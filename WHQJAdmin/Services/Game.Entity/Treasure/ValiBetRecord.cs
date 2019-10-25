/*
 * 版本： 4.0
 * 日期：2019/10/24 13:44:48
 * 
 * 描述：实体类
 * 
 */

using System;
using System.Collections.Generic;

namespace Game.Entity.Treasure
{
    /// <summary>
    /// 实体类 ValiBetRecord  (属性说明自动提取数据库字段的描述信息)
    /// </summary>
    [Serializable]
    public partial class ValiBetRecord
    {
        #region 常量 

        /// <summary>
        /// 表名
        /// </summary>
        public const string Tablename = "ValiBetRecord";

        #endregion 

        #region 私有变量

        private int p_id;
        private byte p_deposittype;
        private int p_userid;
        private int p_depositid;
        private string p_depositname;
        private Int64 p_currentvalidbet;
        private Int64 p_lastvalibet;
        private Int64 p_totalvalibet;

        #endregion

        #region 构造函数 

        /// <summary>
        /// 初始化ValiBetRecord
        /// </summary>
        public ValiBetRecord() 
        {
            p_id = 0;
            p_deposittype = 0;
            p_userid = 0;
            p_depositid = 0;
            p_depositname = string.Empty;
            p_currentvalidbet = 0;
            p_lastvalibet = 0;
            p_totalvalibet = 0;
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
        /// DepositType
        /// </summary>
        public byte DepositType
        {
            set
            {
                p_deposittype=value;
            }
            get
            {
                return p_deposittype;
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
        /// DepositID
        /// </summary>
        public int DepositID
        {
            set
            {
                p_depositid=value;
            }
            get
            {
                return p_depositid;
            }
        }

        /// <summary>
        /// DepositName
        /// </summary>
        public string DepositName
        {
            set
            {
                p_depositname=value;
            }
            get
            {
                return p_depositname;
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
        /// LastValiBet
        /// </summary>
        public Int64 LastValiBet
        {
            set
            {
                p_lastvalibet=value;
            }
            get
            {
                return p_lastvalibet;
            }
        }

        /// <summary>
        /// TotalValiBet
        /// </summary>
        public Int64 TotalValiBet
        {
            set
            {
                p_totalvalibet=value;
            }
            get
            {
                return p_totalvalibet;
            }
        }

        #endregion
    }
}

