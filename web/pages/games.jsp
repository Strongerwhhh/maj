<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<script type="text/javascript" src="<%=basePath%>/js/game.js" ></script>
<script type="text/javascript">
	//变量区
	var jspHandMaj;//自己的手牌
	var jspTableMaj=new Array();//四个出牌区
	//


    if(typeof GoEasy !== 'undefined'){
        var goEasy = new GoEasy({
            appkey: 'BC-6058f1b8923346efade7b8b3d7314b06',
            onConnected:function(){console.log("Connect to GoEasy success.");} ,
            onDisconnected:function(){console.log("Disconnect to GoEasy server.");} ,
            onConnectFailed:function(error){console.log("Connect to GoEasy failed, error code: "+ error.code+" Error message: "+ error.content);}
        });
    }
	function getTrueTableNum(tableNum) {
		var x = tableNum - ${tableNum};
		tableNum = (x > 0) ? (x + 1) : ((x * -1) + 1);
		tableNum = "tableNum_" + tableNum;
		return tableNum;
	}
	subscribe();



    function subscribe() {
        goEasy.subscribe({
            channel: '${roomId}',
            onMessage: function (message) {
                var json=JSON.parse(message.content);
                var tableNum=json.tableNum;
                var majId=json.majId;
                var majIdList=json.majIdList;
                switch (json.type) {
                    case 'initMaj':{
						jspTableMaj[tableNum-1]=new Array();
						$("."+tableNum).html("");
                        if(json.tableNum == ${tableNum}) initMaj(json.tableNum,json.majIdList)
                        else otherMaj(json.tableNum,json.majIdList)
                    }break;
						case "getMaj"://抽牌
							if(tableNum==${tableNum}){
							getMaj(tableNum, majId);}
							else otherGetMaj(tableNum, majId);
						break;
						case "showMaj"://出牌
							outputMaj(tableNum, majId);
						break;
						case "touch"://碰
							touch(tableNum, majId, majIdList);
						break;
						case "eat"://吃
							eat(tableNum, majId, majIdList);
						break;
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
<link rel="stylesheet" href="<%=basePath%>css/games.css" />
<link rel="shortcut icon" href="#"/>
<link href="favicon.ico" rel="shortcut icon">
<body background="<%=basePath%>img/background.jpg"><!--麻将图-->
<script>
    console.log("roomId:${roomId}");
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
			<li class="tableNum_2_majiang_work_chi"><img src="img/吃.png" class="tableNum_2_work_img" /> </li>
			<li class="tableNum_2_majiang_work_peng"> <img src="img/碰.png" class="tableNum_2_work_img" /></li>
			<li class="tableNum_2_majiang_work_gang"> <img src="img/杠.png" class="tableNum_2_work_img" /></li>
			<li class="tableNum_2_majiang_work_hu"> <img src="img/胡.png" class="tableNum_2_work_img" /></li>
			<li class="tableNum_2_majiang_work_guo"> <img src="img/过.png" class="tableNum_2_work_img" /></li>
		</ul>
		<ul class="tableNum_3_majiang_work">
			<li class="tableNum_3_majiang_work_chi"><img src="img/吃.png" class="tableNum_3_work_img" /> </li>
			<li class="tableNum_3_majiang_work_peng"> <img src="img/碰.png" class="tableNum_3_work_img" /></li>
			<li class="tableNum_3_majiang_work_gang"> <img src="img/杠.png" class="tableNum_3_work_img" /></li>
			<li class="tableNum_3_majiang_work_hu"> <img src="img/胡.png" class="tableNum_3_work_img" /></li>
			<li class="tableNum_3_majiang_work_guo"> <img src="img/过.png" class="tableNum_3_work_img" /></li>
		</ul>
		<ul class="tableNum_4_majiang_work">
			<li class="tableNum_4_majiang_work_chi"><img src="img/吃.png" class="tableNum_4_work_img" /> </li>
			<li class="tableNum_4_majiang_work_peng"> <img src="img/碰.png" class="tableNum_4_work_img" /></li>
			<li class="tableNum_4_majiang_work_gang"> <img src="img/杠.png" class="tableNum_4_work_img" /></li>
			<li class="tableNum_4_majiang_work_hu"> <img src="img/胡.png" class="tableNum_4_work_img" /></li>
			<li class="tableNum_4_majiang_work_guo"> <img src="img/过.png" class="tableNum_4_work_img" /></li>
		</ul>
</body>
<script>
	//出牌
	function showMaj(tableNum,majId){
		var data={
			type : "showMaj",
			roomId : ${roomId},
			tableNum : tableNum,
			majId: majId
		}
		$.ajax({
			type:"POST",
			url:"<%=basePath%>ajax/showMaj",
			data : data,
			success : function(result){
				console.log("success" + result);
			},
			error : function () {
				console.log("error")
			}
		})
	}
	//碰
	function peng(tableNum,majIdList){
		var data={
			type : "peng",
			roomId : ${roomId},
			tableNum : tableNum,
			majIdList : majIdList
		}
		$.ajax({
			type:"POST",
			url:"ajax/action",
			data : data,
			success : function(result){
				console.log("success" + result);
			}
		})
	}
	//吃
	function chi(tableNum,majIdList){
		var data={
			type : "peng",
			roomId :  ${roomId},
			tableNum : tableNum,
			majIdList : majIdList
		}
		$.ajax({
			type:"POST",
			url:"ajax/action",
			data : data,
			success : function(result){
				console.log("success" + result);
			}
		})
	}
	//杠
	function gang(tableNum,majIdList) {
		var data = {
			type: "gang",
			roomId: ${roomId},
			tableNum: tableNum,
			majIdList : majIdList
		}
		$.ajax({
			type: "POST",
			url: "ajax/action",
			data: data,
			success: function (result) {
				console.log("success" + result);
			}
		})
	}
	//胡
	function hu(tableNum){
		var data = {
			type: "gang",
			roomId: ${roomId},
			tableNum: tableNum,
		}
		$.ajax({
			type: "POST",
			url: "ajax/hu",
			data: data,
			success: function (result) {
				console.log("success" + result);
			}
		})

	}
	function sort(majIdList) {
		var arr=new Array();
		for(var i=0;i<34;i++){
			for(var j=0;j<majIdList.length;j++)
				if(majIdList[j]%34==i) arr.push(majIdList[j]);
		}
		return arr;
	}

	function getImgSrc(majId) {
		return "'<%=basePath%>img/" + (majId % 34 + 1) + ".png'";
	}


	//初始化手牌
	function initMaj(tableNum, majIdList) {
		jspHandMaj=majIdList;
		var num = "";
		// console.log(majIdList);
		tableNum = getTrueTableNum(tableNum);
		majIdList=sort(majIdList);
		for (var i = 0; i < majIdList.length; i++) {
			num += "<li class='" + tableNum + "_majiang' ondblclick='majOndblclick("+majIdList[i]+")'><img src=" + getImgSrc(majIdList[i]) + " class='" + tableNum + "_img'></li>";
		}
		$("." + tableNum).append(num);
		// console.log(num);
	}
	//刷新出牌区

	function refreshInput(tableNum, tableMaj) {
		var input_num = ""; //出牌区的牌
		//遍历tableMaj，讲图片加入到tablenum_i_input中
		tableNum = getTrueTableNum(tableNum);
		for (var i = 0; i < tableMaj.length; i++) {
			input_num += "<li class='" + tableNum + "_majiang'><img src='" + (tableMaj.get(i) % 34 + 1) + ".png' class='" + tableNum + "_img'></li>";
		}
		$("." + tableNum + "_input").append(input_num);
	}

	//其他人的牌，背面表示
	function otherMaj(tableNum, majIdList) {
		var otherMaj = "";
		tableNum = getTrueTableNum(tableNum);
		//还要传其他3个人的tableNum
		for (var i = 0; i < majIdList.length; i++) {
			otherMaj += "<li class='" + tableNum + "_majiang'><img src='img/35.png' class='" + tableNum + "_img'></li>";
		}
		$("." + tableNum).append(otherMaj);
	}

	//吃碰杠区的刷新
	function workArea(tableNum, majId) {
		var refreshPeng = "";
		tableNum = getTrueTableNum(tableNum);
		for (var i = 0; i < 3; i++) {
			refreshPeng += "<li><img src=" + getImgSrc(majId) + " class='" + tableNum + "_img'</li>";
		}
		$("." + tableNum + "_demo").append(refreshPeng);
	}

	function majOndblclick(majId) {
		console.log("dblclick")
		showMaj(${tableNum},majId);
	}

	//每回合的抽牌
	function getMaj(tableNum, majId) {
		var ttableNum = getTrueTableNum(tableNum);
		var newMaj = "<li class='" + ttableNum + "_majiang' style='margin-left: 20px' ondblclick='majOndblclick("+majId+")'><img src=" + getImgSrc(majId) + " class='" + ttableNum + "_img'></li>";
		$("." + ttableNum).append(newMaj);
	}
	//其他人抽牌
	function otherGetMaj(tableNum) {
		tableNum = getTrueTableNum(tableNum);
		var newMaj = "<li class='" + tableNum + "_majiang' ><img src='img/35.png' class='" + tableNum + "_img'></li>";
		$("." + tableNum).append(newMaj);
	}

	//出牌
	function outputMaj(tableNum, majId) {
		var refreshList = "";
		var ttableNum = getTrueTableNum(tableNum);
		$("." + ttableNum).on('click', '.' + ttableNum + '_majiang', function() {
			//先判断点击的是哪张牌
			var majSeq = parseInt($("." + ttableNum).index(this));
			//移除tablenum_i中的这张牌
			$("." + ttableNum).eq(majSeq).remove();
			//加入到tableMaj中
			jspTableMaj[tableNum-1].push(majId);
			//刷新出牌区
			refreshInput(ttableNum, jspTableMaj[tableNum-1]);
			//重新排序你的手牌
			initMaj(ttableNum, handMaj);
		})
	}

	//碰
	//其他三个人遍历自己的手牌，看有没有和对应的牌相同的，并且有两张；
	function touch(tableNum, majId, majIdList) {
		tableNum = getTrueTableNum(tableNum);
		var demo = "";
		var j = "";
		for (var i = 0; i < majIdList.length; i++) {
			if ((majIdlist.get(i) % 34) == (majId % 34) && (majIdlist.get(i + 1) % 34) == (majId % 34)) {
				$(".tableNum_1_majiang_work_peng").css("display", "block"); //出现碰的图片
				//碰的点击事件,让碰图标消失，把出的牌和自己手牌里的两张牌，放到吃碰杠区
				$(".majdemo_" + tableNum + "_peng").click(function() {
					$("." + tableNum + "_majiang_work_peng").css("display", "none"); //删除碰的图标
					j = i;
				})
			}
		}
		//删除tableMaj最后个值和majIdList中与其相同的两个值
		majIdList.remove(j);
		majIdList.remove(j + 1);
		jspTableMaj.remove(jspTableMaj.length - 1);
		//重新刷新手牌区,出牌区和吃碰杠区
		refreshInput(tableNum, jspTableMaj);
		initMaj(tableNum, jspHandMaj);
		workArea(tableNum, majId);
	}
	//吃

	function eat(tableNum, majId, majIdList) {
		tableNum = getTrueTableNum(tableNum);
		var flags = new flags[4];
		var j = new Array();
		//显示吃的图片
		$("." + tableNum + "_majiang_work_chi").css("display", "block");
		//吃的点击事件
		$(".majdemo_" + tableNum + "_chi").click(function() {
			for (var i = 0; i < majIdList.length; i++) {
				if (majIdList.get(i) % 34 < 27) {
					var x = (majId % 34) % 9;
					var y = (majIdList.get(i) % 34) % 9;
					if (y == (x - 2)) flags[0] = true;
					if (y == (x - 1)) flags[1] = true;
					if (y == (x + 1)) flags[2] = true;
					if (y == (x + 2)) flags[3] = true;
					if (flags[0] == flags[1] && flags[1] == true) {
						$("." + tableNum + "_majiang_work_chi").css("display", "none"); //隐藏吃的图标
						$("." + tableNum + "majdemo_chi_area").append("<li class='majdemo_chi_area_maj_1' style='margin-left:20px'><img src='" + getImgSrc(majIdList.get(i)) + "' class='" + tableNum + "_img'></li>");
						$("." + tableNum + "majdemo_chi_area").append("<li class='majdemo_chi_area_maj_1'><img src='" + getImgSrc(majIdList.get(i + 1)) + "' class='" + tableNum + "_img'></li>");
						$("." + tableNum + "majdemo_chi_area").on('click', '.majdemo_chi_area_maj_1', function() {
							majIdList.remove(i);
							majIdList.remove(i + 1);
							tablemaj.remove(tablemaj.length - 1);
						})
					}
					if (flags[1] == flags[2] && flags[2] == true) {
						$(".tableNum_1_majiang_work_chi").css("display", "none"); //隐藏吃的图标
						$(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj_2' style='margin-left:20px'><img src='" + getImgSrc(majIdList.get(i)) + "' class='" + tableNum + "_img'></li>");
						$(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj_2'><img src='" + getImgSrc(majIdList.get(i + 2)) + "' class='" + tableNum + "_img'></li>");
						$("." + tableNum + "majdemo_chi_area").on('click', '.majdemo_chi_area_maj_2', function() {
							majIdList.remove(i);
							majIdList.remove(i + 2);
							tablemaj.remove(tablemaj.length - 1);
						})
					}
					if (flags[2] == flags[3] && flags[3] == true) {
						$(".tableNum_1_majiang_work_chi").css("display", "none"); //隐藏吃的图标
						$(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj_3' style='margin-left:20px'><img src='" + getImgSrc(majIdList.get(i)) + "' class='" + tableNum + "_img'></li>");
						$(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj_3'><img src='" + getImgSrc(majIdList.get(i + 1)) + "' class='" + tableNum + "_img'> </li>");
						$("." + tableNum + "majdemo_chi_area").on('click', '.majdemo_chi_area_maj_3', function() {
							majIdList.remove(i);
							majIdList.remove(i + 1);
							tablemaj.remove(tablemaj.length - 1);
						})
					}
				}
			}
		})
		//重新刷新手牌区,出牌区和吃碰杠区
		refreshInput(tableNum, tablemaj);
		initMaj(tableNum, majIdList);
		pengArea(tableNum, majId);
	}
	//胡
	//过
	function through(tableNum) {
		$(".tableNum_1_majiang_work_guo").css("display", "block");
	}


</script>
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
            success : function (flag) {
                if(!flag) alert("人数不够开始");
            },
        })
    })
    window.onclose=function (ev) {
        $.get({
            url : "<%=basePath%>quitRoom",
            data : {roomid:${roomId},tableNum:${tableNum}}
        })
    }
</script>
</html>
