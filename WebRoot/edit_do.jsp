<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<html>
	<head>
		<title>编辑书籍</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<%
			request.setCharacterEncoding("utf-8");
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
			String sql = "select ID from book where ID=" + ID;
			ResultSet rs = db.executeQuery(sql);
			if (!rs.next()) {
				response.sendRedirect("nothing.jsp");
				db.close();
				return;
			}

			String ISBN = request.getParameter("ISBN");
			String bookName = request.getParameter("bookName");
			String author = request.getParameter("author");
			String publishingHouse = request.getParameter("publishingHouse");
			String price = request.getParameter("price");
			String summary = request.getParameter("summary");
			if (ISBN == null || bookName == null || author == null
					|| publishingHouse == null || price == null
					|| summary == null || ISBN.equals("")
					|| bookName.equals("") || author.equals("")
					|| publishingHouse.equals("") || price.equals("")
					|| summary.equals("")) {
				out.println("<script>alert('数据不能为空。');");
				out.println("history.back();</script>");
				return;
			}
			try {
				Float.parseFloat(price);
			} catch (Exception e) {
				out.println("<script>alert('价格请输入数字。');");
				out.println("history.back();</script>");
				return;
			}
			if (ISBN.length() != 13) {
				out.println("<script>alert('ISBN为13位数字。');");
				out.println("history.back();</script>");
				return;
			} else {
				for (int i = 0; i < ISBN.length(); i++) {
					if (!Character.isDigit(ISBN.charAt(i))) {
						out.println("<script>alert('ISBN为13位数字。');");
						out.println("history.back();</script>");
						return;
					}
				}
			}
			sql = "select ISBN from book where ISBN='" + ISBN + "' and ID<>"
					+ ID;
			rs = db.executeQuery(sql);
			if (rs.next()) {
				out.println("<script>alert('ISBN已经存在。');");
				out.println("history.back();</script>");
				db.close();
				return;
			}

			sql = "update book set ISBN='" + ISBN + "', bookName='" + bookName
					+ "', author='" + author + "', publishingHouse='"
					+ publishingHouse + "', price='" + price + "', summary='"
					+ summary + "' where ID=" + ID;
			db.executeUpdate(sql);
			db.close();
			out.println("<script>alert('提交成功。');");
			out.println("window.location.href='show.jsp?id=" + ID
					+ "';</script>");
		%>
	</body>
</html>
