using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Game.Web.UI;
using Game.Utils;
using Game.Facade;
using Game.Kernel;
using System.Collections;
using System.Text;
using Game.Entity.Enum;
using Game.Entity.Platform;
using Game.Entity.NativeWeb;

namespace Game.Web.Module.AppManager
{
    public partial class ShareConfigInfo : AdminPage
    {
        #region 窗口事件

        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 308;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            //判断权限
            if (!AuthUserOperationPermission(Permission.Edit))
            {
                return;
            }

            ShareConfig Config = new ShareConfig();
            Config.ID = IntParam;
            Config.DayShareLmt = CtrlHelper.GetInt(txtDayShareLmt, 0);
            Config.TimeShareGold = (int)FacadeManage.ConversionMoneyToReal(CtrlHelper.GetInt(txtTimeShareGold, 0));
            Config.TimeShareDiamond = CtrlHelper.GetInt(txtTimeShareDiamond, 0);
            Config.Nullity = Convert.ToByte(ddlSate.SelectedValue);
            int result = FacadeManage.aideNativeWebFacade.UpdateShareConfig(Config);
            if (result > 0)
            {
                ShowInfo("更新成功", "ShareConfigList.aspx", 500);
            }
            else
            {
                ShowError("更新失败");
            }
        }
        #endregion

        #region 数据加载

        private void BindData()
        {
            if (IntParam <= 0)
                return;
            ShareConfig Config = FacadeManage.aideNativeWebFacade.GetShareConfig(IntParam);
            if (Config == null)
                return;
            CtrlHelper.SetText(txtDayShareLmt, Config.DayShareLmt.ToString());
            CtrlHelper.SetText(txtTimeShareGold, FacadeManage.ConversionMoneyToShow(Config.TimeShareGold).ToString());
            CtrlHelper.SetText(txtTimeShareDiamond, Config.TimeShareDiamond.ToString());
            ddlSate.SelectedValue = Config.Nullity.ToString();
        }
       
       
        #endregion
    }
}