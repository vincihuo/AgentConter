using Game.Facade;
using Game.Utils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Game.Web
{
    /// <summary>
    /// testpost 的摘要说明
    /// </summary>
    public class testpost : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            //允许跨站请求域名
            context.Response.AddHeader("Access-Control-Allow-Origin", AppConfig.MoblieInterfaceDomain);
            //接口返回数据格式
            context.Response.ContentType = "application/json";
            string action = GameRequest.GetFormString("action");
            string userid = GameRequest.GetFormString("userid");
            AjaxJsonValid _ajv = new AjaxJsonValid();
            if(string.IsNullOrEmpty(action)&& string.IsNullOrEmpty(userid))
            {
                _ajv.msg = "获取数据为空！";
                context.Response.Write(_ajv.SerializeToJson());
                return;
            }

            _ajv.msg = "请求数据成功";
            _ajv.SetValidDataValue(true);
            _ajv.SetDataItem("action", action);
            _ajv.SetDataItem("userid", userid);
            context.Response.Write(_ajv.SerializeToJson());
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}