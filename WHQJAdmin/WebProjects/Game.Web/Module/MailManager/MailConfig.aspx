<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MailConfig.aspx.cs" Inherits="Game.Web.Module.MailManager.MailConfig" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <script type="text/javascript" src="../../scripts/comm.js"></script>

    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
            <tr>
                <td width="19" height="25" valign="top" class="Lpd10">
                    <div class="arr">
                    </div>
                </td>
                <td width="1232" height="25" valign="top" align="left">你当前位置：邮件系统 - 邮件查询
                </td>
            </tr>
        </table>


        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnNew1" type="button" class="btn wd1" value="新增" onclick="openWindowOwn('MailAddPage.aspx', '', 700, 400);" />
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
            <tr>
                <td align="center" style="width: 80px">游戏ID：
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="text"></asp:TextBox>
                </td>

                <td align="center" style="width: 80px">邮件编号ID：
                </td>
                <td>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="text"></asp:TextBox>
                </td>

                <td align="center" style="width: 80px">状态：
                </td>
                <td>
                    <asp:DropDownList ID="DropDownList1" runat="server">
                        <asp:ListItem Text="全部" Value="-1"></asp:ListItem>
                        <asp:ListItem Text="未读" Value="0"></asp:ListItem>
                        <asp:ListItem Text="已读" Value="1"></asp:ListItem>
                        <asp:ListItem Text="已删除" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td class="listTdLeft" style="width: 80px">时间：
                </td>
                <td>
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox>
                    <img
                        src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                        style="cursor: pointer; vertical-align: middle" />
                    至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />
                </td>

                <td>
                    <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                </td>

            </tr>
        </table>

        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
                <tr align="center" class="bold">
                    <td class="listTitle2">游戏ID
                    </td>
                    <td class="listTitle2">邮件id
                    </td>
                    <td class="listTitle2">邮件标题
                    </td>
                    <td class="listTitle2">邮件状态
                    </td>
                    <td class="listTitle2">金币数量
                    </td>
                    <td class="listTitle1">钻石数量
                    </td>
                    <td class="listTitle1">打码量
                    </td>
                    <td class="listTitle1">发送时间
                    </td>
                </tr>
                <asp:Repeater ID="rptDataList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%# GetAccountGameID(Convert.ToInt32(Eval("UserID")))%>
                            </td>
                            <td>
                                <%# Eval("id")%>
                            </td>
                            <td>
                                <%# Eval("Title")%>
                            </td>
                            <td>
                                <%# GetMailState(Convert.ToByte(Eval("MState")))%>
                            </td>
                            <td>
                                <%# Eval("GoldNum")%>
                            </td>
                            <td>
                                <%# Eval("DiamNum")%>
                            </td>
                            <td>
                                <%# Eval("Valibet")%>
                            </td>
                            <td>
                                <%# Eval("SendTime")%>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:Literal runat="server" ID="litNoData" Visible="false" Text="<tr class='tdbg'><td colspan='100' align='center'><br>没有任何信息!<br><br></td></tr>"></asp:Literal>
            </table>
        </div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="listTitleBg">
                    <span>选择：</span>&nbsp;<a class="l1" href="javascript:SelectAll(true);">全部</a>&nbsp;-&nbsp;<a class="l1" href="javascript:SelectAll(false);">无</a>
                </td>
                <td align="right" class="page">
                    <gsp:AspNetPager ID="anpNews" runat="server" OnPageChanged="anpNews_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
                        PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                        NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%">
                    </gsp:AspNetPager>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
