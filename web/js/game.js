//出牌
function showMaj(tableNum,majId,roomId){
    var data={
        type : "showMaj",
        roomId : roomId,
        tableNum : tableNum,
       majId: majId
    }
    $.ajax({
        type:"POST",
        url:"ajax/showMaj",
        data : data,
        success : function(result){
            console.log("success" + result);
        }
    })
}
//碰
function peng(tableNum,majIdList,roomId){
    var data={
        type : "peng",
        roomId : roomId,
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
function chi(tableNum,majIdList,roomId){
    var data={
        type : "peng",
        roomId :  roomId,
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
function gang(tableNum,majIdList,roomId) {
    var data = {
        type: "gang",
        roomId: roomId,
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
        roomId: roomId,
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
				var num = "";
				console.log(majIdList);
				tableNum = getTrueTableNum(tableNum);
				 majIdList=sort(majIdList);
				for (var i = 0; i < majIdList.length; i++) {
					num += "<li class='" + tableNum + "_majiang'><img src=" + getImgSrc(majIdList[i]) + " class='" + tableNum + "_img'></li>";
				}
				$("." + tableNum).append(num);
				console.log(num);
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
		
			//每回合的抽牌
		function getMaj(tableNum, majId) {
				tableNum = getTrueTableNum(tableNum);
				var newMaj = "<li class='" + tableNum + "_majiang' ><img src=" + getImgSrc(majId) + " class='" + tableNum + "_img'></li>";
				$("." + tableNum).append(newMaj);
			}
		//其他人抽牌
		function otherGetMaj(tableNum, majId) {
				tableNum = getTrueTableNum(tableNum);
				var newMaj = "<li class='" + tableNum + "_majiang' ><img src='img/35.png' class='" + tableNum + "_img'></li>";
				$("." + tableNum).append(newMaj);
			}
			//出牌
		function showMaj(tableNum, majId, majIdList, tableMaj) {
			var refreshList = "";
			tableNum = getTrueTableNum(tableNum);
			$("." + tableNum).on('click', '.' + tableNum + '_majiang', function() {
				//先判断点击的是哪张牌
				var majSeq = parseInt($("." + tableNum).index(this));
				//移除tablenum_i中的这张牌
				$("." + tableNum).eq(majSeq).remove();
				//加入到tableMaj中
				tableMaj.add(majId);
				tablemaj=tableMaj;
				//刷新出牌区
				refreshInput(tableNum, tableMaj);
				//重新排序你的手牌
				initMaj(tableNum, majIdList);
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
				tablemaj.remove(tablemaj.length - 1);
				//重新刷新手牌区,出牌区和吃碰杠区
				refreshInput(tableNum, tablemaj);
				initMaj(tableNum, majIdList);
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

