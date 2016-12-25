<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.io.File"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<html>
	<head>
		<title>删除</title>
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

			sql = "select ISBN from book where ID=" + ID;
			rs = db.executeQuery(sql);
			rs.next();
			String ISBN = rs.getString(1);
			String path = getServletContext().getRealPath("/");
			path = path + "img" + "\\" + ISBN + ".jpg";
			File file = new File(path);
			if (file.isFile() && file.exists()) {
				file.delete();
			}
			sql = "delete from book where ID=" + ID;
			db.executeUpdate(sql);
			db.close();
			out.println("<script>alert('删除成功。');");
			out.println("window.location.href='index.jsp';</script>");
		%>
	</body>
</html>
