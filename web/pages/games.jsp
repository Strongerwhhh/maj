<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>Title</title>
</head>
<%--<script src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>--%>
<script src="<%=basePath%>/js/jquery-2.1.4.min.js"></script>
<script type="text/javascript" src="https://cdn.goeasy.io/goeasy.js"></script>
<script type="text/javascript">
    if(typeof GoEasy !== 'undefined'){
        var goEasy = new GoEasy({
            appkey: 'BC-6058f1b8923346efade7b8b3d7314b06',
            onConnected:function(){console.log("Connect to GoEasy success.");} ,
            onDisconnected:function(){console.log("Disconnect to GoEasy server.");} ,
            onConnectFailed:function(error){console.log("Connect to GoEasy failed, error code: "+ error.code+" Error message: "+ error.content);}
        });
    }
    subscribe();
    function subscribe() {
        goEasy.subscribe({
            channel: '${roomId}',
            onMessage: function (message) {
                var json=JSON.parse(message.content);
                switch (json.type) {
                    case 'initMaj':{
                        console.log("initMaj");
                        initMaj(json.tableNum,json.majIdList)
                    }break;
                }
            },
            onSuccess: function () {
                console.log("Subscribe the Channel successfully.");
            },
            onFailed: function (error) {
                console.log("Subscribe the Channel failed, error code: " + error.code + " error message: " + error.content);
            }
        });
    }
    function getImgSrc(majId) {
        return "'<%=basePath%>img/" + (majId % 34 + 1) + ".png'";
    }
</script>
<script type="text/javascript" src="<%=basePath%>js/game.js" ></script>
<link rel="stylesheet" href="<%=basePath%>css/games.css" />
<link rel="shortcut icon" href="#"/>
<link href="favicon.ico" rel="shortcut icon">
<body background="<%=basePath%>img/background.jpg"><!--麻将图-->
<script>
    alert("${roomId}");
</script>
<%--<% int roomId=(int)session.getAttribute("roomId");%>--%>
<!--1号位-->
<ul class="tableNum_1">

</ul>
<!--1号位的出牌区-->
<ul class="tableNum_1_input">

</ul>
<!--2号位-->
<ul class="tableNum_2">

</ul>
<!--2号位的出牌区-->
<ul class="tableNum_2_input">

</ul>
<!--3号位-->
<ul class="tableNum_3">

</ul>
<!--3号位的出牌区-->
<ul class="tableNum_3_input">

</ul>
<!--4号位-->
<ul class="tableNum_4">

</ul>
<!--4号位的出牌区-->
<ul class="tableNum_4_input">

</ul>

<!-- 吃碰杠区 -->
<ul class="tableNum_1_demo">

</ul>
<ul class="tableNum_2_demo">

</ul>
<ul class="tableNum_3_demo">

</ul>
<ul class="tableNum_4_demo">

</ul>
<!-- 出牌按钮 -->
<ul>
    <button id="start">开始游戏</button>
</ul>
<ul class="majdemo_chi_area">

</ul>
<!--麻将事件-->
<ul class="tableNum_1_majiang_work">
    <li class="tableNum_1_majiang_work_chi"><img src="img/吃.png" class="tableNum_1_work_img"/> </li>
    <li class="tableNum_1_majiang_work_peng"> <img src="img/碰.png" class="tableNum_1_work_img"/></li>
    <li class="tableNum_1_majiang_work_gang"> <img src="img/杠.png" class="tableNum_1_work_img"/></li>
    <li class="tableNum_1_majiang_work_hu"> <img src="img/胡.png" class="tableNum_1_work_img"/></li>
</ul>
<ul class="tableNum_2_majiang_work">

</ul>
<ul class="tableNum_3_majiang_work">

</ul>
<ul class="tableNum_4_majiang_work">

</ul>
<button id="b1"> 111</button>
</body>
<script>
    $("#start").click(function () {
        var data={
            type : "start",
            roomId : "${roomId}"
        }
        $.ajax({
            url : "<%=basePath%>game/start",
            type : "post",
            data : data,
            success : function (result) {
                console.log("success");
                console.log(result);
            }
        })
    })
</script>
</html>
