<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DecimalFormat"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<html>
	<head>
		<title>书籍统计</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		<link rel="stylesheet" href="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/css/bootstrap.min.css">  
	<script src="http://cdn.static.runoob.com/libs/jquery/2.1.1/jquery.min.js"></script>
	<script src="http://cdn.static.runoob.com/libs/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	</head>
	<body>
		<%
			request.setCharacterEncoding("utf-8");
			String num = request.getParameter("page");
			if (num == null || num.equals("")) {
				response.sendRedirect("count.jsp?page=1");
				return;
			}
			int pageNum;
			try {
				pageNum = Integer.parseInt(num);
			} catch (Exception e) {
				response.sendRedirect("count.jsp?page=1");
				return;
			}
			if (pageNum <= 0) {
				response.sendRedirect("count.jsp?page=1");
				return;
			}

			String RealPath = getServletContext().getRealPath("\\");
			db.setRealPath(RealPath);
			String sql = "select count(*) from book";
			ResultSet rs = db.executeQueryCount(sql);
			rs.next();
			int rowCount = rs.getInt(1);
			db.close();
			int pageSize = 5;
			int pageCount = (int) Math.ceil((double) rowCount / pageSize);

			if (pageNum > pageCount) {
				pageNum = pageCount;
			}

			sql = "select ID, bookName, author, publishingHouse, price, ISBN, rank from book order by rank;";
			rs = db.executeQuery(sql);
			rs.absolute((pageNum - 1) * pageSize + 1);
			rs.previous();
			int i = 0;
			String ID, bookName, author, publishingHouse, price, ISBN, rank;
		%>
		<jsp:include page="header.html"></jsp:include>
		<div id="content">
			<div id="show">
				<table id="count">
					<tr>
						<th>
							编号
						</th>
						<th>
							销售排名
						</th>
						<th>
							书名
						</th>
						<th>
							作者
						</th>
						<th>
							出版社
						</th>
						<th>
							ISBN
						</th>
						<th>
							价格(元)
						</th>
					</tr>
					<%
						double totalPrice = 0;
						while (rs.next()) {
							rank = rs.getString("rank");
							bookName = rs.getString("bookName");
							author = rs.getString("author");
							ISBN = rs.getString("ISBN");
							ID = rs.getString("ID");
							publishingHouse = rs.getString("publishingHouse");
							price = rs.getString("price");
							price = price.substring(0, price.length() - 2);
							totalPrice += Double.parseDouble(price);
							i++;
					%>
					<tr>
						<td><%=ID%></td>
						<td><%=rank%></td>
						<td>
							<a href="show.jsp?id=<%=ID%>"><%=bookName%></a>
						</td>
						<td><%=author%></td>
						<td><%=publishingHouse%></td>
						<td><%=ISBN%></td>
						<td><%=price%></td>
					</tr>
					<%
						if (i >= pageSize) {
								break;
							}
						}
						db.close();
						DecimalFormat df = new DecimalFormat("######0.00");
					%>
					<tr>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td style="text-align: right">
							<b>当页总价格</b>
						</td>
						<td><%=df.format(totalPrice)%></td>
					</tr>
				</table>
				
				<div id="nav">
					总记录：<%=rowCount%>
					<a href="?page=1"><button type="button" class="btn btn-default btn-sm" >首页</button></a>
					
					  <%
						if (pageNum != 1) {
					%>
					<a href="?page=<%=pageNum - 1%>"><button type="button" class="btn btn-default btn-sm" >上一页</button></a>
					<%
						} else {
					%>
					<button type="button" class="btn btn-default btn-sm" >上一页</button>
					<%
						}
					%>
					<%=pageNum + "/" + pageCount%>
					<%
						if (pageNum != pageCount) {
					%>
					<a href="?page=<%=pageNum + 1%>"><button type="button" class="btn btn-default btn-sm" >下一页</button></a>
					<%
						} else {
					%>
					<button type="button" class="btn btn-default btn-sm" >上一页</button>
					<%
						}
					%>
					<a href="?page=<%=pageCount%>"><button type="button" class="btn btn-default btn-sm" >尾页</button></a>
				</div>
			</div>
		</div>
	</body>
</html>
