<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VilaBetList.aspx.cs" Inherits="Game.Web.Module.GoldManager.VilaBetList" %>

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
                <td width="1232" height="25" valign="top" align="left">你当前位置：金币系统-打码量
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
            <tr>
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
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg Tmg7">
            <tr>
                <td class="listTdLeft" style="width: 80px">游戏ID：
                </td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox>
                    <span class="hong">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="请输入游戏ID" Display="Dynamic" ControlToValidate="txtSearch" ForeColor="Red"></asp:RequiredFieldValidator>


                    <asp:Button ID="btnQueryAcc" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQueryAcc_Click" />
                    <span class="total-span">
                        <asp:Literal ID="ltTotal" runat="server"></asp:Literal></span>
                </td>
            </tr>
        </table>



        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
                <tr align="center" class="bold">
                    <td class="listTitle">入款时间
                    </td>
                    <td class="listTitle2">入款类型
                    </td>
                    <td class="listTitle2">结余打码量
                    </td>
                    <td class="listTitle2">增加打码量
                    </td>
                    <td class="listTitle2">总打码量
                    </td>
                    <td class="listTitle2">入款ID
                    </td>
                    <td class="listTitle2">入款名称
                    </td>
                </tr>
                <asp:Repeater ID="rptShareInfo" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%# Eval("DepositTime")%>
                            </td>
                            <td>
                                <%# Eval("DepositType")%>
                            </td>
                            <td>
                                <%# Eval("LastValiBet")%>
                            </td>
                            <td>
                                <%# Eval("CurrentValidBet")%>
                            </td>
                            <td>
                                <%# Eval("TotalValiBet")%>
                            </td>
                            <td>
                                <%# Eval("DepositName")%>
                            </td>
                            <td>
                                <%# Eval("DepositID")%>
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
