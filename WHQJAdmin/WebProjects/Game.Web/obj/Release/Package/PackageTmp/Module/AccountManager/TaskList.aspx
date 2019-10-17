﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TaskList.aspx.cs" Inherits="Game.Web.Module.AccountManager.TaskList" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link href="../../styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../../scripts/common.js"></script>
    <script type="text/javascript" src="../../scripts/comm.js"></script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <!-- 头部菜单 Start -->
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="title">
        <tr>
            <td width="19" height="25" valign="top" class="Lpd10">
                <div class="arr">
                </div>
            </td>
            <td width="1232" height="25" valign="top" align="left">
                你当前位置：用户系统 - 任务管理
            </td>
        </tr>
    </table>
    <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
        <tr>
            <td height="28">
                <ul>
                    <li class="tab1">任务管理</li>
                    <li class="tab2" onclick="Redirect('RecordTaskList.aspx')">任务记录</li>
                </ul>
            </td>
        </tr>
    </table>
    <!-- 头部菜单 End -->
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
        <tr>
            <td class="listTdLeft" style="width: 80px">
                任务名称：
            </td>
            <td>
                <asp:TextBox ID="txtSearch" runat="server" CssClass="text"></asp:TextBox>
                <asp:Button ID="btnQuery" runat="server" Text="查询" CssClass="btn wd1" OnClick="btnQuery_Click" />
            </td>
        </tr>
    </table>
    <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
        <tr>
            <td height="39" class="titleOpBg">
                <input type="button" value="新增" class="btn wd1" onclick="Redirect('TaskInfo.aspx')" />
            </td>
        </tr>
    </table>
    <div id="content">
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="box" id="list">
            <tr align="center" class="bold">
                <td class="listTitle1">
                    <input type="checkbox" name="chkAll" onclick="SelectAll(this.checked);" />
                </td>
                <td class="listTitle2">
                    管理
                </td>
                <td class="listTitle2">
                    任务标识
                </td>
                <td class="listTitle2">
                    任务名称
                </td>
                 <td class="listTitle2">
                    任务描述
                </td>
                <td class="listTitle2">
                    任务类型
                </td>
                <td class="listTitle2">
                    用户类型
                </td>
                <td class="listTitle">
                    时间类型
                </td>
                <td class="listTitle">
                    任务奖励
                </td>
                <td class="listTitle2">
                    完成目标数
                </td>
                <td class="listTitle2">
                    冻结状态
                </td>
            </tr>
            <asp:Repeater ID="rptDataList" runat="server">
                <ItemTemplate>
                    <tr align="center" class="list" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td style="width: 30px;">
                            <input name='cid' type='checkbox' value='<%# Eval("TaskID").ToString()%>' />
                        </td>
                        <td style="width: 100px;">
                            <a class="l" href="<%#"TaskInfo.aspx?param="+Eval("TaskID").ToString() %>">编辑</a>
                        </td>
                        <td>
                            <%# Eval( "TaskID" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "TaskName" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "TaskDescription" ).ToString( )%>
                        </td>
                        <td>
                            <%# TaskTypeName(Convert.ToInt32(Eval( "TaskType" )))%>
                        </td>
                        <td>
                            <%# UserTypeName(Convert.ToInt32(Eval( "UserType" )))%>
                        </td>
                        <td>
                            <%# TimeTypeName(Convert.ToInt32(Eval( "TimeType" )))%>
                        </td>
                        <td>
                            <%# GetTaskAward(Eval( "TaskAward" ).ToString()) %>
                        </td>
                        <td>
                            <%# Eval( "Innings" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetNullityStatus(Convert.ToByte(Eval( "Nullity" )))%>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr align="center" class="listBg" onmouseover="currentcolor=this.style.backgroundColor;this.style.backgroundColor='#caebfc';this.style.cursor='default';"
                        onmouseout="this.style.backgroundColor=currentcolor">
                        <td style="width: 30px;">
                            <input name='cid' type='checkbox' value='<%# Eval("TaskID").ToString()%>' />
                        </td>
                        <td style="width: 100px;">
                            <a class="l" href="<%#"TaskInfo.aspx?param="+Eval("TaskID").ToString() %>">编辑</a>
                        </td>
                        <td>
                            <%# Eval( "TaskID" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "TaskName" ).ToString( )%>
                        </td>
                        <td>
                            <%# Eval( "TaskDescription" ).ToString( )%>
                        </td>
                        <td>
                            <%# TaskTypeName(Convert.ToInt32(Eval( "TaskType" )))%>
                        </td>
                       <td>
                            <%# UserTypeName(Convert.ToInt32(Eval( "UserType" )))%>
                        </td>
                        <td>
                            <%# TimeTypeName(Convert.ToInt32(Eval( "TimeType" )))%>
                        </td>
                        <td>
                            <%# GetTaskAward(Eval( "TaskAward" ).ToString()) %>
                        </td>
                        <td>
                            <%# Eval( "Innings" ).ToString( )%>
                        </td>
                        <td>
                            <%# GetNullityStatus(Convert.ToByte(Eval( "Nullity" )))%>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
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
                <gsp:AspNetPager ID="anpNews" OnPageChanged="anpPage_PageChanged" runat="server" AlwaysShow="true" FirstPageText="首页" LastPageText="末页"
                    PageSize="20" NextPageText="下页" PrevPageText="上页" ShowBoxThreshold="0" ShowCustomInfoSection="Left" LayoutType="Table"
                    NumericButtonCount="5" CustomInfoHTML="总记录：%RecordCount%　页码：%CurrentPageIndex%/%PageCount%　每页：%PageSize%" UrlPaging="false">
                </gsp:AspNetPager>
            </td>
        </tr>
    </table>
    </form>
</body>
</html>
