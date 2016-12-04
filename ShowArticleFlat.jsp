<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
   
<%@ page import="java.sql.*" %>
    
<%
String strPageNo = request.getParameter("pageNo");
int pageNo;
int pageSize = 3;

if(strPageNo == null || strPageNo.equals("")) {
	pageNo = 1;
} else {
	try {
		pageNo = Integer.parseInt(strPageNo.trim());
	} catch(NumberFormatException e) {
		pageNo = 1;
	}
	if(pageNo <= 0) {
		pageNo = 1;
	}
}

Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs","root","");

Statement stmtCount = conn.createStatement();
ResultSet rsCount = stmtCount.executeQuery("select count(*) from article where pid = 0");
rsCount.next();
int totalRecords = rsCount.getInt(1);
int totalPages = totalRecords % pageSize == 0 ? totalRecords / pageSize: totalRecords / pageSize + 1;
rsCount.close();
stmtCount.close();

if(pageNo > totalPages) {
	pageNo = totalPages;
}

int startPos = (pageNo - 1) * pageSize;

Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select * from article where pid = 0 order by pdate desc limit " + startPos + "," + pageSize);
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
		<%
			while(rs.next()) {
		%>
			<tr>
				<td>
					<a href="ShowArticleDetail.jsp?id=<%=rs.getInt("id")%>"><%=rs.getString("title") %></a>
				</td>
			</tr>
		<%
			}
			rs.close();
			stmt.close();
			conn.close();
		%>
	</table>
	��<%=totalPages %>ҳ	��<%=pageNo %>ҳ
	<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo-1%>"> < </a>&nbsp;&nbsp;&nbsp;&nbsp;
	<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo+1%>"> > </a>
	<form name="form1">
		<select name="pageNo" onchange="document.form1.submit()">
			<%
				for(int i=1; i<=totalPages; i++) {
			%>
				<option value=<%=i %> <%=(i == pageNo?"selected" : "") %>>��<%=i %>ҳ
			<%
				}
			%>
		</select>
	</form>
	
	<form name="form2" action="ShowArticleFlat.jsp">
		<input type="text" name="pageNo" value="<%=pageNo %>" size="4">
		<input type="submit" value="go">
	</form>
</body>

</html>










