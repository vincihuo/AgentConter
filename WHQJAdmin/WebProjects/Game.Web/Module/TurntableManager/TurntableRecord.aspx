<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurntableRecord.aspx.cs" Inherits="Game.Web.Module.TurntableManager.TurntableRecord" %>
<%@ Import Namespace="Game.Facade" %>
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
                <td width="1232" height="25" valign="top" align="left">你当前位置：转盘系统 - 开奖记录
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
                        <asp:ListItem Text="全部" Value="3"></asp:ListItem>
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
            <asp:Panel runat="server" ID="aa">
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
                    <tr align="center" class="bold">
                        <td class="listTitle2">时间
                        </td>
                        <td class="listTitle2">1金额
                        </td>
                        <td class="listTitle2">2金额
                        </td>
                        <td class="listTitle2">3金额
                        </td>
                        <td class="listTitle2">4金额
                        </td>
                        <td class="listTitle2">5金额
                        </td>
                        <td class="listTitle2">6金额
                        </td>
                        <td class="listTitle2">7金额
                        </td>
                        <td class="listTitle2">8金额
                        </td>
                        <td class="listTitle2">9金额
                        </td>
                        <td class="listTitle2">10金额
                        </td>
                        <td class="listTitle2">11金额
                        </td>
                        <td class="listTitle2">12金额
                        </td>
                        <td class="listTitle2">13金额
                        </td>
                        <td class="listTitle2">金额合计
                        </td>
                        <td class="listTitle2">人数合计
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
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild1" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild2" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild3" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild4" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild5" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild6" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild7" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild8" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild9" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild10" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild11" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild12" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild13" ).ToString())%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "MoneyCount" ).ToString())%>
                                </td>
                                <td>
                                    <%# Eval( "PersonCount" )%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </asp:Panel>
            <asp:Panel runat="server" ID="bb">
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
                    <asp:Repeater ID="Repeater1" runat="server">
                        <ItemTemplate>
                            <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                                onmouseout="this.style.backgroundColor=currentcolor">
                                <td>
                                    <%# Eval( "CountTime" ).ToString()%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild1" ).ToString())%>
                                </td>
                                <td>
                                    <%# Eval( "Faild2" ).ToString()%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild3" ).ToString())%>
                                </td>
                                <td>
                                    <%# Eval( "Faild4" )%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "Faild5" ).ToString())%>
                                </td>
                                <td>
                                    <%# Eval( "Faild6" )%>
                                </td>
                                <td>
                                    <%# FacadeManage.ConversionMoneyToShow(Eval( "MoneyCount" ).ToString())%>
                                </td>
                                <td>
                                    <%# Eval( "PersonCount" )%>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </asp:Panel>
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
