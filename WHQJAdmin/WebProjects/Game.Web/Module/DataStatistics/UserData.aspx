<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserData.aspx.cs" Inherits="Game.Web.Module.DataStatistics.UserData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/styles/layout.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/scripts/common.js"></script>
    <script src="/scripts/jquery.js"></script>
    <script src="/scripts/g2.js"></script>
    <script type="text/javascript" src="/scripts/My97DatePicker/WdatePicker.js"></script>
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
                <td width="1232" height="25" valign="top" align="left">你当前位置：统计系统 - 平台数据
                </td>
            </tr>
        </table>
        <table width="99%" border="0" align="center" cellpadding="0" cellspacing="0" class="Tmg7">
            <tr>
                <td height="28">
                    <ul>
                        <li class="tab1">用户统计</li>
                        <li class="tab2" onclick="Redirect('DailyPay.aspx')">登录统计</li>
                        <li class="tab2" onclick="Redirect('DailyDiamond.aspx')">新增统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">金币统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">钻石统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">充值统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">提现统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">税收统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">库存统计</li>
                        <li class="tab2" onclick="Redirect('ActiveData.aspx')">彩京统计</li>
                    </ul>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
            <tr>
                <td class="listTdLeft" style="width: 80px">最后登录日期：
                </td>
                <td>
                    <asp:TextBox ID="txtStartDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"></asp:TextBox><img
                        src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtStartDate',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'txtEndDate\')}'})"
                        style="cursor: pointer; vertical-align: middle" />
                    至
                <asp:TextBox ID="txtEndDate" runat="server" CssClass="text wd2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"></asp:TextBox><img
                    src="../../Images/btn_calendar.gif" onclick="WdatePicker({el:'txtEndDate',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'txtStartDate\')}'})"
                    style="cursor: pointer; vertical-align: middle" />

                    <input type="button" id="search" value="查询" class="btn wd1" />
                </td>
            </tr>
        </table>
        <h2 style="text-align: center; margin-bottom: 5px;">用户数据</h2>
        <div id="content">
        </div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr></tr>
        </table>

    </form>
    <script type="text/javascript">
        var data = [];
        var Stat = G2.Stat;
        var chart = new G2.Chart({
            id: 'content',
            forceFit: true,
            height: 500,
        });
        chart.source(data);
        // 重要：绘制饼图时，必须声明 theta 坐标系
        chart.coord('theta', {
            radius: 0.8 // 设置饼图的大小
        });
        chart.legend('name', {
            position: 'bottom',
            itemWrap: true,
            formatter: function (val) {
                for (var i = 0, len = data.length; i < len; i++) {
                    var obj = data[i];
                    if (obj.name === val) {
                        return val + ': ' + obj.value + '%';
                    }
                }
            }
        });
        chart.tooltip({
            title: null,
            map: {
                value: 'value'
            }
        });
        chart.intervalStack()
            .position(Stat.summary.percent('value'))
            .color('name')
            .label('name*..percent', function (name, percent) {
                percent = (percent * 100).toFixed(2) + '%';
                return name + ' ' + percent;
            });
        chart.render();
        // 设置默认选中
        var geom = chart.getGeoms()[0]; // 获取所有的图形
        var items = geom.getData(); // 获取图形对应的数据
        geom.setSelected(items[1]); // 设置选中
        window.onload = loadData();

        $('#search').on('click', function () {
            loadData();
        });

        function loadData() {
            $.ajax({
                type: "GET",
                url: "/Tools/Operating.ashx?action=getuserdata",
                data: { stime: $("#txtStartDate").val(), etime: $("#txtEndDate").val() },
                success: function (result) {
                    if (result.data.valid && result.data.data.length > 0) {
                        chart.changeData(result.data.data);
                        $('#content').show();
                    } else {
                        $('#content').hide();
                    }
                }
            });
        }






    </script>
</body>
</html>
