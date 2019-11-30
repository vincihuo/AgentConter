using System;
using Game.Web.UI;
using Game.Facade;
using Game.Kernel;
using Game.Utils;
using System.Text;
using System.Data;
using System.Web.UI.WebControls;

namespace Game.Web.Module.AgentManager
{
    public partial class AgentUserUnder : AdminPage
    {
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 1001;
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                SetCondition();
                BindData();
            }
        }
        protected void anpPage_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }
        protected string ParseArgument(int id, string time)
        {
            return id.ToString() + ',' + time;
        }

        /// <summary>
        /// 数据绑定
        /// </summary>
        private void BindData()
        {
            // anpPage.CurrentPageIndex, anpPage.PageSize
            PagerSet pagerSet = FacadeManage.aideRecordFacade.GetListLock("WHQJAccountsDB.dbo.AccountsInfo (NOLOCK) A INNER JOIN WHQJRecordDB.dbo.AgentCountRecord (NOLOCK) R ON A.UserID = R.UserID ", SearchItems, " ORDER BY R.CountTime DESC ", anpPage.CurrentPageIndex, anpPage.PageSize, "A.UserID,A.GameID,A.NickName,R.CountTime,R.Tax,R.SubNumber,R.ParentID,R.BeggarNumber,R.CurrReward");

            string startDate = CtrlHelper.GetText(txtStartDate);
            string endDate = CtrlHelper.GetText(txtEndDate);
            StringBuilder where = new StringBuilder();
            if (DropDownList1.SelectedValue != "0"&& DropDownList1.SelectedValue!="")
            {
                where.AppendFormat("WHERE  ParentID={0}", DropDownList1.SelectedValue);
            }
            else
            {
                where.AppendFormat("WHERE  ParentID={0}", IntParam);
            }
            where.AppendFormat(" AND CountTime BETWEEN '{0}' AND '{1}'", startDate, endDate);
            DataSet ds = FacadeManage.aideRecordFacade.CountReward(where.ToString());
            if (ds.Tables.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                long ImmediateMoney = 0;
                long otherMoney = 0;
                string person = "0";
                if (row["Person"] != DBNull.Value)
                {
                    person= row["Person"].ToString();
                }

                if (row["ImmediateMoney"] != DBNull.Value)
                {
                    ImmediateMoney = (long)(Convert.ToInt64(row["ImmediateMoney"]) * 0.3);
                }
                if (row["OtherMoney"] != DBNull.Value)
                {
                    otherMoney = (long)(Convert.ToInt64(row["OtherMoney"]) * 0.3);
                }
                lbTotal.Text = person;
                Label1.Text = FacadeManage.ConversionMoneyToShow(ImmediateMoney).ToString();
                Label1.Text = FacadeManage.ConversionMoneyToShow(otherMoney).ToString();
            }

            anpPage.RecordCount = pagerSet.RecordCount;
            rptDataList.DataSource = pagerSet.PageSet.Tables[0];
            rptDataList.DataBind();
        }
        protected void btnSub(object sender, EventArgs e)
        {
            string[] arguments = ((LinkButton)sender).CommandArgument.ToString().Split(',');
            txtStartDate.Text = arguments[1];
            txtEndDate.Text = arguments[1];
            int parentID = Convert.ToInt32(arguments[0]);
            SetDropDown(parentID);
            SetCondition(parentID);
            BindData();
        }
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            SetCondition();
            BindData();
        }

        private void SetDropDown(int pid)
        {
            DataSet ds = FacadeManage.aideTreasureFacade.GetSubList(pid);
            DropDownList1.Items.Clear();
            DataTable table = ds.Tables[0];
            if (table == null || table.Rows.Count <= 0) return;
            int i = 1;
            DropDownList1.Items.Add(new ListItem("全部", "0"));
            foreach (DataRow row in table.Rows)
            {
                DropDownList1.Items.Add(new ListItem(row["GameID"].ToString(), row["UserID"].ToString()));
                i++;
            }
        }

        private void SetCondition(int pid=0)
        {
            string startDate = CtrlHelper.GetText(txtStartDate);
            string endDate = CtrlHelper.GetText(txtEndDate);
            if (DropDownList1.SelectedValue != "0"&& DropDownList1.SelectedValue != "")
            {
                StringBuilder condition = new StringBuilder($" WHERE  R.UserID={DropDownList1.SelectedValue}");
                condition.AppendFormat(" AND R.CountTime BETWEEN '{0}' AND '{1}'", startDate, endDate);
                ViewState["SearchItems"] = condition.ToString();
            }
            else if (pid == 0)
            {
                StringBuilder condition = new StringBuilder($" WHERE  R.UserID={IntParam}");
                condition.AppendFormat(" AND R.CountTime BETWEEN '{0}' AND '{1}'", startDate, endDate);
                ViewState["SearchItems"] = condition.ToString();
            }
            else
            {
                StringBuilder condition = new StringBuilder($" WHERE  R.ParentID={pid}");
                condition.AppendFormat(" AND R.CountTime BETWEEN '{0}' AND '{1}'", startDate, endDate);
                ViewState["SearchItems"] = condition.ToString();
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
        protected string GetStyle(int id)
        {
            if (id == 0)
            {
                return "visibility:hidden";
            }
            return "visibility:visible";
        }

    }
}