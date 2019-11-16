<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AgentList.aspx.cs" Inherits="Game.Web.Module.AgentManager.AgentList" %>

<%@ Import Namespace="Game.Facade" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="../../scripts/common.js"></script>

    <script type="text/javascript" src="../../scripts/comm.js"></script>

     <script type="text/javascript">
         function getnickname(id) {
             $("#txtGameID")
         }
  </script>

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
                <td width="1232" height="25" valign="top" align="left">你当前位置：用户系统 - 代理账号
                </td>
            </tr>
        </table>
        <!-- 头部菜单 End -->
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
            <tr>
                <td align="center" style="width: 80px">代理查询：
                </td>
                <td>
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox>
                    <asp:DropDownList ID="ddlSearchType" runat="server">
                        <asp:ListItem Text="游戏ID" Value="1"></asp:ListItem>
                        <asp:ListItem Text="上级ID" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
                </td>
            </tr>
        </table>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
            <tr>
                <td height="39" class="titleOpBg">
                    <input type="button" value="新增" class="btn wd1" onclick="openWindowOwn('AgentUserInfo.aspx', 'addagent', 700, 600)" />
                </td>
            </tr>
        </table>
        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
                <tr align="center" class="bold">
                    <td class="listTitle">
                        <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
                    </td>
                    <td class="listTitle2">管理
                    </td>
                    <td class="listTitle2">游戏ID
                    </td>
                    <td class="listTitle2">代理昵称
                    </td>
                    <td class="listTitle2">下级人数
                    </td>
                    <td class="listTitle2">代理域名
                    </td>
                    <td class="listTitle2">当前奖励
                    </td>
                    <td class="listTitle2">已领奖励
                    </td>
                    <td class="listTitle2">上级返利
                    </td>
                    <td class="listTitle2">代理操作
                    </td>
                </tr>
                <asp:Repeater ID="rptDataList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td style="width: 30px;">
                                <input name='cid' type='checkbox' value='<%# Eval("UserID").ToString()%>' />
                            </td>
                            <td>
                                <a href="javascript:;" class="l" onclick="openWindowOwn('AgentUserUpdate.aspx?param=<%# Eval( "UserID") %>', '', 700,490);">编辑</a>
                            </td>
                            <td>
                                <%# Eval( "GameID" ) %>
                            </td>
                            <td>
                                <%# Eval( "NickName" ) %>
                            </td>
                            <td>
                                <%# Eval( "BeggarNumber" ) %>
                            </td>
                            <td>
                                <%# Eval( "LinkUrl" ) %>
                            </td>
                            <td>
                                <%#FacadeManage.ConversionMoneyToShow(Eval("Reward").ToString()) %>
                            </td>
                            <td>
                                <%#FacadeManage.ConversionMoneyToShow(Eval("AllReward").ToString()) %>
                            </td>
                            <td>
                                <%#FacadeManage.ConversionMoneyToShow(Eval("BackMoney").ToString())%>
                            </td>

                            <td>
                                <asp:Button runat="server" Text="查看下级"  OnClick="SelectBeggar" CommandArgument='<%# Eval("GameID")%>' />
                                <a class="l" href="javascript:void(0)" onclick="javascript:openWindowOwn('AgentUserUnder.aspx?param=<%#Eval("UserID").ToString() %>','UnderUser',700,600);">结算记录</a>
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
