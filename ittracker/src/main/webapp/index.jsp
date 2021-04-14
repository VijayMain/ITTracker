<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	String uname=null;
	int d_Id=0;
	Connection con = Connection_Utility.getConnection();
	PreparedStatement ps_uname=con.prepareStatement("select * from User_tbl where U_Id="+uid);
	ResultSet rs_uname=ps_uname.executeQuery();
	while(rs_uname.next())
	{
		d_Id = rs_uname.getInt("Dept_Id");
		uname=rs_uname.getString("U_Name");
	}
%>
</head>
<body>
<div id="container">
  <div id="top">
    <h3>IT Tracker</h3>
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
				<li><a href="index_feedbackUser.jsp">Feedback</a></li> 
				<li><a href="Profile.jsp">Profile</a></li> 
				<li><a href="Logout.jsp">Logout <strong style="color: blue; font-size: small;"> <%=uname%></strong></a></li>
			</ul>
  </div>
  <div style="width:100%; height: 100%; padding-left: 5px;padding-bottom: 5px;padding-top: 5px;"> 
  <%
  SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");  
  // Date tdate = new Date(); 
  
  /* Calendar first_Datecal = Calendar.getInstance();   
  first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
  Date dddd = first_Datecal.getTime();   */
   
  Calendar aCalendar = Calendar.getInstance(); 
  aCalendar.set(Calendar.DATE, aCalendar.getActualMaximum(Calendar.DAY_OF_MONTH)); 
  Date tdate = aCalendar.getTime();
  
  aCalendar.add(Calendar.MONTH, -2); 
  aCalendar.set(Calendar.DATE, 1); 
  Date dddd = aCalendar.getTime(); 
   
  java.sql.Date firstDate = new java.sql.Date(dddd.getTime());
  java.sql.Date nowDate = new java.sql.Date(tdate.getTime());

  /* System.out.println("first and last date = " + firstDate + "  =  " + nowDate); */
/*   
String firstDate = sdfFIrstDate.format(dddd);
String nowDate = sdfFIrstDate.format(tdate); 
*/
  
  boolean flag = false;
  
  ps_uname = con.prepareStatement("SELECT * FROM complaintzilla.it_user_feedback where enable=1 and created_by=" + uid + " and  feedback_date between '"+firstDate+"' and '"+nowDate+"'");
  rs_uname = ps_uname.executeQuery();
  while(rs_uname.next()){ 
	flag = true; 
  }
  if(flag==false){
	  response.sendRedirect("AutoReset_Password.jsp?name="+uname+"&uid="+uid);
   /* response.sendRedirect("index_feedbackUser.jsp"); */
  }
  %>
 <img style="height: 330px;width: 99%"  src="images/helpline.png"></img>
  </div>
  <%
}catch(Exception e)
{
	e.printStackTrace();
}
  %>   
  <div id="footer">
    <p class="style2">
    <a href="index.jsp">Home</a> 
    <a href="New_Requisition.jsp">New Requisition</a> 
    <a href="Requisition_Status.jsp">Requisition Status</a> 
    <a href="All_Requisitions.jsp">All Requisitions</a> 
    <a href="Reports_User.jsp">Reports</a> 
    <a href="Logout.jsp">Logout</a><br />
    <a href="http://www.muthagroup.com">Mutha Group, Satara </a></p>
  </div>
</div>
</body>
</html>
