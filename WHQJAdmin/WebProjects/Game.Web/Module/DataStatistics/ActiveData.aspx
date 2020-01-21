<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ActiveData.aspx.cs" Inherits="Game.Web.Module.DataStatistics.ActiveData" %>

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
                        <li class="tab2" onclick="Redirect('UserData.aspx')">用户统计</li>
                        <li class="tab2" onclick="Redirect('DailyPay.aspx')">登录统计</li>
                        <li class="tab2" onclick="Redirect('DailyDiamond.aspx')">新增统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">金币统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">钻石统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">充值统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">提现统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">税收统计</li>
                        <li class="tab2" onclick="Redirect('DailyGold.aspx')">库存统计</li>
                        <li class="tab1">彩金统计</li>
                    </ul>
                </td>
            </tr>
        </table>

        <h2 style="text-align: center; margin-bottom: 5px;">彩金统计</h2>
        <table width="99%" border="0" cellpadding="0" cellspacing="0" table-layout: fixed>
            <tr>
                <td>
                    <h2 style="text-align: center; margin-bottom: 5px;">金币</h2>
                    <div id="content">
                    </div>
                    <h2 style="text-align: center; margin-bottom: 5px;">钻石</h2>
                    <div id="content1">
                    </div>
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
                <td class="listTdLeft" style="width: 80px">彩金类型：
                </td>
                <td>
                    <label>
                        <input type="radio" name="ddtype" value="1" checked="checked">金币</label>
                    <label>
                        <input type="radio" name="ddtype" value="2">钻石</label>
                </td>
                <td class="listTdLeft" style="width: 80px">日期查询：
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

        <div id="content2">
        </div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr></tr>
        </table>
    </form>

    <script type="text/javascript">
        var data = [
        ]; 
        var Stat = G2.Stat;
        var chart1 = new G2.Chart({
            id: 'content1',
            forceFit: true,
            height: 400,
        });

        var chart = new G2.Chart({
            id: 'content',
            forceFit: true,
            height: 400,
        });
        chart1.source(data);
        chart1.coord('theta', {
            radius: 0.8 // 设置饼图的大小
        });
        chart1.legend('name', {
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
        chart1.tooltip({
            title: null,
            map: {
                value: 'value'
            }
        });
        chart1.intervalStack()
            .position(Stat.summary.percent('value'))
            .color('name')
            .label('name*..percent', function (name, percent) {
                percent = (percent * 100).toFixed(2) + '%';
                return name + ' ' + percent;
            });
        chart1.render();
        chart.source(data);
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

        geom = chart1.getGeoms()[0]; // 获取所有的图形
        items = geom.getData(); // 获取图形对应的数据
        geom.setSelected(items[1]); // 设置选中

        var chart2 = new G2.Chart({
            id: 'content2',
            forceFit: true,
            height: 600,
            plotCfg: {
                margin: [40, 80, 90, 80]
            }
        });

        chart2.legend({
            position: 'bottom'
        });
        chart2.axis('count', {
            position: 'top',
            formatter: function (dimValue) {
                if (dimValue >= 10000 && dimValue <= 99999) {
                    return (dimValue / 10000).toFixed(0) + '万';
                } else if (dimValue >= 100000 && dimValue <= 999999) {
                    return (dimValue / 100000).toFixed(0) + '十万';
                } else if (dimValue >= 1000000 && dimValue <= 9999999) {
                    return (dimValue / 1000000).toFixed(0) + '百万';
                } else if (dimValue >= 10000000 && dimValue <= 99999999) {
                    return (dimValue / 10000000).toFixed(0) + '千万';
                } else if (dimValue >= 100000000 && dimValue <= 999999999) {
                    return (dimValue / 100000000).toFixed(0) + '亿';
                } else if (dimValue >= 1000000000 && dimValue <= 9999999999) {
                    return (dimValue / 1000000000).toFixed(0) + '十亿';
                } else if (dimValue >= 10000000000 && dimValue <= 99999999999) {
                    return (dimValue / 10000000000).toFixed(0) + '百亿';
                } else if (dimValue >= 100000000000 && dimValue <= 999999999999) {
                    return (dimValue / 100000000000).toFixed(0) + '千亿';
                } else if (dimValue >= 1000000000000 && dimValue <= 9999999999999) {
                    return (dimValue / 1000000000000).toFixed(0) + '万亿';
                } else {
                    return dimValue;
                }
            }
        });
        const scale = {
            time: {
                alias: '统计时间',
                type: 'time',
                mask: 'yyyy-mm-dd',
            },
            count: {
                alias: '金币'
            },
            type: {
                type: 'cat'
            },
        };

        chart2.source(data, scale);
        chart2.line().position('time*count').color('type').shape('smooth').size(2);
        chart2.render();
        window.onload = loadData();

        $('#search').on('click', function () {
            loadData();
        });

        function loadData() {
            let pp;
            var radio = document.getElementsByName("ddtype");
            for (i = 0; i < radio.length; i++) {
                if (radio[i].checked) {
                    pp = radio[i].value;
                }
            }
            $.ajax({
                type: "GET",
                url: "/Tools/Operating.ashx?action=getactivedata",
                data: { stime: $("#txtStartDate").val(), etime: $("#txtEndDate").val(), type: pp },
                success: function (result) {
                    if (result.data.valid) {
                        chart.changeData(result.data.DataScore);
                        chart1.changeData(result.data.DataDiamond);
                        chart2.changeData(result.data.data);
                    }
                }
            });
        }
    </script>


</body>
</html>
