<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>Signin Template for Bootstrap</title>
    <!-- Bootstrap core CSS -->
    <link type="text/css" href="<%=basePath%>css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="<%=basePath%>css/signin.css" rel="stylesheet">
    <script src="<%=basePath%>js/jquery-2.1.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

</head>

<body>

<div class="container">

    <form class="form-signin">
        <h2 class="form-signin-heading">Please sign in</h2>
        <label for="inputEmail" class="sr-only">Email address</label>
        <input type="email" id="inputEmail" class="form-control" placeholder="Email address" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> Remember me
            </label>
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        <button class="btn btn-lg btn-primary btn-block" data-target="#rigister">Sign up</button>
    </form>
    <!-- 注册模态框（Modal） -->
    <div class="modal fade" id="rigister" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"
                            aria-hidden="true">
                        &times;
                    </button>
                    <h1 class="text-center">
                        注册
                    </h1>
                </div>
                <div class="modal-body">
                    <form class="form-group" action="log/logup" method="post">
                        <div class="form-group">
                            用户名
                            <input class="form-control" type="text" placeholder="6-15位字母或数字"
                                   id="logup_account" name="logup_account" style="width: 93%">
                            <div id="judge_img1"></div>
                            <span id="logup_account_message1"></span>
                        </div>
                        <div class="form-group">
                            密码
                            <input class="form-control" type="password"
                                   placeholder="至少6位字母或数字" id="logup_password" name="logup_password" style="width: 93%">
                            <div id="judge_img2"></div>
                            <span id="logup_password_message2"></span>
                        </div>
                        <div class="form-group">
                            再次输入密码
                            <input class="form-control" type="password"
                                   placeholder="至少6位字母或数字" id="logup_password1" name="logup_password1" style="width: 93%">
                        </div>
                        <div id="judge_img3"></div>
                        <span id="logup_password_message3"></span>

                        <div class="text-right">
                            <button class="btn btn-primary" type="button" id="logup_submit">
                                提交
                            </button>
                            <button class="btn btn-danger" data-dismiss="modal">
                                取消
                            </button>
                        </div>
                        <a href="" data-toggle="modal" data-dismiss="modal"
                           data-target="#login">已有账号，点我登录</a>
                    </form>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal -->
    </div>
</div> <!-- /container -->
    <script>
            var flag1 = false;
            var flag2 = false;
            var flag3 = false;
            var logup_account_check="";
            $("#logup_account")
                .blur(
                    function() {
                        var logup_account = $("#logup_account").val();
                        if(logup_account == logup_account_check) return false;
                        logup_account_check=logup_account;
                        if (logup_account == "") {
                            document.getElementById("judge_img1").innerHTML = "<div id='judge_img1'></div>";
                            document.getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1'></span>";
                        } else {
                            $
                                .ajax( {
                                    url : "<%=basePath%>log/checkAccount",
                                    type : "POST",
                                    data : {
                                        logup_account : logup_account
                                    },
                                    success : function(data) {
                                        console.log("success"+data);
                                        if (data == "false") {
                                            document
                                                .getElementById("judge_img1").innerHTML = "<div style='position: absolute;top:40px;left:550px' id='judge_img1'><img id='i1' src='<%=basePath%>/img/core-img/1.jpg' style='height: 30px;width: 30px'/></div>";
                                            document
                                                .getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1' style='color: green;'>该用户可用</span>";
                                            flag1 = true;
                                        } else if (data == "true") {
                                            document
                                                .getElementById("judge_img1").innerHTML = "<div style='position: absolute;top:40px;left:550px' id='judge_img1'><img src='<%=basePath%>/img/core-img/2.jpg' style='height: 30px;width: 30px'/></div>";
                                            document
                                                .getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1' style='color: red;'>用户名重复</span>";
                                        }
                                    },
                                    error :function () {
                                        console.log("error");
                                    }
                                });
                        }
                    });

            $("#logup_password")
                .blur(
                    function() {
                        var logup_password = $("#logup_password").val();
                        flag3 = false;
                        $("#logup_password1").val("");
                        document.getElementById("judge_img3").innerHTML = "<div id='judge_img3'></div>";
                        document.getElementById("logup_password_message3").innerHTML = "<span id='logup_password_message3'></span>";
                        if (logup_password == "") {
                            document.getElementById("judge_img2").innerHTML = "<div id='judge_img2'></div>";
                            document.getElementById("logup_password_message2").innerHTML = "<span id='logup_password_message2'></span>";
                        } else {
                        }
                    });

            $("#logup_password1")
                .blur(
                    function() {
                        var logup_password1 = $("#logup_password1").val();
                        var logup_password = $("#logup_password").val();
                        if (logup_password1 == "" || logup_password == "") {
                            document.getElementById("judge_img3").innerHTML = "<div id='judge_img3'></div>";
                            document.getElementById("logup_password_message3").innerHTML = "<span id='logup_password_message3'></span>";
                        } else {
                            if (logup_password1 == logup_password) {
                                document.getElementById("judge_img3").innerHTML = "<div style='position: absolute;margin-top:-45px;left:550px' id='judge_img3'><img src='img/core-img/1.jpg' style='height: 30px;width: 30px'/></div>";
                                document.getElementById("logup_password_message3").innerHTML = "<span id='logup_password_message3'></span>";
                                flag3 = true;
                            } else {
                                document.getElementById("judge_img3").innerHTML = "<div style='position: absolute;margin-top:-45px;left:550px' id='judge_img3'><img src='img/core-img/2.jpg' style='height: 30px;width: 30px'/></div>";
                                document
                                    .getElementById("logup_password_message3").innerHTML = "<span id='logup_password_message3' style='color: red;'>两次密码不一致</span>";
                            }
                        }
                    });

            $("#logup_submit").click(function() {
                if (flag1 & flag2 & flag3) {
                    alert("success_logIn");
                } else {
                    alert("检查是否所有内容正确");
                    return false;
                }
            });
    </script>
</body>
</html>