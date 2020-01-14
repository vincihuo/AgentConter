<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DomainNameList.aspx.cs" Inherits="Game.Web.Module.AgentManager.DomainNameList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <script type="text/javascript" src="../../scripts/comm.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
            <tr>
                <td width="19" height="25" valign="top" class="Lpd10">
                    <div class="arr">
                    </div>
                </td>
                <td width="1232" height="25" valign="top" align="left">你当前位置：代理系统 - 域名配置
                </td>
            </tr>
        </table>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btn1" type="button" class="btn wd1" value="新增域名" onclick="Redirect('DomainNameSet.aspx');" />
                </td>
            </tr>
        </table>


        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
                <tr align="center" class="bold">
                    <td class="listTitle2">域名类型
                    </td>
                    <td class="listTitle2">域名
                    </td>
                    <td class="listTitle2">推广标识
                    </td>
                    <td class="listTitle2">推广人数
                    </td>
                    <td class="listTitle2">状态
                    </td>
                    <td class="listTitle2">模板样式
                    </td>
                    <td class="listTitle2">操作
                    </td>
                </tr>
                <asp:Repeater ID="rptDataList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%#GetUrlTyep(Convert.ToByte(Eval("Type")))%>
                            </td>
                            <td>
                                <a href='<%# Eval("Url")%>'target="_blank" class ="lan"><%# Eval("Url")%></a>
                            </td>
                            <td>
                                <%# GetAgent(Convert.ToInt32(Eval("AgentId")))%>
                            </td>
                            <td>
                                <%# Eval("Number")%>
                            </td>
                            <td>
                                <%# Convert.ToByte(Eval("State"))==0?"禁用":"启用"%>
                            </td>
                            <td>
                               默认模板
                            </td>
                            <td>
                                <a class="l" href="javascript:void(0)" onclick="openWindowOwn('DomainNameSet.aspx?param=<%#Eval("id").ToString() %>','tip',600,300);">编辑</a>
                                <asp:LinkButton runat="server" ForeColor="blue" OnClientClick='<%#SetDelete(Convert.ToByte(Eval("Type")),Eval("Url").ToString()) %>' OnClick="DeleteUrl" CommandArgument='<%#Eval("id").ToString() %>' >删除</asp:LinkButton>
                                <asp:LinkButton runat="server" ForeColor="blue" OnClientClick='<%#SetOff(Convert.ToByte(Eval("Type")),Convert.ToByte(Eval("State")),Eval("Url").ToString()) %>' OnClick="OffUrl" CommandArgument='<%#Convert.ToInt32(Eval("id"))*10+Convert.ToInt32(Eval("State"))%>' ><%#GetState(Convert.ToByte(Eval("State"))) %></asp:LinkButton>
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
