using System;
using Game.Facade;
using Game.Web.UI;
using Game.Entity.Enum;
using Game.Entity.Platform;

namespace Game.Web.Module.MailManager
{
    public partial class MailAddPage :AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 1600;
            AuthUserOperationPermission(Permission.Edit);
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            int gold = 0;
            int diamo = 0;
            int valiBet = 0;
            if (!int.TryParse(txtGold.Text, out gold))
            {
                MessageBox("赠送金币格式不正确");
                return;
            }
            if (!int.TryParse(TextDimao.Text, out diamo))
            {
                MessageBox("赠送金币格式不正确");
                return;
            }
            if (!int.TryParse(txtVileBet.Text, out valiBet))
            {
                MessageBox("赠送金币格式不正确");
                return;
            }
            UserMail mail = new UserMail();
            mail.Title = TextTitle.Text;
            mail.MState = 0;
            mail.Msg = TextBox1.Text;
            mail.Valibet = valiBet;
            mail.GoldNum = gold;
            mail.DiamNum = diamo;
            mail.UserID = 0;
            if (Convert.ToInt32(txtGameID.Text)>0)
            {
                mail.UserID = FacadeManage.aideAccountsFacade.GetAccountInfoByGameId(Convert.ToInt32(txtGameID.Text)).UserID;
            }
            int res= FacadeManage.aidePlatformFacade.SendMail(mail);
            if (res == 1)
            {
                MessageBox("发送成功");
            }
        }
    }
}