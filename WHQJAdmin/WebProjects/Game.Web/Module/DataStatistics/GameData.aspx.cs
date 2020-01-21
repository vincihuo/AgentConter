using System;
using System.Data;
using Game.Facade;
using Game.Web.UI;
using System.Web.UI.WebControls;

namespace Game.Web.Module.DataStatistics
{
    public partial class GameData : AdminPage
    {
        private DataSet gameroom = Fetch.GetKindAndRoom();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                foreach (DataRow item in gameroom.Tables[0].Rows)
                {
                    DateTime time = DateTime.Now;
                    txtStartDate.Text = time.AddDays(-15).ToString("yyyy-MM-dd");
                    txtEndDate.Text = time.AddDays(-1).ToString("yyyy-MM-dd");
                    ddlGameType.Items.Add(new ListItem(item["KindName"].ToString(), item["KindID"].ToString()));
                }
            }
        }
    }
}