<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Feedback</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" type="text/css" href="styles.css" />
<script type="text/javascript">
function validateForm() {
	var internetandnetwork1 = document.getElementById("internetandnetwork1");
	var internetandnetwork2= document.getElementById("internetandnetwork2");
	var internetandnetwork3 = document.getElementById("internetandnetwork3");
	var internetandnetwork4 = document.getElementById("internetandnetwork4");
	var internetandnetwork5 = document.getElementById("internetandnetwork5");
		
	var pclaptop1 = document.getElementById("pclaptop1");
	var pclaptop2 = document.getElementById("pclaptop2");
	var pclaptop3 = document.getElementById("pclaptop3");
	var pclaptop4 = document.getElementById("pclaptop4");
	var pclaptop5 = document.getElementById("pclaptop5");
	
	var inhouse1 = document.getElementById("inhouse1"); 
	var inhouse2 = document.getElementById("inhouse2"); 
	var inhouse3 = document.getElementById("inhouse3"); 
	var inhouse4 = document.getElementById("inhouse4"); 
	var inhouse5 = document.getElementById("inhouse5"); 
		
	var erp1 = document.getElementById("erp1");
	var erp2 = document.getElementById("erp2");
	var erp3 = document.getElementById("erp3");
	var erp4 = document.getElementById("erp4");
	var erp5 = document.getElementById("erp5");
	
	var satisfiedit1 = document.getElementById("satisfiedit1");
	var satisfiedit2 = document.getElementById("satisfiedit2");
	var satisfiedit3 = document.getElementById("satisfiedit3");
	var satisfiedit4 = document.getElementById("satisfiedit4");
	var satisfiedit5 = document.getElementById("satisfiedit5");
	
	var comment = document.getElementById("comment");  
	
	  
	
	
		if (internetandnetwork1.checked==false && internetandnetwork2.checked==false && internetandnetwork3.checked==false && internetandnetwork4.checked==false && internetandnetwork5.checked==false) {
			alert("How do you rate IT Supports for internet and network speed...?");
			document.getElementById("save").disabled = false;
			return false;
		}
		if (pclaptop1.checked==false && pclaptop2.checked==false && pclaptop3.checked==false && pclaptop4.checked==false && pclaptop5.checked==false) {
			alert("How well do our PC,Laptop,printer meets your needs....?");
			document.getElementById("save").disabled = false;
			return false;
		}
		if (inhouse1.checked==false && inhouse2.checked==false && inhouse3.checked==false && inhouse4.checked==false && inhouse5.checked==false) {
			alert("In-House Softwares (IT Tracker,ComplaintZilla,ECN,DVPBoss,Mutha Planner etc.)...?");
			document.getElementById("save").disabled = false;
			return false;
		}
		if (erp1.checked==false && erp2.checked==false && erp3.checked==false && erp4.checked==false && erp5.checked==false) {
			alert("How well do our ERP meets your needs...?");
			document.getElementById("save").disabled = false;
			return false;
		}
		if (satisfiedit1.checked==false && satisfiedit2.checked==false && satisfiedit3.checked==false && satisfiedit4.checked==false && satisfiedit5.checked==false) {
			alert("Overall Satisfied with IT Team...?");
			document.getElementById("save").disabled = false;
			return false;
		}
		if (comment.value=="" || comment.value=="null" || comment.value=="0" || comment.value=="-") {
			alert("If You Have any questions,suggesions,comments let us know....!!!");
			document.getElementById("save").disabled = false;
			return false;
		}
		document.getElementById("save").disabled = true;
}
</script>
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
    <h3>User Satisfaction Survey Request<!-- <br/> Mutha Group IT --></h3>  <img src="images/alert.gif" />
  </div>
  <div id="menu">
   <ul>
		<li><a href="index.jsp">Home</a></li> 
				<li><a href="Logout.jsp">Logout <strong style="color: blue; font-size: small;"> <%=uname%></strong></a></li>
	</ul>
  </div>
  <div style="width:45%; height: 100%; float: left;">
  <form action="Feedback_controller" method="post"  onSubmit="return validateForm();">
  
  <input type="hidden" name="uerrname" id="uerrname" value="<%=uname%>"/>
  <table width="100%" border="0" style="background-color: white;font-family:sans-serif;">
  <tr>
    <td style="background-color: white;
    border: none;
    color: white;
    padding: 2px 25px; 
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer; ">
    <strong style="font-weight: bold;color: red;">1 = Poor, </strong>
    <strong style="font-weight: bold;color: #ff7d7d;">2 = Below Average,</strong> 
    <strong style="font-weight: bold;color: #bcbc12;">3 = Average,</strong> 
    <strong style="font-weight: bold;color: #40ff40;">4 = Good,</strong>  
    <strong style="font-weight: bold;color: #008000;">5 = Excellent</strong>
    </td>
  </tr> 
  <tr>
    <td style="background-color: #3599ea; 
    border: none;
    color: white;
    padding: 15px 32px; 
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer; " title="1=Poor, 2=Below Average, 3=Average, 4=Good, 5=Excellent"><strong>1. How do you rate IT Supports for internet and network speed...?</strong><br /> 
    	 <input type="radio" name="internetandnetwork" id="internetandnetwork1" value="1"/>1
        &nbsp;&nbsp;<input type="radio" name="internetandnetwork" id="internetandnetwork2" value="2"/> 2 
        &nbsp;&nbsp;<input type="radio" name="internetandnetwork" id="internetandnetwork3" value="3"/> 3
        &nbsp;&nbsp;<input type="radio" name="internetandnetwork" id="internetandnetwork4" value="4"/> 4
        &nbsp;&nbsp;<input type="radio" name="internetandnetwork" id="internetandnetwork5" value="5"/> 5 
        </td>
  </tr>
  <tr>
    <td style="background-color: #3599ea; 
    border: none;
    color: white;
    padding: 15px 32px;  
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer; " title="1=Poor, 2=Below Average, 3=Average, 4=Good, 5=Excellent"><strong>2. How well do our PC,Laptop,printer meets your needs...?</strong><br /> 
    	<input type="radio" name="pclaptop" id="pclaptop1" value="1"/> 1
        &nbsp;&nbsp;<input type="radio" name="pclaptop" id="pclaptop2" value="2"/> 2 
        &nbsp;&nbsp;<input type="radio" name="pclaptop" id="pclaptop3" value="3"/> 3
        &nbsp;&nbsp;<input type="radio" name="pclaptop" id="pclaptop4" value="4"/> 4
    &nbsp;&nbsp;<input type="radio" name="pclaptop" id="pclaptop5" value="5"/> 5 </td>
  </tr>
  <tr>
    <td style="background-color: #3599ea; 
    border: none;
    color: white;
    padding: 15px 32px; 
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer; " title="1=Poor, 2=Below Average, 3=Average, 4=Good, 5=Excellent"><strong>3. How well do our In-House Softwares (IT-Tracker,ComplaintZilla etc.) meets your needs...?</strong><br /> 
     <input type="radio" name="inhouse" id="inhouse1" value="1"/> 1
        &nbsp;&nbsp;<input type="radio" name="inhouse" id="inhouse2" value="2"/> 2 
        &nbsp;&nbsp;<input type="radio" name="inhouse" id="inhouse3" value="3"/> 3
       &nbsp;&nbsp; <input type="radio" name="inhouse" id="inhouse4" value="4"/> 4
   &nbsp;&nbsp; <input type="radio" name="inhouse" id="inhouse5" value="5"/> 5 </td>
  </tr>
  <tr>
    <td style="background-color: #3599ea; 
    border: none;
    color: white;
    padding: 15px 32px; 
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer; " title="1=Poor, 2=Below Average, 3=Average, 4=Good, 5=Excellent"><strong>4. How well do our SAP meets your needs...?</strong><br /> 
     <input type="radio" name="erp" id="erp1" value="1"/> 1
       &nbsp;&nbsp; <input type="radio" name="erp" id="erp2" value="2"/> 2 
       &nbsp;&nbsp; <input type="radio" name="erp" id="erp3" value="3"/> 3
       &nbsp;&nbsp; <input type="radio" name="erp" id="erp4" value="4"/> 4
   &nbsp;&nbsp; <input type="radio" name="erp" id="erp5" value="5"/> 5 </td>
  </tr>
  <tr>
    <td style="background-color: #3599ea; 
    border: none;
    color: white;
    padding: 15px 32px; 
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer; " title="1=Poor, 2=Below Average, 3=Average, 4=Good, 5=Excellent"><strong>5. Overall Satisfied with IT Team...?</strong><br /> 
    <input type="radio" name="satisfiedit" id="satisfiedit1" value="1"/> 1
       &nbsp;&nbsp; <input type="radio" name="satisfiedit" id="satisfiedit2" value="2"/> 2 
       &nbsp;&nbsp; <input type="radio" name="satisfiedit" id="satisfiedit3" value="3"/> 3
       &nbsp;&nbsp; <input type="radio" name="satisfiedit" id="satisfiedit4" value="4"/> 4
    &nbsp;&nbsp;<input type="radio" name="satisfiedit" id="satisfiedit5" value="5"/> 5 </td>
  </tr>
  <tr>
   <td style="background-color: #3599ea; 
    border: none;
    color: white;
    padding: 15px 32px; 
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    cursor: pointer; " title="Kindly share your suggestions & comments..."><strong>6. If You Have any questions,suggesions,comments let us know.</strong><br />
  <textarea rows="4" cols="60" name="comment" id="comment"></textarea>
  </tr> 
  <tr>
    <td style="font-size: 14px; padding: 12px; "><input type="submit" name="save" id="save" title="Thank You Very Much" value="Send Feedback" style="border-radius: 50%;background-color: #4CAF50; 
    border: none;
    color: white;
    padding: 15px 32px; 
    text-decoration: none;
    display: inline-block;
    font-size: 14px;
    margin: 4px 2px;
    font-weight:bold;
    cursor: pointer;"></td>
  </tr>
  
</table>
</form>
  </div>
  
  <div style="width:54.8%; height: 100%; float: right;">
<table style="width: 100%;" align="center" class="tftable"> 
<tr>
<td colspan="8" style="background-color: #3599ea;color: white;font-weight: bold;" align="center">Feedback History</td>
</tr>
		<tr style='font-size: 12px;font-weight:bold; background-color: #3599ea;color: white; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>
			<th height='25'>Network</th>
			<th>Device Satisfaction</th>
			<th>In-House Softwares</th>
			<th>SAP</th>
			<th>Overall Satisfied</th>
			<th>Comments</th>  
			<th>Date (yyyy-mm-dd)</th>
		</tr> 
		<%
		 ps_uname = con.prepareStatement("SELECT * FROM complaintzilla.it_user_feedback where enable=1 and created_by=" + uid +" order by feedback_date desc");
		  rs_uname = ps_uname.executeQuery();
		  while(rs_uname.next()){
		%>
		<tr style="background-color: white;font-size: 12px;">
			<td align='right'><%=rs_uname.getInt("internet_speed") %></td>
			<td align='right'><%=rs_uname.getInt("pc_laptop") %></td>
			<td align='right'><%=rs_uname.getInt("inhouse") %></td>
			<td align='right'><%=rs_uname.getInt("erp") %></td>
			<td align='right'><%=rs_uname.getInt("it_satisfaction") %></td>
			<td><%=rs_uname.getString("comments") %></td> 
			<td><%=rs_uname.getString("feedback_date").substring(0,10) %></td>
		</tr> 
		<%
		  }
		%>
</table>
  </div>
  <%
}catch(Exception e)
{
	e.printStackTrace();
}
  %>   
  <!-- <div id="footer">
    <p class="style2"><a href="index.jsp">Home</a> <a href="New_Requisition.jsp">New Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a> <a href="All_Requisitions.jsp">All Requisitions</a> <a href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a><br />
    <a href="http://www.muthagroup.com">Mutha Group, Satara </a></p>
  </div> -->
</div>
</body>
</html>
