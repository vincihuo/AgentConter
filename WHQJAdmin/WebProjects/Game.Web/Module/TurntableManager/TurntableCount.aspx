<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurntableCount.aspx.cs" Inherits="Game.Web.Module.TurntableManager.TurntableCount" %>

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
                <td width="1232" height="25" valign="top" align="left">你当前位置：转盘系统 - 开奖统计
                </td>
            </tr>
        </table>

        <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
            <tr>
                <td height="28">
                    <asp:RadioButtonList RepeatDirection="Horizontal" runat="server" ID="list1" AutoPostBack="True" OnSelectedIndexChanged="ddlProductType_SelectedIndexChanged">
                        <asp:ListItem Text="白银转盘" Value="0"></asp:ListItem>
                        <asp:ListItem Text="黄金转盘" Value="1"></asp:ListItem>
                        <asp:ListItem Text="钻石转盘" Value="2"></asp:ListItem>
                        <asp:ListItem Text="全部" Value="3" Selected="True"></asp:ListItem>
                    </asp:RadioButtonList>
                    <td class="listTdLeft" style="width: 80px">时间查询：
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
                        <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                    </td>
                </td>
            </tr>
        </table>

        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
                <tr align="center" class="bold">
                    <td class="listTitle2">时间
                    </td>
                    <td class="listTitle2">白银金额
                    </td>
                    <td class="listTitle2">白银人数
                    </td>
                    <td class="listTitle2">黄金金额
                    </td>
                    <td class="listTitle2">黄金人数
                    </td>
                    <td class="listTitle2">钻石金额
                    </td>
                    <td class="listTitle2">钻石人数
                    </td>
                    <td class="listTitle2">合计金额
                    </td>
                    <td class="listTitle2">合计人数
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
                                <%# Eval( "silverMoney" )%>
                            </td>
                            <td>
                                <%# Eval( "silverPerson" )%>
                            </td>
                            <td>
                                <%# Eval( "goldMoney" )%>
                            </td>
                            <td>
                                <%# Eval( "goldPerson" )%>
                            </td>
                            <td>
                                <%# Eval( "dimaoMoney" )%>
                            </td>
                            <td>
                                <%# Eval( "dimaoPerson" )%>
                            </td>
                            <td>
                                <%# Eval( "totalMoney" )%>
                            </td>
                            <td>
                                <%# Eval( "totalPerson" )%>
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
