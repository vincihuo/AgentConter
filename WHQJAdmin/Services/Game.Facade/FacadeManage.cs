﻿
// ReSharper disable InconsistentNaming

using System;

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
                if( _aideNativeWebFacade == null )
                {
                    lock( lockObj )
                    {
                        if( _aideNativeWebFacade == null )
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
                if( _aidePlatformManagerFacade == null )
                {
                    lock( lockObj )
                    {
                        if( _aidePlatformManagerFacade == null )
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
                if( _aidePlatformFacade == null )
                {
                    lock( lockObj )
                    {
                        if( _aidePlatformFacade == null )
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
                if( _aideTreasureFacade == null )
                {
                    lock( lockObj )
                    {
                        if( _aideTreasureFacade == null )
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
                if( _aideAccountsFacade == null )
                {
                    lock( lockObj )
                    {
                        if( _aideAccountsFacade == null )
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
                if( _aideRecordFacade == null )
                {
                    lock( lockObj )
                    {
                        if( _aideRecordFacade == null )
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
                if( _aideGameMatchFacade == null )
                {
                    lock( lockObj )
                    {
                        if( _aideGameMatchFacade == null )
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


        public static float ConversionMoneyToShow(string t)
        {
            Int64 a = Convert.ToInt64(t);
            float temp = a / 1000.0f;
            int i = (int)(temp * 100);
            return (i * 1.0f) / 100;
        }
        public static float ConversionMoneyToShow(Int64 a)
        {
            float temp = a / 1000.0f;
            Int64 i = (int)(temp * 100);
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

    }
}
