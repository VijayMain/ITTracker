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
		String fromSoftwareDate=request.getParameter("from"), 
				  toSoftwareDate=request.getParameter("to"),
						  comp=request.getParameter("comp"),								 
								  		cnt=request.getParameter("cnt");
		int  rep= Integer.parseInt(request.getParameter("rep"));
		
		String fromview = fromSoftwareDate.substring(8, 10) + "/" + fromSoftwareDate.substring(5, 7) + "/" + fromSoftwareDate.substring(0, 4);
		String toview = toSoftwareDate.substring(8, 10) + "/" + toSoftwareDate.substring(5, 7) + "/" + toSoftwareDate.substring(0, 4);
		
		SimpleDateFormat sdf2 = new SimpleDateFormat("dd-MM-yyyy");
		String uname = null;
		Connection con = Connection_Utility.getConnection(),
				conn = Connection_Utility.getLocalDatabase();
		PreparedStatement ps_uname = con.prepareStatement("select U_Name from User_tbl where U_Id=" + uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			uname = rs_uname.getString("U_Name");
		}  
		ResultSet rs_Details = null; 
		PreparedStatement ps_Details = null;  
	%>
</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Reports</h3> 
		</div>
		<div id="menu">
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li> 
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
					<table style="width: 100%;" class="tftable">
					<%
					if(rep == 1){
						PreparedStatement ps_sel = con.prepareStatement("select * from complaint_tbl where complaint_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id="+Integer.parseInt(comp));
				    	ResultSet rs_sel = ps_sel.executeQuery(); 
					%>
					<tr>
						<th colspan="14">ComplaintZilla <b style="color: #b5f5fb;">( Marketing Total Count <%=cnt %> )</b> from <%=fromview %> to <%=toview %></th>
					</tr> 
					<tr>
													<th>Complaint No</th>
													<th>Type</th>
													<th>Customer Name</th>
													<th>Company</th>
													<th>Status</th>
													<th>Severity</th>
													<th>Item Name</th>
													<th>Defect</th>
													<th>Complaint Received By</th>
													<th>Complaint Related To</th>
													<th>Complaint Registered By</th>
													<th>Complaint Assigned To</th>
													<th>Category</th>
													<th>Complaint Date</th>
												</tr>
					<%
						while(rs_sel.next()){
					%>
							 			<tr>
												<td><b><%=rs_sel.getString("Complaint_No")%></b></td>
												<td><b><%=rs_sel.getString("complaint_type")%></b></td>
												<%
													PreparedStatement ps_cust = con.prepareStatement("select Cust_name from Customer_tbl where Cust_Id="+ rs_sel.getInt("Cust_Id"));
															ResultSet rs_cust = ps_cust.executeQuery();
															while (rs_cust.next()) {
												%>
												<td><%=rs_cust.getString("Cust_Name")%></td> 
												<%
													}
													ps_cust.close();	
													rs_cust.close(); 
													PreparedStatement ps_comp = con.prepareStatement("select Company_Name from user_tbl_company where Company_Id="
																			+ rs_sel.getInt("Company_Id"));
															ResultSet rs_comp = ps_comp.executeQuery();
															while (rs_comp.next()) {
												%>
												<td><%=rs_comp.getString("Company_Name")%></td>
												<%
													}
															ps_comp.close();		
															rs_comp.close(); 
													PreparedStatement ps_Status = con
																	.prepareStatement("select Status from Status_tbl where Status_Id="
																			+ rs_sel.getInt("Status_id"));
															ResultSet rs_Status = ps_Status.executeQuery();
															while (rs_Status.next()) {
																if (rs_Status.getString("Status").equalsIgnoreCase("New")) {
												%>
												<td style="color: #2230C7;" class="blink"><strong>
														<%=rs_Status.getString("Status")%></strong></td>
												<%
													} else if (rs_Status.getString("Status").equalsIgnoreCase("Open")) {
												%>
												<td><%=rs_Status.getString("Status")%></td>
												<%
													} else if (rs_Status.getString("Status").equalsIgnoreCase("Resolved")) {
												%>
												<td><%=rs_Status.getString("Status")%></td>
												<%
													} else if (rs_Status.getString("Status").equalsIgnoreCase("Reopen")) {
												%>
												<td style="color: #DB2739;" class="blink"><strong>
														<%=rs_Status.getString("Status")%></strong></td>
												<%
													} else if (rs_Status.getString("Status").equalsIgnoreCase("Close")) {
												%>
												<td style="color: green;"><strong> <%=rs_Status.getString("Status")%></strong></td>
												<%
													} 
															}
															PreparedStatement ps_priority = con.prepareStatement("select P_Type from Severity_tbl where P_Id="
																			+ rs_sel.getInt("P_id"));
															ResultSet rs_priority = ps_priority.executeQuery();
															while (rs_priority.next()) {
																if (rs_priority.getString("P_Type").equalsIgnoreCase(
																		"Major")) {
												%>
												<td style="color: #E81A24;" class="blink"><strong>
														<%=rs_priority.getString("P_Type")%></strong></td>
												<%
													} else {
												%>
												<td><%=rs_priority.getString("P_Type")%></td>
												<%
													}
															}
															PreparedStatement ps_Item = con
																	.prepareStatement("select Item_Name from Customer_tbl_Item where Item_Id="
																			+ rs_sel.getInt("Item_id"));
															ResultSet rs_Item = ps_Item.executeQuery();
															while (rs_Item.next()) {
												%>
												<td><%=rs_Item.getString("Item_Name")%></td>
												<%
													}

															PreparedStatement ps_Defect = con
																	.prepareStatement("select Defect_Type from Defect_tbl where Defect_id="
																			+ rs_sel.getInt("Defect_Id"));
															ResultSet rs_Defect = ps_Defect.executeQuery();
															while (rs_Defect.next()) {
												%>
												<td><strong><%=rs_Defect.getString("Defect_Type")%></strong>
												</td>
												<%
													}
												%>

												<td><%=rs_sel.getString("Complaint_Received_By")%></td>

												<%
													PreparedStatement ps_related = con
																	.prepareStatement("select Department from User_tbl_Dept where Dept_id="
																			+ rs_sel
																					.getInt("Complaint_Related_To"));
															ResultSet rs_related = ps_related.executeQuery();
															while (rs_related.next()) {
												%>
												<td><%=rs_related.getString("Department")%></td>
												<%
													}
															PreparedStatement ps_registerer = con
																	.prepareStatement("select U_Name from User_tbl where U_id="
																			+ rs_sel.getInt("U_Id"));
															ResultSet rs_registerer = ps_registerer.executeQuery();
															while (rs_registerer.next()) {
												%>

												<td><%=rs_registerer.getString("U_Name")%></td>
												<%
													}

															PreparedStatement ps_assigned = con
																	.prepareStatement("select U_Name from User_tbl where U_id="
																			+ rs_sel
																					.getInt("Complaint_Assigned_To"));
															ResultSet rs_assigned = ps_assigned.executeQuery();
															while (rs_assigned.next()) {
												%>
												<td><%=rs_assigned.getString("U_Name")%></td>
												<%
													}

															PreparedStatement ps_category = con
																	.prepareStatement("select Category from Category_tbl where category_id="
																			+ rs_sel.getInt("category_id"));
															ResultSet rs_category = ps_category.executeQuery();
															while (rs_category.next()) {
												%>
												<td><%=rs_category.getString("Category")%></td>
												<%
													}
												%>

												<td><%=sdf2.format(rs_sel.getDate("complaint_date"))%></td> 
									</tr>
				<%
							}
					}else	if(rep==2){
						PreparedStatement ps_sel = con.prepareStatement("select * from complaint_tbl_action where Action_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and complaint_no in ("+
								" SELECT complaint_no FROM complaintzilla.complaint_tbl where company_id="+Integer.parseInt(comp) +")");
				    	ResultSet rs_sel = ps_sel.executeQuery(); 
					%>
					<tr>
						<th colspan="14">ComplaintZilla <b style="color: #b5f5fb;">( Quality Total Count <%=cnt %> )</b> from <%=fromview %> to <%=toview %></th>
					</tr> 
					<tr>
						<th>ComplaintNo</th>
						<th>User</th>
						<th>Action Taken</th>
						<th>Action Type</th>
						<th>Action Date</th>
					</tr>
							<%
							 while(rs_sel.next()){
							 %>
							 			<tr>
												<td><b><%=rs_sel.getString("Complaint_No")%></b></td>
												<% 
															PreparedStatement ps_registerer = con.prepareStatement("select U_Name from User_tbl where U_id=" + rs_sel.getInt("U_Id"));
															ResultSet rs_registerer = ps_registerer.executeQuery();
															while (rs_registerer.next()) {
												%>
												<td><%=rs_registerer.getString("U_Name")%></td>
												<%
													}
												 %>
												 <td><b><%=rs_sel.getString("Action_Discription")%></b></td>
												 <td><b><%=rs_sel.getString("Action_Type")%></b></td> 
												<td><%=sdf2.format(rs_sel.getDate("Action_Date"))%></td> 
											</tr> 
					<%
							 }
					}else	if(rep==3){
						PreparedStatement ps_reqDetails = con.prepareStatement("SELECT * FROM complaintzilla.it_user_requisition where Req_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id= " + Integer.parseInt(comp) +" order by company_id,U_Id");
						ResultSet rs_reqDetails = ps_reqDetails.executeQuery(); 
					%>
					<tr>
						<th colspan="14">IT Tracker <b style="color: #b5f5fb;">( Total Count <%=cnt %> )</b> from <%=fromview %> to <%=toview %></th>
					</tr> 
					<tr>
						<th>Req. No.</th>
							<th>User Name</th>
							<th>Company Name</th>
							<th>Department</th>
							<th>Related To</th>
							<th>Type</th>
							<th>Req. Date</th>
							<th>Status</th>
							<th>Transfer To</th> 
					</tr>
							<%
							while (rs_reqDetails.next()) {
							 %>
					<tr>
						<td align="center"><%=rs_reqDetails.getInt("U_Req_Id")%></td>
						<%
							PreparedStatement ps_name = con.prepareStatement("select U_Name from User_tbl where U_Id=" + rs_reqDetails.getInt("U_Id"));
							ResultSet rs_name = ps_name.executeQuery();
							while (rs_name.next()) {
						%>
						<td align="left"><%=rs_name.getString("U_Name")%></td>
						<%
							}
						PreparedStatement ps_comp = con.prepareStatement("select Company_Name from User_tbl_Company where Company_Id="
													+ rs_reqDetails.getInt("Company_Id"));
						ResultSet rs_comp = ps_comp.executeQuery();
						while (rs_comp.next()) {
						%>
						<td align="left"><%=rs_comp.getString("Company_Name")%></td>
						<%
							}
							
PreparedStatement ps_dept = con.prepareStatement("select Department from user_tbl_dept where dept_id in (SELECT dept_id FROM complaintzilla.user_tbl where u_id="+ rs_reqDetails.getInt("U_Id")+")");
ResultSet rs_dept = ps_dept.executeQuery();
			while (rs_dept.next()) {
			%>
			<td align="left"><%=rs_dept.getString("Department")%></td>
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
						<td align="left"><%=rs_reqDetails.getString("transfer_call")%></td>
					</tr>
					<% 
					}
					}else	if(rep==4){
						PreparedStatement ps_reqDetails = con.prepareStatement("SELECT * FROM complaintzilla.cr_tbl where CR_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=" + Integer.parseInt(comp));
						ResultSet rs_CR_Details = ps_reqDetails.executeQuery(); 
					%>
					<tr>
						<th colspan="14">ECN <b style="color: #b5f5fb;">( Internal Total Count <%=cnt %> )</b> from <%=fromview %> to <%=toview %></th>
					</tr> 
					<tr> 
									<th>CR NO</th>
									<th>Supplier Name</th>
									<th>Item Name</th>
									<th>Category</th>
									<th>Change Request Date</th>
									<th>Proposed Impl. Date</th> 
									<th>Approval Status</th> 
								</tr>
							<%
							while (rs_CR_Details.next()) {
							 %>
								<tr>
										<td align="right"><%=rs_CR_Details.getInt("CR_No")%></td>
										<%
											PreparedStatement ps_company = con.prepareStatement("select Company_Name from User_tbl_Company where Company_Id=" + rs_CR_Details.getInt("Company_Id"));
													ResultSet rs_company = ps_company.executeQuery();
													while (rs_company.next()) {
										%>
										<td align="left" width="50px"><%=rs_company.getString("Company_Name")%></td>
										<%
											}
													PreparedStatement ps_item = con.prepareStatement("select Item_Name from customer_tbl_item where Item_Id="
																	+ rs_CR_Details.getInt("Item_Id"));
													ResultSet rs_item = ps_item.executeQuery();
													while (rs_item.next()) {
										%>
										<td align="left"><%=rs_item.getString("Item_Name")%></td>
										<td align="left" width="200px">
												<%
													}
															PreparedStatement ps_category_id = con.prepareStatement("select CR_Category_Id from CR_category_relation_tbl where CR_No=" + rs_CR_Details.getInt("CR_No"));
															ResultSet rs_category_id = ps_category_id.executeQuery();
															ArrayList cat_id = new ArrayList();
															while (rs_category_id.next()) {
																cat_id.add(rs_category_id.getInt("CR_Category_Id"));
															}
															//System.out.println("Home Test = " + cat_id);
															for (int j = 0; j < cat_id.size(); j++) {
																PreparedStatement ps_category = con.prepareStatement("select * from CR_tbl_category where CR_Category_Id="
																				+ Integer.parseInt(cat_id.get(j).toString()));
																ResultSet rs_category = ps_category.executeQuery();
																while (rs_category.next()) {
												%>
												<label><%=rs_category.getString("CR_Category")%></label>, 
												<%
													}
															}
												%>
										</td>
										<td align="left"><%=rs_CR_Details.getString("CR_Date")%></td>
										<td align="left"><%=rs_CR_Details.getString("Proposed_Impl_Date")%></td>  
										<%
													ArrayList appr_list = new ArrayList();
													ArrayList appr_id_list = new ArrayList();
													PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from cr_approver_relation_tbl where CR_No=" + rs_CR_Details.getInt("CR_No"));
													ResultSet rs_appr_list = ps_appr_list.executeQuery();
													while (rs_appr_list.next()) {
														appr_list.add(rs_appr_list.getInt("U_Id"));
													}

													for (int appr = 0; appr < appr_list.size(); appr++) {
														PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from cr_tbl_Approval where CR_No="
																		+ rs_CR_Details.getInt("CR_No")
																		+ " and U_Id="
																		+ Integer.parseInt(appr_list.get(appr)
																				.toString()));

														ResultSet rs_appr = ps_appr.executeQuery();
														while (rs_appr.next()) {
															appr_id_list.add(rs_appr.getInt("Approval_Id"));
														}

													}
													String Status = null;

													boolean flag = false;
													int cnt1 = 0;
													int cnt2 = 0;
													int cnt3 = 0;
													for (int appr_id = 0; appr_id < appr_id_list.size(); appr_id++) {
														int id = 0;
														id = Integer.parseInt(appr_id_list.get(appr_id).toString());

														if (id == 3) {
															cnt3++;
															//flag=true;
															break;
														} else if (id == 2) {
															cnt2++;
															continue;
														} else {
															cnt1++;
															continue;
														} 
													}

													if (cnt3 > 0) {
										%>
										<td align="left">Declined</td>
										<%
											} else if (cnt1 == appr_id_list.size()) {
										%>
										<td align="left">Approved</td>
										<%
											} else {
										%>
										<td align="left">Pending</td>
										<%
											}
										%> 
										<input type="hidden" name="hid" id="hid">
									</tr>
					<% 
					}
					}else	if(rep==5){
						PreparedStatement ps_reqDetails = con.prepareStatement("SELECT * FROM complaintzilla.crc_tbl where CRC_Date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and company_id=" + Integer.parseInt(comp));
						ResultSet rs_CR_Details = ps_reqDetails.executeQuery(); 
					%>
					<tr>
						<th colspan="14">ECN <b style="color: #b5f5fb;">( Customer Total Count <%=cnt %> )</b> from <%=fromview %> to <%=toview %></th>
					</tr> 
					<tr> 
							<th align="center">CR NO</th>
									<th align="center">Supplier Name</th>
									<th align="center">Item Name</th>
									<th align="center">Change For</th>
									<th align="center">Change Request Date</th>
									<th align="center">Total Stock</th>
									<th align="center">Target Impl. Date</th>
									<th align="center">Requested By</th>
									<th align="center">Approval Status</th>
					</tr>
				<%
						int cr_no = 0;
						while (rs_CR_Details.next()) {
							cr_no = rs_CR_Details.getInt("CRC_No");
				%>
			<tr>
					<td align="right"><%=cr_no%></td>
					<%
						PreparedStatement ps_company = con.prepareStatement("select Company_Name from User_tbl_Company where Company_Id=" + rs_CR_Details.getInt("Company_Id"));
						ResultSet rs_company = ps_company.executeQuery();
						while (rs_company.next()) {
					%>
					<td align="left"><%=rs_company.getString("Company_Name")%></td>
					<%
						}
									PreparedStatement ps_item = con.prepareStatement("select Item_Name from customer_tbl_item where Item_Id="
													+ rs_CR_Details.getInt("Item_Id"));
									ResultSet rs_item = ps_item.executeQuery();
									while (rs_item.next()) {
					%>
					<td align="left"><%=rs_item.getString("Item_Name")%></td>
					<%
						}
					%>

					<td align="left"><%=rs_CR_Details.getString("Change_For")%></td>
					<td align="left"><%=rs_CR_Details.getString("CRC_Date")%></td>
					<td align="right"><%=rs_CR_Details.getString("Total_Stock")%></td>
					<%
						if (rs_CR_Details.getString("Targated_Impl_Date").equals("0002-11-30 00:00:00.0")) {
					%>
					<td align="left"></td>
					<%
						} else {
					%>
					<td align="left"><%=rs_CR_Details.getString("Targated_Impl_Date")%></td>
					<%
						}
									PreparedStatement ps_U_Name = con.prepareStatement("select U_Name from User_Tbl where U_Id="
													+ rs_CR_Details.getString("U_Id"));
									ResultSet rs_U_Name = ps_U_Name.executeQuery();
									while (rs_U_Name.next()) {
					%>
					<td align="left"><%=rs_U_Name.getString("U_Name")%></td>
					<%
						}
									ArrayList appr_list = new ArrayList();
									ArrayList appr_id_list = new ArrayList();
									PreparedStatement ps_appr_list = con.prepareStatement("select U_Id from crc_tbl_approver_rel where CRC_No="
													+ cr_no);
									ResultSet rs_appr_list = ps_appr_list.executeQuery();
									while (rs_appr_list.next()) {
										appr_list.add(rs_appr_list.getInt("U_Id"));
									}

									for (int appr = 0; appr < appr_list.size(); appr++) {
										PreparedStatement ps_appr = con.prepareStatement("select Approval_Id from crc_tbl_Approval where CRC_No="
														+ cr_no
														+ " and U_Id="
														+ Integer.parseInt(appr_list.get(
																appr).toString()));

										ResultSet rs_appr = ps_appr.executeQuery();
										while (rs_appr.next()) {
											appr_id_list.add(rs_appr.getInt("Approval_Id"));
										} 
									}
									String Status = null; 
									boolean flag = false;
									int cnt1 = 0;
									int cnt2 = 0;
									int cnt3 = 0;
									for (int appr_id = 0; appr_id < appr_id_list.size(); appr_id++) {
										int id = 0; 
										id = Integer.parseInt(appr_id_list.get(appr_id).toString()); 
										if (id == 3) {
											cnt3++;
											break;
										} else if (id == 2) {
											cnt2++;
											continue;
										} else {
											cnt1++;
											continue;
										} 
									} 
					if (cnt3 > 0) {
					%>
					<td align="left">Declined</td>
					<%
						} else if (cnt1 == appr_id_list.size()) {
					%>
					<td align="left">Approved</td>
					<%
						} else {
					%>
					<td align="left">Pending</td>
					<%
						}
					%>
					<input type="hidden" name="hid" id="hid">
				</tr>
				<%
					}
					}else	if(rep==6){
						int created_erp=0;
						PreparedStatement ps = conn.prepareStatement("select DATE_FORMAT(registered_date, \"%d/%m/%Y %l:%i\") as registered_date,created_inERP,code,supplier,registered_by,approval_status  from new_item_creation where enable=1  and  registered_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and "+ 
								" registered_by in(SELECT u_name FROM complaintzilla.user_tbl where company_id="+Integer.parseInt(comp)+")	");
						ResultSet rs = ps.executeQuery();
					%>
					<tr>
						<th colspan="14">New Suppliers <b style="color: #b5f5fb;">( Total Count <%=cnt %> )</b> from <%=fromview %> to <%=toview %></th>
					</tr> 
					<tr> 
						<th>Status</th>
    					<th>Request Date</th>
    					<th>Created By</th>
    					<th>Status</th>
    					<th>Created in ERP</th>
					</tr>
				<% 
						while (rs.next()) {
							 created_erp = rs.getInt("created_inERP");
				%>
			<tr  onmouseover="ChangeColor(this, true);" onMouseOut="ChangeColor(this, false);" onClick="button1('<%=rs.getInt("code")%>')" style="cursor: pointer;">
  <td align="left" style="font-family: Arial;font-size: 10px;"><%=rs.getString("supplier").toUpperCase() %></td>
  <td><%=rs.getString("registered_date") %></td>
  <td><%=rs.getString("registered_by") %></td>
  <%
  if(rs.getString("approval_status").equalsIgnoreCase("0")){
  %>
  <td>Pending</td>
  <%
  } 
  if(rs.getString("approval_status").equalsIgnoreCase("1")){
  %>
  <td>Approved</td>
  <%
  } 
  if(rs.getString("approval_status").equalsIgnoreCase("3")){
  %>
  <td>Declined</td>
  <%
  }
  if(created_erp==0){
  %>  
 <td><b> - - - - </b></td>
 <%
  }else{
%>
 <td><b>Created</b></td>
<%	  
  }
 %>
  </tr>
				<% 
				created_erp=0;
					}
					}else	if(rep==7){
						
						
						
						PreparedStatement ps = conn.prepareStatement("select DATE_FORMAT(registered_date, \"%d/%m/%Y %l:%i\") as registered_date,created_inERP,code,supplier,registered_by,approval_status  from new_item_creation where enable=1  and  registered_date between '"+fromSoftwareDate+"' and '"+toSoftwareDate+"' and "+ 
								" registered_by in(SELECT u_name FROM complaintzilla.user_tbl where company_id="+Integer.parseInt(comp)+")	");
						ResultSet rs = ps.executeQuery();
					%>
					<tr>
						<th colspan="14">New Suppliers <b style="color: #b5f5fb;">( Total Count <%=cnt %> )</b> from <%=fromview %> to <%=toview %></th>
					</tr> 
					<tr> 
						<th>Status</th>
    					<th>Request Date</th>
    					<th>Created By</th>
    					<th>Status</th>
    					<th>Created in ERP</th>
					</tr> 
				<%  
					} 
				%> 
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