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
		<link rel="stylesheet" href="css/bootstrap.min.css">
		<link rel="shortcut icon" href="#" />
		<script type="text/javascript" src="http://libs.baidu.com/jquery/2.1.4/jquery.min.js"></script>
		<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
		<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
		<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@3.3.7/dist/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	</head>

	<body>
		<!-- 按钮触发登录模态框 -->
		<button class="btn btn-primary btn-lg" data-toggle="modal"
			data-target="#login">
			开始游戏
		</button>

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
						<form class="form-group">
							<div class="form-group">
								用户名
								<input class="form-control" type="text" placeholder="6-15位字母或数字"
									id="logup_account" style="width: 93%">
								<div id="judge_img1"></div>
								<span id="logup_account_message1"></span>
							</div>
							<div class="form-group">
								密码
								<input class="form-control" type="password"
									placeholder="至少6位字母或数字" id="logup_password" style="width: 93%">
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
						<form class="form-group" action="">
							<div class="form-group">
								用户名
								<input class="form-control" type="text" placeholder=""
									id="login_account">
							</div>
							<div class="form-group">
								密码
								<input class="form-control" type="password" placeholder=""
									id="login_password">
							</div>
							<span id="login_message" style="color: red;"></span>
							<div class="text-right">
								<button class="btn btn-primary" type="button" id="login_submit">
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
$(function() {
	var flag1 = false;
	var flag2 = false;
	var flag3 = false;
	$("#logup_account")
			.blur(
					function() {
						var logup_account = $("#logup_account").val();
						if (logup_account == "") {
							document.getElementById("judge_img1").innerHTML = "<div id='judge_img1'></div>";
							document.getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1'></span>";
						} else {
							$
									.ajax( {
										url : "checkRegisterServlet",
										type : "POST",
										data : {
											logup_account : logup_account
										},
										success : function(data) {
											if (data == "false") {
												document
														.getElementById("judge_img1").innerHTML = "<div style='position: absolute;top:40px;left:550px' id='judge_img1'><img id='i1' src='img/core-img/1.jpg' style='height: 30px;width: 30px'/></div>";
												document
														.getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1' style='color: green;'>该用户可用</span>";
												flag1 = true;
											} else if (data == "true") {
												document
														.getElementById("judge_img1").innerHTML = "<div style='position: absolute;top:40px;left:550px' id='judge_img1'><img src='img/core-img/2.jpg' style='height: 30px;width: 30px'/></div>";
												document
														.getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1' style='color: red;'>用户名重复</span>";
											} else if (data == "fail") {
												document
														.getElementById("judge_img1").innerHTML = "<div style='position: absolute;top:40px;left:550px' id='judge_img1'><img src='img/core-img/2.jpg' style='height: 30px;width: 30px'/></div>";
												document
														.getElementById("logup_account_message1").innerHTML = "<span id='logup_account_message1' style='color: red;'>用户名格式错误</span>";
											}
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
							$
									.ajax( {
										url : "CheckRegisterServlet1",
										type : "POST",
										data : {
											logup_password : logup_password
										},
										success : function(data) {
											if (data == "success") {
												document
														.getElementById("judge_img2").innerHTML = "<div style='position: absolute;margin-top:-30px;left:550px' id='judge_img2'><img src='img/core-img/1.jpg' style='height: 30px;width: 30px'/></div>";
												document
														.getElementById("logup_password_message2").innerHTML = "<span id='logup_password_message2' style='color: green;'>该密码可用</span>";
												flag2 = true;
											} else if (data == "fail") {
												document
														.getElementById("judge_img2").innerHTML = "<div style='position: absolute;margin-top:-30px;left:550px'  id='judge_img2'><img src='img/core-img/2.jpg' style='height: 30px;width: 30px'/></div>";
												document
														.getElementById("logup_password_message2").innerHTML = "<span id='logup_password_message2' style='color: red;'>密码格式错误</span>";
											}
										}
									});
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
		}
	});

	$("#login_submit").click(function() {
		var login_account = $("#login_account").val();
		var login_password = $("#login_password").val();
		$.ajax( {
			url : "CheckRegisterServlet3",
			type : "POST",
			data : {
				login_account : login_account,
				login_password : login_password
			},
			success : function(data) {
				if(data=="true"){
				document.getElementById("login_message").innerHTML="<span id='login_message' style='color: red;'></span>";
					alert("登陆成功");
				}else{
					document.getElementById("login_message").innerHTML="<span id='login_message' style='color: red;'>账号密码错误</span>";
				}
			}
		});
	});
});
</script>
</html>