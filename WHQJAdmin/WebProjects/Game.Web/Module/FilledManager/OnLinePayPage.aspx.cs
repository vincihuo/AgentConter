using System;
using Game.Kernel;
using Game.Web.UI;
using Game.Facade;
using Game.Entity.Enum;
using Game.Entity.Treasure;

namespace Game.Web.Module.FilledManager
{
    public partial class OnLinePayPage : AdminPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 200;
            if (!IsPostBack)
            {
                BindData();
            }
        }
        private void BindData()
        {
            PagerSet pagerSet = FacadeManage.aideTreasureFacade.GetList(OnlinePayConfig.Tablename, "WHERE 1=1", "ORDER BY ID DESC", anpNews.CurrentPageIndex, anpNews.PageSize);
            anpNews.RecordCount = pagerSet.RecordCount;
            litNoData.Visible = pagerSet.PageSet.Tables[0].Rows.Count <= 0;
            rptDataList.DataSource = pagerSet.PageSet;
            rptDataList.DataBind();
        }
        protected void btnDelete_Click(object sender, EventArgs e)
        {
            //判断权限
            AuthUserOperationPermission(Permission.Delete);
            int result = FacadeManage.aideTreasureFacade.DeleteOnlinePayConfig(StrCIdList);
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


        protected string GetPayTypeName(int type)
        {
            switch (type)
            {
                case 1:
                    return "微信";
                case 2:
                    return "支付宝";
                case 3:
                    return "云闪付";
                case 4:
                    return "网银转账";
            }
            return "其他类型";
        }

        protected void anpNews_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }
    }
}