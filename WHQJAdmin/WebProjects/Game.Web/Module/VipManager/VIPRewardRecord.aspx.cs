using System;
using Game.Facade;
using System.Text;
using Game.Kernel;
using Game.Web.UI;

namespace Game.Web.Module.VipManager
{
    public partial class VIPRewardRecord : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 1400;
            if (!IsPostBack)
            {
                BindData();
            }
        }
        private void BindData()
        {
            PagerSet pagerSet = FacadeManage.aideRecordFacade.GetList("RecordVIPReward", SearchItems, " ORDER BY TackTime ", anpNews.CurrentPageIndex, anpNews.PageSize);
            anpNews.RecordCount = pagerSet.PageSize;
            rptDataList.DataSource = pagerSet.PageSet.Tables[0];
            rptDataList.DataBind();
            litNoData.Visible = pagerSet.RecordCount == 0;
        }
        protected void anpNews_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        protected int GetAccountGameID(int uid)
        {
           return FacadeManage.aideAccountsFacade.GetAccountInfoByUserId(uid).GameID;
        }
        protected string GetRewardType(int type)
        {
            switch (type)
            {
                case 1:
                    return "晋级奖励";
                case 2:
                    return "周奖励";
                case 3:
                    return "月奖励";
                case 4:
                    return "签到1";
                case 5:
                    return "签到2";
                case 6:
                    return "签到3";
                case 7:
                    return "签到4";
                case 8:
                    return "签到5";
                case 9:
                    return "签到6";
                case 10:
                    return "签到7";
                default:
                    return "未知类型";
            }
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            SetCondition();
            BindData();
        }

        private void SetCondition()
        {
            StringBuilder condition = new StringBuilder("WHERE 1=1");
            if (TextBox1.Text != "")
            {
                int uid = FacadeManage.aideAccountsFacade.GetAccountInfoByGameId(Convert.ToInt32(TextBox1.Text)).UserID;
                condition.AppendFormat(" AND UserID={0}", uid);
            }
            if (DropDownList2.SelectedValue != "0")
            {
                condition.AppendFormat(" AND VIPLevel={0}", DropDownList2.SelectedValue);
            }
            if (DropDownList1.SelectedValue != "0")
            {
                condition.AppendFormat(" AND RewardType={0}", DropDownList1.SelectedValue);
            }
            string RSTime = txtStartDate.Text;
            string RETime = txtEndDate.Text;
            if (RSTime != "" && RETime != "")
            {
                condition.AppendFormat(" AND TackTime BETWEEN '{0}' AND '{1}' ", RSTime, RETime);
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