<%@page import="java.sql.PreparedStatement"%>
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
<title>IT All Requisitions</title>
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
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size:12px; 
	background-color: #406368; 
	color: white;
	padding: 3px; 
	text-align: center;
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size:12px;  
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
		String fromSoftwareDate=request.getParameter("fromSoftwareDate"), 
				  toSoftwareDate=request.getParameter("toSoftwareDate");
		String uname = null;
		Connection con = Connection_Utility.getConnection(),
				conn = Connection_Utility.getLocalDatabase();
		PreparedStatement ps_uname = con.prepareStatement("select U_Name from User_tbl where U_Id=" + uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			uname = rs_uname.getString("U_Name");
		}
		System.out.println("data = " + fromSoftwareDate + " = " + toSoftwareDate);
%>
</head>
<body>
	<div id="container">
		<div id="top">
			<h3>All Requisitions</h3> 
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
	<div style="overflow: scroll;">
			<form method="post" name="edit" action="IT_All_Req_Details.jsp" 	id="edit">
			<input type="hidden" name="hid" id="hid">
				<% 
					ResultSet rs_Details = null; 
					PreparedStatement ps_Details = null;  
				%>
					<table style="width: 100%;" class="tftable">
					<tr>
						<th colspan="8"> In House Software Usage </th>
					</tr>
							<tr>
								<th></th>
								<th>ComplaintZilla(Marketing)</th>
								<th>ComplaintZilla(Quality)</th>
								<th>IT Tracker</th>
								<th>ECN (Internal)</th>
								<th>ECN (Customer)</th>
								<th>New Suppliers</th>
								<th>Meeting Planner</th> 
							</tr>
							<%
						//  Marketing Users : 
							String counth21="",counth25="",countMF="",countUiii="",countdi="",
									countQh21="",countQh25="",countQMF="",countQUiii="",countQdi="",
											countITh21="",countITh25="",countITMF="",countITUiii="",countITdi="",
													countECNh21="",countECNh25="",countECNMF="",countECNUiii="",countECNdi="",
															countECNCh21="",countECNCh25="",countECNCMF="",countECNCUiii="",countECNCdi="",
																	countNSh21="",countNSh25="",countNSMF="",countNSUiii="",countNSdi="",
																			countMeeth21="",countMeeth25="",countMeetMF="",countMeetUiii="",countMeetdi="";
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl where complaint_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=1");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									counth21 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl where complaint_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=2");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									counth25 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl where complaint_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=3");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countMF = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl where complaint_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=4");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countUiii = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl where complaint_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=5");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countdi = rs_Details.getString("count");
								} 
								
								//  Quality Users :
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl_action where Action_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and complaint_no in ("+
										" SELECT complaint_no FROM complaintzilla.complaint_tbl where company_id=1)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countQh21 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl_action where Action_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and complaint_no in ("+
										" SELECT complaint_no FROM complaintzilla.complaint_tbl where company_id=2)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countQh25 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl_action where Action_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and complaint_no in ("+
										" SELECT complaint_no FROM complaintzilla.complaint_tbl where company_id=3)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countQMF = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl_action where Action_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and complaint_no in ("+
										" SELECT complaint_no FROM complaintzilla.complaint_tbl where company_id=4)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countQUiii = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.complaint_tbl_action where Action_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and complaint_no in ("+
										" SELECT complaint_no FROM complaintzilla.complaint_tbl where company_id=5)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countQdi = rs_Details.getString("count");
								}
								
								
								
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.it_user_requisition where Req_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=1");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countITh21 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.it_user_requisition where Req_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=2");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countITh25 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.it_user_requisition where Req_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=3");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countITMF = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.it_user_requisition where Req_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=4");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countITUiii = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.it_user_requisition where Req_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=5");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countITdi = rs_Details.getString("count");
								}
								
								
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.cr_tbl where CR_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=1");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNh21 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.cr_tbl where CR_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=2");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNh25 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.cr_tbl where CR_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=3");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNMF = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.cr_tbl where CR_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=4");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNUiii = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.cr_tbl where CR_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=5");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNdi = rs_Details.getString("count");
								}
								
								
								
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.crc_tbl where CRC_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=1");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNCh21 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.crc_tbl where CRC_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=2");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNCh25 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.crc_tbl where CRC_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=3");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNCMF = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.crc_tbl where CRC_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=4");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNCUiii = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.crc_tbl where CRC_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=5");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countECNCdi = rs_Details.getString("count");
								}
								
								
								
								
								ps_Details = conn.prepareStatement("SELECT count(*) as count FROM erp_database.new_item_creation where registered_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and registered_by in (" +
										" SELECT U_name FROM complaintzilla.user_tbl where company_id=1)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countNSh21 = rs_Details.getString("count");
								}
								ps_Details = conn.prepareStatement("SELECT count(*) as count FROM erp_database.new_item_creation where registered_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and registered_by in (" +
										" SELECT U_name FROM complaintzilla.user_tbl where company_id=2)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countNSh25 = rs_Details.getString("count");
								}
								ps_Details = conn.prepareStatement("SELECT count(*) as count FROM erp_database.new_item_creation where registered_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and registered_by in (" +
										" SELECT U_name FROM complaintzilla.user_tbl where company_id=3)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countNSMF = rs_Details.getString("count");
								}
								ps_Details = conn.prepareStatement("SELECT count(*) as count FROM erp_database.new_item_creation where registered_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and registered_by in (" +
										" SELECT U_name FROM complaintzilla.user_tbl where company_id=4)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countNSUiii = rs_Details.getString("count");
								}
								ps_Details = conn.prepareStatement("SELECT count(*) as count FROM erp_database.new_item_creation where registered_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and registered_by in (" +
										" SELECT U_name FROM complaintzilla.user_tbl where company_id=5)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countNSdi = rs_Details.getString("count");
								}
								
								
								
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.events_units where created_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and " + 
										" created_by in ( SELECT U_Id FROM complaintzilla.user_tbl where company_id=1)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countMeeth21 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.events_units where created_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and "+ 
										" created_by in ( SELECT U_Id FROM complaintzilla.user_tbl where company_id=2)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countMeeth25 = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.events_units where created_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and "+ 
										" created_by in ( SELECT U_Id FROM complaintzilla.user_tbl where company_id=3)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countMeetMF = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.events_units where created_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and "+ 
										" created_by in ( SELECT U_Id FROM complaintzilla.user_tbl where company_id=4)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countMeetUiii = rs_Details.getString("count");
								}
								ps_Details = con.prepareStatement("SELECT count(*) as count FROM complaintzilla.events_units where created_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and "+ 
										" created_by in ( SELECT U_Id FROM complaintzilla.user_tbl where company_id=5)");
								rs_Details = ps_Details.executeQuery();
								while(rs_Details.next()){
									countMeetdi = rs_Details.getString("count");
								}
								
								
							%>
							<tr>
								<td><b>MEPL H21</b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><a href="ReportCountPage.jsp?comp=1&rep=1&from=<%=fromSoftwareDate %>&to=<%= toSoftwareDate%>&cnt=<%=counth21%>"><%=counth21 %></a></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><a href="ReportCountPage.jsp?comp=1&rep=2&from=<%=fromSoftwareDate %>&to=<%= toSoftwareDate%>&cnt=<%=countQh21%>"><%=countQh21 %></a></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><a href="ReportCountPage.jsp?comp=1&rep=3&from=<%=fromSoftwareDate %>&to=<%= toSoftwareDate%>&cnt=<%=countITh21%>"><%=countITh21 %></a></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><a href="ReportCountPage.jsp?comp=1&rep=4&from=<%=fromSoftwareDate %>&to=<%= toSoftwareDate%>&cnt=<%=countECNh21%>"><%=countECNh21 %></a></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><a href="ReportCountPage.jsp?comp=1&rep=5&from=<%=fromSoftwareDate %>&to=<%= toSoftwareDate%>&cnt=<%=countECNCh21%>"><%=countECNCh21 %></a></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><a href="ReportCountPage.jsp?comp=1&rep=6&from=<%=fromSoftwareDate %>&to=<%= toSoftwareDate%>&cnt=<%=countNSh21%>"><%=countNSh21 %></a></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><a href="ReportCountPage.jsp?comp=1&rep=7&from=<%=fromSoftwareDate %>&to=<%= toSoftwareDate%>&cnt=<%=countMeeth21%>"><%=countMeeth21 %></a></b></td>
							</tr> 
							<tr>
								<td><b>MEPL H25</b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=counth25 %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countQh25 %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countITh25 %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countECNh25 %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countECNCh25 %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countNSh25%></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countMeeth25 %></b></td>
							</tr> 
							<tr>
								<td><b>MEPL UIII</b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countUiii %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countQUiii %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countITUiii %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countECNUiii %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countECNCUiii %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countNSUiii %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countMeetUiii %></b></td>
							</tr> 
							<tr>
								<td><b>MFPL</b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countMF %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countQMF %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countITMF %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countECNMF %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countECNCMF %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countNSMF %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countMeetMF %></b></td>
							</tr> 
							<tr>
								<td><b>DI</b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countdi %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countQdi %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countITdi %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countECNdi %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countECNCdi %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countNSdi %></b></td>
								<td align="right"><b style="font-size: 14;font-family: Arial"><%=countMeetdi %></b></td>
							</tr> 
				</table> 
					<%
						} catch (Exception e)
						{
							e.printStackTrace();
						} 
					%>
				</form>
		</div> 
	</div>
</body>
</html>