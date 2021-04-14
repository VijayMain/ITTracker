<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Asset Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/script.js"></script>  
<script>
$(function() {
	$("#tabs").tabs();
});
</script>
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

</head>
<body>
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
				<li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Graphs.jsp">Graphs</a></li>
				<li><a href="AssetReport.jsp">Asset Report</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: x-small;"> <%=uname%></strong></a></li>
			</ul>
		</div>
   <%
   	} catch (Exception e) {
   		e.printStackTrace();
   	}
   %>
  <div style="width:100%; height: 100%; padding-left: 5px;padding-bottom: 5px;padding-top: 5px;"> 
  <div id="tabs">
				<ul>
					<li><a href="#tabs-1" style="cursor: pointer; font-size: 16px;">Generate Report</a></li>  
					<!-- <li><a href="#tabs-2" style="cursor: pointer; font-size: 16px;">Add Device</a></li>   -->          
				</ul>
				
		<div id="tabs-1" style="height: 100%;width: 18%">
		</br>
		</div>		
	</div>
  </div>
  
  <div id="footer">
    <p class="style2"><a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New Requisition</a> <a href="Closed_Requisitions.jsp">Closed Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a> <a href="IT_Reports.jsp">Reports</a> <a href="Software_Access.jsp">Software Access</a> <a href="Logout.jsp">Logout</a><br />
    <a href="http://www.muthagroup.com">Mutha Group, Satara </a></p>
  </div>
</div>
</body>
</html>
