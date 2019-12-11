using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Game.Utils;
using Game.Web.UI;
using Game.Entity.Accounts;
using Game.Kernel;
using Game.Entity.Record;
using System.Text;
using System.Data;
using Game.Entity.Enum;
using Game.Facade;

namespace Game.Web.Module.WebManager
{
    public partial class UMessagePushAll : AdminPage
    {
        /// <summary>
        /// 页面加载
        /// </summary>
        protected void Page_Load(object sender, EventArgs e)
        {
            base.moduleID = 404;
            if(!IsPostBack)
            {
                txtTime.Text = DateTime.Now.AddMinutes(2).ToString("yyyy-MM-dd HH:mm:ss");

                gameid.Visible = false;
                txtGameID.Text = "0";
                time.Visible = false;
                txtStartDate.Text = "";
                txtEndDate.Text = "";
                logincount.Visible = false;
                txtNoLoginDay.Text = "0";
            }

        }
        /// <summary>
        /// 数据保存
        /// </summary>
        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (!AuthUserOperationPermission(Permission.Edit))
            {
                return;
            }
            try
            {
                int typeID = Convert.ToInt32(ddlType.SelectedValue);
                string content = CtrlHelper.GetText(txtContent);
                DateTime time = Convert.ToDateTime(txtTime.Text);

                if(string.IsNullOrEmpty(content))
                {
                    MessageBox("消息内容不能为空");
                    return;
                }
                if(DateTime.Now > time)
                {
                    MessageBox("推送时间不能小于或等于当前时间");
                    return;
                }
                DateTime endTime = time.AddHours(5);
                if(typeID == 0)
                {
                    bool flag = false;
                    flag = Umeng.SendMessage(0, content, "broadcast", time.ToString("yyyy-MM-dd HH:mm:ss"), endTime.ToString("yyyy-MM-dd HH:mm:ss"), "");
                    if(!flag)
                    {
                        MessageBox("推送消息失败，请前往友盟后台绑定系统后台ip");
                        return;
                    }
                    flag = Umeng.SendMessage(1, content, "broadcast", time.ToString("yyyy-MM-dd HH:mm:ss"), endTime.ToString("yyyy-MM-dd HH:mm:ss"), "");
                    if(!flag)
                    {
                        MessageBox("推送消息失败，请前往友盟后台绑定系统后台ip");
                        return;
                    }
                }
                else
                {
                    bool flag = false;
                    string where = string.Empty;
                    switch(typeID)
                    {
                        case 1:
                            flag = Umeng.SendMessage(0, content, "broadcast", time.ToString("yyyy-MM-dd HH:mm:ss"), endTime.ToString("yyyy-MM-dd HH:mm:ss"), "");
                            if (!flag)
                            {
                                MessageBox("推送消息失败，请前往友盟后台绑定系统后台ip");
                                return;
                            }
                            break;
                        case 2:
                            flag = Umeng.SendMessage(1, content, "broadcast", time.ToString("yyyy-MM-dd HH:mm:ss"), endTime.ToString("yyyy-MM-dd HH:mm:ss"), "");
                            if (!flag)
                            {
                                MessageBox("推送消息失败，请前往友盟后台绑定系统后台ip");
                                return;
                            }
                            break;
                        default:
                            break;
                    }
         
                }

                //批量写入记录
                DataTable table = new DataTable();
                table.Columns.AddRange(new DataColumn[] {
                        new DataColumn("RecordID",typeof(int)),
                        new DataColumn("MasterID",typeof(int)),
                        new DataColumn("UserID",typeof(int)),
                        new DataColumn("PushType",typeof(byte)),
                        new DataColumn("PushContent",typeof(string)),
                        new DataColumn("PushTime",typeof(DateTime)),
                        new DataColumn("PushIP",typeof(string))
                    });
                int masterid = userExt.UserID;
                DateTime addTime = DateTime.Now;
                string ip = GameRequest.GetUserIP();
                string connStr = ApplicationSettings.Get("DBRecord");
                DataRow dr = table.NewRow();
                dr[0] = 0;
                dr[1] = masterid;
                dr[2] = 0;
                dr[3] = 0;
                dr[4] = content;
                dr[5] = addTime;
                dr[6] = ip;
                table.Rows.Add(dr);
                int result = FacadeManage.aideRecordFacade.AddRecordAccountsUmeng(table, connStr);
                if(result > 0)
                {
                    MessageBox("推送消息成功");
                }
                else
                {
                    MessageBox("推送消息成功，但推送记录写入失败");
                }
            }
            catch(Exception)
            {
                MessageBox("推送消息异常，请稍后重试");
            }
        }
        /// <summary>
        /// 选择类型
        /// </summary>
        protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
        {
            int typeID = Convert.ToInt32(ddlType.SelectedValue);
            if(typeID == 1)
            {
                gameid.Visible = true;
                time.Visible = false;
                txtStartDate.Text = "";
                txtEndDate.Text = "";
                logincount.Visible = false;
                txtNoLoginDay.Text = "0";
            }
            else if(typeID == 5)
            {
                gameid.Visible = false;
                txtGameID.Text = "0";
                time.Visible = true;
                txtStartDate.Text = "";
                txtEndDate.Text = "";
                logincount.Visible = false;
                txtNoLoginDay.Text = "0";
            }
            else if(typeID == 6)
            {
                gameid.Visible = false;
                txtGameID.Text = "0";
                time.Visible = false;
                txtStartDate.Text = "";
                txtEndDate.Text = "";
                logincount.Visible = true;
                txtNoLoginDay.Text = "0";
            }
            else
            {
                gameid.Visible = false;
                txtGameID.Text = "0";
                time.Visible = false;
                txtStartDate.Text = "";
                txtEndDate.Text = "";
                logincount.Visible = false;
                txtNoLoginDay.Text = "0";
            }
        }
    }
}
