<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChannelConfig.aspx.cs" Inherits="Game.Web.Module.FilledManager.ChannelConfig" %>

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
                    <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="Redirect('ChanelPage.aspx')" />
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
                        <td class="listTdLeft">通道类型：
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlProductType" runat="server" Width="155" Height="24" CssClass="text" AutoPostBack="True">
                                <asp:ListItem Text="微信" Value="1"></asp:ListItem>
                                <asp:ListItem Text="支付宝" Value="2"></asp:ListItem>
                                <asp:ListItem Text="云闪付" Value="3"></asp:ListItem>
                                <asp:ListItem Text="网银转账" Value="4"></asp:ListItem>
                            </asp:DropDownList>
                        </td>

                        <td class="listTdLeft">通道名称：
                        </td>
                        <td>
                            <asp:TextBox ID="txtProductName" runat="server" CssClass="text"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="请输入通道名称" Display="Dynamic" ControlToValidate="txtProductName" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">请求结构：
                        </td>
                        <td>
                            <asp:TextBox ID="Sendpamar" runat="server" CssClass="text" TextMode="MultiLine" Width="450px" Height="150px"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="请输入通道名称" Display="Dynamic" ControlToValidate="Sendpamar" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">充值比列：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="请输入充值比列" Display="Dynamic" ControlToValidate="TextBox2" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">签名位置：
                        </td>
                        <td>
                            <asp:TextBox ID="Singpos" runat="server" CssClass="text" MaxLength="50"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="签名位置" Display="Dynamic" ControlToValidate="Singpos" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">请求方式：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox3" runat="server" CssClass="text" MaxLength="4"></asp:TextBox>
                            <span class="hong">1 post 2 get</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="必须填写发送方法" Display="Dynamic" ControlToValidate="TextBox3" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">返回签名位置：
                        </td>
                        <td>
                            <asp:TextBox ID="RespSign" runat="server" CssClass="text"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">结果key：
                        </td>
                        <td>
                            <asp:TextBox ID="RespCode" runat="server" CssClass="text"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">成功结果值：
                        </td>
                        <td>
                            <asp:TextBox ID="SuccessCode" runat="server" CssClass="text"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">内容key：
                        </td>
                        <td>
                            <asp:TextBox ID="InfoName" runat="server" CssClass="text"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">内容类型：
                        </td>
                        <td>
                            <asp:TextBox ID="InfoType" runat="server" CssClass="text" Text="0" MaxLength="1"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="必须填写内容类型" Display="Dynamic" ControlToValidate="InfoType" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">异步订单key：
                        </td>
                        <td>
                            <asp:TextBox ID="Orderkey" runat="server" CssClass="text"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="必须填写" Display="Dynamic" ControlToValidate="Orderkey" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">异步签名key：
                        </td>
                        <td>
                            <asp:TextBox ID="Signkey" runat="server" CssClass="text"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="必须填写" Display="Dynamic" ControlToValidate="Signkey" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">异步金币key：
                        </td>
                        <td>
                            <asp:TextBox ID="Moneykey" runat="server" CssClass="text"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="必须填写" Display="Dynamic" ControlToValidate="Moneykey" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">异步结果key：
                        </td>
                        <td>
                            <asp:TextBox ID="Codekey" runat="server" CssClass="text"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">异步成功值：
                        </td>
                        <td>
                            <asp:TextBox ID="CodeSuccess" runat="server" CssClass="text"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">返回字符：
                        </td>
                        <td>
                            <asp:TextBox ID="Backstring" runat="server" CssClass="text"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">发送加密方式：
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server" Width="155" Height="24" CssClass="text">
                            </asp:DropDownList>
                        </td>

                        <td class="listTdLeft">返回解密方式：
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList2" runat="server" Width="155" Height="24" CssClass="text">
                            </asp:DropDownList>
                        </td>

                        <td class="listTdLeft">异步解密方式：
                        </td>
                        <td>
                            <asp:DropDownList ID="DropDownList3" runat="server" Width="155" Height="24" CssClass="text">
                            </asp:DropDownList>
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
