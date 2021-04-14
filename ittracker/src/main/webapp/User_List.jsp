<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%
	response.setHeader("Cache-Control", "no-cache"); //Forces caches to obtain a new copy of the page from the origin server
	response.setHeader("Cache-Control", "no-store"); //Directs caches not to store the page under any circumstance
	response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
	response.setHeader("Pragma", "no-cache");
%>
<meta http-equiv="pragma" content="no-cache" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All User List</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
<style>
div.scroll {
	background-color: #F0EBF2;
	width: 95%;
	height: 600px;
	overflow: scroll;
}
</style>
<style type="text/css">
.tftable {
	font-size: 13px;
	color: #333333;
	width: 100%;
}

.tftable th {
	font-size: 14px;
	background-color: #acc8cc;
	padding: 8px;
	text-align: center;
}

.tftable tr {
	background-color: white;
	text-align: center;
}

.tftable td {
	font-size: 13px;
	padding: 8px;
}
</style>
<script type="text/javascript"> 
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#CFCFCF';
	} else {
		tableRow.style.backgroundColor = '#FFFFFF';
	}
}  
	
	function showState(str) {
		var xmlhttp;
		var where_to = confirm("Do you really want to change status of this user ?");
		if (where_to == true) {

			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					window.location.reload();
				}
			};
			xmlhttp.open("POST", "DisableUser.jsp?q=" + str, true);			
			xmlhttp.send();
		} else {
			window.location.reload();
		}
	}
	
	
</script>



<%
	try {

		int uid = Integer.parseInt(session.getAttribute("uid")
				.toString());
		String uname = null;
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con
				.prepareStatement("select U_Name from User_tbl where U_Id="
						+ uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			uname = rs_uname.getString("U_Name");
		}
%>

</head>
<body>
	<div id="container">
		<div id="top">
			<h3>All Users</h3>

		</div>
		<div id="menu">
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li>
				<!-- <li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li> -->
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="MISAccess.jsp">MIS Access</a></li>
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="Profile.jsp">My Profile</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: 8px;"> <%=uname%></strong></a></li>
			</ul>
		</div> 
		<div style="height: 500px;width:99%; overflow: scroll;"> 
			<table border="0" class="tftable">

				<thead>
					<tr align="center">
						<th>User Id</th>
						<th>User Name</th>
						<th>Company</th>
						<th>Department</th>

						<th>Login Name</th>
						<th>Password</th>

						<th>Software Access</th>
						<th>Birth Date</th>
						<th>Reset Password</th>
						<th>Disable User</th>
					</tr>
				</thead>
				<tbody>
					<%
						SimpleDateFormat sdf1 = new SimpleDateFormat("dd-MM-yyyy");
							PreparedStatement ps_userInfo = con
									.prepareStatement("select * from user_tbl order by U_Name");
							int u_id = 0;
							ResultSet rs_userInfo = ps_userInfo.executeQuery();
							while (rs_userInfo.next()) {
								u_id = rs_userInfo.getInt("U_Id");
					%>
					<tr>
						<td align="center"><%=u_id%></td>
						<td align="left"><%=rs_userInfo.getString("U_Name")%></td>
						<%
							PreparedStatement ps_compName = con
											.prepareStatement("select * from user_tbl_Company where Company_Id="
													+ rs_userInfo.getInt("Company_Id"));
									ResultSet rs_compName = ps_compName.executeQuery();
									while (rs_compName.next()) {
						%>
						<td><%=rs_compName.getString("Company_Name")%></td>
						<%
							}
									PreparedStatement ps_deptName = con
											.prepareStatement("select * from user_tbl_dept where dept_id="
													+ rs_userInfo.getInt("dept_Id"));
									ResultSet rs_deptName = ps_deptName.executeQuery();
									while (rs_deptName.next()) {
						%>
						<td><%=rs_deptName.getString("Department")%></td>
						<%
							}
						%>
						<td><%=rs_userInfo.getString("Login_Name")%></td>
						<td><%=rs_userInfo.getString("Login_Password")%></td>

						<td><select>
								<%
									PreparedStatement ps_softwareAccess = con
													.prepareStatement("select * from it_software_access_tbl where U_Id="
															+ rs_userInfo.getInt("U_Id"));
											ResultSet rs_softwareAccess = ps_softwareAccess
													.executeQuery();
											while (rs_softwareAccess.next()) {
												PreparedStatement ps_softName = con
														.prepareStatement("select * from it_software_tbl where Software_Id="
																+ rs_softwareAccess
																		.getInt("Software_Id"));
												ResultSet rs_softName = ps_softName.executeQuery();
												while (rs_softName.next()) {
								%>
								<option><%=rs_softName.getString("Software_Name")%></option>
								<%
									}
											}
								%>
						</select></td>
						<td>
							<%
								String bdate = "";
										if (rs_userInfo.getDate("birth_date")!=null) {
											bdate = sdf1.format(rs_userInfo.getDate("birth_date"));
							%> <span><b><%=bdate%></b></span> <%
 								} else {
 							%>
							<form action="Add_BirthdayList_Controller" method="post">
								<input type="hidden" name="flag" value="userList"> <input
									type="hidden" name="uid" id="uid"
									value="<%=rs_userInfo.getInt("U_Id")%>"> <input
									type="text" name="day" id="day" maxlength="2" size="2"
									value="DD" style="background-color: #D4D4D4;"> <input
									type="text" name="month" id="month" maxlength="2" size="2"
									value="MM" style="background-color: #D4D4D4;"> <input
									type="text" name="year" id="year" maxlength="4" size="4"
									value="YYYY" style="background-color: #D4D4D4;"> <input
									type="submit" value="Add">
							</form> 
							<%
 							}
 							%>
						</td>
						<td><a href="Reset_Password.jsp?u_id=<%=u_id%>"
							style="color: blue;">Reset Password</a></td>
						<%
							if (rs_userInfo.getInt("Enable_id") == 1) {
						%>
						<td><input type="button" value="Disable User"
							onclick="showState(<%=u_id%>)"></td>
						<%
							} else {
						%>
						<td><input type="button" value="Enable User"
							onclick="showState(<%=u_id%>)"></td>
						<%
							}
						%>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>

		<div id="footer">
			<p class="style2">
				<a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New
					Requisition</a> <a href="Closed_Requisitions.jsp">Closed
					Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a>
				<a href="Software_Access.jsp">Software Access</a> <a
					href="Logout.jsp">Logout</a><br /> <a
					href="http://www.muthagroup.com">Mutha Group, Satara. </a>
			</p>
		</div>
	</div>
</body>
</html>