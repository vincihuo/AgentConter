using Game.Web.Helper;
using log4net.Config;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;
using System.Timers;
using Game.Facade;
namespace Game.Web
{
    public class Global : System.Web.HttpApplication
    {
        private int pp;
        protected void Application_Start(object sender, EventArgs e)
        {
            //应用程序启动时，自动加载配置log4Net  
            XmlConfigurator.Configure();
            int pp = 0;
            Timer timer = new Timer(1000);
            timer.Elapsed += new ElapsedEventHandler(Update);
            timer.Enabled = true;
            timer.Start();
        }
        private void Update(object sender, EventArgs e)
        {
            pp--;
            if (pp < 0)
            {
                FacadeManage.CreatTurnTableDate();
                pp = new Random().Next(10);
            }
            
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            Exception ex = this.Context.Server.GetLastError();
            if(ex != null)
            {
                Log4Net.WriteErrorLog(ex);
            } 
        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}