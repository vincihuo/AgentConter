﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using Game.Web.UI;
using Game.Kernel;
using System.Text;
using Game.Utils;
using Game.Entity.Accounts;
using Game.Facade;
using Game.Entity.Record;
using System.Data;

namespace Game.Web.Module.AccountManager
{
    public partial class RecordGrantDiamondList : AdminPage
    {
        private DataSet masteruser = FacadeManage.aidePlatformManagerFacade.GetBaseUsersList();

        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 102;
            if (!IsPostBack)
            {
                txtStartDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                txtEndDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                BindData();
            }
        }
        /// <summary>
        /// 数据分页
        /// </summary>
        protected void anpPage_PageChanged(object sender, EventArgs e)
        {
            BindData();
        }
        /// <summary>
        /// 数据查询
        /// </summary>   
        protected void btnQuery1_Click(object sender, EventArgs e)
        {
            BindData();
        }
        /// <summary>
        /// 时间查询
        /// </summary>
        protected void btnQuery_Click(object sender, EventArgs e)
        {
            BindData();
        }
        // <summary>
        /// 查询今天
        /// </summary>
        protected void btnQueryTD_Click(object sender, EventArgs e)
        {
            string startDate = Fetch.GetTodayTime().Split('$')[0].ToString();
            string endDate = Fetch.GetTodayTime().Split('$')[1].ToString();

            CtrlHelper.SetText(txtStartDate, Convert.ToDateTime(startDate).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate, Convert.ToDateTime(endDate).ToString("yyyy-MM-dd"));

            BindData();
        }
        /// <summary>
        /// 查询昨天
        /// </summary>
        protected void btnQueryYD_Click(object sender, EventArgs e)
        {
            string startDate = Fetch.GetYesterdayTime().Split('$')[0].ToString();
            string endDate = Fetch.GetYesterdayTime().Split('$')[1].ToString();

            CtrlHelper.SetText(txtStartDate, Convert.ToDateTime(startDate).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate, Convert.ToDateTime(endDate).ToString("yyyy-MM-dd"));

            BindData();
        }
        /// <summary>
        /// 查询本周
        /// </summary>
        protected void btnQueryTW_Click(object sender, EventArgs e)
        {
            string startDate = Fetch.GetWeekTime().Split('$')[0].ToString();
            string endDate = Fetch.GetWeekTime().Split('$')[1].ToString();

            CtrlHelper.SetText(txtStartDate, Convert.ToDateTime(startDate).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate, Convert.ToDateTime(endDate).ToString("yyyy-MM-dd"));

            BindData();
        }
        /// <summary>
        /// 查询上周
        /// </summary>
        protected void btnQueryYW_Click(object sender, EventArgs e)
        {
            string startDate = Fetch.GetLastWeekTime().Split('$')[0].ToString();
            string endDate = Fetch.GetLastWeekTime().Split('$')[1].ToString();

            CtrlHelper.SetText(txtStartDate, Convert.ToDateTime(startDate).ToString("yyyy-MM-dd"));
            CtrlHelper.SetText(txtEndDate, Convert.ToDateTime(endDate).ToString("yyyy-MM-dd"));

            BindData();
        }
        /// <summary>
        /// 获取用户信息
        /// </summary>
        /// <param name="userid"></param>
        /// <returns></returns>
        public string GetAccountsInfo(int userid)
        {
            UserInfo info = FacadeManage.aideAccountsFacade.GetUserInfo(userid);
            if (info != null)
            {
                return string.Format("<td>{0}</td><td>{1}</td>", info.GameID, info.NickName);
            }
            return "<td></td><td></td>";
        }
        /// <summary>
        /// 获取管理员名称
        /// </summary>
        /// <param name="masterid"></param>
        /// <returns></returns>
        protected string GetMasterUser(int masterid)
        {
            if (masteruser != null & masteruser.Tables[0].Rows.Count > 0)
            {
                DataRow[] rows = masteruser.Tables[0].Select("UserID=" + masterid);
                if (rows != null && rows.Length > 0)
                {
                    return rows[0]["Username"].ToString();
                }
            }
            return "";
        }
        /// <summary>
        /// 数据绑定
        /// </summary>
        private void BindData()
        {
            string sDate = CtrlHelper.GetText(txtStartDate);
            string eDate = CtrlHelper.GetText(txtEndDate);
            string query = CtrlHelper.GetTextAndFilter(txtSearch);
            int type = int.Parse(ddlSearchType.SelectedValue);
            StringBuilder condition = new StringBuilder();
            condition.Append("WHERE 1=1");

            if (!string.IsNullOrEmpty(query))
            {
                if (!Utils.Validate.IsPositiveInt(query))
                {
                    ShowError("输入的查询格式不正确");
                    return;
                }
                condition.AppendFormat(" AND UserID={0}", type == 1 ? GetUserIDByGameID(Convert.ToInt32(query)) : Convert.ToInt32(query));
            }

            if (sDate != "" && eDate != "")
            {
                condition.AppendFormat(" AND CollectDate BETWEEN '{0}' AND '{1}'",
                   sDate + " 00:00:00", eDate + " 23:59:59");
            }

            PagerSet pagerSet = FacadeManage.aideRecordFacade.GetList(RecordGrantDiamond.Tablename, condition.ToString(),
                Orderby, anpNews.CurrentPageIndex, anpNews.PageSize);
            anpNews.RecordCount = pagerSet.RecordCount;
            if (pagerSet.RecordCount > 0)
            {
                rptDataList.DataSource = pagerSet.PageSet;
                rptDataList.DataBind();
            }
            litNoData.Visible = pagerSet.RecordCount <= 0;
            rptDataList.Visible = pagerSet.RecordCount > 0;
        }
        /// <summary>
        /// 排序条件
        /// </summary>
        public string Orderby
        {
            get
            {
                if (ViewState["Orderby"] == null)
                {
                    ViewState["Orderby"] = "ORDER BY RecordID DESC";
                }

                return (string)ViewState["Orderby"];
            }

            set
            {
                ViewState["Orderby"] = value;
            }
        }
    }
}