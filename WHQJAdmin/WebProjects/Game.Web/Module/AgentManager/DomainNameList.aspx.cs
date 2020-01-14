using System;
using System.Web.UI.WebControls;
using Game.Web.UI;
using Game.Kernel;
using Game.Facade;
using Game.Entity.Platform;
using System.Web.Script.Serialization;
using Game.Utils;
using System.Collections.Generic;
using Game.Entity.Accounts;

namespace Game.Web.Module.AgentManager
{
    public partial class DomainNameList : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 1002;
            if (!IsPostBack)
            {
                DateBind();
            }
        }
        private void DateBind()
        {
            PagerSet pagerSet = FacadeManage.aidePlatformFacade.GetList(DomainName.Tablename," WHERE 1=1 ", " ORDER BY id ", anpPage.CurrentPageIndex, anpPage.PageSize);
            anpPage.RecordCount = pagerSet.RecordCount;
            if (pagerSet.RecordCount > 0)
            {
                rptDataList.DataSource = pagerSet.PageSet;
                rptDataList.DataBind();
            }
            litNoData.Visible = pagerSet.RecordCount <= 0;
            rptDataList.Visible = pagerSet.RecordCount > 0;
        }
        protected void anpPage_PageChanged(object sender, EventArgs e)
        {
            DateBind();
        }
        protected string SetDelete(byte t,string url)
        {
            if (t == 1)
            {
                return "return confirm('删除下载域名"+url+"(删除后关联的推广将无法再访问！请谨慎操作)')";

            }
            return "return confirm('删除推广域名" + url + "(删除后关联的推广将无法再访问！请谨慎操作)')";
        }
        protected string SetOff(byte t,byte s, string url)
        {
            string name = "推广域名";
            string state = "启用";
            string hit = "";
            if (t == 1)
            {
                name = "下载域名";
            }
            if (s == 1)
            {
                state = "禁用";
                if (t == 1)
                {
                    hit = "(禁用期间原域名关联推广将跳转到其他启用的下载域名)";
                }
            }
            else
            {
                if (t == 1)
                {
                    hit = "(下载域名只能同时启用一个，启用新的下载域名将禁用其他下载域名)";
                }
            }
            return "return confirm('"+ state +name+ url+hit+"')";
        }

        protected string GetAgent(int id)
        {
            AccountsInfo info = FacadeManage.aideAccountsFacade.GetAccountInfoByUserId(id);
            if (info != null)
            {
                return info.GameID.ToString();
            }
            return "所有人";
        }

        protected void OffUrl(object sender, EventArgs e)
        {
            int parma = Convert.ToInt32(((LinkButton)sender).CommandArgument);
            int id = parma / 10;
            int state = parma % 10;
            DomainName dm = FacadeManage.aidePlatformFacade.GetDomainById(id);

            string uri = "";
            string sparma = "";
          
        
            if (dm.Type == 1)
            {
                if (state==1)
                {
                    ShowError("下载域名不能禁用");
                    return;
                }

                FacadeManage.aidePlatformFacade.OffDownloadURL();
                uri = ApplicationSettings.Get("AddUri") + "dl_domain/"+ApplicationSettings.Get("SitTag");
                sparma = "{\"dl_domain\":\"" + dm.Url + "\"}";
            }
            else
            {
                if (state != 1)
                {
                    uri = ApplicationSettings.Get("AddUri") + "pm_domain/"+ ApplicationSettings.Get("SitTag");
                    string mm = dm.Url.Replace("https://", "").Replace("http://", "");
                    sparma = "{\"pm_domain\":\"" + mm + "\"}";
                }
                else
                {
                    uri = ApplicationSettings.Get("AddUri") + "del_domain/" + dm.Url.Replace("https://", "").Replace("http://", "");
                }
            }
            string mode = "POST";
            if (state == 1)
            {
                mode = "DELETE";
            }
            string rs = FacadeManage.RequestUri(uri, sparma, mode);
            if (rs == "")
            {
                ShowError("配置请求失败");
                return;
            }
            object obj = new JavaScriptSerializer().DeserializeObject(rs);
            Dictionary<string, object> json = (Dictionary<string, object>)obj;
            if (json["success"].ToString() != "True")
            {
                ShowError("配置请求失败");
                return;
            }

            FacadeManage.aidePlatformFacade.SetDomaState(id,state==0?1:0);
            ShowInfo("修改成功", "DomainNameList.aspx", 1200);
        }

        protected void DeleteUrl(object sender, EventArgs e)
        {
            string id = ((LinkButton)sender).CommandArgument;
            DomainName dm = FacadeManage.aidePlatformFacade.GetDomainById(Convert.ToInt32(id));
            

          
            if (dm.Type == 1&&dm.State==1)
            {
                ShowError("使用当中的下载域名不能禁用");
                return;
            }
            else if(dm.Type != 1)
            {
                string uri = ApplicationSettings.Get("AddUri") + "/del_domain/" + dm.Url.Replace("https://", "").Replace("http://", "");
                string rs = FacadeManage.RequestUri(uri, "", "DELETE");
                if (rs == "")
                {
                    ShowError("配置请求失败");
                    return;
                }
                object obj = new JavaScriptSerializer().DeserializeObject(rs);
                Dictionary<string, object> json = (Dictionary<string, object>)obj;
                if (json["success"].ToString() != "True")
                {
                    ShowError("配置请求失败");
                    return;
                }
            }
            int r = FacadeManage.aidePlatformFacade.DeleteUrl(Convert.ToInt32(id));
            if (r > 0)
            {
                ShowInfo("删除成功", "DomainNameList.aspx",1200);
            }
            
        }
        protected string GetUrlTyep(byte t)
        {
            switch (t)
            {
                case 1:
                    return "下载域名";
                case 2:
                    return "推广域名";
                case 3:
                    return "专属推广域名";
            }
            return "未知类型";
        }
        protected string GetState(byte t)
        {
            if (t == 0)
            {
                return "启用";
            }
            return "禁用";
        }
    }
}