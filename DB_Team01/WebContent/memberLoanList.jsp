<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*"%>
<%
	String memberid = request.getParameter("memberid");
%>
<%
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;

	String jdbUrl = "jdbc:mysql://localhost:3306/library?serverTimezone=UTC&useSSL=false";
	//String jdbUrl = "jdbc:mysql://localhost:3306/jspdatabase";
	String dbId = "root";
	String dbPass = "1234";

	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection(jdbUrl, dbId, dbPass);

%>
<!DOCTYPE html>
<html>
<head>
<title>DB 01�� ȸ�� ���� �˻�</title>
<meta charset="utf-8">
<link rel="stylesheet" href="mainTP.css" type="text/css">

<style>
table {
	width: 100%;
	border-top: 1px solid #444444;
	border-collapse: collapse;
	margin-top: 30px;
}

td, th {
	border-bottom: 1px solid #444444;
	padding: 10px;
	text-align: center;
	/* border: 1px solid #444444; */
}
</style>

</head>
<body>
	<div>
		<h1 style="display: inline;">������ �뿩 ���α׷�</h1>
		<h2 style="display: inline;">ȸ��������</h2>
	</div>

	<div>
		<table>
			<thead>
				<tr>
					<th>������ȣ</th>
					<th>��������</th>
					<th>ISBN</th>
					<th>����</th>
					<th>���ǻ�</th>
					<th>���⳯¥</th>
					<th>�ݳ�������¥</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
				<%

	
	try {
			String sql = "select * from loan where memberid='"+memberid+"'&&returnstate!='done'";
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();

			while (rs.next()) {

				sql = "select * from book where booknum='"+rs.getString("booknum")+"'";
				ps = conn.prepareStatement(sql);
				ResultSet rs2 = ps.executeQuery();
				
				if(rs2.next()){
					sql = "select * from bookInfo where ISBN='"+rs2.getString("ISBN")+"'";
					ps = conn.prepareStatement(sql);
					ResultSet rs3 = ps.executeQuery();
					if(rs3.next()){
				
			
			%>
				<tr>
				<%
				String ISBN = rs2.getString("ISBN");
					%>
					<td><%=rs.getString("booknum")%></td>
					<td><%=rs3.getString("title")%></td>
					<td><%=rs3.getString("ISBN")%></td>
					<td><%=rs3.getString("author")%></td>
					<td><%=rs3.getString("publisher")%></td>
					<td><%=rs.getString("loandate")%></td>
					<td><%=rs.getString("returndate")%></td>
					<%if((rs.getString("returnstate")).equals("ing")){ %>
					<td><button onclick="location.href = 'bookDetail.jsp?ISBN=<%=ISBN%>&memberid=<%=memberid%>'">�ݳ�</button></td>
					<%}else{ %>
					<td>�ݳ���û��</td>
					<%} %>
				</tr>
				<% 
				}
				}
			}
	
	} catch (SQLException e) {
		e.printStackTrace();
	}
      
     %>

			</tbody>

		</table>
	</div>


</body>
</html>