<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
   
<%@ page import="java.sql.*" %>

<%!
boolean login = false;
%>

<%
String admin = (String)session.getAttribute("admin");
if((admin != null) && (admin.equals("true"))) {
	login = true;
}
%>

<%!
String str = "";

private void tree(Connection conn, int id, int level) {
	Statement stmt = null;
	ResultSet rs = null;
	String preStr = "";
	String strLogin = "";
	
	for(int i=0; i<level; i++) {
		preStr += "----";
	}
	
	try {
		stmt = conn.createStatement();
		String sql = "select * from article where pid=" + id;
		rs = stmt.executeQuery(sql);
		while(rs.next()) {
			if(login) {
				strLogin = "<td><a href='Delete.jsp?id=" + rs.getInt("id") + 
						   "&pid=" + rs.getInt("pid") + "'>" + 
						   "ɾ��" + "</a></td>" ;
				
			}
			str += "<tr><td>" + rs.getInt("id") + "</td><td>" + 
				   preStr + "<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" + 
				   rs.getString("title") + "</a></td>"+ 
				   strLogin +
				   "</tr>";
			if(rs.getInt("isleaf") != 0) {
				tree(conn, rs.getInt("id"), level+1);
			}
		}
	} catch(SQLException e) {
		e.printStackTrace();
	} finally {
		try {
			if(rs != null) {
				rs.close();
				rs = null;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		
		try {
			if(stmt != null) {
				stmt.close();
				stmt = null;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
%>
    
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs","root","");
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select * from article where pid = 0");

String strLogin = "";

while(rs.next()) {
	if(login) {
		strLogin = "<td><a href='Delete.jsp?id=" + rs.getInt("id") + 
				   "&pid=" + rs.getInt("pid") + "'>" + 
				   "ɾ��" + "</a></td>" ;
	}
	
	str += "<tr><td>" + rs.getInt("id") + "</td><td>" + 
		   "<a href='ShowArticleDetail.jsp?id=" + rs.getInt("id") + "'>" + 
		   rs.getString("title") + "</a></td>"+ 
		   strLogin +
		   "</tr>";
	if(rs.getInt("isleaf") != 0) {
		tree(conn, rs.getInt("id"), 1);
	}
}

rs.close();
stmt.close();
conn.close();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
	<a href="Post.jsp">��������</a>
	<table border="1">
	<%= str%>
	<%
	str = "";
	strLogin = "";
	login = false;
	%>
	</table>
</body>

</html>