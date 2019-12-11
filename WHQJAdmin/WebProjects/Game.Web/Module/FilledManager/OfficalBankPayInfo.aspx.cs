using System;
using Game.Web.UI;
using Game.Entity.Treasure;
using Game.Facade;
using Game.Entity.Enum;


namespace Game.Web.Module.FilledManager
{
    public partial class OfficalBankPayInfo : AdminPage
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
                OfficalBankPay chanel = FacadeManage.aideTreasureFacade.GetBankPayById(IntParam);
                TxtName.Text = chanel.ConfigName;
                MerchantName.Text = chanel.MerchantName;
                BankName.Text = chanel.BankName;
                BankNumber.Text = chanel.BankNumber;
                BankAddr.Text = chanel.BankAddr;
                TexMax.Text = FacadeManage.ConversionMoneyToShow(chanel.MaxAmount.ToString()).ToString();
                TexMin.Text = FacadeManage.ConversionMoneyToShow(chanel.MinAmount.ToString()).ToString();
                TexDescription.Text = chanel.Description;
                TexSort.Text = chanel.SortId.ToString();
                ckbLock.Checked = chanel.Nullity == 1;
            }
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            OfficalBankPay chanel = new OfficalBankPay();
            if (IntParam > 0)
            {
                if (!AuthUserOperationPermission(Permission.Edit))
                {
                    return;
                }
                chanel = FacadeManage.aideTreasureFacade.GetBankPayById(IntParam);
            }
            else
            {
                if (!AuthUserOperationPermission(Permission.Add))
                {
                    return;
                }
            }
            chanel.ConfigName = TxtName.Text;
            chanel.MerchantName = MerchantName.Text;
            chanel.BankNumber = BankNumber.Text;
            chanel.BankAddr = BankAddr.Text;
            chanel.BankName = BankName.Text;
            chanel.MinAmount = FacadeManage.ConversionMoneyToReal(Convert.ToInt32(TexMin.Text));
            chanel.MaxAmount = FacadeManage.ConversionMoneyToReal(Convert.ToInt32(TexMax.Text));
            chanel.Description = TexDescription.Text;
            chanel.SortId = Convert.ToInt32(TexSort.Text);
            chanel.Nullity = (byte)(ckbLock.Checked ? 1 : 0);
            int result = FacadeManage.aideTreasureFacade.SaveBankPay(chanel);
            if (result > 0)
            {
                ShowInfo("配置信息操作成功", "OfficalBankPayList.aspx", 1200);
            }
            else
            {
                ShowError("配置信息操作失败");
            }
        }

    }
}