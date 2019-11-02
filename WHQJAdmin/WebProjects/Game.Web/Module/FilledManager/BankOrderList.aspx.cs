using System;
using Game.Web.UI;
using System.Text;
using Game.Kernel;
using Game.Utils;
using Game.Facade;
using Game.Entity.Treasure;
using System.Web.UI.WebControls;
using Game.Entity.Enum;

namespace Game.Web.Module.FilledManager
{
    public partial class BankOrderList : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 201;
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                ShareInfoDataBind();
            }
        }
        protected void anpNews_PageChanged(object sender, EventArgs e)
        {
            ShareInfoDataBind();
        }

        private void ShareInfoDataBind()
        {
            PagerSet pagerSet = FacadeManage.aideTreasureFacade.GetList(BankPayOrder.Tablename,
                 SearchItems, Orderby, anpNews.CurrentPageIndex, anpNews.PageSize);
            anpNews.RecordCount = pagerSet.RecordCount;
            litNoData.Visible = pagerSet.PageSet.Tables[0].Rows.Count <= 0;
            long mm = (long)FacadeManage.aideTreasureFacade.GetTotalAmount(BankPayOrder.Tablename, SearchItems);
            ltTotal.Text = $"已充值金额：{FacadeManage.ConversionMoneyToShow(mm)}元 已支付订单数：{FacadeManage.aideTreasureFacade.GetTotalPayOrderCount(BankPayOrder.Tablename, SearchItems)} (当前条件统计)";
            rptShareInfo.DataSource = pagerSet.PageSet;
            rptShareInfo.DataBind();
        }

        private void SetCondition()
        {
            string startDate = CtrlHelper.GetText(txtStartDate) + " 00:00:00";
            string endDate = CtrlHelper.GetText(txtEndDate) + " 23:59:59";
            StringBuilder condition = new StringBuilder("WHERE 1=1");
            if (!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate))
            {
                condition.AppendFormat(" AND PayTime BETWEEN '{0}' AND '{1}'", startDate, endDate);
            }
            ViewState["SearchItems"] = condition.ToString();
        }
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            SetCondition();
            ShareInfoDataBind();
        }
        protected void btnAgree_Click(object sender, EventArgs e)
        {
            AuthUserOperationPermission(Permission.OrderOperating);
            string oid = ((Button)sender).CommandArgument;
            Message result = FacadeManage.aideTreasureFacade.FinshOfficalOrder(oid, 1, userExt.UserID);
            if (result.MessageID == 0)
            {
                ShowInfo("充值成功");
            }
            else
            {
                ShowError("充值失败");
            }
            ShareInfoDataBind();
        }

        /// <summary>
        /// 查询今天
        /// </summary>
        protected void btnQueryTD_Click(object sender, EventArgs e)
        {
            CtrlHelper.SetText(txtStartDate,
                Convert.ToDateTime(Fetch.GetTodayTime().Split('$')[0]).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate,
                Convert.ToDateTime(Fetch.GetTodayTime().Split('$')[1]).ToString("yyyy-MM-dd"));

            btnQuery_Click(sender, e);
        }

        /// <summary>
        /// 查询昨天
        /// </summary>
        protected void btnQueryYD_Click(object sender, EventArgs e)
        {
            CtrlHelper.SetText(txtStartDate,
                Convert.ToDateTime(Fetch.GetYesterdayTime().Split('$')[0]).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate,
                Convert.ToDateTime(Fetch.GetYesterdayTime().Split('$')[1]).ToString("yyyy-MM-dd"));

            btnQuery_Click(sender, e);
        }

        /// <summary>
        /// 查询本周
        /// </summary>
        protected void btnQueryTW_Click(object sender, EventArgs e)
        {
            CtrlHelper.SetText(txtStartDate,
                Convert.ToDateTime(Fetch.GetWeekTime().Split('$')[0]).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate,
                Convert.ToDateTime(Fetch.GetWeekTime().Split('$')[1]).ToString("yyyy-MM-dd"));

            btnQuery_Click(sender, e);
        }

        /// <summary>
        /// 查询上周
        /// </summary>
        protected void btnQueryYW_Click(object sender, EventArgs e)
        {
            CtrlHelper.SetText(txtStartDate,
                Convert.ToDateTime(Fetch.GetLastWeekTime().Split('$')[0]).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate,
                Convert.ToDateTime(Fetch.GetLastWeekTime().Split('$')[1]).ToString("yyyy-MM-dd"));

            btnQuery_Click(sender, e);
        }

        /// <summary>
        /// 用户查询
        /// </summary>
        protected void btnQueryAcc_Click(object sender, EventArgs e)
        {
            int type = Convert.ToInt32(ddlSearchType.SelectedValue);
            int status = Convert.ToInt32(ddlPayStatus.SelectedValue);
            string queryContent = CtrlHelper.GetTextAndFilter(txtSearch);

            StringBuilder condition = new StringBuilder("WHERE 1=1");
            if (status >= 0)
            {
                condition.AppendFormat(" AND OrderStatus='{0}'", status);
            }
            if (!string.IsNullOrEmpty(queryContent))
            {
                switch (type)
                {
                    case 0:
                        condition.AppendFormat(" AND OrderID='{0}'", queryContent);
                        break;
                    default:
                        if (!Utils.Validate.IsPositiveInt(queryContent))
                        {
                            ShowError("输入的查询格式不正确");
                            return;
                        }
                        condition.AppendFormat(" AND GameID={0}", queryContent);
                        break;
                }
            }

            ViewState["SearchItems"] = condition.ToString();
            ShareInfoDataBind();
        }
        /// <summary>
        /// 充值状态
        /// </summary>
        /// <param name="status"></param>
        /// <returns></returns>
        protected string GetPayStatus(int status)
        {
            switch (status)
            {
                case 1:
                    return "已支付";
                default:
                    return "未支付";
            }
        }
        protected string GetTransfType(int status)
        {
            switch (status)
            {
                case 1:
                    return "微信转账";
                case 2:
                    return "支付宝转账";
                case 3:
                    return "QQ转账";
                case 4:
                    return "银联转账";
                default:
                    return "未知类型";
            }
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

        /// <summary>
        /// 排序条件
        /// </summary>
        public string Orderby
        {
            get
            {
                if (ViewState["Orderby"] == null)
                {
                    ViewState["Orderby"] = "ORDER BY PayTime DESC";
                }
                return (string)ViewState["Orderby"];
            }
            set { ViewState["Orderby"] = value; }
        }

    }
}