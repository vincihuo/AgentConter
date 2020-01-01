<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EncryptionInfo.aspx.cs" Inherits="Game.Web.Module.FilledManager.EncryptionInfo" %>

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
                    <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="Redirect('EncryptionList.aspx')" />
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
                        <td class="listTdLeft">签名名称：
                        </td>
                        <td>
                            <asp:TextBox ID="TxtName" runat="server" CssClass="text"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="请签名方法名称" Display="Dynamic" ControlToValidate="TxtName" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">key名：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="text"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">key位置：
                        </td>
                        <td>
                            <asp:TextBox ID="SignArray" runat="server" CssClass="text"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">结构拆分方式：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox3" runat="server" CssClass="text" MaxLength="4"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="必须填写拆分方法" Display="Dynamic" ControlToValidate="TextBox3" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">连接符1：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="text" MaxLength="4"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">连接符2：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox4" runat="server" CssClass="text" MaxLength="4"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">签名类型：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox5" runat="server" CssClass="text" MaxLength="4"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="必须填写发送方法" Display="Dynamic" ControlToValidate="TextBox5" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">大小写：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox6" runat="server" CssClass="text" MaxLength="1"></asp:TextBox>
                            <span class="hong">1 小写 2 大写</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="必须填写发送方法" Display="Dynamic" ControlToValidate="TextBox6" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>


                    <tr>
                        <td class="listTdLeft">加密位置：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox7" runat="server" CssClass="text" MaxLength="1"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">加密字段名：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox8" runat="server" CssClass="text" MaxLength="1"></asp:TextBox>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">加密类型：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox9" runat="server" CssClass="text" MaxLength="1"></asp:TextBox>
                            <span class="hong">没有填0</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="必须填写发送方法" Display="Dynamic" ControlToValidate="TextBox9" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="Redirect('EncryptionList.aspx')" />
                    <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>

    </form>
</body>
</html>
