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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Requisition Result</title>
<link rel="stylesheet" type="text/css" href="styles.css" />


<script type="text/javascript">
function ChangeColor(tableRow, highLight) {
	if (highLight) {
		tableRow.style.backgroundColor = '#CFCFCF';
	} else {
		tableRow.style.backgroundColor = '#FFFFFF';
	}
} 
</script>
<style type="text/css">
.tftable {
	font-family:Arial;
	font-size: 12px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: center;
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size: 11px; 
	padding: 5px; 
}
</style> 
<script language="javascript">
	function button1(val) {
		var val1 = val;
		//alert(val1);
		document.getElementById("hid").value = val1;
		edit.submit();
	}
</script>

<%
	try {

		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		int d_Id=0;
 
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			d_Id = rs_uname.getInt("Dept_Id");
			uname = rs_uname.getString("U_Name");
		}

		ArrayList arr = new ArrayList();
		if (request.getAttribute("arry") != null) {
			arr = (ArrayList) request.getAttribute("arry");
			//System.out.println("There are values in the arraylist");
		} else {
			//System.out.println("There are no values in the arraylist");
		}
%>

</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Search Result</h3>

		</div>
		<div id="menu">
			<ul>
				<li><a href="index.jsp">Home</a></li>
				<li><a href="New_Requisition.jsp">Add New</a></li>
				<li><a href="Requisition_Status.jsp">Status</a></li>
				<li><a href="Closed_Req_User.jsp">Closed</a></li>
				<li><a href="All_Requisitions.jsp">All</a></li>
				<li><a href="Search_Requisitions.jsp">Search</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="Reports_User.jsp">Reports</a></li>
				<li><a href="Change_Password.jsp">Change Password</a></li>
				<li><a href="Profile.jsp">My Profile</a></li> 
				<li><a href="Logout.jsp">Logout</a></li>
				<li><strong style="color: blue; font-size: small;"> <%=uname%></strong></li>
			</ul>
		</div>
	
		
		<div style="height: 500px;width:99%; overflow: scroll;">  
			<form method="post" name="edit"
				action="Requisition_Status_Details.jsp" id="edit">
				<table style="width: 100%;" class="tftable">
					<thead>
						<tr>
							<th>Req. No.</th>
							<th>User Name</th>
							<th>Company Name</th>
							<th>Related To</th>
							<th>Type</th>
							<th>Req. Date</th>
							<th>Status</th>

						</tr>
					</thead>

					<%
						for (int lst = 0; lst < arr.size(); lst++) {

								PreparedStatement ps_reqDetails = con
										.prepareStatement("select * from it_user_requisition where U_Req_Id="
												+ arr.get(lst) + " order by U_Req_Id desc");

								ResultSet rs_reqDetails = ps_reqDetails.executeQuery();

								while (rs_reqDetails.next()) {
					%>

					<tr onmouseover="ChangeColor(this, true);"
						onmouseout="ChangeColor(this, false);"
						onclick="button1('<%=rs_reqDetails.getInt("U_Req_Id")%>');" style="cursor: pointer;">
						<td align="center"><%=rs_reqDetails.getInt("U_Req_Id")%></td>
						<%
							PreparedStatement ps_name = con
												.prepareStatement("select U_Name from User_tbl where U_Id="
														+ rs_reqDetails.getInt("U_Id"));
										ResultSet rs_name = ps_name.executeQuery();
										while (rs_name.next()) {
						%>
						<td align="left"><%=rs_name.getString("U_Name")%></td>
						<%
							}
										PreparedStatement ps_comp = con
												.prepareStatement("select Company_Name from User_tbl_Company where Company_Id="
														+ rs_reqDetails.getInt("Company_Id"));
										ResultSet rs_comp = ps_comp.executeQuery();
										while (rs_comp.next()) {
						%>
						<td align="left"><%=rs_comp.getString("Company_Name")%></td>
						<%
							}

										PreparedStatement ps_related = con
												.prepareStatement("select Related_To from it_related_problem_tbl where Rel_Id="
														+ rs_reqDetails.getInt("Rel_Id"));
										ResultSet rs_related = ps_related.executeQuery();
										while (rs_related.next()) {
						%>
						<td align="left"><%=rs_related.getString("Related_To")%></td>
						<%
							}
										PreparedStatement ps_type = con
												.prepareStatement("select Req_Type from it_requisition_type_tbl where Req_Type_Id="
														+ rs_reqDetails.getInt("Req_type_id"));
										ResultSet rs_type = ps_type.executeQuery();
										while (rs_type.next()) {
						%>
						<td align="left"><%=rs_type.getString("Req_Type")%></td>
						<%
							}
						%>
						<td align="left"><%=rs_reqDetails.getTimestamp("Req_Date")%></td>
						<td align="left"><%=rs_reqDetails.getString("Status")%></td>
						<%
							PreparedStatement ps_doneBy = con
												.prepareStatement("select Done_By from it_requisition_remark_tbl where U_Req_Id="
														+ rs_reqDetails.getInt("U_Req_Id"));
										ResultSet rs_doneBy = ps_doneBy.executeQuery();
										while (rs_doneBy.next()) {

										}
						%>

					</tr>
					<%
						}

							}
						} catch (Exception e) {
							e.printStackTrace();
						}
					%>

					<tr>
					</tr> 
				</table>
				<input type="hidden" name="hid" id="hid">
			</form>

		</div>

		<!-- <div id="footer">
			<p class="style2">
			<p class="style2">
				<a href="index.jsp">Home</a> <a href="New_Requisition.jsp">New
					Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a>
				<a href="All_Requisitions.jsp">All Requisitions</a> <a
					href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a><br />
				<a href="http://www.muthagroup.com">Mutha Group, Satara </a>
			</p>
		</div> -->
	</div>
</body>
</html>