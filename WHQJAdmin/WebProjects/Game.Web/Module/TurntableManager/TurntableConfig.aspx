<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TurntableConfig.aspx.cs" Inherits="Game.Web.Module.TurntableManager.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>转盘</title>
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
            <td width="1232" height="25" valign="top" align="left">你当前位置：转盘系统 - 转盘配置
            </td>
        </tr>
    </table>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td>
                    <a class="listTdLeft">转盘选择：</a>
                    <asp:DropDownList ID="ddlProductType" runat="server" Width="155" Height="24" CssClass="text" AutoPostBack="True" OnSelectedIndexChanged="ddlProductType_SelectedIndexChanged">
                        <asp:ListItem Text="白银转盘" Value="0"></asp:ListItem>
                        <asp:ListItem Text="黄金转盘" Value="1"></asp:ListItem>
                        <asp:ListItem Text="钻石转盘" Value="2"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td>
                    <a class="listTdLeft">消耗积分</a>
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="text" MaxLength="20"></asp:TextBox>
                    <span class="hong">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="转盘消耗不能为空" Display="Dynamic" ControlToValidate="TextBox1" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Score" />
                </td>
                <td>
                    <a class="listTdLeft">加数据调用几率</a>
                    <asp:TextBox ID="TextBox2" runat="server" CssClass="text" MaxLength="20"></asp:TextBox>
                    <span class="hong">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="模拟数据调用几率不能为空" Display="Dynamic" ControlToValidate="TextBox2" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:Button ID="Button2" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Pre" />
                </td>
            </tr>
        </table>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box Tmg7" id="list">
            <tr align="center" class="bold">
                <td class="listTitle2">菜单名
                </td>
                <td class="listTitle2">位置1
                </td>
                <td class="listTitle2">位置2
                </td>
                <td class="listTitle2">位置3
                </td>
                <td class="listTitle2">位置4
                </td>
                <td class="listTitle2">位置5
                </td>
                <td class="listTitle2">位置6
                </td>
                <td class="listTitle2">位置7
                </td>
                <td class="listTitle2">位置8
                </td>
                <td class="listTitle2">位置9
                </td>
                <td class="listTitle2">位置10
                </td>
                <td class="listTitle2">位置11
                </td>
                <td class="listTitle2">位置12
                </td>
                <td class="listTitle2">位置13
                </td>
            </tr>
            <asp:Repeater ID="rptShareInfo" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td>
                            <a href="TurntableConfigInfo.aspx?param=<%# Eval( "id" ).ToString( )%>" class="l"> <%# Eval("MenuName")%></a>
                        </td>
                        <td>
                            <%# Eval("Value1")%>
                        </td>
                        <td>
                            <%# Eval("Value2")%>
                        </td>
                        <td>
                            <%# Eval("Value3")%>
                        </td>
                        <td>
                            <%# Eval("Value4")%>
                        </td>
                        <td>
                            <%# Eval("Value5")%>
                        </td>
                        <td>
                            <%# Eval("Value6")%>
                        </td>
                        <td>
                            <%# Eval("Value7")%>
                        </td>
                        <td>
                            <%# Eval("Value8")%>
                        </td>
                        <td>
                            <%# Eval("Value9")%>
                        </td>
                        <td>
                            <%# Eval("Value10")%>
                        </td>
                        <td>
                            <%# Eval("Value11")%>
                        </td>
                        <td>
                            <%# Eval("Value12")%>
                        </td>
                        <td>
                            <%# Eval("Value13")%>
                        </td>
                    </tr>
                </ItemTemplate>
            </asp:Repeater>
        </table>

    </form>
</body>
</html>
