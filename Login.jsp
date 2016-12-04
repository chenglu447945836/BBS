<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>

<%
String action = request.getParameter("action");
if((action != null) && (action.equals("post"))) {
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	
	if((username == null) || (!username.equals("admin"))) {
		out.println("username is not correct!");
	} else if((password == null) || (!password.equals("admin"))) {
		out.println("password is not correct!");
	} else {
		out.println("Welcom to BBS!");
		session.setAttribute("admin", "true");
		response.sendRedirect("ShowArticleTree.jsp");
	}
	
}
%>

<!DOCTYPE HTML>
<html dir="ltr" lang="en-US">
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=gbk" />

	<title>Login BBS</title>

	<!--- CSS --->
	<link rel="stylesheet" href="style.css" type="text/css" />


	<!--- Javascript libraries (jQuery and Selectivizr) used for the custom checkbox --->

	<!--[if (gte IE 6)&(lte IE 8)]>
		<script type="text/javascript" src="jquery-1.7.1.min.js"></script>
		<script type="text/javascript" src="selectivizr.js"></script>
		<noscript><link rel="stylesheet" href="fallback.css" /></noscript>
	<![endif]-->

	</head>

	<body>
		<div id="container">
			<form action="Login.jsp" method="post">
				<input type="hidden" name="action" value="post">
				<div class="login">LOGIN BBS</div>
				<div class="username-text">Username:</div>
				<div class="password-text">Password:</div>
				<div class="username-field">
					<input type="text" name="username" />
				</div>
				<div class="password-field">
					<input type="password" name="password" />
				</div>
				<input type="checkbox" name="remember-me" id="remember-me" /><label for="remember-me">Remember me</label>
				<div class="forgot-usr-pwd">Forgot <a href="#">username</a> or <a href="#">password</a>?</div>
				<input type="submit" name="submit" value="GO" />
			</form>
		</div>
		<div id="footer">
			Copyright &copy; 2014.Company name All rights reserved.<a target="_blank" href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a>
		</div>
<div style="display:none"><script src='http://v7.cnzz.com/stat.php?id=155540&web_id=155540' language='JavaScript' 
charset='gb2312'></script></div>
</body>
</html>