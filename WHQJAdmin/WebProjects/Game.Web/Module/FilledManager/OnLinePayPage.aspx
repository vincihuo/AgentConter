<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OnLinePayConfig.aspx.cs" Inherits="Game.Web.Module.FilledManager.OnLinePayPage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
                <td width="1232" height="25" valign="top" align="left">你当前位置：充值系统 - 线上冲值配置
                </td>
            </tr>
        </table>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titleOpBg Lpd10">
                    <input id="btnNew1" type="button" class="btn wd1" value="新增" onclick="Redirect('AddOnlineChanel.aspx')" />
                    <input class="btnLine" type="button" />
                    <asp:Button ID="btnDelete" runat="server" Text="删除" CssClass="btn wd1" OnClick="btnDelete_Click" OnClientClick="return deleteop()" />
                </td>
            </tr>
        </table>

        <div id="content">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
                <tr align="center" class="bold">
                    <td style="width: 30px;" class="listTitle">
                        <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" /></td>
                    <td class="listTitle1">管理
                    </td>
                    <td class="listTitle2">充值类型
                    </td>
                    <td class="listTitle2">通道名称
                    </td>
                    <td class="listTitle2">用户ID
                    </td>
                    <td class="listTitle2">支付网关
                    </td>
                    <td class="listTitle2">md5密钥
                    </td>
                    <td class="listTitle2">对称公钥
                    </td>
                    <td class="listTitle2">对称私钥
                    </td>
                    <td class="listTitle2">快捷金额
                    </td>
                    <td class="listTitle2">首充奖励
                    </td>
                    <td class="listTitle2">首充类型
                    </td>
                    <td class="listTitle2">优惠金额
                    </td>
                    <td class="listTitle2">渠道名称
                    </td>
                    <td class="listTitle2">排序标识
                    </td>
                </tr>
                <asp:Repeater ID="rptDataList" runat="server">
                    <ItemTemplate>
                        <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                            onmouseout="this.style.backgroundColor=currentcolor">
                            <td>
                                <%# "<input name='cid' type='checkbox' value='" + Eval("ID").ToString() + "'/>" %>
                            </td>
                            <td>
                                <a href="AddOnlineChanel.aspx?param=<%# Eval( "ID" ).ToString( )%>" class="l">编辑</a>
                            </td>
                            <td>
                                <%# GetPayTypeName(Convert.ToInt32(Eval("PayType").ToString())) %>
                            </td>
                            <td>
                                <%# Eval("PayName")%>
                            </td>
                            <td>
                                <%# Eval("UID")%>
                            </td>
                            <td>
                                <%# Eval("PayUrl")%>
                            </td>

                            <td>
                                <%# Eval("Md5key")%>
                            </td>
                            <td>
                                <div width="80">
                                    <%# Eval("PrivateKey")%>
                                </div>
                            </td>
                            <td>
                                <div width="80">
                                    <%# Eval("PublicKey")%>
                                </div>
                            </td>
                            <td>
                                <%# Eval("ShoutCut")%>
                            </td>
                            <td>
                                <%# Eval("FristPresent") %> 
                            </td>
                            <td>
                                <%#Convert.ToInt32( Eval("PayIdentity").ToString())==0?"普通充值":Convert.ToInt32( Eval("PayIdentity").ToString())==1?"首冲":Convert.ToInt32( Eval("PayIdentity").ToString())==2?"每日":Convert.ToInt32( Eval("PayIdentity").ToString())==3?"热卖":"人气"%>
                            </td>
                            <td>
                                <%# Eval("PresentScore") %>
                            </td>
                            <td>
                                <%# Eval("chanelName").ToString()%>
                            </td>
                            <td>
                                <%# Eval("SortID").ToString()%>
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
                    <gsp:AspNetPager ID="anpNews" runat="server" OnPageChanged="anpNews_PageChanged" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
                        PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                        NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%">
                    </gsp:AspNetPager>
                </td>
            </tr>
        </table>


    </form>
</body>
</html>
