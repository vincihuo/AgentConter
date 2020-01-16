<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DailyGame.aspx.cs" Inherits="Game.Web.Module.DataStatistics.DailyGame" %>

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
                <td width="1232" height="25" valign="top" align="left">你当前位置：统计系统 - 当日游戏盈亏
                </td>
            </tr>
        </table>

        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" class="titleQueBg">
            <tr>
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

        <h2 style="text-align: center; margin-bottom: 5px;">当日游戏盈亏</h2>

        <div id="content">
        </div>
        <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
            <tr></tr>
        </table>
    </form>

    <script type="text/javascript">
        const chart_data = [];

        const chart = new G2.Chart({
            id: 'content',
            forceFit: true,
            height: 600,
            plotCfg: {
                margin: [40, 80, 90, 80]
            }
        });
        chart.legend({
            position: 'bottom'
        });

        chart.axis('value', {
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
                } else if (dimValue <= -10000 && dimValue >= -99999) {
                    return (dimValue / 10000).toFixed(0) + '万';
                } else if (dimValue <= -100000 && dimValue >= -999999) {
                    return (dimValue / 100000).toFixed(0) + '十万';
                } else if (dimValue <= -1000000 && dimValue >= -9999999) {
                    return (dimValue / -1000000).toFixed(0) + '百万';
                }else {
                    return dimValue;
                }
            }
        });

        const scale = {
            name: {
                alias: '游戏名称',
            },
            value: {
                alias: '盈亏'
            },
            type: {
                type: 'cat'
            },
        };

        chart.source(chart_data, scale);
        chart.interval().position('name*value').color('name');
        chart.render();

        window.onload = loadData();

        $('#search').on('click', function () {
            loadData();
        });

        function loadData() {
            $.ajax({
                type: "GET",
                url: "/Tools/Operating.ashx?action=getgamewaste",
                data: { stime: $("#txtStartDate").val(), etime: $("#txtEndDate").val() },
                success: function (result) {
                    if (result.data.valid) {
                        chart.changeData(result.data.data);
                    }
                }
            });
        }

    </script>


</body>
</html>
