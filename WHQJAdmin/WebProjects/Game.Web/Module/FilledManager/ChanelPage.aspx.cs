using System;
using Game.Web.UI;
using System.Text;
using Game.Kernel;
using Game.Utils;
using Game.Facade;
using Game.Entity.Treasure;
using Game.Entity.Enum;


namespace Game.Web.Module.FilledManager
{
    public partial class ChanelPage : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 200;
            if (!Page.IsPostBack)
            {
                BindData();
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            //判断权限
            AuthUserOperationPermission(Permission.Delete);
            int result = FacadeManage.aideTreasureFacade.DeletePayChanel(StrCIdList);
            if (result > 0)
            {
                ShowInfo("删除成功");
                BindData();
            }
            else
            {
                ShowInfo("删除失败");
            }
        }

        private void BindData()
        {
            PagerSet pagerSet = FacadeManage.aideTreasureFacade.GetList(pay_chanel.Tablename, SearchItems, "ORDER BY id DESC", anpNews.CurrentPageIndex, anpNews.PageSize);
            anpNews.RecordCount = pagerSet.RecordCount;
            litNoData.Visible = pagerSet.PageSet.Tables[0].Rows.Count <= 0;
            rptDataList.DataSource = pagerSet.PageSet;
            rptDataList.DataBind();
        }
        protected void anpNews_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }

        protected void btnQuery_Click(object sender, EventArgs e)
        {
            SetCondition();
            BindData();
        }

        private void SetCondition()
        {
            int service = int.Parse(ddlGlobalShareInfo.SelectedValue);
            StringBuilder condition = new StringBuilder("WHERE 1=1");
            if (service > 0)
            {
                condition.AppendFormat(" AND bankType={0} ", service);
            }
            ViewState["SearchItems"] = condition.ToString();
        }

        public string SearchItems
        {
            get
            {
                if (ViewState["SearchItems"] == null)
                {
                    ViewState["SearchItems"] = "WHERE 1=1";
                }
                return (string)ViewState["SearchItems"];
            }
            set
            {
                ViewState["SearchItems"] = value;
            }
        }

        protected string getTypeStr(int type)
        {
            switch (type)
            {
                case 1:
                    return "微信";
                case 2:
                    return "支付宝";
                case 3:
                    return "云闪付";
                default:
                    return "未知类型";
            }
        }
    }
}