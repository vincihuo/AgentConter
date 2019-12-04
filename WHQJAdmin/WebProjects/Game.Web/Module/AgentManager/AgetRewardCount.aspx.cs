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
    public partial class AgetRewardCount : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 1001;
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                int gid = FacadeManage.aideAccountsFacade.GetAccountInfoByUserId(IntParam).GameID;
                GameId.Text = gid.ToString();
                SetCondition();
                BindData();
            }
        }
        protected void anpPage_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }
        private void BindData()
        {
            // anpPage.CurrentPageIndex, anpPage.PageSize
            PagerSet pagerSet = FacadeManage.aideRecordFacade.GetListLock("WHQJAccountsDB.dbo.AccountsInfo (NOLOCK) A INNER JOIN WHQJRecordDB.dbo.AgentCountRecord (NOLOCK) R ON A.UserID = R.UserID ", SearchItems, " ORDER BY R.CountTime DESC ", anpPage.CurrentPageIndex, anpPage.PageSize, "A.UserID,A.GameID,A.NickName,R.CountTime,R.Tax,R.SubNumber,R.ParentID,R.BeggarNumber,R.CurrReward");
            string startDate = CtrlHelper.GetText(txtStartDate);
            string endDate = CtrlHelper.GetText(txtEndDate);
            string gameid = CtrlHelper.GetText(GameId);
            int uid = FacadeManage.aideAccountsFacade.GetAccountInfoByGameId(Convert.ToInt32(gameid)).UserID;
            DataSet ds = FacadeManage.aideRecordFacade.CountReward($"WHERE  UserID={uid} AND CountTime BETWEEN '{startDate}' AND '{endDate}'");
            if (ds.Tables.Count > 0)
            {
                DataRow row = ds.Tables[0].Rows[0];
                long ImmediateMoney = 0;
                long otherMoney = 0;
                string person = "0";
                if (row["Person"] != DBNull.Value)
                {
                    person = row["Person"].ToString();
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
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            SetCondition();
            BindData();
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

        private void SetCondition()
        {
            string startDate = CtrlHelper.GetText(txtStartDate);
            string endDate = CtrlHelper.GetText(txtEndDate);
            string gameid= CtrlHelper.GetText(GameId);
            int uid = FacadeManage.aideAccountsFacade.GetAccountInfoByGameId(Convert.ToInt32(gameid)).UserID;
            if (gameid != "")
            {
                ViewState["SearchItems"] = $"WHERE  R.UserID={uid} AND R.CountTime BETWEEN '{startDate}' AND '{endDate}'";
            }
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