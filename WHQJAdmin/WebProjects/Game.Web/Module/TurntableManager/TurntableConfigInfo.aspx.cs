using System;
using System.Collections.Generic;
using Game.Web.UI;
using Game.Entity.Platform;
using Game.Facade;

namespace Game.Web.Module.TurntableManager
{
    public partial class TurntableConfigInfo : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 141;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }
        protected void BindData()
        {
            TurntableConfig cfg = FacadeManage.aidePlatformFacade.GetTurntableConfigByid(IntParam);
            TextBox1.Text = cfg.Value1.ToString();
            TextBox2.Text = cfg.Value2.ToString();
            TextBox3.Text = cfg.Value3.ToString();
            TextBox4.Text = cfg.Value4.ToString();
            TextBox5.Text = cfg.Value5.ToString();
            TextBox6.Text = cfg.Value6.ToString();
            TextBox7.Text = cfg.Value7.ToString();
            TextBox8.Text = cfg.Value8.ToString();
            TextBox9.Text = cfg.Value9.ToString();
            TextBox10.Text = cfg.Value10.ToString();
            TextBox11.Text = cfg.Value11.ToString();
            TextBox12.Text = cfg.Value12.ToString();
            TextBox13.Text = cfg.Value13.ToString();
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            TurntableConfig cfg = new TurntableConfig();
            cfg.Value1 = Convert.ToDecimal(TextBox1.Text);
            cfg.Value2 = Convert.ToDecimal(TextBox2.Text);
            cfg.Value3 = Convert.ToDecimal(TextBox3.Text);
            cfg.Value4 = Convert.ToDecimal(TextBox4.Text);
            cfg.Value5 = Convert.ToDecimal(TextBox5.Text);
            cfg.Value6 = Convert.ToDecimal(TextBox6.Text);
            cfg.Value7 = Convert.ToDecimal(TextBox7.Text);
            cfg.Value8 = Convert.ToDecimal(TextBox8.Text);
            cfg.Value9 = Convert.ToDecimal(TextBox9.Text);
            cfg.Value10 = Convert.ToDecimal(TextBox10.Text);
            cfg.Value11 = Convert.ToDecimal(TextBox11.Text);
            cfg.Value12 = Convert.ToDecimal(TextBox12.Text);
            cfg.Value13 = Convert.ToDecimal(TextBox13.Text);
            cfg.id = IntParam;
            int mm= FacadeManage.aidePlatformFacade.SaveTurnTable(cfg);
            if (mm > 0)
            {
                ShowInfo("配置信息操作成功", "TurntableConfig.aspx", 1200);
            }
            else
            {
                ShowError("配置信息操作失败");
            }
        }
    }
}