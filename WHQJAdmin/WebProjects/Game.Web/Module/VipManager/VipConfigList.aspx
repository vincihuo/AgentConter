<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VipConfigList.aspx.cs" Inherits="Game.Web.Module.VipManager.VipConfigList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>vip</title>
    <link href="/styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/scripts/common.js"></script>
    <script type="text/javascript" src="/scripts/comm.js"></script>
    <script type="text/javascript" src="/scripts/jquery.js"></script>
</head>
<body>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">你当前位置：VIP系统 - VIP配置
            </td>
        </tr>
    </table>
    <form id="form1" runat="server">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
            <tr align="center" class="bold">
                <td class="listTitle2">操作
                </td>
                <td class="listTitle2">VIP等级
                </td>
                <td class="listTitle2">晋级条件
                </td>
                <td class="listTitle2">晋级奖励
                </td>
                <td class="listTitle2">周奖励
                </td>
                <td class="listTitle2">月奖励
                </td>
                <td class="listTitle2">签到1天
                </td>
                <td class="listTitle2">签到2天
                </td>
                <td class="listTitle2">签到3天
                </td>
                <td class="listTitle2">签到4天
                </td>
                <td class="listTitle2">签到5天
                </td>
                <td class="listTitle2">签到6天
                </td>
                <td class="listTitle2">签到7天
                </td>
            </tr>
            <asp:Repeater ID="rptShareInfo" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <a href="VipConfigInfo.aspx?param=<%# Eval( "VipLevel" ).ToString( )%>" class="l">编辑</a>
                        </td>
                        <td>
                            <%# Eval("VipLevel")%>
                        </td>
                        <td>
                            <%# Eval("Integral")%>
                        </td>
                        <td>
                            <%# Eval("Fresh")%>
                        </td>
                        <td>
                            <%# Eval("Week")%>
                        </td>
                        <td>
                            <%# Eval("Month")%>
                        </td>
                        <td>
                            <%# Eval("Day1")%>
                        </td>
                        <td>
                            <%# Eval("Day2")%>
                        </td>
                        <td>
                            <%# Eval("Day3")%>
                        </td>
                        <td>
                            <%# Eval("Day4")%>
                        </td>
                        <td>
                            <%# Eval("Day5")%>
                        </td>
                        <td>
                            <%# Eval("Day6")%>
                        </td>
                        <td>
                            <%# Eval("Day7")%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>
    </form>
</body>
</html>
