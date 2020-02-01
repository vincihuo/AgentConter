using System;
using Game.Web.UI;
using Game.Facade;
using Game.Utils;
using Game.Kernel;
using Game.Entity.Record;
using System.Text;

namespace Game.Web.Module.AgentManager
{
    public partial class WFAgentList : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }
        protected void BindData()
        {
            PagerSet ps = FacadeManage.aideRecordFacade.GetListLock(WFAgentCountRecord.Tablename,);
        }
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            SetCondition();
            BindData();
        }
        private void SetCondition()
        {
            string startDate = CtrlHelper.GetText(txtStartDate) + " 00:00:00";
            string endDate = CtrlHelper.GetText(txtEndDate) + " 23:59:59";
            StringBuilder condition = new StringBuilder();
            condition.AppendFormat(" WHERE UserID={0} AND ChangeScore<0", IntParam);
            if (!string.IsNullOrEmpty(startDate) && !string.IsNullOrEmpty(endDate))
            {
                condition.AppendFormat(" AND CollectDate BETWEEN '{0}' AND '{1}'", startDate, endDate);
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
            set
            {
                ViewState["SearchItems"] = value;
            }
        }
        protected void btnQueryYD_Click(object sender, EventArgs e)
        {
            CtrlHelper.SetText(txtStartDate, Convert.ToDateTime(Fetch.GetYesterdayTime().Split('$')[0]).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate, Convert.ToDateTime(Fetch.GetYesterdayTime().Split('$')[1]).ToString("yyyy-MM-dd"));
            btnQuery_Click(sender, e);
        }
        protected void btnQueryTW_Click(object sender, EventArgs e)
        {
            CtrlHelper.SetText(txtStartDate, Convert.ToDateTime(Fetch.GetWeekTime().Split('$')[0]).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate, Convert.ToDateTime(Fetch.GetWeekTime().Split('$')[1]).ToString("yyyy-MM-dd"));
            btnQuery_Click(sender, e);
        }
        protected void btnQueryYW_Click(object sender, EventArgs e)
        {
            CtrlHelper.SetText(txtStartDate, Convert.ToDateTime(Fetch.GetLastWeekTime().Split('$')[0]).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate, Convert.ToDateTime(Fetch.GetLastWeekTime().Split('$')[1]).ToString("yyyy-MM-dd"));

            btnQuery_Click(sender, e);
        }
        protected void btnQueryTM_Click(object sender, EventArgs e)
        {
            CtrlHelper.SetText(txtStartDate,
                Convert.ToDateTime(Fetch.GetMonthTime().Split('$')[0]).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate,
                Convert.ToDateTime(Fetch.GetMonthTime().Split('$')[1]).ToString("yyyy-MM-dd"));

            btnQuery_Click(sender, e);
        }
        protected void btnQueryYM_Click(object sender, EventArgs e)
        {
            CtrlHelper.SetText(txtStartDate,
                Convert.ToDateTime(Fetch.GetLastMonthTime().Split('$')[0]).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate,
                Convert.ToDateTime(Fetch.GetLastMonthTime().Split('$')[1]).ToString("yyyy-MM-dd"));
            btnQuery_Click(sender, e);
        }
    }
}