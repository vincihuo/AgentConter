using System;
using Game.Web.UI;
using Game.Entity.Platform;
using Game.Facade;

namespace Game.Web.Module.VipManager
{
    public partial class VipConfigInfo : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 151;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }
        private void BindData()
        {
            VipConfig cfg = FacadeManage.aidePlatformFacade.GetVipConfigByLevel(IntParam);
            TextLevel.Text = cfg.VipLevel.ToString();
            TextBox2.Text = cfg.Integral.ToString();
            TextBox3.Text = cfg.Fresh.ToString();
            TextBox4.Text = cfg.Week.ToString();
            TextBox5.Text = cfg.Month.ToString();
            TextBox6.Text = cfg.Day1.ToString();
            TextBox7.Text = cfg.Day2.ToString();
            TextBox8.Text = cfg.Day3.ToString();
            TextBox9.Text = cfg.Day4.ToString();
            TextBox1.Text = cfg.Day5.ToString();
            TextBox10.Text = cfg.Day6.ToString();
            TextBox11.Text = cfg.Day7.ToString();
        }
        protected void btnSave_Click(object sender, EventArgs e)
        {
            VipConfig config = new VipConfig();
            config.VipLevel = IntParam;
            config.Integral = Convert.ToInt64(TextBox2.Text);
            config.Fresh = Convert.ToInt64(TextBox3.Text);
            config.Week = Convert.ToInt64(TextBox4.Text);
            config.Month = Convert.ToInt64(TextBox5.Text);
            config.Day1 = Convert.ToInt64(TextBox6.Text);
            config.Day2 = Convert.ToInt64(TextBox7.Text);
            config.Day3 = Convert.ToInt64(TextBox8.Text);
            config.Day4 = Convert.ToInt64(TextBox9.Text);
            config.Day5 = Convert.ToInt64(TextBox1.Text);
            config.Day6 = Convert.ToInt64(TextBox10.Text);
            config.Day7 = Convert.ToInt64(TextBox11.Text);
            int r = FacadeManage.aidePlatformFacade.SaveVipConfig(config);
        }
    }
}