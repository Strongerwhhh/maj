<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>Title</title>
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
                    console.log('Meessage received:' + message.content);
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
</head>
<body>
    <input id="input1">
    <button id="button1">test</button>
    <script>
        $("#button1").click(function () {
            console.log("ajax start");
            var msg=$("#input1").val();
            $.ajax({
                type: "POST",
                url: "http://localhost:8888/maj/ajax/test",
                dataType : "text",
                data: {msg : msg},
                success: function(){
                    alert( "Data Saved: " );
                },
                error : function () {
                    alert("error");
                }
            });
        })
    </script>
        

</body>
</html>
