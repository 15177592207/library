<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<html>
	<head>
		<title>编辑书籍</title>
		<script type="text/javascript">
			function deleteConfirm() {
				if (confirm("确认要删除吗？")) {
					return true;
				} else {
					return false;
				}
			}
		</script>
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
			db.close();
		%>
		<jsp:include page="header.html"></jsp:include>
		<div id="content">
			<div id="show">
				<div id="cover">
					<img src="img/<%=ISBN%>.jpg" alt="<%=bookName%>">
				</div>
				<form action="edit_do.jsp?id=<%=ID %>" method="post">
					<div id="des1">
						<p>
							<b>销售排名：</b><%=rank%></p>
						<p>
							<b>书名：</b>
							<input name="bookName" value="<%=bookName%>"></input>
						</p>
						<p>
							<b>作者：</b>
							<input name="author" value="<%=author%>">
						</p>
						<p>
							<b>出版社：</b>
							<input name="publishingHouse" value="<%=publishingHouse%>">
						</p>
						<p>
							<b>价格：</b>
							<input name="price" value="<%=price%>">
							元
						</p>
						<p>
							<b>ISBN：</b>
							<input name="ISBN" value="<%=ISBN%>">
						</p>
					</div>
					<div id="des2">
						<b>简介：</b>
						<p>
							<textarea name="summary" rows="20" cols="55"><%=summary%></textarea>
						</p>
						<div id="submit">
							<a href="delete_do.jsp?id=<%=ID %>" onclick="return deleteConfirm()">删除</a>
							<button>
								提交
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</body>
</html>
