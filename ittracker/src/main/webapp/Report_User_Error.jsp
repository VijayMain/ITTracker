<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.*"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Reports</title>
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
<script type="text/javascript">
	function tab(tab) {
		document.getElementById('tab1').style.display = 'none';
		document.getElementById('tab2').style.display = 'none';
		document.getElementById('li_tab1').setAttribute("class", "");
		document.getElementById('li_tab2').setAttribute("class", "");
		document.getElementById(tab).style.display = 'block';
		document.getElementById('li_' + tab).setAttribute("class", "active");
	}
</script>
 

<%
try {
	DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	// get current date time with Date()
	Date date = new Date();
	System.out.println("by date..:" + dateFormat.format(date));

	java.sql.Timestamp timestamp = new java.sql.Timestamp(
			date.getTime());

	System.out.println("by TIMESTAMP..:" + timestamp);
	

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
%>

</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Reports</h3>
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
		<!-- Reports -->
					<div id="tabs">
				<ul>
					<li><a href="#tabs-1"><font style="font-size: 12px;">Req No Wise</font> </a></li>
					<li><a href="#tabs-2"><font style="font-size: 12px;">Select Particulars</font></a></li> 
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
									<td colspan="2" align="center"><b>Requisition Number
											Wise Report</b></td>
											<td></td>
								</tr>
								<tr>
									<td align="right"><b style="color: red;">*</b> Enter Req. No. :</td>
									<td align="left"><input type="text" name="req_no" id="req_no"/></td>
								</tr>
								<tr>
									<td colspan="2"><b style="color: red;">* Contains
											Mandatory Fields</b></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><input type="submit"
										value="Generate Report" style="width: 150px; height: 30px;"/></td>
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
									<td align="right"><b>Select Particulars :</b></td>
									<td></td>
								</tr>
								<tr>
									<td align="right"><b style="color: red;">*</b> Select
										Company :</td>
									<td align="left"><select name="company_name" id="company_name">
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
									<td align="left"><select name="rel_to">
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
									<td align="left"><select name="req_type">
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
									<td align="left"><input id="demo3" name="first_date" onclick="javascript:NewCal('demo3','ddmmyyyy',true,24)"
										type="text" size="25" readonly="readonly"
										TITLE="Click on Date Picker" /> <a
										href="javascript:NewCal('demo3','ddmmyyyy',true,24)"> <img
											src="cal.gif" width="16" height="16" border="0"
											alt="Pick a date" /></a></td>
								</tr>
								<tr>
									<td align="right"><b style="color: red;">*</b> To Date :</td>
									<td align="left"><input id="demo4" name="last_date" onclick="javascript:NewCal('demo4','ddmmyyyy',true,24)"
										type="text" size="25" readonly="readonly"
										TITLE="Click on Date Picker" /> <a
										href="javascript:NewCal('demo4','ddmmyyyy',true,24)"> <img
											src="cal.gif" width="16" height="16" border="0"
											alt="Pick a date" /></a></td>
								</tr>
								<tr>
									<td colspan="2"><b style="color: red;">* Contains
											Mandatory Fields</b></td>
								</tr>
								
								<tr><td colspan="2"><b style="color: red;font-family: Arial;font-size: 10px;">* Contains Mandatory Fields</b></td></tr>
								<tr><td colspan="2"><b style="color: red;font-family: Arial;font-size: 10px;">Fill all mandatory fields... </b></td></tr>
								
								
								<tr>
									<td colspan="2" align="center"><input type="submit"
										value="Generate Report" style="width: 150px; height: 30px;"/></td>
								</tr>

							</table>
							</form>
				</div>
			</div>	
		
		
		
		<!-- Reports End-->

		<!-- <script language="JavaScript" type="text/javascript"
							xml:space="preserve">
							var frmvalidator = new Validator(
									"report");
							
							frmvalidator.addValidation("company_name",
									"req", "Please Provide Company Name..!!");

							frmvalidator.addValidation("first_date",
									"req", "Please Provide From Date..!!");
							
							frmvalidator.addValidation("last_date",
									"req", "Please Provide the To Date ..!!");
		</script> -->


		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
		<!-- <div id="footer">
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
