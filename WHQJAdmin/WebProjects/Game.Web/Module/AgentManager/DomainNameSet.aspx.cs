using System;
using Game.Facade;
using Game.Web.UI;
using Game.Entity.Enum;
using Game.Entity.Platform;
using Game.Entity.Accounts;
using System.Web.Script.Serialization;
using Game.Utils;
using System.Collections.Generic;

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

                if (domainName.AgentId>0)
                {
                    AccountsInfo acc = FacadeManage.aideAccountsFacade.GetAccountInfoByUserId(domainName.AgentId);
                    if (acc != null)
                    {
                        TextSign.Text = acc.GameID.ToString();
                    }
                }
                TextSign.Visible = domainName.Type == 3;
                LableHit.Visible = domainName.Type == 1;
                DropDownListState.SelectedValue = domainName.State.ToString();
                DropDownListState.Visible = LableHit.Visible = domainName.Type != 1;
                ddlProductType.Enabled = false;
            }
        }

        protected void ddlProductType_SelectedIndexChanged(object sender, EventArgs e)
        {
            TextSign.Visible = ddlProductType.SelectedValue == "3";

        }


        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!AuthUserOperationPermission(Permission.Edit))
            {
                return;
            }
            if (FacadeManage.aidePlatformFacade.CheckUrl(IntParam, TextBoxUrl.Text))
            {
                MessageBox("域名已经被使用");
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
                    MessageBox("游戏id不存在");
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
                uri = ApplicationSettings.Get("AddUri") + "dl_domain/" + ApplicationSettings.Get("SitTag");
                parma = "{\"dl_domain\":\"" + domainName.Url + "\"}";
            }
            else
            {
                uri = ApplicationSettings.Get("AddUri") + "pm_domain/" + ApplicationSettings.Get("SitTag");
                string mm = domainName.Url.Replace("https://", "").Replace("http://", "");
                parma = "{\"pm_domain\":\"" + mm + "\"}";

                //if (domainName.State == 1)
                //{
                //    uri = ApplicationSettings.Get("AddUri") + "pm_domain/" + ApplicationSettings.Get("SitTag");
                //    string mm = domainName.Url.Replace("https://", "").Replace("http://", "");
                //    parma = "{\"pm_domain\":\"" + mm + "\"}";
                //}
                //else
                //{
                //    uri = ApplicationSettings.Get("AddUri") + "del_domain/" + domainName.Url.Replace("https://", "").Replace("http://", "");
                //}
            }

            string rs = FacadeManage.RequestUri(uri, parma);
            if (rs == "")
            {
                MessageBox("配置失败成功");
                return;
            }
            object obj1 = new JavaScriptSerializer().DeserializeObject(rs);
            Dictionary<string, object> json1 = (Dictionary<string, object>)obj1;
            if (json1["success"].ToString() != "True")
            {
                MessageBox("配置失败成功");
                return;
            }

            if (domainName.Type == 1 && domainName.State == 1)
            {
                FacadeManage.aidePlatformFacade.OffDownloadURL();
            }
            int pp = FacadeManage.aidePlatformFacade.SaveDomain(domainName);
            if (pp > 0)
            {
                MessageBox("配置信息操作成功");
            }
            else
            {
                MessageBox("域名生效但是存入失败");
            }
        }
    }
}