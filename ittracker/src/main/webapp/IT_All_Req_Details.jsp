<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Requisitions Details</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
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

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#FFFFFF';
		}
	}
</script>

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
	
	
	int uid = Integer.parseInt(session.getAttribute("uid")
			.toString());
	String uname=null;
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uname=con.prepareStatement("select U_Name from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		uname=rs_uname.getString("U_Name");
	}
%>


</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Requisition Details</h3>

		</div>
		
		<div id="menu">
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_Role_Req.jsp">Log My Issues</a></li>
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li>
				<!-- <li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li> -->
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<!-- <li><a href="MISAccess.jsp">MIS Access</a></li> -->
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="Profile.jsp">My Profile</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: 8px;"> <%=uname%></strong></a></li>
			</ul>
		</div>
		<%@page import="java.text.SimpleDateFormat"%>
		<%@page import="java.text.DateFormat"%>
		<%@page import="java.sql.ResultSet"%>
		<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
		<%@page import="java.sql.Connection"%>
		<%@page import="java.util.*"%>
		<%@page import="java.sql.PreparedStatement"%>
		<%  
				int req_no=0;
				req_no=Integer.parseInt(request.getParameter("hid")); 
		%>
	<div style="height: 500px;width:99%; overflow: scroll;">  
			
		
  		<table align="center" border="0" class="tftable">
  			<tr>
  				<th align="center"><b>Requisition No</b></th>
  				<th align="center"><b>User Name</b></th>
  				<th align="center"><b>Company Name</b></th>
  				<th align="center"><b>Related To</b></th>
  				<th align="center"><b>Req Type</b></th>
  				<th align="center"><b>Req Date</b></th>
  				
  			</tr>
				<%
			
					PreparedStatement ps_reqDetails=con.prepareStatement("select * from IT_User_Requisition where U_Req_Id="+req_no);
					ResultSet rs_reqDetails=ps_reqDetails.executeQuery();
					while(rs_reqDetails.next())
					{
				%>
				<tr>
					<td align="center"><%=req_no %></td>
					<input type="hidden" name="req_no" value="<%=req_no%>">
					<%
					
						PreparedStatement ps_user=con.prepareStatement("select U_Name from User_tbl where U_Id="+rs_reqDetails.getString("U_Id"));
						ResultSet rs_user=ps_user.executeQuery();
						while(rs_user.next())
						{
					%>
					<td align="center"><%=rs_user.getString("U_Name") %></td>
					<%
						}
						
						PreparedStatement ps_comp=con.prepareStatement("select Company_Name from User_tbl_Company where Company_Id="+rs_reqDetails.getString("Company_Id"));
						ResultSet rs_comp=ps_comp.executeQuery();
						while(rs_comp.next())
						{
					%>
					<td align="center"><%=rs_comp.getString("Company_Name") %></td>
					<%
						}
						
						PreparedStatement ps_rel=con.prepareStatement("select Related_To from it_related_problem_tbl where Rel_Id="+rs_reqDetails.getString("Rel_Id"));
						ResultSet rs_rel=ps_rel.executeQuery();
						while(rs_rel.next())
						{
					%>
					<td align="center"><%=rs_rel.getString("Related_To") %></td>
					<%
						}
						PreparedStatement ps_type=con.prepareStatement("select Req_Type from it_requisition_type_tbl where Req_Type_Id="+rs_reqDetails.getString("Req_Type_Id"));
						ResultSet rs_type=ps_type.executeQuery();
						while(rs_type.next())
						{
					%>
					<td align="center"><%=rs_type.getString("Req_Type") %></td>
					<%
						
						}
					%>
					<td align="center"><%=rs_reqDetails.getString("Req_Date") %></td>
					</tr>
					<tr><td colspan="6" align="center"><b>Requisition Details</b></td></tr>
					<tr><td colspan="6" align="center"><%=rs_reqDetails.getString("Req_Details") %></td></tr>	
					<%
						}rs_reqDetails.close();
					%>
					<tr>
						
						
					</tr>
					<tr>
						<th align="center"><b>Action Date</b></th>
						<th colspan="3" align="center"><b>Remark</b></th>
						<th align="center"><b>Status</b></th>
						<th align="center"><b>Done By</b></th>
					</tr>
					<%
						PreparedStatement ps_reqRemark=con.prepareStatement("select * from it_requisition_remark_tbl where U_Req_Id="+req_no);
						ResultSet rs_reqRemark=ps_reqRemark.executeQuery();
						while(rs_reqRemark.next())
						{
					%>
					<tr>
						<td align="center"><%=rs_reqRemark.getTimestamp("Remark_Date") %></td>
						<td colspan="3" align="center"><%=rs_reqRemark.getString("Action_Details") %></td>
						<td align="center"><%=rs_reqRemark.getString("Status") %></td> 
								<td align="center"><%=rs_reqRemark.getString("Done_by")%></td> 
					</tr>
					<tr>
						<th align="center"><b>Call Transfer Date</b></th>
						<th colspan="3" align="center"><b>Transferred Reason</b></th>
						<th colspan="1" align="center"><b>Transfer/Send To</b></th>
						<th align="center"><b>Transferred By</b></th>
					</tr>
					<%
						ps_reqRemark=con.prepareStatement("select * from it_user_reqcalltransfer where req_id="+req_no);
						rs_reqRemark=ps_reqRemark.executeQuery();
						while(rs_reqRemark.next())
						{
					%>
					<tr>
						<td align="left"><%=rs_reqRemark.getTimestamp("date_transfer") %></td>
						<td colspan="3" align="left"><%=rs_reqRemark.getString("explained") %></td>
						<td colspan="1" align="left"><%=rs_reqRemark.getString("transfer_status") %></td>
						<td align="left"><%=rs_reqRemark.getString("created_by") %></td>
					</tr>
					<%
						}
						}
  				%>
  				<tr><td colspan="6" align="center"><a href="IT_All_Requisitions.jsp"><font style="font-size: 18px; color: blue;">&#8656; Go Back</font></a></td></tr>
  		</table>

	<%
			}catch(Exception e)
			{
				e.printStackTrace();
			}
		
		%>
		
	</div>
	<div id="footer">
			<p class="style2">
				<a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New
					Requisition</a> <a href="Closed_Requisitions.jsp">Closed
					Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a> <a href="Software_Access.jsp">Software Access</a>
				<a href="Logout.jsp">Logout</a><br /> <a
					href="http://www.muthagroup.com">Mutha Group, Satara</a>
			</p>
		</div>
	</div>
</body>
</html>