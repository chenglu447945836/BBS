 <%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%
request.setCharacterEncoding("gb2312");

//out.println( new String(hello.getName().getBytes("ISO8859_1"), "gbk") );

int pid = Integer.parseInt(request.getParameter("id"));
int rootid = Integer.parseInt(request.getParameter("rootid"));

String title = request.getParameter("title");
if(title == null) {
	out.println("error!please use my bbs in the right way");
	return;
}
title = title.trim();
if(title.equals("")) {
	out.println("title can't be empty");
	return;
}

String cont = request.getParameter("cont");
if(cont == null) {
	out.println("error!please use my bbs in the right way");
	return;
}
cont = cont.trim();
if(cont.equals("")) {
	out.println("content can't be empty");
	return;
}
cont = cont.replaceAll("\n", "<br>");

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "root", "");

conn.setAutoCommit(false);

String sql = "insert into article values(null, ?, ?, ?, ?, now(), 0)";
PreparedStatement pstmt = conn.prepareStatement(sql);

Statement stmt = conn.createStatement();
stmt.executeUpdate("update article set isleaf = 1 where id=" + pid);

pstmt.setInt(1, pid);
pstmt.setInt(2, rootid);
pstmt.setString(3, title);
pstmt.setString(4, cont);
pstmt.executeUpdate();

conn.commit();
conn.setAutoCommit(true);

stmt.close();
pstmt.close();
conn.close();

response.sendRedirect("ShowArticleTree.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
	<font size="7" color="red">
		OK!
	</font>
</body>
</html>