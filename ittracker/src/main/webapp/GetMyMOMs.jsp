<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
	padding: 5px; 
}
</style>
<title>Get My Docs</title>
</head>
<body>
<span id="new_dms">
   <%
   try{
	   Connection con = Connection_Utility.getConnection();
	   int code = Integer.parseInt(request.getParameter("q"));
	   int uid = Integer.parseInt(session.getAttribute("uid").toString());
	   PreparedStatement ps_use = null,ps_des=null;
	   ResultSet rs_use = null,rs_des=null;
	   String cr_use="",cr_note="";
	   PreparedStatement psList = con.prepareStatement("SELECT event_id,DATE_FORMAT(event_date, \"%d/%m/%Y \") as event_date,text,DATE_FORMAT(start_time,'%l:%i %p') as start_time, DATE_FORMAT(end_time,'%l:%i %p') as end_time,event_venue,event_desc,created_by FROM  events_units where enable_id=1 and event_id in(SELECT event_id FROM event_users where u_id="+ uid +")  order by event_date desc");
	   ResultSet rsList = psList.executeQuery();
   %> 
   <div style="float: left;width: 100%"> 
   
   <table class="tftable">
		 <tr>
		 <th>Meeting Date</th>
		 <th>Topic / Agenda</th>
		 <th>Details</th>
		 <th>Start Time</th>
		 <th>End Time</th>
		 <th>Venue</th>
 		<th>Participants</th>
 		<th>Organizer</th>
 		<th>Attached MOM</th> 
 		</tr>
 		<%
 		while(rsList.next()){
 		%>
 		<tr>
 		 <td><%=rsList.getString("event_date") %></td>
		  <td><%=rsList.getString("text") %></td>
		  <td><%=rsList.getString("event_desc") %></td>
		  <td><%=rsList.getString("start_time") %></td>
		  <td><%=rsList.getString("end_time") %></td>
		  <td><%=rsList.getString("event_venue") %></td>
 		<td width="20%">
		  <%
		  ps_des = con.prepareStatement("select * from event_users where event_id="+rsList.getInt("event_id"));
		  rs_des = ps_des.executeQuery();
		  while(rs_des.next()){
		  %>
		  <%=rs_des.getString("user_name") %>,
		  <%
		  }
		  %>
		  </td>
 		<td>
   <%
  ps_des = con.prepareStatement("select * from user_tbl where U_Id="+rsList.getInt("created_by"));
  rs_des = ps_des.executeQuery();
  while(rs_des.next()){
  %>
  <%=rs_des.getString("u_name") %>
  <%
  }
  %>
  </td>
 	<td width="200" style="font-size: 11px;font-weight: bold;">
		<%	 
		ps_des = con.prepareStatement("select * from events_units_mom where enable=1 and event_id="+rsList.getInt("event_id"));
		rs_des = ps_des.executeQuery();
			 while(rs_des.next()){
		%>
		<span><a href="Display_AttachedMOM.jsp?field=<%=rs_des.getInt("code")%>"><%=rs_des.getString("file_name")%>,&nbsp;</a></span>
		<%
			 }
		%>
		</td>
 		</tr>
 		<%
 		}
 		%>
 </table>
   
   </div> 
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
</span>
</body>
</html>