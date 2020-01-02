<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MailAddPage.aspx.cs" Inherits="Game.Web.Module.MailManager.MailAddPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>发送邮件</title>
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" src="/scripts/common.js"></script>
    <script type="text/javascript" src="/scripts/jquery.js"></script>
</head>
<body>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">目前操作功能：邮件系统 - 邮件编辑
            </td>
        </tr>
    </table>

    <form id="form1" runat="server">
        <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input type="button" value="关闭" class="btn wd1" onclick="window.close();" />
                    <asp:Button ID="btnSave" runat="server" Text="确认" CssClass="btn wd1" OnClick="btnSave_Click" />
                </td>
            </tr>
        </table>
        <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2" style="height: 136px;">
            <tr runat="server" id="trGameID">
                <td class="listTdLeft">玩家游戏ID：
                </td>
                <td>
                    <asp:TextBox ID="txtGameID" runat="server" CssClass="text wd4" MaxLength="7"></asp:TextBox>
                    <span class="hong">0表示发送所有玩家</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="请输入邮件标题" Display="Dynamic" ControlToValidate="txtGameID" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">邮件标题：
                </td>
                <td>
                    <asp:TextBox ID="TextTitle" runat="server" MaxLength="8" CssClass="text wd4"></asp:TextBox>
                    <span class="hong">8个字以内</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="请输入玩家id" Display="Dynamic" ControlToValidate="TextTitle" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">邮件内容：
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" TextMode="MultiLine" MaxLength="500" Height="200" Width="300"></asp:TextBox>
                    <span class="hong">*</span>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="请输入邮件内容" Display="Dynamic" ControlToValidate="TextTitle" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">附加金币数：
                </td>
                <td>
                    <asp:TextBox ID="txtGold" runat="server" Text="0" CssClass="text wd4"></asp:TextBox>
                </td>
            </tr>

            <tr>
                <td class="listTdLeft">增加打码量：
                </td>
                <td>
                    <asp:TextBox ID="txtVileBet" runat="server" Text="0" CssClass="text wd4"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">附加钻石量：
                </td>
                <td>
                    <asp:TextBox ID="TextDimao" runat="server" Text="0" CssClass="text wd4"></asp:TextBox>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
