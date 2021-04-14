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
 
<style type="text/css">
.tftable {
	font-size: 10px;
	color: #333333;
	width: 60%;
	border-width: 1px;
	border-color: #729ea5;
	border-collapse: collapse;
}

.tftable th {
	font-size: 11px;
	background-color: #acc8cc;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5; 
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 10px;
	border-width: 1px;
	padding: 3px;
	border-style: solid;
	border-color: #729ea5;
}
</style>  
<%
	try {
		String fromdate = request.getParameter("from");
		String todate = request.getParameter("to");
		
		Calendar first_Datecal = Calendar.getInstance();   
		first_Datecal.set(Calendar.DAY_OF_MONTH, 1);  
		Date dddd = first_Datecal.getTime();  
		SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");  
		Date tdate = new Date();
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_uname = con.prepareStatement("select U_Name from User_tbl where U_Id=" + uid);
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
<div style="height: 500px;width: 70%;overflow: scroll;padding-left: 20px;">
<table border="1" class="tftable">
  <tr>
    <th colspan="3"><strong>INHOUSE SOFTWARE USAGE FROM <b style="color: green;background-color: yellow;"><%=fromdate %> TO <%=todate %></b></strong></th>
  </tr>
  <tr align="center">
    <th><strong>USER NAME</strong></th>
    <th><strong>COMPANY</strong></th>
    <th><strong>TOTAL</strong></th>
  </tr>
  <!-- IT Tracker start -->
  <tr>
    <td colspan="3" style="background-color:#f9f799 "><strong style="font-size: 12px;">IT Tracker &#8680;</strong></td>
  </tr>
  <%
  PreparedStatement ps_other = null,ps_other1 = null;
  ResultSet rs_other = null,rs_other1 = null;
  String val="",u_Name ="",u_comp="";
  int reqid=0;
  
  PreparedStatement ps_cnt = con.prepareStatement("SELECT distinct(u_id) FROM it_user_requisition where Req_Date between '" + fromdate + "' and '" + todate +"'");
  ResultSet rs_cnt = ps_cnt.executeQuery();
  while(rs_cnt.next()){
  
  ps_other = con.prepareStatement("select count(*) as cnt from it_user_requisition where u_id="+rs_cnt.getInt("u_id")+" and Req_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
	 val = rs_other.getString("cnt"); 
  }
  ps_other = con.prepareStatement("select * from it_user_requisition where u_id="+rs_cnt.getInt("u_id")+" and Req_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){ 
  ps_other1 = con.prepareStatement("select * from user_tbl where u_id="+rs_other.getInt("u_id"));
  rs_other1 = ps_other1.executeQuery();
	while(rs_other1.next()){
		u_Name = rs_other1.getString("U_Name"); 
	}

	 ps_other1 = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_other.getInt("Company_Id"));
	  rs_other1 = ps_other1.executeQuery();
		while(rs_other1.next()){
			u_comp = rs_other1.getString("Company_Name"); 
		}
  }
  if(u_Name!=""){
  %>
  <tr> 
    <td><%-- <%=rs_cnt.getInt("u_id") %>  --%><%=u_Name %></td>
    <td><%=u_comp %></td>
    <td align="right"><%=val %></td>
  </tr>
  <% 
  }
  }
  %>
  <!-- IT Tracker End -->
  <!-- ComplaintZilla start -->
  <tr>
    <td colspan="3" style="background-color:#f9f799 "><strong style="font-size: 12px;">ComplaintZilla &#8680;</strong></td>
  </tr>
  <%
  ps_other = null;ps_other1 = null;
  rs_other = null;rs_other1 = null;
  val="";u_Name ="";u_comp="";
  reqid=0;
  ps_cnt = con.prepareStatement("SELECT distinct(u_id) FROM complaint_tbl where Complaint_Date between '" + fromdate + "' and '" + todate +"'");
  rs_cnt = ps_cnt.executeQuery();
  while(rs_cnt.next()){
  
  ps_other = con.prepareStatement("select count(*) as cnt from complaint_tbl where u_id="+rs_cnt.getInt("u_id")+" and Complaint_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
	 val = rs_other.getString("cnt"); 
  }
  ps_other = con.prepareStatement("select * from complaint_tbl where u_id="+rs_cnt.getInt("u_id")+" and Complaint_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
  ps_other1 = con.prepareStatement("select * from user_tbl where u_id="+rs_other.getInt("u_id"));
  rs_other1 = ps_other1.executeQuery();
	while(rs_other1.next()){
		u_Name = rs_other1.getString("U_Name"); 
	}

	 ps_other1 = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_other.getInt("Company_Id"));
	  rs_other1 = ps_other1.executeQuery();
		while(rs_other1.next()){
			u_comp = rs_other1.getString("Company_Name"); 
		}
  }
  if(u_Name!=""){
  %>
  <tr title="Registered by marketing login"> 
    <td><%-- <%=rs_cnt.getInt("u_id") %>  --%><%=u_Name %></td>
    <td><%=u_comp %></td>
    <td align="right"><%=val %></td>
  </tr> 
  <%
  }
  }
%>

<tr>
<td colspan="3"><hr /></td>  
</tr>

<%
ps_other = null;ps_other1 = null;
rs_other = null;rs_other1 = null;
val="";u_Name ="";u_comp="";
reqid=0;
  ps_cnt = con.prepareStatement("SELECT distinct(u_id) FROM complaint_tbl_action where Action_Date between '" + fromdate + "' and '" + todate +"'");
  rs_cnt = ps_cnt.executeQuery();
  while(rs_cnt.next()){
  
  ps_other = con.prepareStatement("select count(*) as cnt from complaint_tbl_action where u_id="+rs_cnt.getInt("u_id")+" and Action_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
	 val = rs_other.getString("cnt"); 
  }
  ps_other = con.prepareStatement("select * from complaint_tbl_action where u_id="+rs_cnt.getInt("u_id")+" and Action_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
  ps_other1 = con.prepareStatement("select * from user_tbl where u_id="+rs_other.getInt("u_id"));
  rs_other1 = ps_other1.executeQuery();
	while(rs_other1.next()){
		u_Name = rs_other1.getString("U_Name"); 
	}
	  
	 ps_other1 = con.prepareStatement("SELECT * FROM user_tbl_company where company_id =(SELECT company_id FROM complaint_tbl where complaint_no='"+rs_other.getString("Complaint_No")+"')");	 
	 rs_other1 = ps_other1.executeQuery();
	 while(rs_other1.next()){
			u_comp = rs_other1.getString("Company_Name"); 
		}
  }
  if(u_Name!=""){
  %>
  <tr title="Action Taken"> 
    <td><%-- <%=rs_cnt.getInt("u_id") %>  --%><%=u_Name %></td>
    <td><%=u_comp %></td>
    <td align="right"><%=val %></td>
  </tr>
  <%
  }
  }
  %>
  
  <!-- ComplaintZilla End -->
  <!-- ECN start -->

	<tr>
    <td colspan="3" style="background-color:#f9f799 "><strong style="font-size: 12px;">ECN &#8680;</strong></td>
  </tr>
  <%
  ps_other = null;ps_other1 = null;
  rs_other = null;rs_other1 = null;
  val="";u_Name ="";u_comp="";
  reqid=0;
  ps_cnt = con.prepareStatement("SELECT distinct(u_id) FROM cr_tbl where CR_Date between '" + fromdate + "' and '" + todate +"'");
  rs_cnt = ps_cnt.executeQuery();
  while(rs_cnt.next()){
  
  ps_other = con.prepareStatement("select count(*) as cnt from cr_tbl where u_id="+rs_cnt.getInt("u_id")+" and CR_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
	 val = rs_other.getString("cnt"); 
  }
  ps_other = con.prepareStatement("select * from cr_tbl where u_id="+rs_cnt.getInt("u_id")+" and CR_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
  ps_other1 = con.prepareStatement("select * from user_tbl where u_id="+rs_other.getInt("u_id"));
  rs_other1 = ps_other1.executeQuery();
	while(rs_other1.next()){
		u_Name = rs_other1.getString("U_Name"); 
	}

	 ps_other1 = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_other.getInt("Company_Id"));
	  rs_other1 = ps_other1.executeQuery();
		while(rs_other1.next()){
			u_comp = rs_other1.getString("Company_Name"); 
		}
  }
  if(u_Name!=""){
  %>
  <tr title="Registered by marketing login"> 
    <td><%-- <%=rs_cnt.getInt("u_id") %>  --%><%=u_Name %></td>
    <td><%=u_comp %></td>
    <td align="right"><%=val %></td>
  </tr> 
  <%
  }
  } 
  
  
  ps_other = null;ps_other1 = null;
  rs_other = null;rs_other1 = null;
  val="";u_Name ="";u_comp="";
  reqid=0;
  ps_cnt = con.prepareStatement("SELECT distinct(u_id) FROM cr_tbl_action where Action_Date between '" + fromdate + "' and '" + todate +"'");
  rs_cnt = ps_cnt.executeQuery();
  while(rs_cnt.next()){
  
  ps_other = con.prepareStatement("select count(*) as cnt from cr_tbl_action where u_id="+rs_cnt.getInt("u_id")+" and Action_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
	 val = rs_other.getString("cnt"); 
  }
  ps_other = con.prepareStatement("select * from cr_tbl_action where u_id="+rs_cnt.getInt("u_id")+" and Action_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
  ps_other1 = con.prepareStatement("select * from user_tbl where u_id="+rs_other.getInt("u_id"));
  rs_other1 = ps_other1.executeQuery();
	while(rs_other1.next()){
		u_Name = rs_other1.getString("U_Name"); 
	}

	 ps_other1 = con.prepareStatement("select * from user_tbl_company where Company_Id=(SELECT company_id FROM cr_tbl where CR_No="+rs_other.getInt("CR_No")+")");
	  rs_other1 = ps_other1.executeQuery();
		while(rs_other1.next()){
			u_comp = rs_other1.getString("Company_Name"); 
		}
  }
  if(u_Name!=""){
  %>
  <tr title="Registered by marketing login"> 
    <td><%-- <%=rs_cnt.getInt("u_id") %>  --%><%=u_Name %></td>
    <td><%=u_comp %></td>
    <td align="right"><%=val %></td>
  </tr> 
  <%
  }
  }
%>



<!--  -->
 <%
  ps_other = null;ps_other1 = null;
  rs_other = null;rs_other1 = null;
  val="";u_Name ="";u_comp="";
  reqid=0;
  ps_cnt = con.prepareStatement("SELECT distinct(u_id) FROM crc_tbl where CRC_Date between '" + fromdate + "' and '" + todate +"'");
  rs_cnt = ps_cnt.executeQuery();
  while(rs_cnt.next()){
  
  ps_other = con.prepareStatement("select count(*) as cnt from crc_tbl where u_id="+rs_cnt.getInt("u_id")+" and CRC_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
	 val = rs_other.getString("cnt"); 
  }
  ps_other = con.prepareStatement("select * from crc_tbl where u_id="+rs_cnt.getInt("u_id")+" and CRC_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
  ps_other1 = con.prepareStatement("select * from user_tbl where u_id="+rs_other.getInt("u_id"));
  rs_other1 = ps_other1.executeQuery();
	while(rs_other1.next()){
		u_Name = rs_other1.getString("U_Name"); 
	}

	 ps_other1 = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_other.getInt("Company_Id"));
	  rs_other1 = ps_other1.executeQuery();
		while(rs_other1.next()){
			u_comp = rs_other1.getString("Company_Name"); 
		}
  }
  if(u_Name!=""){
  %>
  <tr title="Registered by marketing login"> 
    <td><%-- <%=rs_cnt.getInt("u_id") %>  --%><%=u_Name %></td>
    <td><%=u_comp %></td>
    <td align="right"><%=val %></td>
  </tr> 
  <%
  }
  } 
  
  
  ps_other = null;ps_other1 = null;
  rs_other = null;rs_other1 = null;
  val="";u_Name ="";u_comp="";
  reqid=0;
  ps_cnt = con.prepareStatement("SELECT distinct(u_id) FROM crc_tbl_action where Action_Date between '" + fromdate + "' and '" + todate +"'");
  rs_cnt = ps_cnt.executeQuery();
  while(rs_cnt.next()){
  
  ps_other = con.prepareStatement("select count(*) as cnt from crc_tbl_action where u_id="+rs_cnt.getInt("u_id")+" and Action_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
	 val = rs_other.getString("cnt"); 
  }
  ps_other = con.prepareStatement("select * from crc_tbl_action where u_id="+rs_cnt.getInt("u_id")+" and Action_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
  ps_other1 = con.prepareStatement("select * from user_tbl where u_id="+rs_other.getInt("u_id"));
  rs_other1 = ps_other1.executeQuery();
	while(rs_other1.next()){
		u_Name = rs_other1.getString("U_Name"); 
	}

	 ps_other1 = con.prepareStatement("select * from user_tbl_company where Company_Id=(SELECT company_id FROM crc_tbl where CRC_No="+rs_other.getInt("CRC_No")+")");
	  rs_other1 = ps_other1.executeQuery();
		while(rs_other1.next()){
			u_comp = rs_other1.getString("Company_Name"); 
		}
  }
  if(u_Name!=""){
  %>
  <tr title="Registered by marketing login"> 
    <td><%-- <%=rs_cnt.getInt("u_id") %>  --%><%=u_Name %></td>
    <td><%=u_comp %></td>
    <td align="right"><%=val %></td>
  </tr> 
  <%
  }
  }
%>
  <!-- ECN End -->
  <!-- DVP BOSS start -->
  <tr>
    <td colspan="3" style="background-color:#f9f799 "><strong style="font-size: 12px;">DVP BOSS &#8680;</strong></td>
  </tr>
  <%
  ps_other = null;ps_other1 = null;
  rs_other = null;rs_other1 = null;
  val="";u_Name ="";u_comp="";
  reqid=0;
  ps_cnt = con.prepareStatement("SELECT distinct(Created_By) FROM dev_basicinfo_tbl where Created_Date between '" + fromdate + "' and '" + todate +"'");
  rs_cnt = ps_cnt.executeQuery();
  while(rs_cnt.next()){
  
  ps_other = con.prepareStatement("select count(*) as cnt from dev_basicinfo_tbl where Created_By="+rs_cnt.getInt("Created_By")+" and Created_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
	 val = rs_other.getString("cnt"); 
  }
  ps_other = con.prepareStatement("select * from dev_basicinfo_tbl where Created_By="+rs_cnt.getInt("Created_By")+" and Created_Date between '" + fromdate + "' and '" + todate +"'");
  rs_other = ps_other.executeQuery();
  while(rs_other.next()){
  ps_other1 = con.prepareStatement("select * from user_tbl where u_id="+rs_other.getInt("Created_By"));
  rs_other1 = ps_other1.executeQuery();
	while(rs_other1.next()){
		u_Name = rs_other1.getString("U_Name");
	}

	 ps_other1 = con.prepareStatement("select * from user_tbl_company where Company_Id=(select company_id from user_tbl where u_id="+rs_other.getInt("Created_By")+")");
	  rs_other1 = ps_other1.executeQuery();
		while(rs_other1.next()){
			u_comp = rs_other1.getString("Company_Name"); 
		}
  }
  if(u_Name!=""){
  %>
  <tr title="Registered by marketing login"> 
    <td><%-- <%=rs_cnt.getInt("u_id") %>  --%><%=u_Name %></td>
    <td><%=u_comp %></td>
    <td align="right"><%=val %></td>
  </tr>
  <%
  }
  } 
   %> 
</table>	 
</div>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
		<!-- <div id="footer">
			<p class="style2">
				<a href="IT_index.jsp">Home</a> <a href="IT_New_Requisition.jsp">New
					Requisition</a> <a href="Closed_Requisitions.jsp">Closed
					Requisition</a> <a href="IT_All_Requisitions.jsp">All Requisitions</a>
				<a href="IT_Reports.jsp">Reports</a> <a href="Software_Access.jsp">Software
					Access</a> <a href="Logout.jsp">Logout</a><br /> <a
					href="http://www.muthagroup.com">Mutha Group, Satara </a>
			</p>
		</div> -->
	</div>
</body>
</html>
