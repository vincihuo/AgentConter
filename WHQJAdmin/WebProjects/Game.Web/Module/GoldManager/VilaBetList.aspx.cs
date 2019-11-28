using System;
using Game.Web.UI;
using System.Text;
using Game.Kernel;
using Game.Utils;
using Game.Facade;
using Game.Entity.Accounts;
using Game.Entity.Treasure;
using System.Web.UI.WebControls;
using Game.Entity.Enum;

namespace Game.Web.Module.GoldManager
{
    public partial class VilaBetList : AdminPage
    {
        private int UserId;

        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 201;
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }
        protected void btnQueryAcc_Click(object sender, EventArgs e)
        {
            string gameID = CtrlHelper.GetTextAndFilter(txtSearch);
            AccountsInfo info = FacadeManage.aideAccountsFacade.GetAccountInfoByGameId(Convert.ToInt32(gameID));
            if (info == null)
            {
                ShowError("没用找到用户");
                return;
            }
            UserId = info.UserID;
            SetUerBet();
            SetCondition();
            ShareInfoDataBind();
        }

        protected string DepositName(int type)
        {
            switch (type)
            {
                case 1:
                    return "线上入款";
                case 2:
                    return "官方入款";
                case 3:
                    return "代理入款";
                case 4:
                    return "每日分享";
                case 5:
                    return "注册送";
                case 6:
                    return "签到奖励";
                default:
                    return "未知类型";
            }
        }

        private void ShareInfoDataBind()
        {
            if (SearchItems == null)
            {
                ShowError("输入游戏id");
                return;
            }
            PagerSet pagerSet = FacadeManage.aideTreasureFacade.GetList(ValiBetRecord.Tablename,
                SearchItems, Orderby, anpNews.CurrentPageIndex, anpNews.PageSize);
            anpNews.RecordCount = pagerSet.RecordCount;
            litNoData.Visible = pagerSet.PageSet.Tables[0].Rows.Count <= 0;
            rptShareInfo.DataSource = pagerSet.PageSet;
            rptShareInfo.DataBind();
        }


        protected void anpNews_PageChanged(object sender, EventArgs e)
        {
            ShareInfoDataBind();
        }

        private void SetUerBet()
        {
            UserValidBet bet = FacadeManage.aideTreasureFacade.GetUserVailBet(UserId);
            ltTotal.Text = $"目标打码量：{bet.TargetBet/1000} 当前打码量：{bet.CurrentValidBet/1000}";

        }

        private void SetCondition()
        {
            string startDate = CtrlHelper.GetText(txtStartDate) + " 00:00:00";
            string endDate = CtrlHelper.GetText(txtEndDate) + " 23:59:59";
            StringBuilder condition = new StringBuilder("WHERE 1=1");
            condition.AppendFormat(" AND UserID={0} ", UserId);
            if (!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate))
            {
                condition.AppendFormat(" AND DepositTime BETWEEN '{0}' AND '{1}'", startDate, endDate);
            }
            ViewState["SearchItems"] = condition.ToString();
        }
        public string SearchItems
        {
            get
            {
                return (string)ViewState["SearchItems"];
            }
            set { ViewState["SearchItems"] = value; }
        }

        /// <summary>
        /// 排序条件
        /// </summary>
        public string Orderby
        {
            get
            {
                if (ViewState["Orderby"] == null)
                {
                    ViewState["Orderby"] = "ORDER BY DepositTime DESC";
                }
                return (string)ViewState["Orderby"];
            }
            set { ViewState["Orderby"] = value; }
        }


    }
}