<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OfficalImgPayList.aspx.cs" Inherits="Game.Web.Module.FilledManager.OfficalImgPayList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
            <tr>
                <td width="19" height="25" valign="top" class="Lpd10">
                    <div class="arr">
                    </div>
                </td>
                <td width="1232" height="25" valign="top" align="left">你当前位置：充值系统 - 线上冲值配置
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnNew1" type="button" class="btn wd1" value="新增" onclick="Redirect('OfficalImgPayInfo.aspx')" />
                    <input class="btnLine" type="button" />
                    <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()" />
                </td>
            </tr>
        </table>

        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
                <tr align="center" class="bold">
                    <td style="width: 30px;" class="listTitle">
                        <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" /></td>
                    <td class="listTitle1">管理
                    </td>
                    <td class="listTitle2">渠道名称
                    </td>
                    <td class="listTitle2">类型
                    </td>
                    <td class="listTitle2">支付链接
                    </td>
                    <td class="listTitle2">最低入款
                    </td>
                    <td class="listTitle2">最高入款
                    </td>
                </tr>
                <asp:Repeater ID="rptDataList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%# "<input name='cid' type='checkbox' value='" + Eval("id").ToString() + "'/>" %>
                            </td>
                            <td>
                                <a href="OfficalImgPayInfo.aspx?param=<%# Eval( "id" ).ToString( )%>" class="l">编辑</a>
                            </td>
                            <td>
                                <%# Eval("ConfigName")%>
                            </td>
                            <td>
                                <%# GetTypeStr(Convert.ToInt32(Eval("PayType")))%>
                            </td>
                            <td>
                                <%# Eval("PayUrl")%>
                            </td>
                            <td>
                                <%# Eval("MinAmount")%>
                            </td>
                            <td>
                                <%# Eval("MaxAmount")%>
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
