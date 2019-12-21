using System;
using Game.Web.UI;
using System.Text;
using Game.Kernel;
using Game.Facade;

namespace Game.Web.Module.TurntableManager
{
    public partial class TurntableCount : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 140;
            if (!IsPostBack)
            {
                AccountsDataBind();
            }
        }
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            AccountsDataBind();
        }
        protected void anpPage_PageChanged(object sender, EventArgs e)
        {
            AccountsDataBind();
        }
        protected void AccountsDataBind()
        {
            StringBuilder condition = new StringBuilder(" WHERE 1=1");
            string RSTime = txtStartDate.Text;
            string RETime = txtEndDate.Text;
            if (RSTime != "" && RETime != "")
            {
                condition.AppendFormat(" AND CountTime BETWEEN '{0}' AND '{1}' ", RSTime, RETime);
            }
            condition.AppendFormat(" AND TurnType ={0}", list1.SelectedValue);
            PagerSet pagerSet = FacadeManage.aideRecordFacade.GetList("RecordCountTurn", condition.ToString(), " ORDER BY CountTime DESC ", anpPage.CurrentPageIndex, anpPage.PageSize);
            anpPage.RecordCount = pagerSet.RecordCount;
            litNoData.Visible = pagerSet.RecordCount <= 0;
            rptDataList.Visible = pagerSet.RecordCount > 0;
            rptDataList.DataSource = pagerSet.PageSet;
            rptDataList.DataBind();
        }
        protected void ddlProductType_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Convert.ToInt32(list1.SelectedValue) < 2)
            {
                Redirect("TurntableRecord.aspx");
            }
            else
            {
                AccountsDataBind();
            }

        }
    }
}