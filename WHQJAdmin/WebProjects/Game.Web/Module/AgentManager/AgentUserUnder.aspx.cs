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
        private int parentID=0;
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 1001;
            if(!IsPostBack)
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
        protected void btnSub(object sender, EventArgs e)
        {
            string[] arguments = ((LinkButton)sender).CommandArgument.ToString().Split(',');
            txtStartDate.Text = arguments[1];
            txtEndDate.Text = arguments[1];
            parentID = Convert.ToInt32(arguments[0]);
            SetDropDown();
            SetCondition();
            BindData();
        }
        protected string ParseArgument(int id,string time)
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

            DataSet ds = FacadeManage.aideTreasureFacade.CountReward(parentID==0?IntParam:parentID);
            if (ds.Tables.Count>0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                lbTotal.Text = row["person"].ToString();
                Label1.Text = Convert.ToInt32((Int64)(row["ImmediateMoney"]) *0.3).ToString();
                Label2.Text = Convert.ToInt32((Int64)(row["OtherMoney"]) * 0.3).ToString();
            }

            anpPage.RecordCount = pagerSet.RecordCount;
            rptDataList.DataSource = pagerSet.PageSet.Tables[0];
            rptDataList.DataBind();
        }
        protected void GameID_SelectedIndexChanged(object sender, EventArgs e)
        {
            SetCondition();
            BindData();
        }
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            SetCondition();
            BindData();

        }

        private void SetDropDown()
        {
            DataSet ds = FacadeManage.aideTreasureFacade.GetSubList(parentID);
            DropDownList1.Items.Clear();
            DataTable table = ds.Tables[0];
            if (table == null || table.Rows.Count <= 0) return;
            int i = 1;
            DropDownList1.Items.Add(new ListItem("全部", "0"));
            foreach (DataRow row in table.Rows)
            {
                DropDownList1.Items.Add(new ListItem(row["GameID"].ToString(), i.ToString()));
                i++;
            }
        }

        private void SetCondition()
        {
            string startDate = CtrlHelper.GetText(txtStartDate);
            string endDate = CtrlHelper.GetText(txtEndDate);
            if (parentID == 0)
            {
                StringBuilder condition = new StringBuilder($" WHERE  R.UserID={IntParam}");
                condition.AppendFormat(" AND R.CountTime BETWEEN '{0}' AND '{1}'", startDate, endDate);
                ViewState["SearchItems"] = condition.ToString();
            }
            else
            {
                StringBuilder condition = new StringBuilder($" WHERE  R.ParentID={parentID}");

                if (DropDownList1.SelectedValue != "0")
                {
                    condition.AppendFormat(" AND R.UserID ={0}", DropDownList1.SelectedItem.Text);
                }
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