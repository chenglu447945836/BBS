<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import = "java.sql.*" %>



<%!
private void delete(Connection conn, int id) {
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		stmt = conn.createStatement();
		String sql = "select * from article where pid=" + id;
		rs = stmt.executeQuery(sql);
		
		while(rs.next()) {
			delete(conn, rs.getInt("id"));
		}
		stmt.executeUpdate("delete from article where id=" + id);
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
String admin = (String)session.getAttribute("admin");
if((admin == null) || (!admin.equals("true"))) {
	out.println("小贼！休想通过我这关！");
	return;
}
%>

<%
int id = Integer.parseInt(request.getParameter("id"));
int pid = Integer.parseInt(request.getParameter("pid"));

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "root", "");

conn.setAutoCommit(false);

delete(conn, id);

Statement stmt = conn.createStatement();
String sql ="select count(*) from article where pid=" + id;
ResultSet rs = stmt.executeQuery(sql);
rs.next();
int count = rs.getInt(1);

rs.close();
stmt.close();

if(count <= 0) {
	Statement stmtUpdate = conn.createStatement();
	stmtUpdate.executeUpdate("update article set isleaf=0 where id=" + pid);
	stmtUpdate.close();
}

conn.commit();
conn.setAutoCommit(true);

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

</body>
</html>












