using System;
using Game.Web.UI;
using Game.Facade;
using Game.Entity.Platform;
using System.Collections.Generic;

namespace Game.Web.Module.TurntableManager
{
    public partial class WebForm1 : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 140;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }
        protected void ddlProductType_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindData();
        }
        private void BindData()
        {
            int index = Convert.ToInt32(ddlProductType.SelectedValue);
            List<TurntableConfig> mm = new List<TurntableConfig>();
            IList<TurntableConfig> list= FacadeManage.aidePlatformFacade.GetTurntableConfigs();
            index *= 5;
            mm.Add(list[index]);
            mm.Add(list[index + 1]);
            mm.Add(list[index + 2]);
            mm.Add(list[index + 3]);
            mm.Add(list[index + 4]);
            TextBox1.Text = list[index].MenuVaule.ToString();
            TextBox2.Text = list[index + 2].MenuVaule.ToString();
            rptShareInfo.DataSource = mm;
            rptShareInfo.DataBind();
        }
        protected void btnSave_Pre(object sender, EventArgs e)
        {
            int pp= FacadeManage.aidePlatformFacade.SaveMenuValue(Convert.ToInt32(ddlProductType.SelectedValue) * 5 + 3, Convert.ToInt32(TextBox2.Text));
            if (pp > 0)
            {
                ShowInfo("修改成功");
            }
            else
            {
                ShowError("修改失败");
            }
        }
        protected void btnSave_Score(object sender, EventArgs e)
        {
            int pp= FacadeManage.aidePlatformFacade.SaveMenuValue(Convert.ToInt32(ddlProductType.SelectedValue) * 5+1, Convert.ToInt32(TextBox1.Text));
            if (pp > 0)
            {
                ShowInfo("修改成功");
            }
            else
            {
                ShowError("修改失败");
            }
        }
    }
}