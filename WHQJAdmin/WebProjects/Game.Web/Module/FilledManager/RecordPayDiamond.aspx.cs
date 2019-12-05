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
    public partial class RecordPayDiamond : AdminPage
    {
        /// <summary>
        /// 页面加载
        /// </summary>
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

        /// <summary>
        /// 数据分页
        /// </summary>
        protected void anpNews_PageChanged(object sender, EventArgs e)
        {
            ShareInfoDataBind();
        }


        /// <summary>
        /// 数据绑定
        /// </summary>
        private void ShareInfoDataBind()
        {
            PagerSet pagerSet = FacadeManage.aideTreasureFacade.GetList(OnLinePayOrder.Tablename,
                 SearchItems, Orderby, anpNews.CurrentPageIndex, anpNews.PageSize);
            anpNews.RecordCount = pagerSet.RecordCount;
            litNoData.Visible = pagerSet.PageSet.Tables[0].Rows.Count <= 0;
            ltTotal.Text = $"已支付金额：{FacadeManage.ConversionMoneyToShow(FacadeManage.aideTreasureFacade.GetTotalPayAmount(SearchItems + " AND OrderStates>0").ToString())}元 已支付订单数：{FacadeManage.aideTreasureFacade.GetTotalPayOrderCount(OnLinePayOrder.Tablename,SearchItems)} (当前条件统计)";
            rptShareInfo.DataSource = pagerSet.PageSet;
            rptShareInfo.DataBind();
        }

        /// <summary>
        /// 设置查询条件
        /// </summary>
        private void SetCondition()
        {
            int service = int.Parse(ddlGlobalShareInfo.SelectedValue);
            string startDate = CtrlHelper.GetText(txtStartDate) + " 00:00:00";
            string endDate = CtrlHelper.GetText(txtEndDate) + " 23:59:59";
            StringBuilder condition = new StringBuilder("WHERE 1=1");
            if (service > 0)
            {
                condition.AppendFormat(" AND PayType={0} ", service);
            }
            if (!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate))
            {
                condition.AppendFormat(" AND PayTime BETWEEN '{0}' AND '{1}'", startDate, endDate);
            }
            int type = Convert.ToInt32(ddlSearchType.SelectedValue);
            int status = Convert.ToInt32(ddlPayStatus.SelectedValue);
            string queryContent = CtrlHelper.GetTextAndFilter(txtSearch);
            if (status >= 0)
            {
                condition.AppendFormat(" AND OrderStates='{0}'", status);
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
        }

        /// <summary>
        /// 数据查询
        /// </summary>
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            SetCondition();
            ShareInfoDataBind();
        }

        protected void btnAgree_Click(object sender, EventArgs e)
        {
            AuthUserOperationPermission(Permission.OrderOperating);
            string oid = ((Button)sender).CommandArgument;
            Message result= FacadeManage.aideTreasureFacade.FinshOnlineOrder(oid,2,0,userExt.UserID,userExt.PreLoginIP);
            if (result.MessageID == 0)
            {
                ShowInfo(result.Content);
            }
            else
            {
                ShowError(result.Content);
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
        /// 充值类型
        /// </summary>
        /// <param name="shareId"></param>
        /// <returns></returns>
        public string GetOrderShareName(int shareId)
        {
            switch (shareId)
            {
                case 1:
                    return "微信";
                case 2:
                    return "支付宝";
                case 3:
                    return "云闪付";
                default:
                    return "未知类型";
            }
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
                case 2:
                    return "补单";
                case 1:
                    return "已支付";
                default:
                    return "未支付";
            }
        }


        protected string GetArrvieStatus(int status)
        {
            switch (status)
            {
                case 1:
                    return "金币到账";
                case 2:
                    return "银行到账";
                default:
                    return "未到账";
            }
        }


        /// <summary>
        /// 查询条件
        /// </summary>
        public string SearchItems
        {
            get
            {
                if (ViewState["SearchItems"] == null)
                {
                    SetCondition();
                }
                return (string) ViewState["SearchItems"];
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
                return (string) ViewState["Orderby"];
            }
            set { ViewState["Orderby"] = value; }
        }
    }
}