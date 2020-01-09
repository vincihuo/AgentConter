using System;
using Game.Facade;
using Game.Web.UI;
using Game.Entity.Enum;
using Game.Entity.Platform;
using Game.Entity.Accounts;
using System.Web.Script.Serialization;
using Game.Utils;

namespace Game.Web.Module.AgentManager
{
    public partial class DomainNameSet : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 102;

            if (!Page.IsPostBack)
            {
                BindData();
            }
        }
        protected void BindData()
        {
            DomainName domainName = new DomainName();
            TextSign.Visible = false;
            if (IntParam > 0)
            {
                domainName = FacadeManage.aidePlatformFacade.GetDomainById(IntParam);
                ddlProductType.SelectedValue = domainName.Type.ToString();
                TextBoxUrl.Text = domainName.Url;
                TextSign.Visible = domainName.Type == 3;
                LableHit.Visible = domainName.Type == 1;
                DropDownListState.SelectedValue = domainName.State.ToString();
            }

        }

        protected void ddlProductType_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextSign.Visible = ddlProductType.SelectedValue == "3";
            LableHit.Visible = ddlProductType.SelectedValue == "1";
        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!AuthUserOperationPermission(Permission.Edit))
            {
                return;
            }
            DomainName domainName = new DomainName();
            domainName.Type = Convert.ToByte(ddlProductType.SelectedValue);
            domainName.Url = TextBoxUrl.Text;
            domainName.AgentId = 0;
            if (ddlProductType.SelectedValue == "3")
            {
                int GameId = Convert.ToInt32(TextSign.Text);
                AccountsInfo acc = FacadeManage.aideAccountsFacade.GetAccountInfoByGameId(GameId);
                if (acc == null)
                {
                    ShowError("游戏id不存在");
                    return;
                }
                domainName.AgentId = acc.UserID;
            }
            domainName.State = Convert.ToByte(DropDownListState.SelectedValue);
            domainName.Mode = 0;
            domainName.id = IntParam;

            string uri = "";
            string parma = "";
            if (ddlProductType.SelectedValue == "1")
            {
                uri = ApplicationSettings.Get("AddUri")+ "/dl_domain/hn8";
                //parma = "dl_domain=" + System.Web.HttpUtility.UrlEncode(domainName.Url);

                parma = "{\"dl_domain\":\"http://zhizhang1.com\"}";
            }
            else
            {
                if (domainName.State == 1)
                {
                    uri = ApplicationSettings.Get("AddUri") + "/pm_domain/hn8";
                    string mm = domainName.Url.Replace("https://", "").Replace("http://", "");
                    parma = "pm_domin=" + System.Web.HttpUtility.UrlEncode(mm);
                }
                else
                {
                    uri = ApplicationSettings.Get("AddUri") + "/del_domain/"+ domainName.Url.Replace("https://", "").Replace("http://", "");
                }
            }
            string rs = FacadeManage.RequestUri(uri, parma);
            if (rs == "")
            {
                ShowError("配置请求失败");
                return;
            }
            object obj = new JavaScriptSerializer().DeserializeObject(rs);
            if (obj.GetType().GetProperties()[0].GetValue(obj, null).ToString() != "true")
            {
                ShowError("配置请求失败");
                return;
            }

            if (domainName.Type == 1 && domainName.State == 1)
            {
                FacadeManage.aidePlatformFacade.OffDownloadURL();
            }
            int pp = FacadeManage.aidePlatformFacade.SaveDomain(domainName);
            if (pp > 0)
            {
                ShowInfo("配置信息操作成功", "DomainNameList.aspx", 1200);
            }
            else
            {
                ShowError("配置失败");
            }
        }
    }
}