﻿using System;
using Game.Entity.Record;
using Game.Facade;
using Game.Entity.Accounts;
using Game.Web.UI;
using Game.Entity.Enum;
using Game.Utils;
using Game.Kernel;


namespace Game.Web.Module.GoldManager
{
    public partial class GrantGold : AdminPage
    {
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 500;
            if(!IsPostBack)
            {
                AuthUserOperationPermission(Permission.GrantTreasure);
                trGameID.Visible = IntParam <= 0;
            }
        }
        /// <summary>
        /// 数据保存
        /// </summary>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            string strReason = CtrlHelper.GetText(txtReason);
            int valiBet = 0;
            int a = 0;
            if(!int.TryParse(txtGold.Text,out a))
            {
                MessageBox("赠送金币格式不正确");
                return;
            }
            if (!int.TryParse(VileBet.Text,out valiBet))
            {
                MessageBox("打码量格式不正确");
                return;
            }
            if (valiBet < 0)
            {
                MessageBox("打码量必须不小于0");
                return;
            }
            if (a>1000000)
            {
                MessageBox("单次赠送不能超过1000000");
                return;
            }
            int gold = a;
            bool flag = cbPull.Checked;
            int userid = IntParam <= 0 ? CtrlHelper.GetInt(hidUserID, 0) : IntParam;
            if(string.IsNullOrEmpty(strReason))
            {
                MessageBox("赠送备注不能为空");
                return;
            }
            string ip = GameRequest.GetUserIP();
            RecordGrantTreasure rgt = new RecordGrantTreasure
            {
                MasterID = userExt.UserID,
                UserID = userid,
                AddGold = gold*1000,
                ClientIP = ip,
                Reason = strReason
            };
            btnSave.Enabled = false;
            Message msg = FacadeManage.aideTreasureFacade.GrantTreasure(rgt);
            if(msg.Success)
            {
                
                if (valiBet > 0)
                {
                    Message msg1 = FacadeManage.aideTreasureFacade.AddValiBet(valiBet*1000, userid, 3, 1, strReason);
                    if (!msg1.Success)
                    {
                        MessageBox("怎加打码量失败");
                        return;
                    }
                }
                if (flag)
                {
                    AccountsUmeng umeng = FacadeManage.aideAccountsFacade.GetAccountsUmeng(IntParam);
                    if(!string.IsNullOrEmpty(umeng?.DeviceToken))
                    {
                        string content = "系统管理员" + userExt.UserName + "已" + (gold < 0 ? "扣除" : "赠送") + "您" + gold.ToString() + "金币";
                        DateTime start = DateTime.Now.AddMinutes(1);
                        DateTime end = start.AddHours(5);
                        bool result = Umeng.SendMessage(umeng.DeviceType, content, "unicast", start.ToString("yyyy-MM-dd HH:mm:ss"), end.ToString("yyyy-MM-dd HH:mm:ss"), umeng.DeviceToken);
                        if(!result)
                        {
                            MessageBox("赠送成功，但推送消息失败，请前往友盟后台绑定系统后台ip");
                            return;
                        }
                        RecordAccountsUmeng record = new RecordAccountsUmeng
                        {
                            MasterID = rgt.MasterID,
                            UserID = rgt.UserID,
                            PushType = umeng.DeviceType,
                            PushTime = DateTime.Now,
                            PushIP = ip,
                            PushContent = content
                        };
                        int rows = FacadeManage.aideRecordFacade.AddRecordAccountsUmeng(record);
                        MessageBox(rows > 0 ? "赠送成功" : "赠送成功，但推送记录写入失败");
                    }
                    else
                    {
                        MessageBox("赠送成功，但推送用户未绑定设备，无法推送");
                    }
                }
                else
                {
                    MessageBox("赠送成功");
                }
             

            }
            else
            {
                MessageBox("赠送失败");
            }
            btnSave.Enabled = true;
        }
    }
}