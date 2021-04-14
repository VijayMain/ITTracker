<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="org.jfree.chart.ChartUtilities"%>
<%@page import="java.awt.BasicStroke"%>
<%@page import="org.jfree.chart.ChartFactory"%>
<%@page import="org.jfree.chart.JFreeChart"%>
<%@page import="org.jfree.data.general.DefaultPieDataset"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>IT Tracker Home</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" type="text/css" href="styles.css" /> 
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
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: x-small;"> <%=uname%></strong></a></li>
			</ul>
		</div>
   
  <div style="width:100%; height: 100%; padding-left: 5px;padding-bottom: 5px;padding-top: 5px;">
  
  <%
  int pending = 0,closed = 0,inprogress=0,reopen=0;
  PreparedStatement ps_pend = con.prepareStatement("select count(U_Req_Id) from it_user_requisition where Status='Pending'");
  ResultSet rs_pend = ps_pend.executeQuery();
  while(rs_pend.next()){
	  pending = rs_pend.getInt("count(U_Req_Id)");
  }
  PreparedStatement ps_closed = con.prepareStatement("select count(U_Req_Id) from it_user_requisition where Status='Closed'");
  ResultSet rs_closed = ps_closed.executeQuery();
  while(rs_closed.next()){
	  closed = rs_closed.getInt("count(U_Req_Id)");
  }
  PreparedStatement ps_inprog = con.prepareStatement("select count(U_Req_Id) from it_user_requisition where Status='In Progress'");
  ResultSet rs_prog = ps_inprog.executeQuery();
  while(rs_prog.next()){
	  inprogress = rs_prog.getInt("count(U_Req_Id)");
  }
  PreparedStatement ps_reopen = con.prepareStatement("select count(U_Req_Id) from it_user_requisition where Status='Reopen'");
  ResultSet rs_reopen = ps_reopen.executeQuery();
  while(rs_reopen.next()){
	  reopen = rs_reopen.getInt("count(U_Req_Id)");
  }
  
  OutputStream outputStream = response.getOutputStream(); 
  DefaultPieDataset dataset = new DefaultPieDataset();
  dataset.setValue("Pending Requisitions "+pending, pending); 
  dataset.setValue("Closed Requisitions "+closed, closed); 
  dataset.setValue("In-Progress Requisitions "+inprogress, inprogress); 
  dataset.setValue("Reopen Requisitions "+reopen, reopen); 
  

  boolean legend = true;
  boolean tooltips = true;
  boolean urls = true; 
  JFreeChart chart = ChartFactory.createPieChart("Cars", dataset, legend, tooltips, urls);  
  chart.setTitle("IT Tracker Requisition Status Chart");  
  chart.setBorderStroke(new BasicStroke(5.0f));
  chart.setBorderVisible(true); 

  JFreeChart chart1 = chart;
  int width = 600;
  int height = 500;
  ChartUtilities.writeChartAsPNG(outputStream, chart1, width, height); 
  outputStream.close();
  %> 
  <br />
  </div>
  <%
   	} catch (Exception e) {
   		e.printStackTrace();
   	}
   %>
  <div id="footer">
    <p class="style2"><a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New Requisition</a> <a href="Closed_Requisitions.jsp">Closed Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a> <a href="IT_Reports.jsp">Reports</a> <a href="Software_Access.jsp">Software Access</a> <a href="Logout.jsp">Logout</a><br />
    <a href="http://www.muthagroup.com">Mutha Group, Satara </a></p>
  </div>
</div>
</body>
</html>
