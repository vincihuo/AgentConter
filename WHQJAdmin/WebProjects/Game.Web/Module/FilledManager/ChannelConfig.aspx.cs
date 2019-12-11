using System;
using Game.Web.UI;
using Game.Entity.Treasure;
using Game.Facade;
using Game.Entity.Enum;
using System.Web.UI.WebControls;
using Game.Utils;
using System.Collections.Generic;

namespace Game.Web.Module.FilledManager
{
    public partial class ChannelConfig : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 204;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            DropDownList1.Items.Clear();
            DropDownList2.Items.Clear();
            DropDownList3.Items.Clear();
            IList<signtype> list = FacadeManage.aideTreasureFacade.GetSignList();
            if (list == null)
            {
                return;
            }
            for (int i = 0; i < list.Count; ++i)
            {
                DropDownList1.Items.Add(new ListItem(list[i].name, list[i].id.ToString()));
                DropDownList2.Items.Add(new ListItem(list[i].name, list[i].id.ToString()));
                DropDownList3.Items.Add(new ListItem(list[i].name, list[i].id.ToString()));
            }
            DropDownList1.SelectedValue = list[0].id.ToString();
            DropDownList2.SelectedValue = list[0].id.ToString();
            DropDownList3.SelectedValue = list[0].id.ToString();

            if (IntParam > 0)
            {
                pay_chanel chanel = FacadeManage.aideTreasureFacade.GetPay_ChanelsByID(IntParam);
                ddlProductType.SelectedValue = chanel.bankType.ToString();
                txtProductName.Text = chanel.name;
                Sendpamar.Text = chanel.sendpamar;
                TextBox2.Text = chanel.moneyPre.ToString();
                Singpos.Text = chanel.singpos;
                TextBox3.Text = chanel.method.ToString();
                RespSign.Text = chanel.respSign;
                RespCode.Text = chanel.respCode;
                SuccessCode.Text = chanel.successCode;
                InfoName.Text = chanel.infoName;
                InfoType.Text = chanel.infoType.ToString();
                Orderkey.Text = chanel.orderkey;
                Signkey.Text = chanel.signkey;
                Moneykey.Text = chanel.moneykey;
                Codekey.Text = chanel.codekey;
                CodeSuccess.Text = chanel.codeSuccess;
                Backstring.Text = chanel.backstring;

                DropDownList1.SelectedValue = chanel.sendSign.ToString();
                DropDownList2.SelectedValue = chanel.backSign.ToString();
                DropDownList3.SelectedValue = chanel.callSign.ToString();
            }
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            pay_chanel chanel = new pay_chanel();
            if (IntParam > 0)
            {
                if (!AuthUserOperationPermission(Permission.Edit))
                {
                    return;
                }
                chanel = FacadeManage.aideTreasureFacade.GetPay_ChanelsByID(IntParam);
            }
            else
            {
                if (!AuthUserOperationPermission(Permission.Add))
                {
                    return;
                }
            }
            chanel.sendpamar = Sendpamar.Text;
            chanel.moneyPre = Convert.ToInt32(TextBox2.Text);
            chanel.singpos = Singpos.Text;
            chanel.method = Convert.ToByte(TextBox3.Text);
            chanel.respCode = RespCode.Text;
            chanel.respSign = RespSign.Text;
            chanel.successCode = SuccessCode.Text;
            chanel.infoName = InfoName.Text;
            chanel.infoType = Convert.ToByte(InfoType.Text);
            chanel.orderkey = Orderkey.Text;
            chanel.signkey = Signkey.Text;
            chanel.moneykey = Moneykey.Text;
            chanel.codekey = Codekey.Text;
            chanel.codeSuccess = CodeSuccess.Text;
            chanel.backstring = Backstring.Text;
            chanel.sendSign = Convert.ToInt32(DropDownList1.SelectedValue);
            chanel.backSign = Convert.ToInt32(DropDownList2.SelectedValue);
            chanel.callSign = Convert.ToInt32(DropDownList3.SelectedValue);
            chanel.name = txtProductName.Text;
            chanel.bankType = Convert.ToByte(ddlProductType.SelectedValue);

            int result = FacadeManage.aideTreasureFacade.SavePayChanel(chanel);
            if (result > 0)
            {
                ShowInfo("配置信息操作成功", "ChanelPage.aspx", 1200);
            }
            else
            {
                ShowError("配置信息操作失败");
            }

        }
    }
}