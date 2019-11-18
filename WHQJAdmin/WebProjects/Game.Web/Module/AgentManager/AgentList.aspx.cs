using Game.Entity.Accounts;
using Game.Facade;
using Game.Kernel;
using Game.Utils;
using Game.Web.UI;
using System;
using System.Data;
using System.Text;
using System.Web.UI.WebControls;

namespace Game.Web.Module.AgentManager
{
    public partial class AgentList : AdminPage
    {
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 1001;
            if (!IsPostBack)
            {
                if (IntParam > 0)
                {
                    UserInfo info = FacadeManage.aideAccountsFacade.GetUserInfo(IntParam);
                    txtSearch.Text = info.GameID.ToString();
                    ddlSearchType.SelectedValue = Convert.ToString(1);
                }
                AgentDataBind();
            }
        }
        /// <summary>
        /// 数据分页
        /// </summary>
        protected void anpPage_PageChanged(object sender, EventArgs e)
        {
            AgentDataBind();
        }
        /// <summary>
        /// 数据查询
        /// </summary>
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            AgentDataBind();
        }
        protected void SelectBeggar(object sender, EventArgs e)
        {
            string id = ((LinkButton)sender).CommandArgument;
            txtSearch.Text = id;
            ddlSearchType.SelectedValue=Convert.ToString(1);
            AgentDataBind();
        }
        /// <summary>
        /// 数据绑定
        /// </summary>
        /// 
        private void AgentDataBind()
        {
            string query = CtrlHelper.GetTextAndFilter(txtSearch);
            int typeid = Convert.ToInt32(ddlSearchType.SelectedValue);
            StringBuilder condition = new StringBuilder(" WHERE 1=1 ");
            if (!string.IsNullOrEmpty(query))
            {
                if (!Utils.Validate.IsPositiveInt(query))
                {
                    ShowError("输入查询格式不正确");
                    return;
                }
                UserInfo info = FacadeManage.aideAccountsFacade.GetUserInfo(0, Convert.ToInt32(query));
                if (typeid == 1)
                {
                    condition.AppendFormat(" AND R.UserID={0}", info != null ? info.UserID : 0);
                }
                else
                {
                    condition.AppendFormat(" AND R.ParentID={0}", info != null ? info.UserID : 0);
                }
            }
            PagerSet pagerSet = FacadeManage.aideTreasureFacade.GetListLock(" WHQJAccountsDB.dbo.AccountsInfo (NOLOCK) A INNER JOIN WHQJTreasureDB.dbo.AgentInfo (NOLOCK) R ON A.UserID = R.UserID ",
                condition.ToString(), " ORDER BY BackMoney DESC ", anpPage.CurrentPageIndex, anpPage.PageSize, "R.UserID,A.GameID,A.NickName,R.SubNumber,R.AllReward,R.ParentID,R.Reward,R.BackMoney,R.LinkUrl");
            anpPage.RecordCount = pagerSet.RecordCount;
            if (pagerSet.RecordCount > 0)
            {
                rptDataList.DataSource = pagerSet.PageSet;
                rptDataList.DataBind();
            }
            litNoData.Visible = pagerSet.RecordCount <= 0;
            rptDataList.Visible = pagerSet.RecordCount > 0;
        }
         
    }
}