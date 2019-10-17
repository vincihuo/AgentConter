using System;
using System.Data;
using System.Text;
using Game.Entity.Accounts;
using Game.Entity.Agent;
using Game.Entity.Enum;
using Game.Entity.Group;
using Game.Facade;
using Game.Kernel;
using Game.Utils;
using Game.Web.UI;

namespace Game.Web.Module.ClubManager
{
    public partial class GroupList : AdminPage
    {
        private DataTable wealth;

        #region 窗体事件
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 902;
            if(!IsPostBack)
            {
                DBDataBind();
            }
        }
        /// <summary>
        /// 数据分页
        /// </summary>
        protected void anpPage_PageChanged(object sender, EventArgs e)
        {
            DBDataBind();
        }
        /// <summary>
        /// 数据查询
        /// </summary>
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            DBDataBind();
        }
       
        /// <summary>
        /// 批量冻结群组
        /// </summary>
        protected void btnDongjie_Click(object sender, EventArgs e)
        {
            //判断权限
            AuthUserOperationPermission(Permission.Add);
            int result = FacadeManage.aideGroupFacade.NullityGroup(StrCIdList, 2);
            if(result > 0)
            {
                ShowInfo("冻结成功");
                DBDataBind();
            }
            else
            {
                ShowError("冻结失败");
            }
        }
        /// <summary>
        /// 批量解冻群组
        /// </summary>
        protected void btnJiedong_Click(object sender, EventArgs e)
        {
            //判断权限
            AuthUserOperationPermission(Permission.Add);
            int result = FacadeManage.aideGroupFacade.NullityGroup(StrCIdList, 1);
            if(result > 0)
            {
                ShowInfo("解冻成功");
                DBDataBind();
            }
            else
            {
                ShowError("解冻失败");
            }
        }
        #endregion

        #region 数据绑定
        /// <summary>
        /// 数据绑定
        /// </summary>
        private void DBDataBind()
        {
            string query = CtrlHelper.GetTextAndFilter(txtSearch);
            int type = Convert.ToInt32(ddlSearchType.SelectedValue);

            string where = " WHERE 1=1";
            if (!string.IsNullOrEmpty(query))
            {
                where = where + string.Format(" AND {0}={1}", type==1? "CreaterGameID": "GroupID", query);
            }

            PagerSet pagerSet = FacadeManage.aideGroupFacade.GetPageGroupList(where, 
                Orderby, anpPage.CurrentPageIndex, anpPage.PageSize);
            anpPage.RecordCount = pagerSet.RecordCount;
            if (pagerSet.RecordCount > 0)
            {
                wealth = pagerSet.PageSet.Tables[1];
                rptDataList.DataSource = pagerSet.PageSet.Tables[0];
                rptDataList.DataBind();
            }
            litNoData.Visible = pagerSet.RecordCount <= 0;
            rptDataList.Visible = pagerSet.RecordCount > 0;
        }
        /// <summary>
        /// 获取亲友圈信息
        /// </summary>
        protected string GetGroupWealth(int groupid)
        {
            if(wealth!=null&& wealth.Rows.Count > 0)
            {
                DataRow[] rows = wealth.Select("GroupID="+ groupid);
                if (rows != null && rows.Length > 0)
                {
                    return string.Format("<td>{0}</td><td>{1}</td><td>{2}</td>", 
                        rows[0]["Ingot"], rows[0]["ConsumeIngot"], rows[0]["BattleCreate"]);
                }
            }
            return "<td></td><td></td><td></td>";
        }
        #endregion

        #region 公共属性
        /// <summary>
        /// 排序条件
        /// </summary>
        public string Orderby
        {
            get
            {
                if (ViewState["Orderby"] == null)
                {
                    ViewState["Orderby"] = "ORDER BY GroupID DESC";
                }
                return (string)ViewState["Orderby"];
            }
            set
            {
                ViewState["Orderby"] = value;
            }
        }

        #endregion





    }
}