//出牌
function showMaj(tableNum,majId){
    var data={
        type : "showMaj",
        roomId : roomId,
        tableNum : tableNum,
        majIdList : [majId]
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
function peng(tableNum,majIdList){
    var data={
        type : "peng",
        roomId : roomId,
        tableNum : tableNum,
        majIdList : [1,2,3],
    }
    $.ajax({
        type:"POST",
        url:"ajax/peng",
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
        roomId : roomId,
        tableNum : tableNum,
        majIdList : [1,2,3],
    }
    $.ajax({
        type:"POST",
        url:"ajax/chi",
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
        roomId: roomId,
        tableNum: tableNum,
        majIdList: [1, 2, 3, 4],
    }
    $.ajax({
        type: "POST",
        url: "ajax/gang",
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

//初始化手牌
function initMaj(tableNum, majIdList) {
    var num = "";
    tableNum="tableNum_"+tableNum;
    majIdList=sort(majIdList);
    for (var i = 0; i < majIdList.length; i++) {
        num += "<li class='" + tableNum + "_majiang'><img src=" + getImgSrc(majIdList[i]) + " class='" + tableNum + "_img'></li>";

    }
    $("." + tableNum).append(num);
}

//刷新出牌区
function refreshInput(tableNum, tableMaj) {
    var input_num = ""; //出牌区的牌
    //遍历tableMaj，讲图片加入到tablenum_i_input中
    for (var i = 0; i < tableMaj.size(); i++) {
        input_num += "<li class='" + tableNum + "_majiang'><img src='" + (tableMaj.get(i) % 34 + 1) + ".png' class='" + tableNum + "_img'></li>";
    }
    $("." + tableNum + "_input").append(input_num);
}

//吃碰杠区的刷新
function pengArea(tableNum, majId) {
    var refreshPeng = "";
    for (var i = 0; i < 3; i++) {
        refreshPeng += "<li><img src=" + getImgSrc(majId) + " class='" + tableNum + "_img'</li>";
    }
    $("." + tableNum + "_demo").append(refreshPeng);
}

//其他人的牌，背面表示
function initMaj_other(tableNum) {
    var otherMaj = "";
    //还要传其他3个人的tableNum
    tableNum="tableNum_"+tableNum;
    for (var i = 0; i < 13; i++) {
        otherMaj += "<li class='" + tableNum + "_majiang'><img src='img/35.png' class='" + tableNum + "_img'></li>";
    }
    $("." + tableNum).append(otherMaj);
}

//每回合的抽牌
function getMaj(tableNum, majId) {
    tableNum="tableNum_"+tableNum;
    var newMaj = "<li class='" + tableNum + "_majiang' ><img src=" + getImgSrc(majId) + " class='" + tableNum + "_img'></li>";
    $("." + tableNum).append(newMaj);
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

function peng_img(){
    demo = "<img src='img/碰.png' class='majdemo_" + tableNum + "_peng'>";
    $("." + tableNum + "_input").html(demo);
}

function chi_img(){
    demo = "<img src='img/吃.png' class='majdemo_" + tableNum + "_chi'>";
    $("." + tableNum + "_input").html(demo);
}
//碰
//其他三个人遍历自己的手牌，看有没有和对应的牌相同的，并且有两张；
function touch(tableNum, majId, majIdList, tableMaj) {
    var demo = "";
    var j = "";
    for (var i = 0; i < majIdList.size(); i++) {
        if ((majIdlist.get(i) % 34 ) == (majId % 34 ) && (majIdlist.get(i + 1) % 34 ) == (majId % 34 )) {
            $(".tableNum_1_majiang_work_peng").css("display","block");//出现碰的图片

            //碰的点击事件,让碰图标消失，把出的牌和自己手牌里的两张牌，放到吃碰杠区
            $(".majdemo_" + tableNum + "_peng").click(function() {
                $(".tableNum_1_majiang_work_peng").css("display","none"); //删除碰的图标
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
//吃
function eat(tableNum,majId,majIdList,tableMaj){
    var flags=new flags[4];
    var j=new Array();
    //创建吃的图片
    chi_img();
    //吃的点击事件
    $(".majdemo_" + tableNum + "_chi").click(function() {
        for(var i=0;i<majIdList.size();i++){
            if(majIdList.get(i)%34<27){
                var x = (majId%34)%9;
                var y = (majIdList.get(i)%34)%9;
                if(y==(x-2)) flags[0]=true;
                if(y==(x-1)) flags[1]=true;
                if(y==(x+1)) flags[2]=true;
                if(y==(x+2)) flags[3]=true;
                if(flags[0]==flags[1]&&flags[1]==true){
                    j=i
                    $(".majdemo_" + tableNum + "_chi").remove(); //删除吃的图标
                    $(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj' style='margin-left:20px'><img src='"+getImgSrc(majIdList.get(i))+"' class='tableNum_1_img'></li>");
                    $(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj'><img src='"+getImgSrc(majIdList.get(i+1))+"' class='tableNum_1_img'></li>");
                    $(".majdemo_chi_area").on('click','.majdemo_chi_area_maj',function(){

                    })
                }
                if(flags[1]==flags[2]&&flags[2]==true){
                    $(".majdemo_" + tableNum + "_chi").remove(); //删除吃的图标
                    $(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj' style='margin-left:20px'><img src='"+getImgSrc(majIdList.get(i))+"' class='tableNum_1_img'></li>");
                    $(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj'><img src='"+getImgSrc(majIdList.get(i+2))+"' class='tableNum_1_img'></li>");
                }
                if(flags[2]==flags[3]&&flags[3]==true){
                    $(".majdemo_" + tableNum + "_chi").remove(); //删除吃的图标
                    $(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj' style='margin-left:20px'><img src='"+getImgSrc(majIdList.get(i))+"' class='tableNum_1_img'></li>");
                    $(".majdemo_chi_area").append("<li class='majdemo_chi_area_maj'><img src='"+getImgSrc(majIdList.get(i+1))+"' class='tableNum_1_img'></li>");
                }

            }
        }
    })}

