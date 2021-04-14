<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>IT Tracker Home</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<script language="javascript" type="text/javascript"
	src="datetimepicker.js"></script>
<link rel="stylesheet" type="text/css" href="styles.css" />
<link href="tab_trial.css" rel="stylesheet" />
<script language="JavaScript" src="gen_validatorv4.js"
	type="text/javascript" xml:space="preserve"></script>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script>
	$(function() {
		$("#tabs").tabs();
	});
	
	$(document).ready(
			  function () {
			    $( "#fromUserwiseDate" ).datepicker({
			      changeMonth: true,
			      changeYear: true 
			    });
			    $( "#toUserwiseDate" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });   				   
			    $( "#fromSoftwareDate" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });   
			    $( "#toSoftwareDate" ).datepicker({
				      changeMonth: true,
				      changeYear: true 
				    });   
			  } 
			); 
	
</script>
<style type="text/css">
.tftable {
	font-size: 12px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 12px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: left;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 12px; 
	padding: 8px; 
}
</style>
<script type="text/javascript">
function validateForm() {
	var reqNo=document.getElementById("req_no"); 
	 
	 if(reqNo.value=="" || reqNo.value==null){
		 alert("Please Enter Requisition No !!!");
			return false;
	 }
	
	 return true;
}


function validatePerticularForm() {
	var compName=document.getElementById("company_name");
	var frDate=document.getElementById("demo3");
	var toDate=document.getElementById("demo4");
	 
	 if(compName.value=="" || compName.value==null){
		 alert("Please Provide Company Name !!!");
			return false;
	 }
	 if(frDate.value=="" || frDate.value==null){
		 alert("Please Provide From Date !!!");
			return false;
	 }
	 if(toDate.value=="" || toDate.value==null){
		 alert("Please Provide To Date !!!");
			return false;
	 }
	
	 return true;
}

</script>

<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%>


<%
	try {

		Calendar first_Datecal = Calendar.getInstance();   
		first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
		Date dddd = first_Datecal.getTime();  
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");  
		Date tdate = new Date();
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
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
			<h3>Reports</h3>
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
		<!-- Reports -->
		
					<div id="tabs">
				<ul>
					<li><a href="#tabs-1"><font style="font-size: 12px;">Req No Wise</font> </a></li>
					<li><a href="#tabs-2"><font style="font-size: 12px;">Select Particulars</font></a></li> 
					<li><a href="#tabs-3"><font style="font-size: 12px;">User Wise Usage</font></a></li>
					<li><a href="#tabs-4"><font style="font-size: 12px;">Software Counts</font></a></li> 
					<li><a href="#tabs-5"><font style="font-size: 12px;">All Report</font></a></li> 
				</ul>
				<div id="tabs-1">
				<form action="Report_Generator_Controller" name="report" id="report"
			method="post"  onsubmit ="return(validateForm());">
			
			<input type="hidden" name="company_name" value=""/>
			<input type="hidden" name="rel_to" value=""/>
			<input type="hidden" name="req_type" value=""/>
			<input type="hidden" name="first_date" value=""/>
			<input type="hidden" name="last_date" value=""/>
			
			
				<table align="center" border="0" class="tftable">

								<tr>
									<td colspan="3" align="center"><b>Requisition Number
											Wise Report</b></td>
											<td width="5%"></td>
				  </tr>
								<tr>
									<td width="13%" align="right"><b style="color: red;">*</b> Enter Req. No. :</td>
								  <td colspan="2" align="left"><input type="text" name="req_no" id="req_no"/></td>
				  </tr>
								<tr>
									<td colspan="3"><b style="color: red;">* Contains
											Mandatory Fields</b></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><input type="submit"
										value="Generate Report" style="width: 150px; height: 30px;"/></td>
								    <td width="63%" align="center">&nbsp;</td>
								</tr>
							</table>
				  </form>
				</div>
				<div id="tabs-2">
				<form action="Report_Generator_Controller" name="report" id="report"
			method="post"  onsubmit ="return(validatePerticularForm());">
				<input type="hidden" name="req_no" value=""/>
				<table  align="center" border="0" class="tftable">

								<tr>
									<td width="13%" align="right"><b>Select Particulars :</b></td>
								  <td colspan="2"></td>
				  </tr>
								<tr>
									<td align="right"><b style="color: red;">*</b> Select
										Company :</td>
									<td colspan="2" align="left"><select name="company_name" id="company_name">
											<option value="">--Select--</option>
											<%
												PreparedStatement ps_compName = con
															.prepareStatement("Select * from user_tbl_Company where company_id!=6");
													ResultSet rs_compName = ps_compName.executeQuery();

													while (rs_compName.next()) {
											%>
											<option value="<%=rs_compName.getInt("Company_Id")%>"><%=rs_compName.getString("Company_Name")%></option>
											<%
												}
											%>
									</select></td>
								</tr>
								<tr>
									<td align="right">Problem Related To :</td>
									<td colspan="2" align="left"><select name="rel_to">
											<option value="0">--Select--</option>
											<%
												PreparedStatement ps_relTo = con
															.prepareStatement("Select * from it_related_problem_tbl");
													ResultSet rs_relTo = ps_relTo.executeQuery();

													while (rs_relTo.next()) {
											%>
											<option value="<%=rs_relTo.getInt("Rel_Id")%>"><%=rs_relTo.getString("Related_To")%></option>
											<%
												}
											%>
									</select></td>
								</tr>
								<tr>
									<td align="right">Requisition Type :</td>
									<td colspan="2" align="left"><select name="req_type">
											<option value="0">--Select--</option>
											<%
												PreparedStatement ps_type = con
															.prepareStatement("Select * from it_requisition_type_tbl");
													ResultSet rs_type = ps_type.executeQuery();

													while (rs_type.next()) {
											%>
											<option value="<%=rs_type.getInt("Req_Type_Id")%>"><%=rs_type.getString("Req_Type")%></option>
											<%
												}
											%>
									</select></td>
								</tr>
								<tr>
									<td align="right"><b style="color: red;">*</b> From Date :</td>
									<td colspan="2" align="left"><input id="demo3" name="first_date" onclick="javascript:NewCal('demo3','ddmmyyyy',true,24)"
										type="text" size="25" readonly="readonly"
										TITLE="Click on Date Picker" /> <a
										href="javascript:NewCal('demo3','ddmmyyyy',true,24)"> <img
											src="cal.gif" width="16" height="16" border="0"
											alt="Pick a date" /></a></td>
								</tr>
								<tr>
									<td align="right"><b style="color: red;">*</b> To Date :</td>
									<td colspan="2" align="left"><input id="demo4" name="last_date" onclick="javascript:NewCal('demo4','ddmmyyyy',true,24)"
										type="text" size="25" readonly="readonly"
										TITLE="Click on Date Picker" /> <a
										href="javascript:NewCal('demo4','ddmmyyyy',true,24)"> <img
											src="cal.gif" width="16" height="16" border="0"
											alt="Pick a date" /></a></td>
								</tr>
								<tr>
									<td colspan="3"><b style="color: red;">* Contains
											Mandatory Fields</b></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><input type="submit"
										value="Generate Report" style="width: 150px; height: 30px;"/></td>
								    <td width="70%" align="center">&nbsp;</td>
								</tr>
							</table>
				  </form>
				</div>
				<div id="tabs-3">
				
				<form action="UserWise_CountReport" name="Userreport" id="Userreport" method="post">
				<table  align="center" border="0" class="tftable">
								<tr>
									<td width="12%" align="right"><b>Select Report Dates :</b></td>
								  <td width="88%" colspan="2"></td>
				  </tr> 
								<tr>
									<td align="right"><b style="color: red;">*</b> From :</td>
									<td colspan="2" align="left">
									<input type="text" name="fromUserwiseDate" id="fromUserwiseDate" readonly="readonly" value="<%=sdfFIrstDate.format(dddd) %>"/>									</td>
								</tr>
								<tr>
									<td align="right"><b style="color: red;">*</b> To Date :</td>
									<td colspan="2" align="left">
									<input type="text" name="toUserwiseDate" id="toUserwiseDate" readonly="readonly" value="<%=sdfFIrstDate.format(tdate) %>"/>									</td>
								</tr>
								<tr>
									<td colspan="3"><b style="color: red;">* Contains
											Mandatory Fields</b></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><input type="submit"
										value="View Report" style="width: 150px; height: 30px;"/></td>
								    <td align="center">&nbsp;</td>
								</tr>
							</table>
				  </form>
				
				
				</div>
				
				
				
				<div id="tabs-4">
				
				<form action="Software_CountReport.jsp" name="Userreport" id="Userreport" method="post">
				<table  align="center" border="0" class="tftable">
								<tr>
									<td width="12%" align="right"><b>Select Report Dates :</b></td>
								  <td width="88%" colspan="2"></td>
				  </tr> 
								<tr>
									<td align="right">From :</td>
									<td colspan="2" align="left">
									<input type="text" name="fromSoftwareDate" id="fromSoftwareDate" readonly="readonly" value="<%=sdfFIrstDate.format(dddd) %>"/>									</td>
								</tr>
								<tr>
									<td align="right">To Date :</td>
									<td colspan="2" align="left">
									<input type="text" name="toSoftwareDate" id="toSoftwareDate" readonly="readonly" value="<%=sdfFIrstDate.format(tdate) %>"/>									</td>
								</tr> 
								<tr>
									<td colspan="2" align="center"><input type="submit" value="View Report" style="width: 150px; height: 30px;"/></td>
								    <td align="center">&nbsp;</td>
								</tr>
							</table>
				  </form>
				
				
				</div>
				
				<div id="tabs-5">
				<form action="Report_Generator_Controller" name="report" id="report" method="post"  onsubmit ="return(validateForm());">
				</form>				
				</div>
				
				
				
				
			</div>	
		 <!-- Reports End-->
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%> 
	</div>
</body>
</html>
