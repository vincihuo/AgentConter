using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Game.Utils;
using Game.Kernel;
using Game.Facade;
using Game.Entity.Accounts;

namespace Game.Web.Spread
{
    public partial class TestRegister : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string gameid = GameRequest.GetQueryString("g");
            if (string.IsNullOrEmpty(gameid))
            {
                Response.Write("未填写推广人信息");
                return;
            }

            UserInfo info = new UserInfo();
            Random r = new Random();
            string name = "wp" + r.Next(1, 500000);
            info.Accounts = name;
            info.NickName = name;
            info.LogonPass = Utility.MD5("123456").ToUpper();
            info.InsurePass = Utility.MD5("123456").ToUpper();
            info.DynamicPass = Utility.MD5("123456").ToUpper();
            info.Compellation = "";
            info.PassPortID = "";
            info.FaceID = 1;
            info.Gender = 0;
            info.RegisterIP = "172.0.0.2";
            Message msg = FacadeManage.aideAccountsFacade.Register(info, gameid);
            if (msg.Success)
            {
                Response.Write("注册成功！");
            }
            else
            {
                Response.Write(msg.Content);
            }
        }
    }
}