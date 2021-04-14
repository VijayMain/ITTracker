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
	padding: 3px; 
}
</style>
<%
	try {

		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con.prepareStatement("select U_Name from User_tbl where U_Id=" + uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			uname = rs_uname.getString("U_Name");
		}
		 String startDate = request.getParameter("fromUserwiseDate");
		 String endDate = request.getParameter("toUserwiseDate");
		 String company = request.getParameter("company");
		 String department = request.getParameter("department"); 
		 
		 if(company.equalsIgnoreCase(String.valueOf("6"))){ 
			 company = "";
		 }else{
			  company = " and company_id="+company;
		 }
		 if(department.equalsIgnoreCase("all")){ 
			 department="";
		 }else{
			 department = " and dept_id=" + department;
		 }
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
		
		<div style="height: 500px;width:49.5%;float:left; overflow: scroll;"> 
			<a href="IT_Feedback.jsp"><strong><<=== BACK</strong></a> 
			 	<%
					Connection conn = null;
						conn = Connection_Utility.getConnection(); 
						PreparedStatement ps_reqDetails = null;
						PreparedStatement psRowCnt = null; 
						
						String sqlPagination = "SELECT * FROM  it_user_feedback where enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department; 
						ps_reqDetails = conn.prepareStatement(sqlPagination);
						rs_uname = ps_reqDetails.executeQuery(); 
				%> 
					<table border="0" class="tftable"> 
							<tr style="font-weight: bold;background-color: #305fc0;color: white;font-size: 10px;text-align: center;">
								<td height='20'>Network</td>
								<td>Device Satisfaction</td>
								<td>In-House Softwares</td>
								<td>ERP</td>
								<td>Overall Satisfied</td>
								<td>Comments</td>  
								<td>Date (yyyy-mm-dd)</td>
								<td>User</td>  
							</tr>
							<% 
								while (rs_uname.next()) { 
							%>
							<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" style="cursor: pointer;">
								<td align='right'><%=rs_uname.getInt("internet_speed") %></td>
								<td align='right'><%=rs_uname.getInt("pc_laptop") %></td>
								<td align='right'><%=rs_uname.getInt("inhouse") %></td>
								<td align='right'><%=rs_uname.getInt("erp") %></td>
								<td align='right'><%=rs_uname.getInt("it_satisfaction") %></td>
								<td><%=rs_uname.getString("comments") %></td> 
								<td><%=rs_uname.getString("feedback_date").substring(0,10) %></td>
								<td><%=rs_uname.getString("user") %></td> 
							</tr>
							<%
								} 
							%> 
					</table> 
		</div>

<div style="height: 500px;width:50%;float:right; overflow: scroll;">
<table border="0">
<tr>
<td>
<%
String rate1 = "SELECT count(*) as count FROM  it_user_feedback where internet_speed=1 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
String rate2 = "SELECT count(*) as count FROM  it_user_feedback where internet_speed=2 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
String rate3 = "SELECT count(*) as count FROM  it_user_feedback where internet_speed=3 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
String rate4 = "SELECT count(*) as count FROM  it_user_feedback where internet_speed=4 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
String rate5 = "SELECT count(*) as count FROM  it_user_feedback where internet_speed=5 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;

ps_reqDetails = conn.prepareStatement(rate1);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate1=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate2);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate2=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate3);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate3=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate4);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate4=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate5);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate5=String.valueOf(rs_uname.getInt("count"));
}
%>

<script type="text/javascript"> 
	google.load('visualization','1.0',{'packages': ['corechart']}); 
	google.setOnLoadCallback(drawChart); 
	function drawChart(){ 
	var data = new google.visualization.DataTable();
<%   
String d1="Rating 1";
String d2="Rating 2";
String d3="Rating 3";
String d4="Rating 4";
String d5="Rating 5";
double v1=Double.valueOf(rate1);
double v2=Double.valueOf(rate2);
double v3=Double.valueOf(rate3);
double v4=Double.valueOf(rate4);
double v5=Double.valueOf(rate5); 
%>
		data.addColumn('string','Topping');
		data.addColumn('number','Slices');
		data.addRows([['<%=d1%>',<%=v1%>],['<%=d2%>',<%=v2%>],['<%=d3%>',<%=v3%>],['<%=d4%>',<%=v4%>],['<%=d5%>',<%=v5%>]]);
		var options = {'title':'Internet and network speed','width':360,'height':200}; 
		var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
		chart.draw(data,options); 
	}
</script>
<div id="chart_div"></div>

</td>

<td>

<%
rate1="";rate2="";rate3="";rate4="";rate5="";
rate1 = "SELECT count(*) as count FROM  it_user_feedback where pc_laptop=1 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate2 = "SELECT count(*) as count FROM  it_user_feedback where pc_laptop=2 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate3 = "SELECT count(*) as count FROM  it_user_feedback where pc_laptop=3 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate4 = "SELECT count(*) as count FROM  it_user_feedback where pc_laptop=4 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate5 = "SELECT count(*) as count FROM  it_user_feedback where pc_laptop=5 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;

ps_reqDetails = conn.prepareStatement(rate1);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate1=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate2);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate2=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate3);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate3=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate4);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate4=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate5);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate5=String.valueOf(rs_uname.getInt("count"));
}
%>
 
<script type="text/javascript"> 
	google.load('visualization','1.0',{'packages': ['corechart']}); 
	google.setOnLoadCallback(drawChart); 
	function drawChart(){ 
	var data = new google.visualization.DataTable();
<%
d1="";d2="";d3="";d4="";d5="";
v1=0;v2=0;v3=0;v4=0;v5=0;
d1="Rating 1";
d2="Rating 2";
d3="Rating 3";
d4="Rating 4";
d5="Rating 5";

v1=Double.valueOf(rate1);
v2=Double.valueOf(rate2);
v3=Double.valueOf(rate3);
v4=Double.valueOf(rate4);
v5=Double.valueOf(rate5); 
%>
		data.addColumn('string','Topping');
		data.addColumn('number','Slices');
		data.addRows([['<%=d1%>',<%=v1%>],['<%=d2%>',<%=v2%>],['<%=d3%>',<%=v3%>],['<%=d4%>',<%=v4%>],['<%=d5%>',<%=v5%>]]);
		var options = {'title':'(PC,Laptop,Printer)Device Satisfaction','width':360,'height':200}; 
		var chart = new google.visualization.PieChart(document.getElementById('chart_div1'));
		chart.draw(data,options); 
	}
</script>
<div id="chart_div1"></div> 
</td> 
</tr>
 
<tr>
<td>

<%
rate1="";rate2="";rate3="";rate4="";rate5="";
rate1 = "SELECT count(*) as count FROM  it_user_feedback where inhouse=1 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate2 = "SELECT count(*) as count FROM  it_user_feedback where inhouse=2 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate3 = "SELECT count(*) as count FROM  it_user_feedback where inhouse=3 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate4 = "SELECT count(*) as count FROM  it_user_feedback where inhouse=4 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate5 = "SELECT count(*) as count FROM  it_user_feedback where inhouse=5 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;

ps_reqDetails = conn.prepareStatement(rate1);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate1=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate2);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate2=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate3);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate3=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate4);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate4=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate5);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate5=String.valueOf(rs_uname.getInt("count"));
}
%>
 
<script type="text/javascript"> 
	google.load('visualization','1.0',{'packages': ['corechart']}); 
	google.setOnLoadCallback(drawChart); 
	function drawChart(){ 
	var data = new google.visualization.DataTable();
<%
d1="";d2="";d3="";d4="";d5="";
v1=0;v2=0;v3=0;v4=0;v5=0;
d1="Rating 1";
d2="Rating 2";
d3="Rating 3";
d4="Rating 4";
d5="Rating 5";

v1=Double.valueOf(rate1);
v2=Double.valueOf(rate2);
v3=Double.valueOf(rate3);
v4=Double.valueOf(rate4);
v5=Double.valueOf(rate5); 
%>
		data.addColumn('string','Topping');
		data.addColumn('number','Slices');
		data.addRows([['<%=d1%>',<%=v1%>],['<%=d2%>',<%=v2%>],['<%=d3%>',<%=v3%>],['<%=d4%>',<%=v4%>],['<%=d5%>',<%=v5%>]]);
		var options = {'title':'In-House Softwares','width':360,'height':200}; 
		var chart = new google.visualization.PieChart(document.getElementById('chart_div2'));
		chart.draw(data,options); 
	}
</script>
<div id="chart_div2"></div> 
</td>
<td>
  <%
rate1="";rate2="";rate3="";rate4="";rate5="";
rate1 = "SELECT count(*) as count FROM  it_user_feedback where erp=1 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate2 = "SELECT count(*) as count FROM  it_user_feedback where erp=2 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate3 = "SELECT count(*) as count FROM  it_user_feedback where erp=3 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate4 = "SELECT count(*) as count FROM  it_user_feedback where erp=4 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate5 = "SELECT count(*) as count FROM  it_user_feedback where erp=5 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;

ps_reqDetails = conn.prepareStatement(rate1);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate1=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate2);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate2=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate3);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate3=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate4);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate4=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate5);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate5=String.valueOf(rs_uname.getInt("count"));
}
%>
 
<script type="text/javascript"> 
	google.load('visualization','1.0',{'packages': ['corechart']}); 
	google.setOnLoadCallback(drawChart); 
	function drawChart(){ 
	var data = new google.visualization.DataTable();
<%
d1="";d2="";d3="";d4="";d5="";
v1=0;v2=0;v3=0;v4=0;v5=0;
d1="Rating 1";
d2="Rating 2";
d3="Rating 3";
d4="Rating 4";
d5="Rating 5";

v1=Double.valueOf(rate1);
v2=Double.valueOf(rate2);
v3=Double.valueOf(rate3);
v4=Double.valueOf(rate4);
v5=Double.valueOf(rate5); 
%>
		data.addColumn('string','Topping');
		data.addColumn('number','Slices');
		data.addRows([['<%=d1%>',<%=v1%>],['<%=d2%>',<%=v2%>],['<%=d3%>',<%=v3%>],['<%=d4%>',<%=v4%>],['<%=d5%>',<%=v5%>]]);
		var options = {'title':'ERP','width':360,'height':200}; 
		var chart = new google.visualization.PieChart(document.getElementById('chart_div3'));
		chart.draw(data,options); 
	}
</script>
<div id="chart_div3"></div> 
</td>
</tr>
<tr>
<td colspan="2">
 
<%
rate1="";rate2="";rate3="";rate4="";rate5="";
rate1 = "SELECT count(*) as count FROM  it_user_feedback where it_satisfaction=1 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate2 = "SELECT count(*) as count FROM  it_user_feedback where it_satisfaction=2 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate3 = "SELECT count(*) as count FROM  it_user_feedback where it_satisfaction=3 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate4 = "SELECT count(*) as count FROM  it_user_feedback where it_satisfaction=4 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;
rate5 = "SELECT count(*) as count FROM  it_user_feedback where it_satisfaction=5 and enable=1 and feedback_date between '" + startDate + "' and '" + endDate+"'" + company + department;

ps_reqDetails = conn.prepareStatement(rate1);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate1=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate2);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate2=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate3);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate3=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate4);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate4=String.valueOf(rs_uname.getInt("count"));
}

ps_reqDetails = conn.prepareStatement(rate5);
rs_uname = ps_reqDetails.executeQuery(); 
while(rs_uname.next()){
	rate5=String.valueOf(rs_uname.getInt("count"));
}
%>
 
<script type="text/javascript"> 
	google.load('visualization','1.0',{'packages': ['corechart']}); 
	google.setOnLoadCallback(drawChart); 
	function drawChart(){ 
	var data = new google.visualization.DataTable();
<%
d1="";d2="";d3="";d4="";d5="";
v1=0;v2=0;v3=0;v4=0;v5=0;
d1="Rating 1";
d2="Rating 2";
d3="Rating 3";
d4="Rating 4";
d5="Rating 5";

v1=Double.valueOf(rate1);
v2=Double.valueOf(rate2);
v3=Double.valueOf(rate3);
v4=Double.valueOf(rate4);
v5=Double.valueOf(rate5); 
%>
		data.addColumn('string','Topping');
		data.addColumn('number','Slices');
		data.addRows([['<%=d1%>',<%=v1%>],['<%=d2%>',<%=v2%>],['<%=d3%>',<%=v3%>],['<%=d4%>',<%=v4%>],['<%=d5%>',<%=v5%>]]);
		var options = {'title':'Overall Satisfied with IT','width':360,'height':200}; 
		var chart = new google.visualization.PieChart(document.getElementById('chart_div4'));
		chart.draw(data,options); 
	}
</script>
<div id="chart_div4"></div>

</td>
</tr>
</table>


<!--_______________________________________________________________________________________________________-->






 
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
