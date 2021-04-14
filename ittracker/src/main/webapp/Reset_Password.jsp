<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma", "no-cache");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All User List</title>
<link rel="stylesheet" type="text/css" href="styles.css" />

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#EDEDED';
		}
	}
</script>



<%
	try {
		int user_id=0;
		user_id=Integer.parseInt(request.getParameter("u_id"));
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con.prepareStatement("select U_Name from User_tbl where U_Id=" + uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			uname = rs_uname.getString("U_Name");
		}
%>

</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Reset Password</h3>

		</div>
		<div id="menu">
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New Requisitions</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed Requisition</a></li>
				<li><a href="IT_All_Requisitions.jsp">All Requisitions</a></li>
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="Logout.jsp">Logout</a></li>
				<li><strong style="color: blue; font-size: x-small;"> <%=uname%></strong></li>
			</ul>
		</div>
		<%@page import="java.text.SimpleDateFormat"%>
		<%@page import="java.text.DateFormat"%>
		<%@page import="java.sql.ResultSet"%>
		<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
		<%@page import="java.sql.Connection"%>
		<%@page import="java.util.*"%>
		<%@page import="java.sql.PreparedStatement"%>

		<form action="Reset_Password" method="post" id="myForm" name="myForm" onsubmit="return(validate());">
				<table align="center"> 
					<input type="hidden" name="user_id" value="<%=user_id%>">
					<tr>
						<td>Enter New Password :</td>
						<td><input type="password" name="pwd1"> </td>
					</tr>
					<tr>
						<td>Re-enter Password :</td>
						<td><input type="password" name="pwd2"> </td>
					</tr>
					<tr>
						<td colspan="2" align="center"><input type="submit" value="Save" ></td>
					</tr>
				</table>
		</form>
<%

	}catch(Exception e)
	{
		e.printStackTrace();
	}
%>
	<div id="footer">
		<p class="style2">
			<a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New
				Requisition</a> <a href="Closed_Requisitions.jsp">Closed Requisition</a>
			<a href="IT_All_Requisitions.jsp">All Requisitions</a> <a
				href="Software_Access.jsp">Software Access</a> <a href="Logout.jsp">Logout</a><br />
			<a href="http://www.muthagroup.com">Mutha Group, Satara </a>
		</p>
	</div>
	</div>
</body>
</html>