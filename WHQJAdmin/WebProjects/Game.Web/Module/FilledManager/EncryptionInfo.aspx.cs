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
    public partial class EncryptionInfo : AdminPage
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
            if (IntParam > 0)
            {
                signtype mm = FacadeManage.aideTreasureFacade.GetSignById(IntParam);
                TxtName.Text = mm.name;
                TextBox2.Text = mm.keyName;
                SignArray.Text = mm.signArray;
                TextBox3.Text = mm.splicetype.ToString();
                TextBox1.Text = mm.joiner1;
                TextBox4.Text = mm.joiner2;
                TextBox5.Text = mm.type.ToString();
                TextBox6.Text = mm.updown.ToString();
                TextBox7.Text = mm.mapPos;
                TextBox8.Text = mm.cyphertext;
                TextBox9.Text = mm.cypType.ToString();
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            signtype mm = new signtype();
            if (IntParam > 0)
            {
                AuthUserOperationPermission(Permission.Edit);
                mm = FacadeManage.aideTreasureFacade.GetSignById(IntParam);
            }
            else
            {
                AuthUserOperationPermission(Permission.Add);
            }
            mm.keyName = TextBox2.Text;
            mm.name = TxtName.Text;
            mm.signArray = SignArray.Text;
            mm.splicetype = Convert.ToByte(TextBox3.Text);
            mm.joiner1 = TextBox1.Text;
            mm.joiner2 = TextBox4.Text;
            mm.type = Convert.ToByte(TextBox5.Text);
            mm.updown = Convert.ToByte(TextBox6.Text);
            mm.mapPos = TextBox7.Text;
            mm.cyphertext = TextBox8.Text;
            mm.cypType = Convert.ToByte(TextBox9.Text);

            int result = FacadeManage.aideTreasureFacade.SaveEncryption(mm);
            if (result > 0)
            {
                ShowInfo("配置信息操作成功", "EncryptionList.aspx", 1200);
            }
            else
            {
                ShowError("配置信息操作失败");
            }

        }

    }
}