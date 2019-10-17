using System.Collections;
using System.Collections.Generic;
using System.Data;
using Game.Data.Factory;
using Game.Entity.Accounts;
using Game.Entity.Group;
using Game.IData;
using Game.Kernel;

// ReSharper disable once CheckNamespace
namespace Game.Facade
{
    /// <summary>
    /// 代理外观
    /// </summary>
    public class GroupFacade
    {
        #region Fields

        // ReSharper disable once FieldCanBeMadeReadOnly.Local
        // ReSharper disable once InconsistentNaming
        private IGroupDataProvider groupData;

        #endregion Fields

        #region 构造函数

        /// <summary>
        /// 构造函数
        /// </summary>
        public GroupFacade()
        {
            groupData = ClassFactory.GetIGroupDataProvider();
        }

        #endregion 构造函数

        #region 公用分页
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        /// <param name="tableName">表名</param>
        /// <param name="where">查询条件</param>
        /// <param name="order">排序</param>
        /// <param name="pageIndex">页下标</param>
        /// <param name="pageSize">页显示数</param>
        /// <param name="fields">查询字段</param>
        /// <returns></returns>
        public PagerSet GetList(string tableName, string where, string order, int pageIndex, int pageSize, string[] fields = null)
        {
            return groupData.GetList(tableName, where, order, pageIndex, pageSize, fields);
        }
        #endregion 公用分页

        #region 系统配置
        /// <summary>
        /// 获取配置信息
        /// </summary>
        /// <param name="optionName">配置键值</param>
        /// <returns></returns>
        public IMGroupOption GetGroupOption(string optionName)
        {
            return groupData.GetGroupOption(optionName);
        }
        /// <summary>
        /// 修改配置信息
        /// </summary>
        /// <param name="optionInfo">配置信息</param>
        /// <returns></returns>
        public int UpdateGroupOption(IMGroupOption optionInfo)
        {
            return groupData.UpdateGroupOption(optionInfo);
        }
        #endregion

        #region 俱乐部信息
        /// <summary>
        /// 分页获取数据列表
        /// </summary>
        /// <param name="where">查询条件</param>
        /// <param name="order">排序</param>
        /// <param name="pageIndex">页下标</param>
        /// <param name="pageSize">页显示数</param>
        /// <returns></returns>
        public PagerSet GetPageGroupList(string where, string order, int pageIndex, int pageSize)
        {
            return groupData.GetPageGroupList(where, order, pageIndex, pageSize);
        }
        /// <summary>
        /// 获取亲友圈亲友列表
        /// </summary>
        /// <param name="groupid">亲友圈标识</param>
        /// <returns></returns>
        public DataSet GetGroupMemberList(long groupid)
        {
            return groupData.GetGroupMemberList(groupid);
        }
        /// <summary>
        /// 获取俱乐部信息
        /// </summary>
        /// <param name="groupId">群组编号</param>
        /// <returns></returns>
        public IMGroupProperty GetGroupInfo(long groupId)
        {
            return groupData.GetGroupInfo(groupId);
        }

        /// <summary>
        /// 批量冻结、解冻俱乐部
        /// </summary>
        /// <param name="ids">俱乐部列表 （分隔符：,）</param>
        /// <param name="nullity">0：解冻 1：冻结</param>
        /// <returns></returns>
        public int NullityGroup(string ids, byte nullity)
        {
            return groupData.NullityGroup(ids, nullity);
        }

        /// <summary>
        /// 批量强制解散
        /// </summary>
        /// <param name="ids">俱乐部列表 （分隔符：,）</param>
        /// <returns></returns>
        public int DeleteGroup(string ids)
        {
            return groupData.DeleteGroup(ids);
        }

        /// <summary>
        /// 移交会长
        /// </summary>
        /// <param name="info">群组信息</param>
        /// <returns></returns>
        public int UpdateGroup(IMGroupProperty info)
        {
            return groupData.UpdateGroup(info);
        }

        /// <summary>
        /// 获取俱乐部在线人数（金币房间与比赛房间）
        /// </summary>
        /// <param name="groupId">俱乐部编号</param>
        /// <returns></returns>
        public int GetGroupMemberOnline(long groupId)
        {
            return groupData.GetGroupMemberOnline(groupId);
        }

        /// <summary>
        /// 获取俱乐部钻石数量
        /// </summary>
        /// <param name="groupId">俱乐部编号</param>
        /// <returns></returns>
        public long GetGroupWealth(long groupId)
        {
            return groupData.GetGroupWealth(groupId);
        }

        /// <summary>
        /// 获取俱乐部约战统计 
        /// </summary>
        /// <param name="groupId">俱乐部编号</param>
        /// <param name="userId">用户标识（两个维度：userId为0是为俱乐部统计，大于0时为该用户在该俱乐部的统计）</param>
        /// <returns></returns>
        public StreamGroupBalance GetGroupBattleRoomStream(long groupId, int userId = 0)
        {
            return groupData.GetGroupBattleRoomStream(groupId, userId);
        }

        /// <summary>
        /// 获取俱乐部约战当前房间数
        /// </summary>
        /// <param name="groupId">俱乐部编号</param>
        /// <param name="roomStatus">房间状态</param>
        /// <returns></returns>
        public int GetGroupBattleRoomCurrent(long groupId, int roomStatus = -1)
        {
            return groupData.GetGroupBattleRoomCurrent(groupId, roomStatus);
        }

        #endregion
    }
}