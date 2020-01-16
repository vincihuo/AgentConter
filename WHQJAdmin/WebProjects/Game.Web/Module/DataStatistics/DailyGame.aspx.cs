using System;
using Game.Web.UI;
using System.Data;
using Game.Facade;
using Game.Utils;

namespace Game.Web.Module.DataStatistics
{
    public partial class DailyGame : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
            }
        }
    }
}