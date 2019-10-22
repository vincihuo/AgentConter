<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DrawalOrderInfo.aspx.cs" Inherits="Game.Web.Module.DrawalManager.DrawalOrderInfo" %>

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
                <td width="1232" height="25" valign="top" align="left">你当前位置：提现系统 - 提现订单
                </td>
            </tr>
        </table>


        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input type="button" value="返回" class="btn wd1" onclick="Redirect('DrawalOrderPage.aspx')" />
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="listBg2">

            <tr>
                <td class="listTdLeft">订单号：
                </td>
                <td>
                    <asp:Literal ID="TxtOrderId" runat="server"></asp:Literal>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">游戏ID：
                </td>
                <td>
                    <asp:Literal ID="TxtGameID" runat="server"></asp:Literal>
                </td>
            </tr>

            <tr>
                <td class="listTdLeft">提现金额：
                </td>
                <td>
                    <asp:Literal ID="TxtAmount" runat="server"></asp:Literal>
                </td>
            </tr>

            <tr>
                <td class="listTdLeft">手续费：
                </td>
                <td>
                    <asp:Literal ID="TxtOrderCost" runat="server"></asp:Literal>
                </td>
            </tr>

            <tr>
                <td class="listTdLeft">处理账号：
                </td>
                <td>
                    <asp:Literal ID="TxtMasterID" runat="server"></asp:Literal>
                </td>
            </tr>

            <tr>
                <td class="listTdLeft">订单状态：
                </td>
                <td>
                    <asp:Literal ID="TextState" runat="server"></asp:Literal>
                    <asp:Button ID="BtnY" Text="同意"  runat="server" OnClick="OnBtnY" />
                    <asp:Button ID="BtnN" Text="拒绝"  runat="server" OnClick="OnBtnN" />
                </td>
            </tr>

            <tr>
                <td class="listTdLeft">订单时间：
                </td>
                <td>
                    <asp:Literal ID="TxtCurrTime" runat="server"></asp:Literal>
                </td>
            </tr>

            <tr>
                <td class="listTdLeft">处理时间：
                </td>
                <td>
                    <asp:Literal ID="TxtDealTime" runat="server"></asp:Literal>
                </td>
            </tr>
            <tr>
                <td class="listTdLeft">下单地址：
                </td>
                <td>
                    <asp:Literal ID="IP" runat="server"></asp:Literal>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input type="button" value="返回" class="btn wd1" onclick="Redirect('DrawalOrderPage.aspx')" />
                </td>
            </tr>
        </table>



    </form>
</body>
</html>
