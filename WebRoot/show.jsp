<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<html>
	<head>
		<title>书籍展示</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<%
			String ID = request.getParameter("id");
			if (ID == null || ID.equals("")) {
				response.sendRedirect("nothing.jsp");
				return;
			}
			try {
				Integer.parseInt(ID);
			} catch (Exception e) {
				response.sendRedirect("nothing.jsp");
				return;
			}
			String RealPath = getServletContext().getRealPath("\\");
			db.setRealPath(RealPath);
			String sql = "select * from book where ID=" + ID;
			ResultSet rs = db.executeQuery(sql);
			if (!rs.next()) {
				response.sendRedirect("nothing.jsp");
				db.close();
				return;
			}

			String rank, ISBN, bookName, author, publishingHouse, price, summary;
			rank = rs.getString("rank");
			ISBN = rs.getString("ISBN");
			bookName = rs.getString("bookName");
			author = rs.getString("author");
			publishingHouse = rs.getString("publishingHouse");
			price = rs.getString("price");
			price = price.substring(0, price.length() - 2);
			summary = rs.getString("summary");
			summary = summary.replaceAll("\n", "<br>");
			db.close();
		%>
		<jsp:include page="header.html"></jsp:include>
		<div id="content">
			<div id="show">
				<div id="cover">
					<img src="img/<%=ISBN%>.jpg" alt="<%=bookName%>">
				</div>
				<div id="des1">
					<p>
						<b>销售排名：</b><%=rank%></p>
					<p>
						<b>书名：</b><%=bookName%></p>
					<p>
						<b>作者：</b><%=author%></p>
					<p>
						<b>出版社：</b><%=publishingHouse%></p>
					<p>
						<b>价格：</b><%=price%>元
					</p>
					<p>
						<b>ISBN：</b><%=ISBN%></p>
				</div>
				<div id="des2">
					<b>简介：</b>
					<p><%=summary%></p>
					<div id="edit">
						<a href="edit.jsp?id=<%=ID%>">编辑</a>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>
