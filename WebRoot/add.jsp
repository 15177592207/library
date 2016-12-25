<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@page import="java.sql.ResultSet"%>
<jsp:useBean id="db" class="MyClass.DBconn" scope="request" />
<html>
	<head>
		<title>����鼮</title>
		<link rel="stylesheet" type="text/css" href="style.css">
		<script>
			function checkImg() {
				var choose = document.getElementById("chooseImg");
				if (choose.value == "") {
					alert("��ѡ��ͼƬ");
					return false;
				}
			}
		����	function setImagePreview() {
			����	var choose = document.getElementById("chooseImg");
				var img=document.getElementById("image");
				var type = choose.value.split(".")[1];
				var ale = document.getElementById("alert");
				if (!/(jpg)/.test(type)) {    
		            alert("��ѡ��jpg���͵�ͼƬ��");
		            choose.value = ""; 
		            img.src = "";
		        	ale.style.display = 'inline';
		            return false;    
		        }    
			����	img.style.display = 'block';
				ale.style.display = 'none';
			����	img.src = window.URL.createObjectURL(choose.files[0]);
			����	return true;
		����	}
		</script>
	</head>
	<body>
		<%
			request.setCharacterEncoding("GBK");
			boolean step = false;
			String ISBN = request.getParameter("ISBN");
			String bookName = request.getParameter("bookName");
			String author = request.getParameter("author");
			String publishingHouse = request.getParameter("publishingHouse");
			String price = request.getParameter("price");
			String summary = request.getParameter("summary");
			if (ISBN == null || bookName == null || author == null
					|| publishingHouse == null || price == null
					|| summary == null) {
				step = true;
			}
			if (!step) {
				if (ISBN.equals("") || bookName.equals("") || author.equals("")
						|| publishingHouse.equals("") || price.equals("")
						|| summary.equals("")) {
					out.println("<script>alert('���ݲ���Ϊ�ա�');");
					out.println("history.back();</script>");
					return;
				}
				try {
					Float.parseFloat(price);
				} catch (Exception e) {
					out.println("<script>alert('�۸����������֡�');");
					out.println("history.back();</script>");
					return;
				}
				if (ISBN.length() != 13) {
					out.println("<script>alert('ISBNΪ13λ���֡�');");
					out.println("history.back();</script>");
					return;
				} else {
					for (int i = 0; i < ISBN.length(); i++) {
						if (!Character.isDigit(ISBN.charAt(i))) {
							out.println("<script>alert('ISBNΪ13λ���֡�');");
							out.println("history.back();</script>");
							return;
						}
					}
				}
				String RealPath = getServletContext().getRealPath("\\");
				db.setRealPath(RealPath);
				String sql = "select ISBN from book where ISBN='" + ISBN + "'";
				ResultSet rs = db.executeQuery(sql);
				if (rs.next()) {
					out.println("<script>alert('ISBN�Ѿ����ڡ�');");
					out.println("history.back();</script>");
					db.close();
					return;
				}
			}
		%>
		<jsp:include page="header.html"></jsp:include>
		<div id="content">
			<%
				if (step) {
			%>
			<div id="show" style="min-width: 420px">
				<form action="add.jsp" method="post">
					<div id="des">
						<p>
							<b>������</b>
							<input id="bookName" name="bookName" value=""></input>
						</p>
						<p>
							<b>���ߣ�</b>
							<input id="author" name="author" value="">
						</p>
						<p>
							<b>�����磺</b>
							<input id="publishingHouse" name="publishingHouse" value="">
						</p>
						<p>
							<b>�۸�(Ԫ)��</b>
							<input id="price" name="price" value="">
						</p>
						<p>
							<b>ISBN��</b>
							<input id="ISBN" name="ISBN" value="">
						</p>
						<b>��飺</b>
						<p>
							<textarea id="summary" name="summary" rows="20" cols="55"></textarea>
						</p>
					</div>
					<div id="submit">
						<input id="next" type="submit" value="��һ��">
					</div>
				</form>
			</div>
			<%
				}
			%>
			<%
				if (!step) {
			%>
			<div id="show" style="min-width: 660px">
				<form method="post" action="add_do.jsp"
					enctype="multipart/form-data">
					<div id="left">
						<div id="des">
							<p>
								<b>������</b>
								<input id="bookName" name="bookName" value="<%=bookName%>"
									readonly="readonly" style="border: none"></input>
							</p>
							<p>
								<b>���ߣ�</b>
								<input id="author" name="author" value="<%=author%>"
									readonly="readonly" style="border: none">
							</p>
							<p>
								<b>�����磺</b>
								<input id="publishingHouse" name="publishingHouse"
									value="<%=publishingHouse%>" readonly="readonly"
									style="border: none">
							</p>
							<p>
								<b>�۸�(Ԫ)��</b>
								<input id="price" name="price" value="<%=price%>"
									readonly="readonly" style="border: none">
							</p>
							<p>
								<b>ISBN��</b>
								<input id="ISBN" name="ISBN" value="<%=ISBN%>"
									readonly="readonly" style="border: none">
							</p>
							<b>��飺</b>
							<p>
								<textarea id="summary" name="summary" rows="20" cols="55"
									readonly="readonly" style="border: none;outline:none"><%=summary%></textarea>
							</p>
						</div>
					</div>
					<div id="right">
						<div id="showImg">
							<p id="alert">
								���ϴ��鼮����ͼƬ
							</p>
							<img id="image" />
							<input type="file" id="chooseImg" name="chooseImg"
								style="width: 200px" onchange="javascript:setImagePreview();" />
						</div>
						<div id="submit">
							<input type="submit" style="margin-top: 50px;"
								onclick="return checkImg()" value="�ύ">
						</div>
					</div>
				</form>
			</div>
			<%
				}
			%>
		</div>
	</body>
</html>
