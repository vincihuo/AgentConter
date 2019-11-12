using System;
using Game.Web.UI;
using Game.Facade;
using Game.Kernel;

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
            if(!IsPostBack)
            {
                BindData();
            }
        }
        protected void anpPage_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }
        /// <summary>
        /// 数据绑定
        /// </summary>
        private void BindData()
        {
            // anpPage.CurrentPageIndex, anpPage.PageSize
            PagerSet pagerSet = FacadeManage.aideRecordFacade.GetList("AgentCountRecord", $" WHERE  UserID={IntParam} ", " ORDER BY CountTime DESC ", anpPage.CurrentPageIndex, anpPage.PageSize);
            anpPage.RecordCount = pagerSet.RecordCount;
            rptDataList.DataSource = pagerSet.PageSet.Tables[0];
            rptDataList.DataBind();
        }
    }
}