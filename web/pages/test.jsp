
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="<%=basePath%>js/jquery-2.2.4.min.js"></script>
</head>
<body>
<div>
    test
    <button id="test" >test</button>
</div>

    <script>
        $("#test").click(function () {
            $.ajax({
                url : "<%=basePath%>ajax/test",
                type : "get",
                data : {msg : "test"},
                success : function (bean) {
                    var json=$.parseJSON(bean);
                    console.log(bean)
                    console.log(json)
                    var majs=new Array();
                    for(var i=0;i<json.majIdList.length;i++) majs.push(json.majIdList[i]);
                    console.log(majs)
                },
                error : function () {
                    console.log("error");
                }
            })
        })
    </script>
</body>
</html>
