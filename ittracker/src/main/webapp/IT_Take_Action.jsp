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
<title>Requisition Remark</title>
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
<script language="JavaScript" src="gen_validatorv4.js"
	type="text/javascript" xml:space="preserve"></script>
<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#FFFFFF';
		}
	}
	
	function validateForm() {
		var remark_details = document.getElementById("remark_details");  
			if (remark_details.value=="0" || remark_details.value==null || remark_details.value=="" || remark_details.value=="null") {
				alert("Please Provide Remark !!!"); 
				document.getElementById("Save").disabled = false;
				return false;
			}
			document.getElementById("Save").disabled = true;
			return true;
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
	
	
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
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
			<h3>Take Action</h3>

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
		
		<%
				int req_no=0;
				req_no=Integer.parseInt(request.getParameter("hid"));
				
		%>
<div style="height: 500px;width:99%; overflow: scroll;">
		<form action="take_action_controller" name="Take_Action" id="Take_Action" method="post" onSubmit="return validateForm();">
  		<table align="center" border="0" class="tftable">
  			<tr>
  				<th align="center"><b>Requisition No</b></th>
  				<th align="center"><b>User Name</b></th>
  				<th align="center"><b>Company Name</b></th>
  				<th align="center">Department</th>
  				<th align="center"><b>Related To</b></th>
  				<th align="center"><b>Req Type</b></th>
  				<th align="center"><b>Req Date</b></th>
  				<th align="center"><b>Current Status</b></th>
  				
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
						
						PreparedStatement ps_dept = con.prepareStatement("select Department from user_tbl_dept where dept_id in (SELECT dept_id FROM complaintzilla.user_tbl where u_id="+ rs_reqDetails.getInt("U_Id")+")");
						ResultSet rs_dept = ps_dept.executeQuery();
						while (rs_dept.next()) {
						%>
							<td align="center"><%=rs_dept.getString("Department")%></td>
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
					<td align="center"><%=rs_reqDetails.getString("Status")%></td>
					</tr>
					<tr><td colspan="8" align="center"><b>Requisition Details</b></td></tr>
					<tr><td colspan="8" align="center"><%=rs_reqDetails.getString("Req_Details") %></td></tr>	
					<%
						
						}
					%> 
  				<tr>
						<th align="center"><b>Action Date</b></th>
						<th colspan="5" align="center"><b>Remark</b></th>
						<th colspan="1" align="center"><b>Status</b></th>
						<th align="center"><b>Done By</b></th>
					</tr>
					<%
					String curr_status="Pending";
						PreparedStatement ps_reqRemark=con.prepareStatement("select * from it_requisition_remark_tbl where U_Req_Id="+req_no);
						ResultSet rs_reqRemark=ps_reqRemark.executeQuery();
						while(rs_reqRemark.next())
						{
					%>
					<tr>
						<td align="center"><%=rs_reqRemark.getTimestamp("Remark_Date") %></td>
						<td colspan="5" align="center"><%=rs_reqRemark.getString("Action_Details") %></td>
						<td colspan="1" align="center"><%=rs_reqRemark.getString("Status") %></td> 
						<td align="center"><%=rs_reqRemark.getString("Done_by") %></td>
					</tr>
  				<% 
  				curr_status = rs_reqRemark.getString("status");
						}
  				%>
  					<tr>
						<th align="center"><b>Call Transfer Date</b></th>
						<th colspan="5" align="center"><b>Transferred Reason</b></th>
						<th colspan="1" align="center"><b>Transfer/Send To</b></th>
						<th align="center"><b>Transferred By</b></th>
					</tr>
					<%
					int transfer_to=0;
					String transfer_status="None";
						ps_reqRemark=con.prepareStatement("select * from it_user_reqcalltransfer where req_id="+req_no);
						rs_reqRemark=ps_reqRemark.executeQuery();
						while(rs_reqRemark.next())
						{
					%>
					<tr>
						<td align="left"><%=rs_reqRemark.getTimestamp("date_transfer") %></td>
						<td colspan="5" align="left"><%=rs_reqRemark.getString("explained") %></td>
						<td colspan="1" align="left"><%=rs_reqRemark.getString("transfer_status") %></td>
						<td align="left"><%=rs_reqRemark.getString("created_by") %></td>
					</tr>
					<%
					transfer_to = rs_reqRemark.getInt("transfer_to");
					transfer_status = rs_reqRemark.getString("transfer_status");
						}
					%>
  		</table>
  		<hr>
  	 	<table align="center" border="0" class="tftable">
  			<tr>
  				<td align="right"><b>Status</b></td>
  				<td align="left">
  					<select name="status">
  					<option value="<%=curr_status%>"><%=curr_status%></option>
  						<option value="Pending">Pending</option>
  						<option value="In Progress">In Progress</option>
  						<option value="Closed">Closed</option>
  					</select>
  				</td>
  			</tr>
  			<tr>
  				<td align="right"><b>Transfer To (If Any)</b></td>
  				<td align="left">
  					<select name="transfer_status" id="transfer_status">
  						<option value="<%=transfer_to%>"><%=transfer_status %></option>
  						<%
  						PreparedStatement ps_doneBY = con.prepareStatement("select * from it_requisition_handover_tbl where enable=1");
  		  				ResultSet rs_doneBy = ps_doneBY.executeQuery();
  		  				while(rs_doneBy.next()){
  						%>
  						<option value="<%=rs_doneBy.getInt("code")%>"><%=rs_doneBy.getString("name")%></option>
  						<%
  		  				}
  						%>
  					</select>
  				</td>
  			</tr>
  			<tr>
  				<td align="right"><b>Remark</b></td>
  				<td align="left">
  				<textarea rows="4" cols="40" name="remark_details" id="remark_details"></textarea>
   				</td>
  			</tr>
  			<tr>
  				<td align="right"><b>Done By</b></td>
  				<td align="left">
  				<select name="done_by" id="done_by">
  				<%
  				ps_doneBY = con.prepareStatement("select * from user_tbl where dept_id=18 and Enable_id=1 and u_id="+uid);
  				rs_doneBy = ps_doneBY.executeQuery();
  				while(rs_doneBy.next()){
  				%>
  				 <option value="<%=rs_doneBy.getString("U_Name")%>"><%=rs_doneBy.getString("U_Name")%></option>
  				<%
  				}
  				%>
  				<%
  				PreparedStatement ps_doneBY2 = con.prepareStatement("select * from user_tbl where dept_id=18 and Enable_id=1 and u_id!="+uid);
  				ResultSet rs_doneBy2 = ps_doneBY2.executeQuery();
  				while(rs_doneBy2.next()){
  				%>
  				 <option value="<%=rs_doneBy2.getString("U_Name")%>"><%=rs_doneBy2.getString("U_Name")%></option>
  				<%
  				}
  				%>
  				</select>
  				</td>
  			</tr>
  			<tr>
  				<td align="right"><a href="IT_New_Requisition.jsp"><font style="font-size: 18px; color: blue;text-decoration: none;">&#8656; Back</font></a> </td>
  				<td align="left"><input type="submit" id="Save" name="Save" value="Done" style="width: 150px; height: 30px;"> </td>
  			</tr> 
  		</table>
  </form>




























<br/>
<script language="JavaScript" type="text/javascript" xml:space="preserve">
	var frmvalidator = new Validator("Take_Action");
	frmvalidator.addValidation("remark_details","req", "Please Provide the Remark..!!"); 
	frmvalidator.addValidation("done_by", "req", "Please Provide the Done By ..!!");
</script>
		</div>
		<%
			}catch(Exception e)
			{
				e.printStackTrace();
			}
		
		%>
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