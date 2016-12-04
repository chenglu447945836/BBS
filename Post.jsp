<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import = "java.sql.*" %>

<%
String action = request.getParameter("action");

if((action != null) && (action.equals("post"))) {
	
	request.setCharacterEncoding("gb2312");
	
	String title = request.getParameter("title");
	if(title == null) {
		out.println("error! Please use my bbs in right way");
		return;
	}
	title = title.trim();
	if(title.equals("")) {
		out.println("title can not be empty!");
		return;
	}
	
	String cont = request.getParameter("cont");
	if(cont == null) {
		out.println("error! Please use my bbs in right way");
		return;
	}
	cont = cont.trim();
	if(title.equals("")) {
		out.println("content can not be empty!");
		return;
	}
	cont = cont.replaceAll("\n", "<br>");
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "root", "");
	
	conn.setAutoCommit(false);
	
	String sql = "insert into article values(null, 0, ?, ?, ?, now(), 0)";
	PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
	Statement stmt = conn.createStatement();
	
	pstmt.setInt(1, -1);
	pstmt.setString(2, title);
	pstmt.setString(3, cont);
	pstmt.executeUpdate();
	
	ResultSet rsKey = pstmt.getGeneratedKeys();
	rsKey.next();
	int rootid = rsKey.getInt(1);
	rsKey.close();
	
	stmt.executeUpdate("update article set rootid=" + rootid);
	
	conn.commit();
	conn.setAutoCommit(true);
	
	stmt.close();
	pstmt.close();
	conn.close();
	
	response.sendRedirect("ShowArticleFlat.jsp");
}
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>

<script language="javascript">
<!--
	//javascript去空格函数 
	function LTrim(str){ //去掉字符串 的头空格
		var i;
		for(i=0;i<str.length; i++) {
			if(str.charAt(i)!=" ") break;
		}
		str = str.substring(i,str.length);
		return str;
	}
	
	function RTrim(str){
		var i;
		for(i=str.length-1;i>=0;i--){
			if(str.charAt(i)!=" "&&str.charAt(i)!=" ") break;
		}
		str = str.substring(0,i+1);
		return str;
	}
	function Trim(str){
	
		return LTrim(RTrim(str));
	
	}
	
	function check() {
		if(Trim(document.p.title.value) == "") {
			alert("please intput the title!");
			document.p.title.focus();
			return false;
		}
		
		if(Trim(document.p.cont.value) == "") {
			alert("plsease input the content!");
			document.p.cont.focus();
			return false;
		}
		
		return true;
		
	}
-->
</script>

</head>
<body>
	<form name="p" action="Post.jsp" method="post" onsubmit="return check()">
		<input type="hidden" name="action" value="post">
		<table border="1">
			<tr>
				<td>Title</td>
				<td>
					<input type="text" name="title" size="80">
				</td>
			</tr>
			<tr>
				<td>Content</td>
				<td>	
					<textarea rows="12" cols="80" name="cont"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="提交">
				</td>
			</tr>
		</table>
	</form>

</body>
</html>