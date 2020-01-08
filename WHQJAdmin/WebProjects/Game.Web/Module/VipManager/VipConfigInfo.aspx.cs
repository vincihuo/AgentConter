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
            config.Fresh = Convert.ToDecimal(TextBox3.Text);
            config.Week = Convert.ToDecimal(TextBox4.Text);
            config.Month = Convert.ToDecimal(TextBox5.Text);
            config.Day1 = Convert.ToDecimal(TextBox6.Text);
            config.Day2 = Convert.ToDecimal(TextBox7.Text);
            config.Day3 = Convert.ToDecimal(TextBox8.Text);
            config.Day4 = Convert.ToDecimal(TextBox9.Text);
            config.Day5 = Convert.ToDecimal(TextBox1.Text);
            config.Day6 = Convert.ToDecimal(TextBox10.Text);
            config.Day7 = Convert.ToDecimal(TextBox11.Text);
            int r = FacadeManage.aidePlatformFacade.SaveVipConfig(config);
            if (r > 0)
            {
                ShowInfo("配置信息操作成功", "VipConfigList.aspx", 1200);
            }
            else
            {
                ShowError("配置信息操作失败");
            }
        }
    }
}