<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VipConfigInfo.aspx.cs" Inherits="Game.Web.Module.VipManager.VipConfigInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
                <td width="1232" height="25" valign="top" align="left">你当前位置：转盘系统 - 转盘配置
                </td>
            </tr>
        </table>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="Redirect('VipConfigList.aspx')" />
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
                        <td class="listTdLeft">等级：
                        </td>
                        <td>
                            <asp:Label runat="server" ID="TextLevel"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">晋级条件：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox2" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox2" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">晋级奖励：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox3" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox3" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">周奖励：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox4" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox4" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">月奖励：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox5" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox5" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">签到奖励1：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox6" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox6" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">签到奖励2：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox7" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox7" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">签到奖励3：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox8" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox8" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">签到奖励4：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox9" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox9" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>

                    <tr>
                        <td class="listTdLeft">签到奖励5：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox1" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox1" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">签到奖励6：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox10" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox10" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td class="listTdLeft">签到奖励7：
                        </td>
                        <td>
                            <asp:TextBox ID="TextBox11" runat="server" CssClass="text" MaxLength="10"></asp:TextBox>
                            <span class="hong">*</span>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="不能为空" Display="Dynamic" ControlToValidate="TextBox11" ForeColor="Red"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnReturn" type="button" value="返回" class="btn wd1" onclick="Redirect('VipConfigList.aspx')" />
                    <asp:Button ID="Button1" runat="server" Text="保存" CssClass="btn wd1" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>

    </form>
</body>
</html>
