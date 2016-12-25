<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<jsp:useBean id="ch" class="MyClass.StrConvert" scope="request" />
<html>
	<head>
		<title>查找书籍</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<%
			request.setCharacterEncoding("utf-8");
			String search = request.getParameter("search");
			search = ch.chStr(search);
			if (search == null || search.equals("")) {
				response.sendRedirect("nothing.jsp");
				return;
			}

			String RealPath = getServletContext().getRealPath("\\");
			db.setRealPath(RealPath);
			String sql = "select ID, bookName, author, publishingHouse, ISBN from book where " + "bookName like '%"
					+ search + "%' or " + "author like '%" + search + "%' or "
					+ "publishingHouse like '%" + search + "%' or "
					+ "ISBN like '%" + search + "%'";
			ResultSet rs = db.executeQuery(sql);
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();

			int i = 0;
			String ID, bookName, author, ISBN, publishingHouse;
		%>
		<jsp:include page="header.html"></jsp:include>
		<div id="content">
			<div id="show">
				<h2>
					查到<%=count%>条记录
				</h2>
				<hr />
				<%
					while (rs.next()) {
						i++;
						bookName = rs.getString("bookName");
						author = rs.getString("author");
						ISBN = rs.getString("ISBN");
						ID = rs.getString("ID");
						publishingHouse = rs.getString("publishingHouse");
						bookName = bookName.replaceAll(search, "<b style='color:red'>"
								+ search + "</b>");
						author = author.replaceAll(search, "<b style='color:red'>"
								+ search + "</b>");
						ISBN = ISBN.replaceAll(search, "<b style='color:red'>" + search
								+ "</b>");
						publishingHouse = publishingHouse.replaceAll(search,
								"<b style='color:red'>" + search + "</b>");
				%>
				<div id="searchResult">
					<a href="show.jsp?id=<%=ID%>"> <%=i%>. <b><%=bookName%></b> （<%=author%>）<%=publishingHouse%>（ISBN：<%=ISBN%>）
					</a>
					<hr />
				</div>
				<%
					}
					db.close();
				%>
			</div>
		</div>
	</body>
</html>
