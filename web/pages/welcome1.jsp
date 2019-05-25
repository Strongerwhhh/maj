<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<meta charset="utf-8">
		<title>welcome</title>

		<!--模态框包-->
		<link rel="stylesheet" href="<%=basePath%>css/bootstrap.min.css">
		<link href="<%=basePath%>css/style.css" rel="stylesheet" type="text/css" media="all" />
		<link rel="shortcut icon" href="#" />
		<script src="<%=basePath%>js/jquery-2.1.4.min.js"></script>
		<script src="<%=basePath%>js/bootstrap.min.js"></script>
		<script src="<%=basePath%>js/responsiveslides.min.js"></script>
	</head>

	<body>
    ${errormsg}
		<!-- banner -->
		<div class="banner">
			<!--Slider-->
			<div class="slider">
				<div class="callbacks_container">
					<ul class="rslides" id="slider3">
						<li>
							<div class="slider-img">
								<img src="<%=basePath%>img/lun1.jpg" class="img-responsive" alt="Fantasy World" style="width: 1920px;height: 937px">
							</div>
							<div class="slider-info">
								<h4>欢乐麻将</h4>
								<p>解放你的大脑</p>
								<a href="#about" class="hvr-shutter-in-horizontal scroll" data-toggle="modal" data-target="#login">开始游戏</a>
							</div>
						</li>
						<li>
							<div class="slider-img">
								<img src="<%=basePath%>img/lun2.jpg" class="img-responsive" alt="Fantasy World" style="width: 1920px;height: 937px">
							</div>
							<div class="slider-info">
								<h4 style="color: black;">Girl Dragon fantasy sword wing</h4>
								<p>World building is component of fantasy </p>
								<a href="#about" class="hvr-shutter-in-horizontal scroll" data-toggle="modal" data-target="#login">开始游戏</a>
							</div>
						</li>
						<li>
							<div class="slider-img">
								<img src="<%=basePath%>img/lun3.jpg" class="img-responsive" alt="Fantasy World" style="width: 1920px;height: 937px">
							</div>
							<div class="slider-info">
								<h4>Danger bear guy pistol moment</h4>
								<p>World building is component of fantasy </p>
								<a href="#about" class="hvr-shutter-in-horizontal scroll" data-toggle="modal" data-target="#login">开始游戏</a>
							</div>
						</li>
					</ul>
				</div>
				<div class="clearfix"></div>
			</div>
			<!--//Slider-->
		</div>
		<!--banner Slider starts Here-->
		

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
									placeholder="至少6位字母或数字" id="logup_password1" style="width: 93%">
							</div>
							<div id="judge_img3"></div>
							<span id="logup_password_message3"></span>

							<div class="text-right">
								<button class="btn btn-primary" type="submit" id="logup_submit">
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
		<!-- 登录模态框（Modal） -->
		<div id="login" class="modal fade">
			<div class="modal-dialog" style="z-index: 2000;">
				<div class="modal-content">
					<div class="modal-body">
						<button class="close" data-dismiss="modal">
							<span>&times;</span>
						</button>
					</div>
					<div class="modal-title">
						<h1 class="text-center">
							登录
						</h1>
					</div>
					<div class="modal-body">
						<form class="form-group" action="log/login" method="post">
							<div class="form-group">
								用户名
								<input class="form-control" type="text" placeholder=""
									id="login_account" name="login_account">
							</div>
							<div class="form-group">
								密码
								<input class="form-control" type="password" placeholder=""
									id="login_password" name="login_password">
							</div>
							<span id="login_message" style="color: red;"></span>
							<div class="text-right">
								<button class="btn btn-primary" type="submit" id="login_submit">
									登录
								</button>
								<button class="btn btn-danger" data-dismiss="modal">
									取消
								</button>
							</div>
							<a href="" data-toggle="modal" data-dismiss="modal"
								data-target="#rigister">还没有账号？点我注册</a>
						</form>
					</div>
				</div>
			</div>
		</div>

	</body>

	<script type="text/javascript">
        var flag1 = false;
        var flag2 = false;
        var flag3 = false;
        function setLogupAccount(flag){
            if(flag == "false"){
                document
                    .getElementById("judge_img1").innerHTML = "<div style='position: absolute;top:40px;left:550px' id='judge_img1'><img id='i1' src='<%=basePath%>/img/core-img/1.jpg' style='height: 30px;width: 30px'/></div>";
                document
                    .getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1' style='color: green;'>该用户可用</span>";
                flag1 = true;
            }else if(flag == "true"){
                document
                    .getElementById("judge_img1").innerHTML = "<div style='position: absolute;top:40px;left:550px' id='judge_img1'><img src='<%=basePath%>/img/core-img/2.jpg' style='height: 30px;width: 30px'/></div>";
                document
                    .getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1' style='color: red;'>用户名重复</span>";
            }else if(flag == "fail"){
                document
                    .getElementById("judge_img1").innerHTML = "<div style='position: absolute;top:40px;left:550px' id='judge_img1'><img src='<%=basePath%>/img/core-img/2.jpg' style='height: 30px;width: 30px'/></div>";
                document
                    .getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1' style='color: red;'>用户名格式错误</span>";

            }
        }
        $(function() {
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
                                        setLogupAccount(data)
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
                            var data;
                            if(logup_password.length>=6) data="success";
                            else data="fail";
                            if (data == "success") {
                                document
                                    .getElementById("judge_img2").innerHTML = "<div style='position: absolute;margin-top:-30px;left:550px' id='judge_img2'><img src='<%=basePath%>img/core-img/1.jpg' style='height: 30px;width: 30px'/></div>";
                                document
                                    .getElementById("logup_password_message2").innerHTML = "<span id='logup_password_message2' style='color: green;'>该密码可用</span>";
                                flag2 = true;
                            } else if (data == "fail") {
                                document
                                    .getElementById("judge_img2").innerHTML = "<div style='position: absolute;margin-top:-30px;left:550px'  id='judge_img2'><img src='<%=basePath%>img/core-img/2.jpg' style='height: 30px;width: 30px'/></div>";
                                document
                                    .getElementById("logup_password_message2").innerHTML = "<span id='logup_password_message2' style='color: red;'>密码格式错误</span>";
                            }
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
                } else {
                    alert("检查是否所有内容正确");
                    return false;
                }
            });

            $("#login_submit").click(function() {
                var account = $("#login_account").val();
                var password = $("#login_password").val();
                if(account.length<6 || password.length<6){
                    console.log("账号密码格式不对")
                    return false;
                }
            });
        });
$(function() {
				$("#slider3").responsiveSlides({
					auto: true,
					pager: false,
					nav: true,
					speed: 500,
					namespace: "callbacks",
					before: function() {
						$('.events').append("<li>before event fired.</li>");
					},
					after: function() {
						$('.events').append("<li>after event fired.</li>");
					}
				});

			});
</script>
</html>