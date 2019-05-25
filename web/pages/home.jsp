<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@page import="com.wzy.pojo.MajUser" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
    <script src="<%=basePath%>js/jquery-2.1.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

</head>
<body>
<div>
    test
    <!--个人信息模块-->
    <div class="panel panel-default" style="width: 300px; height: 150px; position: absolute; top: 0px;">
        <div class="panel-body">
            <img src="<%=basePath%>img/EDBEF179ABCCB9B92DFA72DA5DDCECA3.png" class="img-thumbnail" style="width: 100px;height: 120px;">
            <span style="position: absolute; top: 20px; margin-left: 20px;"><h4>${user.userName}</h4></span>
            <img src="<%=basePath%>img/欢乐豆 .png" style="margin-top: 80px;height: 30px;margin-left: 20px;" /><span style="position: absolute; top: 100px;margin-left: 10px;"><h4>${user.happyBean}</h4></span>
            <img src="<%=basePath%>img/123.png" style="margin-top: -70px;height: 30px;margin-left: 30px; cursor:pointer;" id="modify_user_information" data-target="#modify_user_information_modal" data-toggle="modal" />
        </div>
    </div>
    <!--三个按钮-->
    <div>
        <button type="button" class="btn btn-primary btn-lg" style="position: absolute;top: 700px; margin-left: 500px; width: 300px;" id="create_room" data-target="#create_room_modal" data-toggle="modal"><h2>创建房间</h2></button>
        <button type="button" class="btn btn-primary btn-lg" style="position: absolute;top: 700px; margin-left: 840px; width: 300px;" id="join_room" data-target="#join_room_modal" data-toggle="modal"><h2>加入房间</h2></button>
        <button type="button" class="btn btn-primary btn-lg" style="position: absolute;top: 700px; margin-left: 1180px; width: 300px;" id="fast_game"><h2>快速游戏</h2></button>
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
            <form class="form-group" action="<%=basePath%>createRoom" method="post">
                <div class="modal-body" id="show_password_input">
                    <input name="userId" id="userId" value="123123" > <br>
                    <input name="roomPwd" id="roomPwd">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="submit" class="btn btn-primary" id="create_room_submit" >创建</button>
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
                <img src="img/EDBEF179ABCCB9B92DFA72DA5DDCECA3.png" class="img-thumbnail" style="width: 100px;height: 120px;" id="img_modify">
                <input type='text' class='form-control' id='modify_name_input' placeholder='修改昵称' style="width: 60%; position: absolute; top: 70px;left: 160px;">
                <button type="button" class="btn btn-success" style="margin-left: 280px; margin-top: 60px;">确认修改</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal" style="margin-top: 60px;">取消</button>
                <input type="file" id="modify_img_here">
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
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" style="text-align: center;">加入房间</h4>
            </div>
            <div>
                <h3>请输入房间名</h3><input type='text' class='form-control' id='modify_name_input1' placeholder='房间号' style="width: 60%; position: absolute; top: 75px;left: 160px;">
                <button type="button" class="btn btn-success" style="margin-left: 400px; margin-top: 40px;">加入</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal" style="margin-top: 40px; margin-left: 20px;">取消</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
</body>
<script>

</script>
</html>
