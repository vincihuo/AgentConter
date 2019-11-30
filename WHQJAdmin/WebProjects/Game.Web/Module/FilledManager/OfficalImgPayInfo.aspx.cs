using System;
using Game.Web.UI;
using Game.Entity.Treasure;
using Game.Facade;
using Game.Entity.Enum;

namespace Game.Web.Module.FilledManager
{
    public partial class OfficalImgPayInfo : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 200;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            if (IntParam > 0)
            {
                OfficalImgPay chanel = FacadeManage.aideTreasureFacade.GetImgPayById(IntParam);
                TxtName.Text = chanel.ConfigName;
                ddlProductType.SelectedValue = chanel.PayType.ToString();
                PayUrl.Text = chanel.PayUrl;
                TexMax.Text = FacadeManage.ConversionMoneyToShow(chanel.MaxAmount).ToString();
                TexMin.Text = FacadeManage.ConversionMoneyToShow(chanel.MinAmount).ToString();
                TexDescription.Text = chanel.Description;
                TexSort.Text = chanel.SortId.ToString();
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            OfficalImgPay chanel = new OfficalImgPay();
            if (IntParam > 0)
            {
                AuthUserOperationPermission(Permission.Edit);
                chanel = FacadeManage.aideTreasureFacade.GetImgPayById(IntParam);
            }
            else
            {
                AuthUserOperationPermission(Permission.Add);
            }
            chanel.ConfigName = TxtName.Text;
            chanel.PayType = Convert.ToByte(ddlProductType.SelectedValue);
            chanel.PayUrl = PayUrl.Text;
            chanel.MinAmount = FacadeManage.ConversionMoneyToReal(Convert.ToInt32(TexMin.Text));
            chanel.MaxAmount = FacadeManage.ConversionMoneyToReal(Convert.ToInt32(TexMax.Text));
            chanel.Description = TexDescription.Text;
            chanel.SortId = Convert.ToInt32(TexSort.Text);
            int result = FacadeManage.aideTreasureFacade.SaveImgPay(chanel);
            if (result > 0)
            {
                ShowInfo("配置信息操作成功", "OfficalImgPayList.aspx", 1200);
            }
            else
            {
                ShowError("配置信息操作失败");
            }
        }

    }
}