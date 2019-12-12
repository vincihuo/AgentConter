﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Game.Utils;
using Game.Entity.Enum;
using Game.Entity.Treasure;
using Game.Web.UI;
using Game.Entity.NativeWeb;
using Game.Facade;

namespace Game.Web.Module.WebManager
{
    public partial class AddAds : AdminPage
    {
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 402;
            if(!IsPostBack)
            {
                BindData();
            }
        }
        /// <summary>
        /// 数据保存
        /// </summary>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            Ads ads = new Ads();
            if (IntParam > 0)
            {
                if (!AuthUserOperationPermission(Permission.Edit))
                {
                    return;
                }
                ads = FacadeManage.aideNativeWebFacade.GetAds(IntParam);
            }
            else
            {
                if (!AuthUserOperationPermission(Permission.Add))
                {
                    return;
                }
            }

            ads.Type = Convert.ToByte(ddlType.SelectedValue);
            ads.LinkURL = ddlLink.SelectedValue;
            if (ads.Type == 6 && Convert.ToInt32(ddlActivity.SelectedValue) == 0)
            {
                ads.LinkURL = CtrlHelper.GetText(txtLink);
            }
            else if (ads.Type == 6 && Convert.ToInt32(ddlActivity.SelectedValue) > 0)
            {
                ads.LinkURL = ddlActivity.SelectedValue;
            }

            ads.Remark = CtrlHelper.GetText(txtDescript);
            //ads.Title = CtrlHelper.GetText(txttitle);
            ads.SortID = CtrlHelper.GetInt(txtSortID, 0);
            ads.PlatformType = 1;
            string filepath = upImage.FilePath;

            if (string.IsNullOrEmpty(filepath))
            {
                ShowError("广告图片未上传");
                return;
            }

            ads.ResourceURL = filepath.Substring(7, filepath.Length - 7);

            int result = IntParam > 0 ? FacadeManage.aideNativeWebFacade.UpdateAds(ads) : FacadeManage.aideNativeWebFacade.InsertAds(ads);
            if (result > 0)
            {
                ShowInfo("广告信息操作成功", "AdsList.aspx", 1200);
            }
            else
            {
                ShowError("广告信息操作失败");
            }
        }
        /// <summary>
        /// 数据绑定
        /// </summary>
        private void BindData()
        {
            if(IntParam > 0)
            {
                Ads ads = FacadeManage.aideNativeWebFacade.GetAds(IntParam);
                if(ads != null)
                {
                    CtrlHelper.SetText(txtDescript, ads.Remark);
                    //CtrlHelper.SetText(txttitle, ads.Title);
                    CtrlHelper.SetText(txtSortID, ads.SortID.ToString());
                    ddlType.SelectedValue = ads.Type.ToString();
                    ddlType.Enabled = false;
                    activity.Visible = false;
                    if (ads.Type == 6)
                    {
                        activity.Visible = true;
                        ddlLink.Visible = false;

                        if (ads.LinkURL.Length > 1)
                        {
                            CtrlHelper.SetText(txtLink, ads.LinkURL);
                        }

                    }
                    if (!string.IsNullOrEmpty(ads.ResourceURL))
                    {
                        upImage.FilePath = "/Upload" + ads.ResourceURL;
                    }
                    else if(ads.Type==3 && ads.Type == 4)
                    {
                        linkurl.Visible = false;
                    }
                    else
                    {
                        ddlLink.Visible = false;
                        CtrlHelper.SetText(txtLink, ads.LinkURL);
                    }
                }
            }
        }
    }
}