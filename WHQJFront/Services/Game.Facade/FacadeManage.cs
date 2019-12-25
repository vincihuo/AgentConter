using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Game.Facade.DataStruct;
using Game.Entity.Platform;
using Game.Entity.Accounts;

namespace Game.Facade
{
    /// <summary>
    /// 逻辑层管理类
    /// </summary>
    public class FacadeManage
    {
        public static List<TurntableReward> bList=new List<TurntableReward>();
        public static List<TurntableReward> nList=new List<TurntableReward>();

        private static object lockObj = new object();

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

        ///// <summary>
        ///// 代理逻辑
        ///// </summary>
        private static volatile AgentFacade _aideAgentFacade;
        public static AgentFacade aideAgentFacade
        {
            get
            {
                if (_aideAgentFacade != null) return _aideAgentFacade;
                lock (lockObj)
                {
                    if (_aideAgentFacade == null)
                        _aideAgentFacade = new AgentFacade();
                }
                return _aideAgentFacade;
            }
        }

        ///// <summary>
        ///// 群组逻辑
        ///// </summary>
        private static volatile GroupFacade _aideGroupFacade;
        public static GroupFacade aideGroupFacade
        {
            get
            {
                if (_aideGroupFacade != null) return _aideGroupFacade;
                lock (lockObj)
                {
                    if (_aideGroupFacade == null)
                        _aideGroupFacade = new GroupFacade();
                }
                return _aideGroupFacade;
            }
        }
        public static string GetOrperteName(int type)
        {
            switch (type)
            {
                case 0:
                    return "后台赠送";
                case 1:
                    return "注册赠送";
                case 2:
                    return "后台赠送";
                case 3:
                    return "注册赠送";
                case 4:
                    return "后台赠送";
                case 5:
                    return "购买房卡";
                case 6:
                    return "保险箱存入";
                case 7:
                    return "保险箱取出";
                case 10:
                    return "提现退款";
                case 11:
                    return "提现";
                case 12:
                    return "充值入款";
                case 13:
                    return "代理奖励";
                case 14:
                    return "签到";
                case 15:
                    return "分享";
                case 16:
                    return "转盘";
                case 17:
                    return "VIP奖励";
                default:
                    return "未知类型";
            }
        }

        public static void CreatTurnTableDate()
        {
            IList<TurntableConfig> list = aidePlatformFacade.GetTurntableConfigs();
            int pp = new Random().Next(100);
            int turnIndex = 0;
            if (pp > list[3].MenuVaule && pp < list[8].MenuVaule)
            {
                turnIndex = 1;
            }
            else if (pp> list[8].MenuVaule)
            {
                turnIndex = 2;
            }
            TurntableConfig broad = list[5 * turnIndex + 2];
            TurntableConfig money = list[5 * turnIndex];
            AccountsInfo android = aideAccountsFacade.RandomAndroid();
            int index = StartTurntable(list[5 * turnIndex + 3]);
            TurntableReward record = new TurntableReward();
            record.money  = (long)money.GetType().GetProperty("Value" + index).GetValue(money, null);
            record.time = DateTime.Now;
            string tName = "";
            switch (turnIndex)
            {
                case 0:
                    tName = "白银转盘";
                    break;
                case 1:
                    tName = "黄金转盘";
                    break;
                default:
                    tName = "钻石转盘";
                    break;
            }
            record.turnName = tName;
            record.nickName = android.NickName;
            long mm = (long)broad.GetType().GetProperty("Value" + index).GetValue(broad, null);
            PustTurnTableRecord(record, (int)mm);
        }

        public static int StartTurntable(TurntableConfig pre)
        {
            int r = new Random().Next((int)pre.MenuVaule);

            int i = 1;
            long p = 0;
            for (; i < 13; ++i)
            {
                p+= (long)pre.GetType().GetProperty("Value" + i).GetValue(pre, null);
                if (p > r)
                {
                    break;
                }
            }
            return i;
        }
        public static void PustTurnTableRecord(TurntableReward record,int big)
        {
            nList.Add(record);
            if (nList.Count > 20)
            {
                nList.RemoveAt(0);
            }
            if (big == 1)
            {
                bList.Add(record);
                if (bList.Count > 20)
                {
                    bList.RemoveAt(0);
                }
            }
        }
    }
}
