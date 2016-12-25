<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<html>
	<head>
		<title>首页</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<%
			String RealPath = getServletContext().getRealPath("\\");
			db.setRealPath(RealPath);

			String sql = "select ID, rank, bookName, author, ISBN from book order by rank;";
			ResultSet rs = db.executeQuery(sql);
			rs.last();
			int count = rs.getRow();
			rs.beforeFirst();
			String ID, rank, ISBN, bookName, author;
		%>
		<jsp:include page="header.html"></jsp:include>
		<div id="left-head">
		fdfsdfsfsfsff
		
		</div>
		<div id="content">
			<div class="title">
				图书畅销排行榜（前<%=count%>名）
			</div>
			<%
				while (rs.next()) {
					rank = rs.getString("rank");
					bookName = rs.getString("bookName");
					author = rs.getString("author");
					ISBN = rs.getString("ISBN");
					ID = rs.getString("ID");
			%>
			<div class="showBook">
				<div class="rank"><%=rank%>.
				</div>
				<div class="cover">
					<a target="_blank" href="show.jsp?id=<%=ID%>"><img
							src="img/<%=ISBN%>.jpg" alt="<%=bookName%>"> </a>
				</div>
				<div class="name">
					<a target="_blank" href="show.jsp?id=<%=ID%>"> <%=bookName%> </a>
				</div>
				<div class="author">
					——<%=author%></div>
			</div>
			<%
				}
				db.close();
			%>
		</div>
	</body>
</html>
