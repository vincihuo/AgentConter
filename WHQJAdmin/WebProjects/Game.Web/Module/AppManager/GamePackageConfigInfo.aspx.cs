using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Game.Web.UI;
using Game.Utils;
using Game.Entity.Treasure;
using Game.Facade;
using System.Data;
using Game.Kernel;
using Game.Entity.Enum;
using Game.Entity.Platform;

namespace Game.Web.Module.AppManager
{
    public partial class GamePackageConfigInfo : AdminPage
    {
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 307;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }
        /// <summary>
        /// 数据保存
        /// </summary>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            GamePackage config = new GamePackage();
            if (IntParam > 0)
            {
                AuthUserOperationPermission(Permission.Edit);
                config = FacadeManage.aidePlatformFacade.GetGamePackage(IntParam);
            }
           

            config.Name = CtrlHelper.GetText(txtName);
            config.TypeID = Convert.ToByte(ddlTypeID.SelectedValue);
            config.SortID = CtrlHelper.GetInt(txtSortID, 0);
            config.Describe = CtrlHelper.GetText(txtDescribe);
            config.Nullity = Convert.ToByte(rblNullity.SelectedValue);
            config.PlatformKind = Convert.ToInt32(Dropplatform.SelectedValue);

            int result = IntParam > 0 ? FacadeManage.aidePlatformFacade.UpdateGamePackage(config) : FacadeManage.aidePlatformFacade.InsertGamePackage(config);
            if (result > 0)
            {
                ShowInfo("操作成功", "GamePackageConfigList.aspx", 1200);
            }
            else
            {
                ShowError("操作失败");
            }
        }
        /// <summary>
        /// 数据绑定
        /// </summary>
        private void BindData()
        {
            if (IntParam > 0)
            {
                GamePackage config = FacadeManage.aidePlatformFacade.GetGamePackage(IntParam);
                if (config != null)
                {
                    CtrlHelper.SetText(txtName, config.Name.ToString());
                    CtrlHelper.SetText(txtSortID, config.SortID.ToString());
                    CtrlHelper.SetText(txtDescribe, config.Describe.ToString());
                    ddlTypeID.SelectedValue = config.TypeID.ToString();
                    rblNullity.SelectedValue = config.Nullity.ToString();
                    Dropplatform.SelectedValue = config.PlatformKind.ToString();
                }
            }
        }
    }
}