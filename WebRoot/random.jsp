<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<html>
	<head>
		<title>跳转中...</title>
	</head>
	<body>
		<%
			String RealPath = getServletContext().getRealPath("\\");
			db.setRealPath(RealPath);
			String sql = "select count(*) from book;";
			ResultSet rs = db.executeQueryCount(sql);
			rs.next();
			int count = rs.getInt(1);
			db.close();
			int choice = 1 + (int) (Math.random() * count);
			response.sendRedirect("show.jsp?id=" + choice);
		%>
	</body>
</html>
