<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Profile</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
<style type="text/css">
.tftable {
	font-size: 14px;
	font-family: Arial;  
}

.tftable th {
	font-size: 14px;
	background-color: #acc8cc; 
	padding: 3px; 
	text-align: center;
} 

.tftable td {
	font-size: 14px; 
	padding: 3px; 
}
</style> 
<script type="text/javascript" src="js/highslide.js"></script>
<link rel="stylesheet" type="text/css" href="css/highslide.css" />

<script type="text/javascript">
	hs.graphicsDir = 'graphics/';
	hs.outlineType = null;
	hs.wrapperClassName = 'colored-border';
</script>  
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes
 
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {
    alert("Only allow numeric Data entry");
    return false;
}else 
{
	return true;
};
}
</script>
<script type="text/javascript">
function validatePhoto() {
	var photo = document.getElementById("photo");   
	 
		if (photo.value=="0" || photo.value==null || photo.value=="" || photo.value=="null") {
			alert("Please select an image to upload first !!!");  
			return false;
		} 
		return true;
}		
</script>
<%
	try {
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null,department="",designation="",log_name="",log_pass="";
		int d_Id=0;
 	
		Connection con = Connection_Utility.getConnection();
		
		PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		
		PreparedStatement ps_deptName = null;
		ResultSet rs_deptName = null;
		
		while (rs_uname.next()) {
			d_Id = rs_uname.getInt("Dept_Id");
			uname = rs_uname.getString("U_Name");
			log_name = rs_uname.getString("Login_Name");
			log_pass = rs_uname.getString("Login_Password");
			ps_deptName = con.prepareStatement("select * from user_tbl_dept where dept_id="+ d_Id);
			rs_deptName = ps_deptName.executeQuery();
			while(rs_deptName.next()){
				department = rs_deptName.getString("Department");
			}
			designation = rs_uname.getString("U_Designation");
		}
%>
</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Change Password</h3>
		</div>
		<div id="menu">
		<%
		if(d_Id==18){
		%>
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
		<%	
		}else{
		%>
			<ul>
				<li><a href="index.jsp">Home</a></li>
				<li><a href="New_Requisition.jsp">Add New</a></li>
				<li><a href="Requisition_Status.jsp">Status</a></li>
				<li><a href="Closed_Req_User.jsp">Closed</a></li>
				<li><a href="All_Requisitions.jsp">All</a></li>
				<li><a href="Search_Requisitions.jsp">Search</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
						<%
						if(d_Id==26 || d_Id==21 || d_Id==11){
						%>
						<li><a href="Admin.jsp">Admin</a></li>
						<%
						}
						%>
				<li><a href="Reports_User.jsp">Reports</a></li>
				<li><a href="Change_Password.jsp">Change Password</a></li>
				<li><a href="Profile.jsp">My Profile</a></li> 
				<li><a href="Logout.jsp">Logout</a><strong style="color: blue; font-size: small;"> <%=uname%></strong></li>
			</ul>
		<%
		}
		%>
		</div> 
		<div style="width:100%; height: 100%;float: left;"> 
			<br/>
				<table align="left"  border="0" class="tftable" style="padding-left: 100px;font-family: Arial;font-size: 12px;"> 
					<tr>
					<td colspan="2" align="left" style="font-size: 16px;color: #0B6E7D;"><b>YOUR PERSONAL INFORMATION &#8658;</b></td>
					</tr>
					<%
					PreparedStatement ps_info = con.prepareStatement("select user_photoName,phone_no,Bdays,day(birth_date),month(birth_date),year(birth_date) from User_tbl where U_Id="+ uid); 
					ResultSet rs_info = ps_info.executeQuery();
					while (rs_info.next()) {
						if(rs_info.getString("user_photoName")==null){
					%>
					<tr>
						<td align="left"><b>My Photo</b>(max size 200kb)<b> :</b></td>
						<td align="left" style="color: blue;">
						<form action="AddPhoto_Controller" enctype="multipart/form-data" method="post" onsubmit="return validatePhoto();">
							<input type="hidden" name="uid" id="uid" value="<%=uid%>">
							<input type="file" name="photo" id="photo" style="background-color: white;">
							<input type="submit" value="Change">
						</form>
						</td>
					</tr>
					<%
						}else{
					%>
					<tr>
						<td align="left"><b>My Photo :</b></td>
						<td align="left" style="color: blue;"> 
						<img src="View_photo.jsp?field=<%=uid%>" alt="No Image" title="Click to enlarge"  height="70" width="70" onclick="return hs.expand(this)"  style="cursor:pointer"/><br/>	 
						</td>
					</tr>
					<%
						}
					%>
					<tr>
						<td align="left"><b>Name :</b></td>
						<td align="left" style="color: blue;"><%=uname %></td>
					</tr>
					<tr>
						<td align="left"><b>Department :</b></td>
						<td align="left" style="color: blue;"><%=department %></td>
					</tr>
					<tr>
						<td align="left"><b>Designation :</b></td>
						<td align="left" style="color: blue;"><%=designation %></td>
					</tr> 
					<tr>
						<td align="left"><b>Login Name :</b></td>
						<td align="left" style="color: blue;"><%=log_name %></td>
					</tr>
					<tr>
						<td align="left"><b>Login Password :</b></td>
						<td align="left" style="color: blue;"><%=log_pass %></td>
					</tr>
					<%
					if(rs_info.getString("Bdays")==null){
					%>
					<tr>
						<td align="left"><b>Birth Date :</b></td>
						<td align="left" style="color: blue;">
						<form action="Add_Birthday_Controller" method="post">
							<input type="hidden" name="uid" id="uid" value="<%=uid%>">
							<input type="text" name="day" id="day" maxlength="2" size="2" value="DD" onKeyPress="return validatenumerics(event);">
							<input type="text" name="month" id="month" maxlength="2" size="2" value="MM" onKeyPress="return validatenumerics(event);">
							<input type="text" name="year" id="year" maxlength="4" size="4" value="YYYY"	onKeyPress="return validatenumerics(event);">
							<input type="submit" value="Add">
							</form>
						
						</td>
					</tr>
					<%
					} else{				
					%>
					<tr>
						<td align="left"><b>Birth Date :</b></td>
						<td align="left" style="color: blue;">
						<form action="Add_Birthday_Controller" method="post">
							<input type="hidden" name="uid" id="uid" value="<%=uid%>">
							<input type="text" name="day" id="day" maxlength="2" size="2" value="<%=rs_info.getString("day(birth_date)") %>" onKeyPress="return validatenumerics(event);">
							<input type="text" name="month" id="month" maxlength="2" size="2" value="<%=rs_info.getString("month(birth_date)") %>" onKeyPress="return validatenumerics(event);">
							<input type="text" name="year" id="year" maxlength="4" size="4" value="<%=rs_info.getString("year(birth_date)") %>"	onKeyPress="return validatenumerics(event);">
							<input type="submit" value="Change">
						</form>						
						</td>
					</tr>
					<%	
					} if(rs_info.getString("phone_no")==null){
					%>
					<tr>
						<td align="left"><b>Phone Number :</b></td>
						<td align="left" style="color: blue;">
						<form action="AddInfo_Controller" method="post">
							<input type="hidden" name="uid" id="uid" value="<%=uid%>">
							<input type="text" name="phone" id="phone" maxlength="10" size="10"  onKeyPress="return validatenumerics(event);">
							<input type="submit" value="Add">
						</form>						
						</td>
					</tr>
					<%
					}else{
					%>
					<tr>
						<td align="left"><b>Phone Number :</b></td>
						<td align="left" style="color: blue;">
						<form action="AddInfo_Controller" method="post">
							<input type="hidden" name="uid" id="uid" value="<%=uid%>">
							<input type="text" name="phone" id="phone" maxlength="10" size="10" value="<%=rs_info.getString("phone_no") %>" onKeyPress="return validatenumerics(event);">
							<input type="submit" value="Change">
						</form>						
						</td>
					</tr>
					<%	
					}
					%> 
					<%
					}
					%> 
					<tr>
					<td colspan="2">
						<%
						if(request.getParameter("success")!=null){
						%>
						<span style="color: green;"><b><%=request.getParameter("success") %></b></span>
						<% 	
						}
						%>
					</td>
					</tr>					
				</table> 
		</div>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
		<div id="footer">
			<p class="style2">
				<a href="index.jsp">Home</a> <a href="New_Requisition.jsp">New
					Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a>
				<a href="All_Requisitions.jsp">All Requisitions</a> <a
					href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a>
				<br /> <a href="http://www.muthagroup.com">Mutha Group, Satara
				</a>
			</p>
		</div>
	</div>
</body>
</html>