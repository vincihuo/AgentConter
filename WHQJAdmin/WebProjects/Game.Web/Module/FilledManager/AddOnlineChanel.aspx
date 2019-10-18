<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddOnlineChanel.aspx.cs" Inherits="Game.Web.Module.FilledManager.AddOnlineChanel" %>

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
                    <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="Redirect('OnLinePayPage.aspx')" />
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
                        <td height="35" colspan="2" class="f14 bold Lpd10 Rpd10">
                            <div class="hg3  pd7">
                                产品信息
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">通道类型：
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlProductType" runat="server" Width="155" Height="24" CssClass="text" AutoPostBack="True" OnSelectedIndexChanged="ddlProductType_SelectedIndexChanged">
                                <asp:ListItem Text="微信" Value="0"></asp:ListItem>
                                <asp:ListItem Text="支付宝" Value="1"></asp:ListItem>
                                <asp:ListItem Text="云闪付" Value="2"></asp:ListItem>
                                <asp:ListItem Text="网银转账" Value="3"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">通道名称：
                        </td>
                        <td>
                            <asp:TextBox ID="txtProductName" runat="server" CssClass="text"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="请输入通道名称" Display="Dynamic" ControlToValidate="txtProductName" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">渠道选择：
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" Width="155" Height="24" CssClass="text">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">商户ID：
                        </td>
                        <td>
                            <asp:TextBox ID="tetUID" runat="server" CssClass="text" MaxLength="50"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="请输入商户ID" Display="Dynamic" ControlToValidate="txtPrice" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">Md5密钥：
                        </td>
                        <td>
                            <asp:TextBox ID="TexMd5" runat="server" CssClass="text" MaxLength="32"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">对称私钥：
                        </td>
                        <td>
                            <asp:TextBox ID="TxtPrivateKey" runat="server" CssClass="text" TextMode="MultiLine" Width="450px" Height="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">对称公钥：
                        </td>
                        <td>
                            <asp:TextBox ID="TxtPublicKey" runat="server" CssClass="text" TextMode="MultiLine" Width="450px" Height="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">快捷金额：
                        </td>
                        <td>
                            <asp:TextBox ID="txtPrice" runat="server" CssClass="text" MaxLength="30"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="请输入快捷金额" Display="Dynamic" ControlToValidate="txtPrice" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">首充类别：
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" Width="155" Height="24" CssClass="text">
                                <asp:ListItem Text="普通" Value="0"></asp:ListItem>
                                <asp:ListItem Text="首充" Value="1"></asp:ListItem>
                                <asp:ListItem Text="每日" Value="2"></asp:ListItem>
                                <asp:ListItem Text="热卖" Value="3"></asp:ListItem>
                                <asp:ListItem Text="人气" Value="4"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">首冲赠送比列：
                        </td>
                        <td>
                            <asp:TextBox ID="txtFristPresent" runat="server" CssClass="text" Text="0" MaxLength="9"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="请输入赠送数量" Display="Dynamic" ControlToValidate="txtFristPresent" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="赠送数量格式不正确" Display="Dynamic" ControlToValidate="txtFristPresent" ForeColor="Red" ValidationExpression="^[0-9]\d*$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">充值赠送比列：
                        </td>
                        <td>
                            <asp:TextBox ID="txtPresentScore" runat="server" CssClass="text" Text="0" MaxLength="9"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="请输入赠送数量" Display="Dynamic" ControlToValidate="txtPresentScore" ForeColor="Red"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="赠送数量格式不正确" Display="Dynamic" ControlToValidate="txtPresentScore" ForeColor="Red" ValidationExpression="^[0-9]\d*$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">排序标识：
                        </td>
                        <td>
                            <asp:TextBox ID="SortID" runat="server" CssClass="text" Text="0" MaxLength="9"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">预留字段：
                        </td>
                        <td>
                            <asp:TextBox ID="AttaBox" runat="server" CssClass="text" MaxLength="100"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnReturn2" type="button" value="返回" class="btn wd1" onclick="Redirect('OnLinePayPage.aspx')" />
                    <asp:Button ID="btnSave2" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>

    </form>
</body>
</html>
