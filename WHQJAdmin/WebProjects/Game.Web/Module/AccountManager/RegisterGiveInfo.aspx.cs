using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Game.Web.UI;
using Game.Entity.NativeWeb;
using Game.Facade;
using Game.Utils;
using Game.Entity.Enum;
using Game.Entity.Accounts;

namespace Game.Web.Module.AccountManager
{
    public partial class RegisterGiveInfo : AdminPage
    {
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 105;
            if (!IsPostBack)
            {
                BindData();
            }
        }
        /// <summary>
        /// 数据保存
        /// </summary>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            RegisterGive quest = new RegisterGive()
            {
                ScoreCount = Convert.ToInt32(txtScoreCount.Text.Trim()),
                DiamondCount = Convert.ToInt32(txtDiamondCount.Text.Trim()),
                PlatformType = Convert.ToInt32(Dropplatform.SelectedValue.ToString())
            };

            if (IntParam > 0)
            {
                AuthUserOperationPermission(Permission.Edit);
                quest.ConfigID = IntParam;
            }
            else
            {
                AuthUserOperationPermission(Permission.Add);
                RegisterGive info= FacadeManage.aideAccountsFacade.GetRegisterGiveInfoByPlatformType(Convert.ToInt32(Dropplatform.SelectedValue.ToString()));
                if (info != null)
                {
                    ShowError("已存在平台注册");
                    return;
                }
            }
            quest.ScoreCount = Convert.ToInt32(txtScoreCount.Text.Trim())*1000;
            quest.DiamondCount = Convert.ToInt32(txtDiamondCount.Text.Trim());
            quest.PlatformType = Convert.ToInt32(Dropplatform.SelectedValue.ToString());

            int result = FacadeManage.aideAccountsFacade.SaveRegisterGiveInfo(quest);
            if (result > 0)
            {
                ShowInfo("注册赠送操作成功", "RegisterGiveList.aspx", 1000);
            }
            else
            {
                ShowError("注册赠送操作失败");
            }
        }
        /// <summary>
        /// 数据绑定
        /// </summary>
        protected void BindData()
        {
            if (IntParam > 0)
            {
                RegisterGive quest = FacadeManage.aideAccountsFacade.GetRegisterGiveInfo(IntParam);
                if (quest != null)
                {
                    CtrlHelper.SetText(txtScoreCount, FacadeManage.ConversionMoneyToShow(quest.ScoreCount.ToString()).ToString());
                    CtrlHelper.SetText(txtDiamondCount, quest.DiamondCount.ToString());
                    Dropplatform.SelectedValue = quest.PlatformType.ToString();
                }
            }
        }
    }
}