<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DomainNameSet.aspx.cs" Inherits="Game.Web.Module.AgentManager.DomainNameSet" %>

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
                <td width="1232" height="25" valign="top" align="left">你当前位置：代理系统 - 域名配置
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="window.close();" />
                    <asp:Button ID="btnCreate" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="True">
            <ContentTemplate>
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">
                    <tr>
                        <td class="listTdLeft">域名类型：
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlProductType" runat="server" Width="155" Height="24" CssClass="text" AutoPostBack="True" OnSelectedIndexChanged="ddlProductType_SelectedIndexChanged">
                                <asp:ListItem Text="下载域名" Value="1"></asp:ListItem>
                                <asp:ListItem Text="通用推广域名" Value="2"></asp:ListItem>
                                <asp:ListItem Text="专属推广域名" Value="3"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                        <td>
                            <asp:Label runat="server" ID="typeText"></asp:Label>
                        </td>

                    </tr>
                    <tr>
                        <td class="listTdLeft">域名地址：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBoxUrl" runat="server" CssClass="text"></asp:TextBox>
                            <span class="hong">http:// 或者 https:// 开头</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="请输入域名地址" Display="Dynamic" ControlToValidate="TextBoxUrl" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">推广标识：
                        </td>
                        <td>
                            <asp:TextBox ID="TextSign" runat="server" CssClass="text" Text="0"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="输入标识" Display="Dynamic" ControlToValidate="TextSign" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">状态：
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownListState" runat="server" Width="155" Height="24" CssClass="text" AutoPostBack="True" OnSelectedIndexChanged="ddlProductType_SelectedIndexChanged">
                                <asp:ListItem Text="禁用" Value="0"></asp:ListItem>
                                <asp:ListItem Text="启用" Value="1"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:Label runat="server" ID="LableHit" class="hong" >启用新的下载域名其他下载域名将被禁用</asp:Label>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnReturn1" type="button" value="返回" class="btn wd1" onclick="window.close();" />
                    <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>

    </form>
</body>
</html>
