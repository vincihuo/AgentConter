<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OfficalImgPayInfo.aspx.cs" Inherits="Game.Web.Module.FilledManager.OfficalImgPayInfo" %>

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
                <td width="1232" height="25" valign="top" align="left">你当前位置：充值系统 - 充值配置
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="Redirect('OfficalImgPayList.aspx')" />
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
                        <td class="listTdLeft">渠道名称：
                        </td>
                        <td>
                            <asp:TextBox ID="TxtName" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="请输入渠道名称" Display="Dynamic" ControlToValidate="TxtName" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">充值类型：
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlProductType" runat="server" Width="155" Height="24" CssClass="text" AutoPostBack="True">
                                <asp:ListItem Text="微信固码" Value="1"></asp:ListItem>
                                <asp:ListItem Text="QQ固码" Value="2"></asp:ListItem>
                                <asp:ListItem Text="支付宝固码" Value="3"></asp:ListItem>
                                <asp:ListItem Text="云闪付固码" Value="4"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">充值链接：
                        </td>
                        <td>
                            <asp:TextBox ID="PayUrl" runat="server" CssClass="text" MaxLength="50"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="请输入银行卡号" Display="Dynamic" ControlToValidate="PayUrl" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">最高充值：
                        </td>
                        <td>
                            <asp:TextBox ID="TexMax" runat="server" CssClass="text" MaxLength="50"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="请输入充值下限" Display="Dynamic" ControlToValidate="TexMax" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">最低充值：
                        </td>
                        <td>
                            <asp:TextBox ID="TexMin" runat="server" CssClass="text" MaxLength="50"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="请输入充值上限" Display="Dynamic" ControlToValidate="TexMin" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">附加说明：
                        </td>
                        <td>
                            <asp:TextBox ID="TexDescription" runat="server" CssClass="text" MaxLength="50"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">排序标识：
                        </td>
                        <td>
                            <asp:TextBox ID="TexSort" runat="server" CssClass="text" MaxLength="5"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="请输入开户地址" Display="Dynamic" ControlToValidate="TexSort" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="Redirect('OfficalImgPayList.aspx')" />
                    <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
