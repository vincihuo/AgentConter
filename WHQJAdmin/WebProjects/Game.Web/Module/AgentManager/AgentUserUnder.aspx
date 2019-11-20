<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgentUserUnder.aspx.cs" Inherits="Game.Web.Module.AgentManager.AgentUserUnder" %>

<%@ Import Namespace="Game.Facade" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
    <title>下级报表</title>
</head>
<body>
    <form id="form1" runat="server">
        <!-- 头部菜单 Start -->
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
            <tr>
                <td width="19" height="25" valign="top" class="Lpd10">
                    <div class="arr">
                    </div>
                </td>
                <td width="1232" height="25" valign="top" align="left">你当前位置：代理系统 - 下级报表
                </td>
            </tr>
        </table>
        <!-- 头部菜单 End -->
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="155" Height="24" CssClass="text" OnSelectedIndexChanged="GameID_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>

                <td class="listTdLeft" style="width: 80px">日期查询：
                </td>
                <td>
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                        src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                        style="cursor: pointer; vertical-align: middle" />
                    至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />

                    <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                </td>
                <td class="titleOpBg Lpd10">
                    <span style="color: white; font-size: 14px; font-weight: bold;">下线总注册人数：<asp:Label ID="lbTotal" runat="server" Text="0"></asp:Label></span>
                </td>

                <td class="titleOpBg Lpd10">
                    <span style="color: white; font-size: 14px; font-weight: bold;">一级返利合计：<asp:Label ID="Label1" runat="server" Text="0"></asp:Label></span>
                </td>

                <td class="titleOpBg Lpd10">
                    <span style="color: white; font-size: 14px; font-weight: bold;">其他返利合计：<asp:Label ID="Label2" runat="server" Text="0"></asp:Label></span>
                </td>

            </tr>
        </table>
        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
                <tr align="center" class="bold">
                    <td class="listTitle2">结算时间
                    </td>
                    <td class="listTitle2">游戏id
                    </td>
                    <td class="listTitle2">用户昵称
                    </td>
                    <td class="listTitle2">税收
                    </td>
                    <td class="listTitle2">一级下级
                    </td>
                    <td class="listTitle2">其他下级
                    </td>
                    <td class="listTitle2">获得返利
                    </td>
                    <td class="listTitle2">创造返利
                    </td>
                    <td class="listTitle2">操作
                    </td>
                </tr>
                <asp:Repeater ID="rptDataList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%# Eval( "CountTime" ).ToString()%>
                            </td>
                            <td>
                                <%# Eval( "GameID" ).ToString()%>
                            </td>
                            <td>
                                <%# Eval( "NickName" ).ToString()%>
                            </td>
                            <td>
                                <%#FacadeManage.ConversionMoneyToShow(Eval("Tax").ToString()) %>
                            </td>
                            <td>
                                <%# Eval( "SubNumber" ).ToString()%>
                            </td>
                            <td>
                                <%# Convert.ToInt32(Eval( "BeggarNumber" ))-Convert.ToInt32(Eval( "SubNumber" ))%>
                            </td>
                            <td>
                                <%# FacadeManage.ConversionMoneyToShow(Eval("CurrReward").ToString())%>
                            </td>
                            <td>
                                <%# FacadeManage.ConversionMoneyToShow((Int64)((Convert.ToInt32(Eval( "CurrReward" ))+Convert.ToInt32(Eval( "Tax" )))*0.3)) %>
                            </td>
                            <td>
                                <asp:LinkButton class="l" runat="server" OnClick="btnSub" Enabled='<%# Convert.ToInt32(Eval( "SubNumber" ))==0?false:true %>' Text="下级报表" CommandArgument='<%# ParseArgument(Convert.ToInt32(Eval("UserID")),Eval("CountTime").ToString()) %> '></asp:LinkButton>
                                <a class="l" href="javascript:void(0)" style="<%# GetStyle(Convert.ToInt32(Eval("ParentID")))%>" onclick="Redirect('AgentList.aspx?param='+<%# Eval("ParentID")%>);">查看上级</a>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
            </table>
        </div>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td align="right" class="page">
                    <gsp:AspNetPager ID="anpPage" OnPageChanged="anpPage_PageChanged" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
                        PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                        NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%" UrlPaging="false">
                    </gsp:AspNetPager>
                </td>
            </tr>
        </table>

    </form>
</body>
</html>
