<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BankOrderList.aspx.cs" Inherits="Game.Web.Module.FilledManager.BankOrderList" %>

<%@ Import Namespace="Game.Facade" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <script type="text/javascript" src="../../scripts/comm.js"></script>

    <script type="text/javascript" src="../../scripts/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
        function CheckData() {
            $.ajax({
                type: "GET",
                url: "/Tools/Operating.ashx?action=checkorder",
                data: { type: 3 },
                success: function (result) {
                    if (result.data.valid) {
                        var soundControl = document.getElementById("sss");
                        soundControl.play();
                    }
                }
            });
        }
        setTimeout("CheckData()", 6000);
    </script>
</head>
<body>
    <embed id="sss" height="100" width="100" hidden="true" src="../../sound/song.mp3" />
    <form id="form1" runat="server">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
            <tr>
                <td width="19" height="25" valign="top" class="Lpd10">
                    <div class="arr">
                    </div>
                </td>
                <td width="1232" height="25" valign="top" align="left">你当前位置：充值系统 - 银行订单
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

                    <asp:Button ID="btnQueryTD" runat="server" Text="今天" CssClass="btn wd1" OnClick="btnQueryTD_Click" />
                    <asp:Button ID="btnQueryYD" runat="server" Text="昨天" CssClass="btn wd1" OnClick="btnQueryYD_Click" />
                    <asp:Button ID="btnQueryTW" runat="server" Text="本周" CssClass="btn wd1" OnClick="btnQueryTW_Click" />
                    <asp:Button ID="btnQueryYW" runat="server" Text="上周" CssClass="btn wd1" OnClick="btnQueryYW_Click" />
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg Tmg7">
            <tr>
                <td class="listTdLeft" style="width: 80px">用户查询：
                </td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox>
                    <asp:DropDownList ID="ddlSearchType" runat="server">
                        <asp:ListItem Value="0">按订单号码</asp:ListItem>
                        <asp:ListItem Value="1">按游戏ID</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="ddlPayStatus" runat="server">
                        <asp:ListItem Value="-1">全部</asp:ListItem>
                        <asp:ListItem Value="0">未处理</asp:ListItem>
                        <asp:ListItem Value="1">已支付</asp:ListItem>
                        <asp:ListItem Value="1">已拒绝</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="btnQueryAcc" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                    <span class="total-span">
                        <asp:Literal ID="ltTotal" runat="server"></asp:Literal></span>
                </td>
            </tr>
        </table>

        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
                <tr align="center" class="bold">
                    <td class="listTitle">订单时间
                    </td>
                    <td class="listTitle2">订单号码
                    </td>
                    <td class="listTitle2">收款账号
                    </td>
                    <td class="listTitle2">游戏ID
                    </td>
                    <td class="listTitle2">玩家昵称
                    </td>
                    <td class="listTitle2">充值金额
                    </td>
                    <td class="listTitle2">赠送
                    </td>
                    <td class="listTitle2">存款银行
                    </td>
                    <td class="listTitle2">存款姓名
                    </td>
                    <td class="listTitle2">转账类型
                    </td>
                    <td class="listTitle2">订单状态
                    </td>
                    <td class="listTitle2">操作ID
                    </td>
                    <td class="listTitle">到账时间
                    </td>
                    <td class="listTitle2">操作
                    </td>
                </tr>
                <asp:Repeater ID="rptShareInfo" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%# Eval("PayTime")%>
                            </td>
                            <td>
                                <%# Eval("OrderID")%>
                            </td>
                            <td>
                                <%# Eval("Payee")%>
                            </td>
                            <td>
                                <%# Eval("GameID")%>
                            </td>
                            <td>
                                <a class="l" href="javascript:void(0);" onclick="openWindowOwn('/Module/AccountManager/AccountsBaseInfo.aspx?param=<%#Eval("UserID").ToString() %>','<%#Eval("UserID").ToString() %>',850,790);">
                                    <%# Eval("NickName")%>
                                </a>
                            </td>
                            <td>
                                <%# FacadeManage.ConversionMoneyToShow(Eval("Amount").ToString())%>
                            </td>
                            <td>
                                <%# FacadeManage.ConversionMoneyToShow(Eval("PresentScore").ToString())%>
                            </td>
                            <td>
                                <%# Eval("PayBank")%>
                            </td>
                            <td>
                                <%# Eval("PayName")%>
                            </td>
                            <td>
                                <%#  GetTransfType(Convert.ToInt32(Eval("TransferType")))%>
                            </td>
                            <td>
                                <%#  GetPayStatus(Convert.ToInt32(Eval("OrderStates")))%>
                            </td>
                            <td>
                                <%# Eval("MasterId")%>
                            </td>
                            <td>
                                <%# Eval("CallTime")%>
                            </td>
                            <td>
                                <asp:LinkButton class="l" runat="server" OnClick="btnAgree_Click" Visible='<%# Convert.ToInt32(Eval( "OrderStates" ))==0?true:false %>' Text="通过" CommandArgument='<%# Eval("OrderID")%>'></asp:LinkButton>
                                <asp:LinkButton class="l" runat="server" OnClick="btnRefuse" Visible='<%# Convert.ToInt32(Eval( "OrderStates" ))==0?true:false %>' Text="拒绝" CommandArgument='<%# Eval("OrderID")%>'></asp:LinkButton>
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
