using System;
using System.Text;
using Game.Web.UI;
using Game.Facade;
using Game.Kernel;
using Game.Entity.Accounts;
using Game.Entity.Platform;

namespace Game.Web.Module.MailManager
{
    public partial class MailConfig : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 1500;
            if (!IsPostBack)
            {
                BindData();
            }
        }
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            if (FacadeManage.aideAccountsFacade.GetAccountInfoByGameId(Convert.ToInt32(TextBox1.Text)) != null)
            {
                SetCondition();
                BindData();
            }
            else
            {
                ShowInfo("玩家不存在");
            }
        }
        protected void anpNews_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }
        protected int GetAccountGameID(int uid)
        {
            AccountsInfo user = FacadeManage.aideAccountsFacade.GetAccountInfoByUserId(uid);
            if (user != null)
            {
                return user.GameID;
            }
            return -1;
        }
        protected void BindData()
        {
            PagerSet pagerSet = FacadeManage.aidePlatformFacade.GetList(UserMail.Tablename, SearchItems, " ORDER BY SendTime ", anpNews.CurrentPageIndex, anpNews.PageSize);
            anpNews.RecordCount = pagerSet.PageSize;
            rptDataList.DataSource = pagerSet.PageSet;
            rptDataList.DataBind();
            litNoData.Visible = pagerSet.RecordCount == 0;
        }
        protected string GetMailState(byte state)
        {
            switch (state)
            {
                case 1:
                    return "已读";
                case 2:
                    return "删除";
            }
            return "未读";
        }

        private void SetCondition()
        {
            StringBuilder condition = new StringBuilder("WHERE 1=1");
            if (TextBox1.Text != "")
            {
                int uid = FacadeManage.aideAccountsFacade.GetAccountInfoByGameId(Convert.ToInt32(TextBox1.Text)).UserID;

                condition.AppendFormat(" AND UserID={0}", uid);
            }

            if (TextBox2.Text != "")
            {
                condition.AppendFormat(" AND UserID={0}", TextBox2.Text);
            }

            if (DropDownList1.SelectedValue != "-1")
            {
                condition.AppendFormat(" AND MState={0}", DropDownList1.SelectedValue);
            }
            string RSTime = txtStartDate.Text;
            string RETime = txtEndDate.Text;
            if (RSTime != "" && RETime != "")
            {
                condition.AppendFormat(" AND SendTime BETWEEN '{0}' AND '{1}' ", RSTime, RETime);
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
    }
}