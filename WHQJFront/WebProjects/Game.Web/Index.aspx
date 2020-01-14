<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Game.Web.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title><%=Title %></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="/css/index.css" rel="stylesheet" />
</head>

<body>
    <p id="OpenInstallKey"><%= OpenInstallKey %></p>
    <div class="ui-page">
        <div class="ui-contact">
            <a href="http://wpa.b.qq.com/cgi/wpa.php?ln=2&uin=<%= Qq %>" class="ui-qq" target="_blank">
                <img src="/image/qq_pc.png" alt="" /><%= Qq %>
            </a><a href="javascript:;" class="ui-tel">
                <img src="/image/tel_pc.png" alt="" /><%= Tel %>
            </a>
        </div>
        <img src="<%= Mobilebg %>" class="ui-bg" alt="" />
        <img src="<%= Mobilelogo %>" class="ui-logo" alt="" />
        <img src="<%= MobileQrcode %>" class="ui-qrcode" alt="" />
        <a id="ui-btn" class="ui-btn">
            <img src="<%= Mobiledown %>" alt="" />
        </a>
        <img src="<%= MobileCase %>" class="ui-product" alt="" />
    </div>
</body>
<!-- 以下为openinstall集成代码，建议在html文档中尽量靠前放置，加快初始化过程 -->
<!-- 强烈建议直接引用下面的cdn加速链接，以得到最及时的更新，我们将持续跟踪各种主流浏览器的变化，提供最好的服务；不推荐将此js文件下载到自己的服务器-->
<link rel="preconnect" href="https://openinstall.io" crossorigin="use-credentials" />
<script type="text/javascript" charset="utf-8" src="https://res.cdn.openinstall.io/openinstall.js">
</script>
<script type="text/javascript">
    //openinstall初始化时将与openinstall服务器交互，应尽可能早的调用
    /*web页面向app传递的json数据(json string/js Object)，应用被拉起或是首次安装时，通过相应的android/ios api可以获取此数据*/
    var data = OpenInstall.parseUrlParams();//openinstall.js中提供的工具函数，解析url中的所有查询参数
    new OpenInstall({
        /*appKey必选参数，openinstall平台为每个应用分配的ID*/
        appKey:  document.getElementById("OpenInstallKey"),
        /*可选参数，自定义android平台的apk下载文件名，只有apk在openinstall托管时才有效；个别andriod浏览器下载时，中文文件名显示乱码，请慎用中文文件名！*/
        //apkFileName : '',
        /*可选参数，是否优先考虑拉起app，以牺牲下载体验为代价*/
        //preferWakeup:true,
        /*自定义遮罩的html*/
        //mask:function(){
        //  return "<div id='openinstall_shadow' style='position:fixed;left:0;top:0;background:rgba(0,255,0,0.5);filter:alpha(opacity=50);width:100%;height:100%;z-index:10000;'></div>"
        //},
        /*openinstall初始化完成的回调函数，可选*/
        onready: function () {
            var m = this, button = document.getElementById("ui-btn");
            button.style.visibility = "visible";

            /*在app已安装的情况尝试拉起app*/
            m.schemeWakeup();
            /*用户点击某个按钮时(假定按钮id为downloadButton)，安装app*/
            button.onclick = function () {
                m.wakeupOrInstall();
                return false;
            }
        }
    }, data);
</script>
</html>
