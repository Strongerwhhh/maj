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

<link rel="stylesheet" href="<%=basePath%>css/games.css" />
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
    function getImgSrc(majId) {
        return "'<%=basePath%>img/" + (majId % 34 + 1) + ".png'";
    }

    function mySort(majIdList) {
        var arr=new Array();
        for(var j=0;j<34;j++)
            for(var i=0;i<majIdList.size();i++) if(majIdList[i]%34 == j) arr.push(majIdList.remove(i));
        return arr;
    }

    //初始化手牌
    function initMaj(tableNum, majIdList) {
        var num = "";
        console.log(majIdList);
        arr.sort(majIdList);
        for (var i = 0; i < majIdList.size(); i++) {
            num += "<div class='" + tableNum + "_majiang'><img src=" + getImgSrc(majIdList[i]) + " class='" + tableNum + "_img'></div>";
        }
        $("." + tableNum).html(num);
        console.log(num);
    }

    //刷新出牌区
    function refreshInput(tableNum, tableMaj) {
        var input_num = ""; //出牌区的牌
        //遍历tableMaj，讲图片加入到tablenum_i_input中
        for (var i = 0; i < tableMaj.size(); i++) {
            input_num += "<div class='" + tableNum + "_majiang'><img src='" + (tableMaj.get(i) % 34 + 1) + ".png' class='" + tableNum + "_img'></div>";
        }
        $("." + tableNum + "_input").html(input_num);
    }

    //吃碰杠区的刷新
    function pengArea(tableNum, majId) {
        var refreshPeng = "";
        for (var i = 0; i < 3; i++) {
            refreshPeng += "<div><img src=" + getImgSrc(majId) + " class='" + tableNum + "_img'</div>";
        }
        $("." + tableNum + "_demo").html(refreshPeng);
    }

    //其他人的牌，背面表示
    function otherMaj(tableNum, majIdList) {
        var otherMaj = "";
        //还要传其他3个人的tableNum
        for (var i = 0; i < majIdList.size(); i++) {
            otherMaj += "<div class='" + tableNum + "_majiang'><img src='img/35.png' class='" + tableNum + "_img'></div>";
        }
        $("." + tableNum).html(otherMaj);
    }

    //每回合的抽牌
    function getMaj(tableNum, majId) {
        var innerHTML = $("." + tableNum).innerHTML;
        var newMaj = "<div class='" + tableNum + "_majiang' ><img src=" + getImgSrc(majId) + " class='" + tableNum + "_img'></div>";
        $("." + tableNum).html(innerHTML + newMaj);
    }

    //出牌
    function outputMaj(tableNum, majId, majIdList, tableMaj) {
        var refreshList = "";
        $("." + tableNum).on('click', '.' + tableNum + '_majiang', function() {
            //先判断点击的是哪张牌
            var majSeq = parseInt($("." + tableNum).index(this));
            //移除tablenum_i中的这张牌
            $("." + tableNum).eq(majSeq).remove();
            //加入到tableMaj中
            tableMaj.add(majId);
            //刷新出牌区
            refreshInput(tableNum, tableMaj);
            //重新排序你的手牌
            initMaj(tableNum, majIdList);
        })
    }

    //碰
    //其他三个人遍历自己的手牌，看有没有和对应的牌相同的，并且有两张；
    function touch(tableNum, majId, majIdList, tableMaj) {
        var demo = "";
        var j = "";
        for (var i = 0; i < majIdList.size(); i++) {
            if ((majIdlist.get(i) % 34 + 1) == (majId % 34 + 1) && (majIdlist.get(i + 1) % 34 + 1) == (majId % 34 + 1)) {
                demo = "<img src='img/碰.png' class='majdemo_" + tableNum + "_peng'></img>";
                $("." + tableNum + "_input").html(demo);
                //碰的点击事件,让碰图标消失，把出的牌和自己手牌里的两张牌，放到吃碰杠区
                $(".majdemo_" + tableNum + "_peng").click(function() {
                    $(".majdemo_" + tableNum + "_peng").remove(); //删除碰的图标
                    j = i;
                })
            }
        }
        //删除tableMaj最后个值和majIdList中与其相同的两个值
        majIdList.remove(j);
        majIdList.remove(j + 1);
        tableMaj.remove(tableMaj.size() - 1);
        //重新刷新手牌区,出牌区和吃碰杠区
        refreshInput(tableNum, tableMaj);
        initMaj(tableNum, majIdList);
        pengArea(tableNum, majId);
    }
</script>
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
