<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>主页</title>
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <script src="<%=basePath%>js/jquery-2.1.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <link rel="stylesheet" type="text/css" href="<%=basePath%>/css/home.css" />
</head>

<body >
<c:if test="${not empty errorMsg}">
    <div id="myAlert" class="alert alert-danger text-center" >
        <strong>${errorMsg}！</strong>
        <a href="#" id="myclose" data-dismiss="alert">&times;</a>
    </div>
    <script>
        $(function(){
            $("#myclose").click(function(){
                $("#myAlert").alert();
            });
        });
    </script>
</c:if>

<img src="<%=basePath%>/img/lun3.jpg" style="width: 1920px; height: 927px;" />

<div>
    <!--个人信息模块-->
    <div class="panel panel-default" style="width: 300px; height: 150px; position: absolute;top: 0;background-color: #E0E0E0;">
        <div class="panel-body">
            <img src="<%=basePath%>/img/EDBEF179ABCCB9B92DFA72DA5DDCECA3.png" class="img-circle" style="width: 120px;height: 120px;">
            <span style="position: absolute; top: 20px; margin-left: 20px;">${user.userName}</span>
            <img src="<%=basePath%>/img/欢乐豆 .png" style="margin-top: 80px;height: 30px;margin-left: 20px; cursor:pointer;"  id="happy_bean"><span style="position: absolute; top: 100px;margin-left: 10px;"><h4>${user.happyBean}</h4></span>
            <img src="<%=basePath%>/img/123.png" style="margin-top: -70px;height: 30px;margin-left: 30px; cursor:pointer;" id="modify_user_information" data-target="#modify_user_information_modal" data-toggle="modal" />
        </div><span><strong><a href="<%=basePath%>logout">退出登录</a></strong></span>
    </div>
    <!--三个按钮-->
    <div>
        <button type="button" class="btn btn-primary btn-lg" style="position: absolute;top: 750px; margin-left: 500px; width: 300px;" id="create_room" data-target="#create_room_modal" data-toggle="modal"><h2>创建房间</h2></button>
        <button type="button" class="btn btn-primary btn-lg" style="position: absolute;top: 750px; margin-left: 840px; width: 300px;" id="join_room" data-target="#join_room_modal" data-toggle="modal"><h2>加入房间</h2></button>
        <button type="button" class="btn btn-primary btn-lg" style="position: absolute;top: 750px; margin-left: 1180px; width: 300px;" id="fast_game"><h2>快速游戏</h2></button>
    </div>
</div>
<!--创建房间模态框-->
<div class="modal fade" id="create_room_modal">
    <div class="modal-dialog">

        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" style="text-align: center;">创建房间</h4>
            </div>
            <form action="<%=basePath%>/createRoom" method="post">
                <input name="userId" value="${user.userId}" type="hidden"/>
                <div class="modal-body" id="show_password_input">
                    <h3><span class="label label-warning">是否设置密码？</span>&nbsp;<button type="button" class="btn btn-success" id="select_password">YES</button></h3>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary">创建</button>
                </div>
            </form>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!--修改个人信息模态框-->
<div class="modal fade" id="modify_user_information_modal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" style="text-align: center;">修改个人信息</h4>
            </div>
            <div>
                <img src="<%=basePath%>/img/EDBEF179ABCCB9B92DFA72DA5DDCECA3.png" class="img-circle" style="width: 100px;height: 100px;" id="img_modify">
                <input type='text' class='form-control' id='modify_nickname_input' placeholder='修改昵称' style="width: 60%; position: absolute; top: 70px;left: 160px;">
                <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-left: 275px;margin-top: 50px;">关闭</button>
                <button type="button" class="btn btn-primary" style="margin-top: 50px;">确认修改</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!--加入游戏模态框-->
<div class="modal fade" id="join_room_modal">
    <div class="modal-dialog">
        <form action="<%=basePath%>/joinRoom" method="get">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" style="text-align: center;">加入房间</h4>
            </div>
                <div>
                    <h3>请输入房间号</h3><input type='text' class='form-control' id='roomId_input' name="roomId" placeholder='房间号' style="width: 65%; position: absolute; top: 75px;left: 160px;">
                    <div id="write_room_password"></div>
                    <button type="button" class="btn btn-default" data-dismiss="modal" style="margin-left: 440px;">关闭</button>
                    <button type="submit" class="btn btn-primary" id="join_btn">加入</button>
                </div>
        </div>
        </form>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<!--管家butters-->
<div class="kePublic">
    <div class='content'>
        <p style='text-align:center;'>
        <div class='eye_wrapper' id='eyeballs'>
            <img alt="Head" class="head" src="<%=basePath%>/img/head.jpg" style="width:141px;margin:20px auto;" id="head_show_message" />
            <img alt="Ball" class="eye-left" id="eye_left" src="<%=basePath%>/img/ball.png" />
            <img alt="Ball" class="eye-right" id="eye_right" src="<%=basePath%>/img/ball.png" />
        </div>
        </p>
        <div id="show_message"></div>
    </div>
</div>

</body>
<script>
    $(function() {
        $("#roomId_input").blur(function () {
            var roomId=this.value();
            $.ajax({
                type : "get",
                url : "<%=basePath%>roomIsLock",
                data : {roomId : roomId},
                success : function (flag) {
                    console.log(flag);
                }
            })
        })
        $("#join_btn").click(function () {

        })
        //设置密码
        $("#show_password_input").on('click', '#select_password', function() {
            $("#show_password_input").html("<input type='text' class='form-control' id='password_input' placeholder='Password'>");
        });

        $("#img_modify").click(function() {
            alert("1");
        });
        //按钮触发提示事件

        function show_message(str, left) {
            str = "<h4 style='position: absolute; top: 640px; left:" + left + "px; z-index: 100;font-weight: 800;'>" + str + "</h4>";
            $("#show_message").html(str + "<img src='<%=basePath%>/img/showMessage.png' style='position: absolute; top: 580px; left: 180px; width: 320px;height: 220px;' />");
        }

        $("#create_room").hover(function() {
            var str = "创建房间和好友战个痛快";
            show_message(str, 262);
        });
        $("#create_room").mouseleave(function() {
            $("#show_message").html("");
        });

        $("#join_room").hover(function() {
            var str = "三缺一就差你了!";
            show_message(str, 290);
        });
        $("#join_room").mouseleave(function() {
            $("#show_message").html("");
        });

        $("#fast_game").hover(function() {
            var str = "狩猎开始了!";
            show_message(str, 310);
        });
        $("#fast_game").mouseleave(function() {
            $("#show_message").html("");
        });

        $("#modify_user_information").hover(function() {
            var str = "我早已厌烦这个名字!";
            show_message(str, 270);
        });
        $("#modify_user_information").mouseleave(function() {
            $("#show_message").html("");
        });

        $("#head_show_message").hover(function() {
            var str = "I'm butters!";
            show_message(str, 300);
        });
        $("#head_show_message").mouseleave(function() {
            $("#show_message").html("");
        });

        $("#happy_bean").hover(function() {
            var str = "充钱将使你变得更强!";
            show_message(str, 270);
        });
        $("#happy_bean").mouseleave(function() {
            $("#show_message").html("");
        });
    });
    //眼睛随动
    var getAngle = function(Xc, Yc, Xa, Ya, Xb, Yb) {
        var v1x = Xb - Xc;
        var v1y = Yb - Yc;
        var v2x = Xa - Xc;
        var v2y = Ya - Yc;
        return 180 * (Math.atan2(v1x, v1y) - Math.atan2(v2x, v2y)) / Math.PI
    };
    var left_center_offset = {
            left: 50,
            top: 92
        },
        right_center_offset = {
            left: 82,
            top: 92
        },
        radius = 10;
    var setEyeOffset = function(event) {
        var offset = $(".eye_wrapper").offset();
        var x1 = offset.left + left_center_offset.left;
        var y1 = offset.top + left_center_offset.top;
        var x2 = offset.left + right_center_offset.left;
        var y2 = offset.top + right_center_offset.top;
        var n1 = event.clientX - x1;
        var m1 = -(event.clientY - y1);
        var k1 = Math.atan2(m1, n1);
        var n2 = event.clientX - x2;
        var m2 = -(event.clientY - y2);
        var k2 = Math.atan2(m2, n2);
        var x11 = (Math.cos(k1) * radius + x1).toFixed(0);
        var y11 = ((-Math.sin(k1) * radius) + y1).toFixed(0);
        $(".eye-left").offset({
            left: x11,
            top: y11
        });
        var x22 = (Math.cos(k2) * radius + x2).toFixed(0);
        var y22 = ((-Math.sin(k2) * radius) + y2).toFixed(0);
        $(".eye-right").offset({
            left: x22,
            top: y22
        })
    };
    $(window).mousemove(setEyeOffset);
</script>

</html>