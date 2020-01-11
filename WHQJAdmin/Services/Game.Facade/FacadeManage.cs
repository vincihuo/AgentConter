
// ReSharper disable InconsistentNaming

using System;
using System.Net;
using System.IO;
using System.Text;

namespace Game.Facade
{
    /// <summary>
    /// 逻辑层管理类
    /// </summary>
    public class FacadeManage
    {
       
        private static readonly object lockObj = new object();

        ///// <summary>
        ///// 前台逻辑
        ///// </summary>
        private static volatile NativeWebFacade _aideNativeWebFacade;
        public static NativeWebFacade aideNativeWebFacade
        {
            get
            {
                if (_aideNativeWebFacade == null)
                {
                    lock (lockObj)
                    {
                        if (_aideNativeWebFacade == null)
                            _aideNativeWebFacade = new NativeWebFacade();
                    }
                }
                return _aideNativeWebFacade;
            }
        }

        ///// <summary>
        ///// 后台逻辑
        ///// </summary>
        private static volatile PlatformManagerFacade _aidePlatformManagerFacade;
        public static PlatformManagerFacade aidePlatformManagerFacade
        {
            get
            {
                if (_aidePlatformManagerFacade == null)
                {
                    lock (lockObj)
                    {
                        if (_aidePlatformManagerFacade == null)
                            _aidePlatformManagerFacade = new PlatformManagerFacade();
                    }
                }
                return _aidePlatformManagerFacade;
            }
        }

        ///// <summary>
        ///// 平台逻辑
        ///// </summary>
        private static volatile PlatformFacade _aidePlatformFacade;
        public static PlatformFacade aidePlatformFacade
        {
            get
            {
                if (_aidePlatformFacade == null)
                {
                    lock (lockObj)
                    {
                        if (_aidePlatformFacade == null)
                            _aidePlatformFacade = new PlatformFacade();
                    }
                }
                return _aidePlatformFacade;
            }
        }

        ///// <summary>
        ///// 游戏币库逻辑
        ///// </summary>
        private static volatile TreasureFacade _aideTreasureFacade;
        public static TreasureFacade aideTreasureFacade
        {
            get
            {
                if (_aideTreasureFacade == null)
                {
                    lock (lockObj)
                    {
                        if (_aideTreasureFacade == null)
                            _aideTreasureFacade = new TreasureFacade();
                    }
                }
                return _aideTreasureFacade;
            }
        }

        ///// <summary>
        ///// 帐号库逻辑
        ///// </summary>
        private static volatile AccountsFacade _aideAccountsFacade;
        public static AccountsFacade aideAccountsFacade
        {
            get
            {
                if (_aideAccountsFacade == null)
                {
                    lock (lockObj)
                    {
                        if (_aideAccountsFacade == null)
                            _aideAccountsFacade = new AccountsFacade();
                    }
                }
                return _aideAccountsFacade;
            }
        }

        ///// <summary>
        ///// 记录库逻辑
        ///// </summary>
        private static volatile RecordFacade _aideRecordFacade;
        public static RecordFacade aideRecordFacade
        {
            get
            {
                if (_aideRecordFacade == null)
                {
                    lock (lockObj)
                    {
                        if (_aideRecordFacade == null)
                            _aideRecordFacade = new RecordFacade();
                    }
                }
                return _aideRecordFacade;
            }
        }

        ///// <summary>
        ///// 比赛库逻辑
        ///// </summary>
        private static volatile GameMatchFacade _aideGameMatchFacade;
        public static GameMatchFacade aideGameMatchFacade
        {
            get
            {
                if (_aideGameMatchFacade == null)
                {
                    lock (lockObj)
                    {
                        if (_aideGameMatchFacade == null)
                            _aideGameMatchFacade = new GameMatchFacade();
                    }
                }
                return _aideGameMatchFacade;
            }
        }

        /// <summary>
        /// 群组库逻辑
        /// </summary>
        private static volatile GroupFacade _aideGroupFacade;
        public static GroupFacade aideGroupFacade
        {
            get
            {
                if (_aideGroupFacade == null)
                {
                    lock (lockObj)
                    {
                        if (_aideGroupFacade == null)
                            _aideGroupFacade = new GroupFacade();
                    }
                }
                return _aideGroupFacade;
            }
        }

        ///// <summary>
        ///// 代理库逻辑
        ///// </summary>
        private static volatile AgentFacade _aideAgentFacade;
        public static AgentFacade aideAgentFacade
        {
            get
            {
                if (_aideAgentFacade == null)
                {
                    lock (lockObj)
                    {
                        if (_aideAgentFacade == null)
                            _aideAgentFacade = new AgentFacade();
                    }
                }
                return _aideAgentFacade;
            }
        }


        public static string ConverToShow(string t)
        {
            string[] mm = t.Split(',');
            string shout = "";
            for (int i = 0; i < mm.Length; ++i)
            {
                shout += Convert.ToInt32(mm[i]) * 1000 + ",";
            }
            return shout.Substring(0, shout.Length - 1);
        }

        public static float ConversionMoneyToShow(string t)
        {
            Int64 a = (Int64)double.Parse(t);
            double temp = a * 0.001;
            Int64 i = (long)(temp * 100);
            return (i * 1.0f) / 100;
        }
        public static float ConversionMoneyToShow(Int64 a)
        {
            double temp = a*0.001;
            Int64 i = (long)(temp * 100);
            return (i * 1.0f) / 100;
        }
        public static Int64 ConversionMoneyToReal(float a)
        {
            return (Int64)(a * 1000);
        }

        public static Int64 ConversionMoneyToReal(int a)
        {
            return a * 1000;
        }
        public static string GetBankName(int type)
        {
            switch (type)
            {
                case 1:
                    return "中国银行";
                case 2:
                    return "农业银行";
                case 3:
                    return "建设银行";
                case 4:
                    return "浦发银行";
                case 5:
                    return "发展银行";
                case 6:
                    return "宁波银行";
                default:
                    return "未绑定";
            }
        }
        public static string RequestUri(string uri, string param,string Molde= "POST")
        {
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(uri);
            request.Method = Molde;
            request.ContentType = "application/json";
            //StreamWriter write = new StreamWriter(request.GetRequestStream(), Encoding.GetEncoding("utf-8"));
            //write.Write(param);
            //write.Flush();
            //HttpWebResponse response = null;
            //try
            //{
            //    response = (HttpWebResponse)request.GetResponse();
            //}
            //catch (Exception)
            //{
            //}


            byte[] bs = Encoding.UTF8.GetBytes(param);
            request.ContentLength = bs.Length;
            using (Stream reqStream = request.GetRequestStream())
            {
                reqStream.Write(bs, 0, bs.Length);
                reqStream.Close();
            }
            HttpWebResponse response = (HttpWebResponse)request.GetResponse();

            string strJson = string.Empty;
            if (response != null)
            {
                Stream responseStream = response.GetResponseStream();
                StreamReader reader = new StreamReader(responseStream, Encoding.GetEncoding("utf-8"));
                strJson = reader.ReadToEnd();
                reader.Close();
                responseStream.Close();
            }
            return strJson;
        }

    }
}
