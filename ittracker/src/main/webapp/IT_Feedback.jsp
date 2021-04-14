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
<title>Feedbacks</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
<script type="text/javascript" src="js/jsapi"></script>
<script type="text/javascript" src="js/loader.js"></script>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script> 
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
			  } 
			); 
	
</script>
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
	
		function RunMe() {
			var xmlhttp;
			var xmlhttp1;
			var fromdate = document.getElementById("fromUserwiseDate").value;
			var todate = document.getElementById("toUserwiseDate").value;
			
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
				xmlhttp1 = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {
				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					document.getElementById("getReport").innerHTML = xmlhttp.responseText;
				}
			};
			xmlhttp1.onreadystatechange = function() {
				if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) {
					document.getElementById("getChartReport").innerHTML = xmlhttp1.responseText;
				}
			};
			xmlhttp.open("POST", "Feedbackgraph.jsp?p=" + fromdate + "&q=" + todate, true);
			xmlhttp1.open("POST", "Feedbackgraph1.jsp?p=" + fromdate + "&q=" + todate, true);
			xmlhttp.send();
			xmlhttp1.send();
	}; 
</script>
<style>
div.scroll {
	background-color: #F0EBF2;
	width: 760px;
	height: 600px;
	overflow: scroll;
}
</style>
<style type="text/css">
.tftable {
	font-family:Arial;
	font-size: 12px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 13px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: center;
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size: 12px; 
	padding: 8px; 
}
</style>
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
		Calendar first_Datecal = Calendar.getInstance();   
		first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
		Date dddd = first_Datecal.getTime();  
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");  
		Date tdate = new Date();
%>


</head>
<body>
	<div id="container">
		<div id="top">
			<h3>Closed Requisitions</h3>

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
				<li><a href="IT_Feedback.jsp">Feedback</a></li> 
				<li><a href="Profile.jsp">My Profile</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: 8px;"> <%=uname%></strong></a></li>
			</ul>
		</div>
		
<div style="height: 500px;width:60%;float:left; overflow: scroll;"> 
	<form method="post" name="edit" action="Feedbackgraph.jsp" id="edit">
	<table  align="center" border="0" class="tftable">
								<tr>
									<td width="12%" align="left" colspan="4"><b>Select Report Dates :</b></td></td>
				 			 </tr> 	
				  				<tr>
									<td align="right"><b style="color: red;">*</b> Company :</td>
									<td colspan="2" align="left">
									<select name="company" id="company">
									<%
									PreparedStatement ps=con.prepareStatement("select * from user_tbl_company");
									ResultSet rs = ps.executeQuery();
									while(rs.next()){
									%> 
									<option value="<%=rs.getInt("Company_Id")%>"><%=rs.getString("Company_Name") %></option>
									<%
									}
									%>
									</select>
									</td>
								</tr>
								<tr>
									<td align="right"><b style="color: red;">*</b> Department :</td>
									<td colspan="2" align="left">
									<select name="department" id="department">
									<option value="all">ALL</option>
									<%
									ps=con.prepareStatement("select * from user_tbl_dept");
									rs = ps.executeQuery();
									while(rs.next()){ 
									%> 
									<option value="<%=rs.getInt("dept_id")%>"><%=rs.getString("Department") %></option>
									<%
									}
									%>
									</select>
									</td>
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
									<td colspan="3"><b style="color: red;">* Contains Mandatory Fields</b></td>
								</tr>
								<tr>
									<td colspan="2" align="center"><input type="submit" value="View Report" style="width: 150px; height: 30px;"/></td>
								    <td align="center">&nbsp;</td>
								</tr>
							</table> 
	</form>
	</div>
		
  
		<div id="footer">
			<p class="style2">
				<a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New
					Requisition</a> <a href="Closed_Requisitions.jsp">Closed
					Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a> <a href="IT_Reports.jsp">Reports</a>
				<a href="Software_Access.jsp">Software Access</a> <a
					href="Logout.jsp">Logout</a><br /> <a
					href="http://www.muthagroup.com">Mutha Group, Satara </a>
			</p>
	</div>
</div>
<%
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</body>
</html>