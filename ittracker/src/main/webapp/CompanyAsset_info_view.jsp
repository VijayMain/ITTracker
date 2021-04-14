<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<title>Company Asset Info</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
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
	font-size: 14px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 16px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: center;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 15px; 
	padding: 8px; 
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
</head>
<body>
<%
try {	
	int dept_id=0;
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	String uname=null;
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		uname=rs_uname.getString("U_Name");
		dept_id = rs_uname.getInt("Dept_Id");
	}
%>
<div id="container">
  <div id="top">
    <h3><strong>IT Tracker </strong> </h3> 
  </div>
  <div id="menu">
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New Requisitions</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed Requisition</a></li>
				<li><a href="IT_All_Requisitions.jsp">All Requisitions</a></li>
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li>
				<!-- <li><a href="Asset_info.jsp">Asset Info </a></li> -->
				<li><a href="Logout.jsp">Logout</a></li>
				<li><strong style="color: blue; font-size: x-small;"> <%=uname%></strong></li>
			</ul>
		</div>
 
  <div style="width:100%; height: 100%; padding-left: 5px;padding-bottom: 5px;padding-top: 5px;">
  <table align="center" border="0" class="tftable">
  			<tr>
  				<th align="center" width="5%"><b>Sr. No</b></th>
  				<th align="center"><b>Device Name</b></th>
  				<th align="center"><b>Location</b></th>
  				<th align="center"><b>Company Name</b></th>
  				<th align="center"><b>Model No</b></th>   				
  			</tr> 
  		</table>
  		 <br/>
  
  <div id="footer">
    <p class="style2"><a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New Requisition</a> <a href="Closed_Requisitions.jsp">Closed Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a> <a href="IT_Reports.jsp">Reports</a> <a href="Software_Access.jsp">Software Access</a> <a href="Logout.jsp">Logout</a><br />
    <a href="http://www.muthagroup.com">Mutha Group, Satara </a></p>
  </div>
</div>
  <%
   	} catch (Exception e) {
   		e.printStackTrace();
   	}
   %>
   </div>
</body>
</html>
