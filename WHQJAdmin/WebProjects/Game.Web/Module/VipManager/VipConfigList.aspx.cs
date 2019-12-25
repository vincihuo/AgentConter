using System;
using Game.Web.UI;
using System.Collections.Generic;
using Game.Entity.Platform;
using Game.Facade;

namespace Game.Web.Module.VipManager
{
    public partial class VipConfigList : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 150;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }
        private void BindData()
        {
            rptShareInfo.DataSource = FacadeManage.aidePlatformFacade.GetVipConfigList();
            rptShareInfo.DataBind();
        }
    }
}