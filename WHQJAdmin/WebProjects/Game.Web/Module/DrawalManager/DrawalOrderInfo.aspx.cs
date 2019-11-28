using System;
using Game.Web.UI;
using Game.Kernel;
using Game.Facade;
using Game.Entity.Treasure;
using Game.Entity.Accounts;

namespace Game.Web.Module.DrawalManager
{
    public partial class DrawalOrderInfo : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 1301;
            if (!IsPostBack)
            {
                OrderDabaBind();
            }
        }
        private void OrderDabaBind()
        {
            DrawalOrder order = FacadeManage.aideTreasureFacade.GetOrderById(StrParam);
            TxtOrderId.Text = order.OrderID;
            TxtAmount.Text = FacadeManage.ConversionMoneyToShow((long)order.Amount).ToString();
            TxtGameID.Text = order.GameID.ToString();
            TxtMasterID.Text = order.MasterID.ToString();
            TxtOrderCost.Text = FacadeManage.ConversionMoneyToShow((long)order.OrderCost).ToString();
            TxtCurrTime.Text = order.CurrentTime.ToString();
            TxtDealTime.Text = order.DealTime.ToString();
            IP.Text = order.IP;

            AccountsInfo info = FacadeManage.aideAccountsFacade.GetAccountInfoByUserId(order.UserID);
            Literal1.Text = info.AliAccount;
            Literal2.Text = info.BankAccount;
            Literal3.Text = FacadeManage.GetBankName(info.BankType);

            if (order.OrderState == 0)
            {
                TextState.Visible = false;
            }
            else
            {
                TextState.Text = order.OrderState == 1 ? "同意" : "拒绝";
                BtnN.Visible = BtnY.Visible = false;
            }
            TxtDrawalType.Text = order.drawalType == 1 ? "支付宝" : "银行卡";
        }

        protected void OnBtnY(object sender, EventArgs e)
        {
            SetOrderState(1);
        }
        protected void OnBtnN(object sender, EventArgs e)
        {
            SetOrderState(2);
        }

        private void SetOrderState(int s)
        {
            Message result= FacadeManage.aideTreasureFacade.DealDralwalOrder(StrParam, s,userExt.UserID, userExt.PreLoginIP);
            if (result.Success)
            {
                ShowInfo("操作成功", "DrawalOrderPage.aspx", 1200);
            }
            else
            {
                ShowError(result.Content);
            }
        }

        protected string GetStateStr(int state)
        {
            if (state == 1)
            {
                return "同意";
            }
            else if (state == 2)
            {
                return "拒绝";
            }
            return "未处理";
        }
    }



}