using System;
using Game.Web.UI;
using Game.Kernel;
using Game.Entity.Accounts;
using Game.Facade;
using System.Text;

namespace Game.Web.Module.TurntableManager
{
    public partial class UserTurntableRecord : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 140;
            if (!IsPostBack)
            {
                BindData();
            }
        }
        private void BindData()
        {
            PagerSet ps = FacadeManage.aideRecordFacade.GetList("RecordTurntable", SearchItems, " ORDER BY Opentime DESC ", anpNews.CurrentPageIndex, anpNews.PageSize);
            rptDataList.DataSource = ps.PageSet;
            rptDataList.DataBind();
            anpNews.RecordCount = ps.RecordCount;
            litNoData.Visible = ps.RecordCount <= 0;
        }
        private void SetCondition()
        {
            StringBuilder condition = new StringBuilder(" WHERE 1=1");
            if(TextBox1.Text!="")
            {
                AccountsInfo acc = FacadeManage.aideAccountsFacade.GetAccountInfoByGameId(Convert.ToInt32(TextBox1.Text));
                if (acc != null)
                {
                    condition.AppendFormat(" AND GameID={0}", acc.UserID);
                }
                else
                {
                    condition.AppendFormat(" AND GameID={0}", 0);
                }
            }
            if (ddlSearchType.SelectedValue != "0")
            {
                condition.AppendFormat(" AND TableIndex={0}", Convert.ToInt32(ddlSearchType.SelectedValue) - 1);
            }
            string RSTime = txtStartDate.Text;
            string RETime = txtEndDate.Text;
            if (RSTime != "" && RETime != "")
            {
                condition.AppendFormat(" AND Opentime BETWEEN '{0}' AND '{1}' ", RSTime, RETime);
            }
            ViewState["SearchItems"] = condition.ToString();
        }

        public string SearchItems
        {
            get
            {
                if (ViewState["SearchItems"] == null)
                {
                    SetCondition();
                }
                return (string)ViewState["SearchItems"];
            }
            set { ViewState["SearchItems"] = value; }
        }
        protected string GetAccountsInfo(int userid)
        {
            AccountsInfo info = FacadeManage.aideAccountsFacade.GetAccountInfoByUserId(userid);
            if (info != null)
            {
                return string.Format("<td>{0}</td><td>{1}</td>", info.GameID, info.NickName);
            }
            return "<td></td><td></td>";
        }
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            SetCondition();
            BindData();
        }
        protected void anpNews_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }
    }
}