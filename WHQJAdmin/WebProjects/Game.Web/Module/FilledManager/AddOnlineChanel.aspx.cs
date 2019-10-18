using System;

using Game.Web.UI;
using Game.Entity.Treasure;
using Game.Facade;
using Game.Entity.Enum;
using System.Web.UI.WebControls;
using Game.Utils;

namespace Game.Web.Module.FilledManager
{
    public partial class AddOnlineChanel : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 200;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            OnlinePayConfig config = new OnlinePayConfig();
            if (IntParam > 0)
            {
                AuthUserOperationPermission(Permission.Edit);
                config = FacadeManage.aideTreasureFacade.GetOnlinePayConfig(IntParam);
            }
            else
            {
                AuthUserOperationPermission(Permission.Add);
            }
            config.PayType = Convert.ToByte(ddlProductType.SelectedValue);
            config.PayName = CtrlHelper.GetText(txtProductName);
            config.UID= CtrlHelper.GetText(tetUID);
            config.Md5key = CtrlHelper.GetText(TexMd5);
            config.PublicKey = CtrlHelper.GetText(TxtPublicKey);
            config.PrivateKey= CtrlHelper.GetText(TxtPrivateKey);
            config.ShoutCut = CtrlHelper.GetText(txtPrice);
            config.PayIdentity = Convert.ToByte(DropDownList1.SelectedValue);
            config.SortID = Convert.ToInt32(SortID.Text);
            config.FristPresent = Convert.ToInt32(txtFristPresent.Text);
            config.PresentScore = Convert.ToInt32(txtPresentScore.Text);
            config.ChanelID = Convert.ToInt32(DropDownList2.SelectedValue);
            config.ChanelName = DropDownList2.SelectedItem.Text;
            config.AttaChStr = CtrlHelper.GetText(AttaBox);
            if (IntParam > 0)
            {
                config.ID = IntParam;
            }

            int result = FacadeManage.aideTreasureFacade.SaveOnlinePayConfig(config);
            if (result > 0)
            {
                ShowInfo("配置信息操作成功", "OnLinePayPage.aspx", 1200);
            }
            else
            {
                ShowError("配置信息操作失败");
            }
        }

        protected void ddlProductType_SelectedIndexChanged(object sender, EventArgs e)
        {
            ChangePayType(Convert.ToInt32(ddlProductType.SelectedValue));
        }

        private void ChangePayType(int typeid)
        {
            string s = "";
            switch (typeid)
            {
                case 0:
                    s = "微信";
                    break;
                case 1:
                    s = "支付宝";
                    break;
                case 2:
                    s = "云闪付";
                    break;
                case 3:
                    s = "网银转账";
                    break;
            }


            DropDownList2.Items.Clear();
            //搜索数据得到
            int t = typeid * 100;
            for (int i = 0; i < 6; ++i)
            {
                t += i;
                DropDownList2.Items.Add(new ListItem(s + i.ToString(), t.ToString()));
            }
            DropDownList2.SelectedValue = (typeid * 100).ToString();
        }


        private void BindData()
        {
            ChangePayType(Convert.ToInt32(ddlProductType.SelectedValue));
            if (IntParam > 0)
            {
                OnlinePayConfig config = FacadeManage.aideTreasureFacade.GetOnlinePayConfig(IntParam);
                if (config != null)
                {
                    ChangePayType(config.PayType);
                    ddlProductType.SelectedValue = config.PayType.ToString();
                    txtProductName.Text = config.PayName;
                    DropDownList2.SelectedValue = config.ChanelID.ToString();
                    tetUID.Text = config.UID;
                    TexMd5.Text = config.Md5key;
                    TxtPrivateKey.Text = config.PrivateKey;
                    TxtPublicKey.Text = config.PublicKey;
                    txtPrice.Text = config.ShoutCut;
                    DropDownList1.SelectedValue = config.PayIdentity.ToString();
                    txtFristPresent.Text = config.FristPresent.ToString();
                    txtPresentScore.Text = config.PresentScore.ToString();
                    SortID.Text = config.SortID.ToString();
                    AttaBox.Text = config.AttaChStr;
                }
            }
        }

    }
}