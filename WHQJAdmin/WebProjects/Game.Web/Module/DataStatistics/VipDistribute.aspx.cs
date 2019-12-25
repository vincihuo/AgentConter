using Game.Entity.Record;
using Game.Facade;
using Game.Utils;
using System;
using System.Text;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using Game.Web.UI;

namespace Game.Web.Module.DataStatistics
{
    public partial class VipDistribute : AdminPage
    {
        protected string person;
        protected string gjson;
        protected void Page_Load(object sender, EventArgs e)
        {
            DataSet ds = FacadeManage.aideTreasureFacade.GetVIPDistribute();
            IList<StatisticsWealth> list = DataHelper.ConvertDataTableToObjects<StatisticsWealth>(ds.Tables[0]);
            if (list != null)
            {
                JavaScriptSerializer js = new JavaScriptSerializer();
                gjson = js.Serialize(list);
            }
            person = ds.Tables[1].Rows[0]["AllPerson"].ToString();
        }
    }
}