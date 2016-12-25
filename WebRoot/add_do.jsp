<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="com.jspsmart.upload.*"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<jsp:useBean id="ch" class="MyClass.StrConvert" scope="request" />
<html>
	<head>
		<title>添加书籍</title>
		<link rel="stylesheet" type="text/css" href="style.css">
	</head>
	<body>
		<%
			request.setCharacterEncoding("GBK");
			SmartUpload su = new SmartUpload();
			su.initialize(pageContext);
			su.setTotalMaxFileSize(5 * 1024 * 1024);
			su.upload();

			String ISBN = su.getRequest().getParameter("ISBN");
			String bookName = su.getRequest().getParameter("bookName");
			String author = su.getRequest().getParameter("author");
			String publishingHouse = su.getRequest().getParameter(
					"publishingHouse");
			String price = su.getRequest().getParameter("price");
			String summary = su.getRequest().getParameter("summary");
			
			String path = getServletContext().getRealPath("/");
			path = path + "img" + "\\";
			java.io.File folder = new java.io.File(path);
			if (!folder.exists()) {
				folder.mkdir();
			}
			File img = su.getFiles().getFile(0);
			try {
				img.saveAs(path + ISBN + ".jpg");
			} catch (Exception e) {
				out.println(e.toString());
			}

			String RealPath = getServletContext().getRealPath("\\");
			db.setRealPath(RealPath);
			String sql = "select top 1 rank from book order by rank desc";
			ResultSet rs = db.executeQuery(sql);
			rs.next();
			int lastRank = rs.getInt(1);
			sql = "insert into book "
					+ "(bookName,author,publishingHouse,price,ISBN,summary,rank) values "
					+ "('" + bookName + "','" + author + "','" + publishingHouse
					+ "'," + price + ",'" + ISBN + "','" + summary +"'," + (lastRank + 1) + ")";
			db.executeUpdate(sql);
			sql = "select top 1 id from book order by id desc";
			rs = db.executeQuery(sql);
			rs.next();
			int ID = rs.getInt(1);
			db.close();
			out.println("<script>alert('提交成功。');");
			out.println("window.location.href='show.jsp?id=" + ID
					+ "';</script>");
		%>
	</body>
</html>
