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
<link rel="stylesheet" href="<%=basePath%>/css/majiang.css" />
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
            channel: 'test',
            onMessage: function (message) {
                console.log(message);
                var arr=message.content.split("--");
                switch (arr[0]) {
                    case "sendMaj":
                        var majList=new Array();
                        for(var i=2;i<arr.length;i++) majList[i-2]=arr[i];
                        initMaj("tableNum_"+arr[1],majList);
                        break;
                }
                console.log('received:' + message.content);
            },
            onSuccess: function () {
                console.log("Subscribe the Channel successfully.");
            },
            onFailed: function (error) {
                console.log("Subscribe the Channel failed, error code: " + error.code + " error message: " + error.content);
            }
        });
    }

</script>

<link rel="shortcut icon" href="#"/>
<link href="favicon.ico" rel="shortcut icon">
<body background="<%=basePath%>img/background.jpg">
<!--麻将图-->
<!--1号位-->
<div class="tableNum_1">

</div>
<!--1号位的出牌区-->
<div class="tableNum_1_input">

</div>
<!--2号位-->
<div class="tableNum_2">


</div>
<!--2号位的出牌区-->
<div class="tableNum_2_input">

</div>
<!--3号位-->
<div class="tableNum_3">


</div>
<!--3号位的出牌区-->
<div class="tableNum_3_input">

</div>
<!--4号位-->
<div class="tableNum_4">


</div>
<!--4号位的出牌区-->
<div class="tableNum_4_input">

</div>

<!-- 出牌按钮 -->
<div>
    <button id="start">开始游戏</button>
</div>
</body>

<script>
    $("#start").click(function ( ) {
        $.ajax({
            url : "ajax/start",
            type : "post",
            dataType: "text",
            data : {userId : "123123"},
            success : function (roomId) {
                console.log(roomId);
            },
            error : function () {
                console.log("error");
            }
        })
    })
    function getImgSrc(majId) {
        return "'<%=basePath%>img/"+(majId%34+1)+".png'";
    }
    function getMaj(tableNum, majId) {
        var innerHTML = $("."+tableNum).innerHTML;
        var newMaj="<div class='"+tableNum+"_majiang'><img src="+getImgSrc(majId)+" class='"+tableNum+"_img'></div>";
        $("."+tableNum).html(innerHTML+newMaj);
    }
    function initMaj(tableNum, majIdList){
        console.log(majIdList);
        var num="";
        for (var i=0;i<13;i++){
            num+="<div class='"+tableNum+"_majiang'><img src="+getImgSrc(majIdList[i])+" class='"+tableNum+"_img'></div>";
        }
        $("."+tableNum).html(num);
        console.log(num);
    }

</script>
</html>
