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
<title>DMS</title>
<link rel="stylesheet" type="text/css" href="styles.css" />
<script type="text/javascript" src="js/tabledeleterow.js"></script>
<script language="javascript" type="text/javascript" src="datetimepicker.js"></script>
<link rel="stylesheet" href="js/jquery-ui.css"/>
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script type="text/javascript">
$(document).ready(
		  function () {
		    $( "#dated" ).datepicker({
		      changeMonth: true,
		      changeYear: true
		    });
		  }
		);
</script>
<script type="text/javascript">
function validateNewDMSFile(){
	var note = document.getElementById("note");
	var srno = document.getElementById("srno"); 
	if(srno.value==""){
		alert("Document !...Click to Add Files.");
		return false;
	}
	if(note.value==""){
		alert("Note ???");
		return false;
	}
}
	function validateForm() {
		/* var folder = document.getElementById("folder"); */
		var subject = document.getElementById("subject");
		var srno = document.getElementById("srno"); 
		var avail = document.getElementById("avail");
		var subject = document.getElementById("subject");
		  var share_yes = document.getElementById("share_yes").checked;
	      var share_no = document.getElementById("share_no").checked; 
	      
		
		if(avail.value=="1"){
			alert("Header / Folder Name is invalid  or already available !!!");	
			document.getElementById("submit").disabled = false;
			return false;
		}
		if(subject.value==""){
			alert("Subject / File Name ?");
			document.getElementById("submit").disabled = false;
			return false;
		}
		if(share_yes==false && share_no==false){
			alert("Share To Other Users ?");	
			document.getElementById("submit").disabled = false;
			return false;
		}  
		
		if(share_yes==true){
	      var x=document.getElementById("company");
	      var y=document.getElementById("department");
	      var cntcomp="",cntdept="";
	      
	      for (var i = 0; i < x.options.length; i++) {
	         if(x.options[i].selected ==true){
	        	 cntcomp = x.options[i].value;
	          }
	      } 
	      for (var i = 0; i < y.options.length; i++) {
		      if(y.options[i].selected ==true){
		         cntdept = y.options[i].value;
		      }
		  }
	      if(cntcomp=="" && cntdept==""){
	    	  alert("Please Provide Shared Company / Departments !!!");
	    	  return false;
	      }
	      document.getElementById("submit").disabled = false;
		}
		if(srno.value==""){
			alert("Document !...Click to Add Files.");
			document.getElementById("submit").disabled = false;
			return false;
		}
		document.getElementById("submit").disabled = true;
	}
	
	function validateApproval(str,str1,str2,str3) {
		document.getElementById("hid_code").value = str;
		document.getElementById("folder_code").value = str1;
		document.getElementById("tran_no").value = str2;
		document.getElementById("hid_tranrel").value = str3;
		document.getElementById("hid_aprl").value = '1';
		document.getElementById("approve").disabled = true;
		document.getElementById("decline").disabled = true; 		
		return true;   
	}
	
	function validateDeclined(str,str1,str2,str3) {
		document.getElementById("hid_code").value = str;
		document.getElementById("folder_code").value = str1;
		document.getElementById("tran_no").value = str2;
		document.getElementById("hid_tranrel").value = str3;
		document.getElementById("hid_aprl").value = '0';
		document.getElementById("approve").disabled = true;
		document.getElementById("decline").disabled = true; 		
		return true;
	}
	
</script>
<style>
button.accordion {
    background-color: #006999;
    color: white;
    cursor: pointer;
    padding: 5px; 
    width: 100%;
    border: thin; 
    outline: black;
    font-size: 12.5px;
    transition: 0.4s;
}

button.accordion.active, button.accordion:hover {
    background-color: #ddd;
    color: black;
}

div.panel {
font-size: 12.5px;
    padding: 0 1px;
    background-color: white;
    color : #050aad;
    max-height: 0;
    overflow: hidden;
    transition: 0.6s ease-in-out;
    opacity: 0;
}

div.panel.show {
    opacity: 1;
    max-height: 500px;  
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
	padding: 4px; 
	text-align: center;
}

.tftable tr {
	background-color: white; 
}

.tftable td {
	font-size: 12px; 
	padding: 2px; 
}
</style>
<script type="text/javascript">
function validatenumerics(key) {
//getting key code of pressed key
var keycode = (key.which) ? key.which : key.keyCode;
//comparing pressed keycodes 
if (keycode > 31 && (keycode < 48 || keycode > 57) && keycode != 46) {
    alert("Only allow numeric Data entry");
    return false;
}else
{
	return true;
};
}
</script>
<script language="javascript" type="text/javascript">
	function showState(str) {
		var xmlhttp;

		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var a = null;
				document.getElementById("new_dms").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Add_NewDoc.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
		
	function GetMyDocs(str,str1) {
		var xmlhttp;

		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var a = null;
				document.getElementById("new_dms").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "GetMyDocs.jsp?q=" + str + "&r=" + str1, true);
		xmlhttp.send();
	};
	
	function GetMyMOMs(str) {
		var xmlhttp;

		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var a = null;
				document.getElementById("new_dms").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "GetMyMOMs.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
	function GetSharedDocs(str) {
		var xmlhttp;

		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var a = null;
				document.getElementById("new_dms").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Shared_doc.jsp?q=" + str, true);
		xmlhttp.send();
	};
	
	
	function AddNewDocs(str,str1) {
		var xmlhttp;

		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				var a = null;
				document.getElementById("new_dms").innerHTML = xmlhttp.responseText;
			}
		};
		xmlhttp.open("POST", "Add_DMSNewFile.jsp?q=" + str + "&r=" + str1, true);
		xmlhttp.send();
	};
	
	
	function get_allAvailFolders(name) {
		if(name!=""){
			document.getElementById("subject").readOnly = false;
		var xmlhttp;
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest(); 
		} else {
			// code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP"); 
		}
		xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				document.getElementById("availFolder").innerHTML = xmlhttp.responseText; 
			}
		};
		xmlhttp.open("POST", "All_AvailableFolder.jsp?q=" + name , true);  
		xmlhttp.send();
		}else{
			//alert("Test = " + document.getElementById("avail").value);
			document.getElementById("subject").readOnly = true; 
			document.getElementById("availFolder").innerHTML = "";
			document.getElementById("subject").value = "";
			document.getElementById("avail").value = "0";
			
		}
	}
</script>
<script type="text/javascript">  
	// Form validation code will come here.
	function validateDEVDMSFile() {		                    

	var carriedout = document.getElementById("carriedout"); 
	var videbill = document.getElementById("videbill"); 
	var demo4 = document.getElementById("demo4"); 
	var forrs = document.getElementById("forrs"); 
	var purorder = document.getElementById("purorder"); 
	var filename = document.getElementById("filename");
	var remark = document.getElementById("remark");
	
		if (carriedout.value=="0" || carriedout.value==null || carriedout.value=="" || carriedout.value=="null") {
			alert("Work carried out by ?");
			document.getElementById("submit").disabled = false;
			return false;
		}
		if (videbill.value=="0" || videbill.value==null || videbill.value=="" || videbill.value=="null") {
			alert("Vide Bill No ?"); 
			document.getElementById("submit").disabled = false;
			return false;
		}
		if (demo4.value=="0" || demo4.value==null || demo4.value=="" || demo4.value=="null") {
			alert("Dated ?");
			document.getElementById("submit").disabled = false;
			return false;
		}
		if (forrs.value=="0" || forrs.value==null || forrs.value=="" || forrs.value=="null") {
			alert("For Rs. ?"); 
			document.getElementById("submit").disabled = false;
			return false;
		}
		if (purorder.value=="0" || purorder.value==null || purorder.value=="" || purorder.value=="null") {
			alert("Purchase/work Order No ?"); 
			document.getElementById("submit").disabled = false;
			return false;
		}
		if (filename.value=="0" || filename.value==null || filename.value=="" || filename.value=="null") {
			alert("Attach file missing ?"); 
			document.getElementById("submit").disabled = false;
			return false;
		}
		if (remark.value=="0" || remark.value==null || remark.value=="" || remark.value=="null") {
			alert("Remark ?"); 
			document.getElementById("submit").disabled = false;
			return false;
		}
		 
		document.getElementById("submit").disabled = true; 
	} 
</script>
<%
	try {
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		String uname = null;
		int d_Id=0,comp_id=0;
 		Connection con = Connection_Utility.getConnection();
 		
 		PreparedStatement ps_use = null;
 		ResultSet rs_use = null;
 		String cr_use="";
 		
		PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			d_Id = rs_uname.getInt("Dept_Id");
			comp_id = rs_uname.getInt("Company_Id");
			uname = rs_uname.getString("U_Name");
		}
%>
</head>
<body>
<%
if(request.getParameter("msg")!=null){ 
%>
<script type="text/javascript">
alert("<%=request.getParameter("msg") %>");
</script>
<%
	}
%>
<div id="container">
	<div id="top" style="width: 120%">
			<h3>Document Management System (DMS)</h3>
	</div>
	<div id="menu" style="width: 120%">
			<%
			if(d_Id!=18){
			%>
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
			<%
			}else{
			%>
			<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li> 
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="MISAccess.jsp">MIS Access</a></li>
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="Profile.jsp">My Profile</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: 8px;"> <%=uname%></strong></a></li>
			</ul>
			<%
			}
			%>
</div>
<div style="height: 530px;width:120%; overflow: scroll;">
<div style="float:left;width:15%;text-align: left; height: 500px;background-color: #006999;overflow: scroll;">    	 
<button class="accordion" style="font-weight: bold;padding-left: 12px;text-align: left;">Add New Document</button> 
<div class="panel">
  <p style="padding-left: 15px;">
 	<a onclick="showState(this.value)" style="cursor: pointer;"><b>Add New Document</b></a>
  </p>
</div>
<button class="accordion" style="font-weight: bold;padding-left: 12px;text-align: left;">Search Document</button> 
<div class="panel">
  <p style="padding-left: 15px;">
 	<a href="Search_DMSDocs.jsp" style="cursor: pointer;"><b>Search</b></a>
  </p>
</div>
<button class="accordion" style="font-weight: bold;padding-left: 12px;text-align: left;">My Documents</button>
<div class="panel">
 <%
 PreparedStatement ps = con.prepareStatement("select * from mst_dmsfolder where USER="+uid);
 ResultSet rs = ps.executeQuery();
 while(rs.next()){
 %>
 <p style="padding-left: 15px;">
 	<a onclick="GetMyDocs('<%=rs.getInt("CODE") %>','<%=rs.getString("FOLDER") %>')" style="cursor: pointer;"><b><%=rs.getString("FOLDER") %></b></a>
 	</p>
 <%
 }
 %>
</div>

<button class="accordion" style="font-weight: bold;padding-left: 12px;text-align: left;">Shared Documents</button>
<div class="panel">
 <%
 ps = con.prepareStatement("SELECT * FROM mst_dmsfolder where code in (SELECT dms_code FROM mst_comp where company in("+comp_id+",0)) and code in(SELECT dms_code FROM mst_dept where dept in("+d_Id+",0)) and code in(SELECT dms_code FROM mst_dmsuser where USER in('"+uname+"','0')) and share_flag=1 and user!="+uid);
 rs = ps.executeQuery();
 while(rs.next()){
	 ps_use = con.prepareStatement("select * from user_tbl where u_id="+rs.getInt("user"));
	 rs_use = ps_use.executeQuery();
	 while(rs_use.next()){
		 cr_use = rs_use.getString("u_name");
	 }
 %>
 <p style="padding-left: 15px;">
 	<a onclick="GetMyDocs('<%=rs.getInt("CODE") %>','<%=rs.getString("FOLDER") %>')" style="cursor: pointer;" title="Created By <%=cr_use%>"><b><%=rs.getString("FOLDER") %></b></a>
 	</p>
 <%
 }
 %>
</div>


<button class="accordion" style="font-weight: bold;padding-left: 12px;text-align: left;">MOM Data</button>
<div class="panel">
 <p style="padding-left: 15px;">
 <a onclick="GetMyMOMs('<%=uid %>')" style="cursor: pointer;"><b>My MOM Data</b></a>
 </p>
</div>

 
<script>
var acc = document.getElementsByClassName("accordion");
var i;
for (i = 0; i < acc.length; i++) {
    acc[i].onclick = function(){
        this.classList.toggle("active");
        this.nextElementSibling.classList.toggle("show"); 
  }
}
</script>
</div>
<div style="float:right; width:84.9%">
	<span id="new_dms">
	<% 
	int code = Integer.parseInt(request.getParameter("q"));
	String folder ="";
	 ps = con.prepareStatement("select * from mst_dmsfolder where CODE="+code);
	 rs = ps.executeQuery();
	 while(rs.next()){
		 folder = rs.getString("FOLDER");
	 } 
	   // String folder = request.getParameter("r");
	   ps_use = null;
	   rs_use = null;
	   String cr_note="";
	   cr_use="";
	   PreparedStatement ps_data = null,ps_chk=null;
		ResultSet rs_data = null,rs_chk=null;
		int my_depid=0; 
		ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
		rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			my_depid = rs_uname.getInt("Dept_Id"); 
		}
		
		String report = "DMS_Approved";
		ArrayList to_emails = new ArrayList();
		Connection conLocal = Connection_Utility.getLocalDatabase();
		PreparedStatement ps_rec = conLocal.prepareStatement("select distinct(validlimit) from pending_approvee where type='to' and report='"+ report + "'");
		ResultSet rs_rec = ps_rec.executeQuery();
		while (rs_rec.next()) {
			to_emails.add(rs_rec.getString("validlimit"));
		}
		
	   ArrayList dept_check = new ArrayList();
		  ps_chk = con.prepareStatement("SELECT dept FROM mst_dept where dms_code="+code);
		  rs_chk = ps_chk.executeQuery();
		  while(rs_chk.next()){
			 dept_check.add(rs_chk.getInt("DEPT"));
		  }
		  int ins_check=0;
		  ps_chk = con.prepareStatement("SELECT dept_id FROM user_tbl where u_id in(SELECT USER FROM mst_dmsfolder where code="+code+")");
		  rs_chk = ps_chk.executeQuery();
		  while(rs_chk.next()){
			ins_check = rs_chk.getInt("dept_id");
		  }
	   // System.out.println("dept id = " + ins_check);
   %>
   <div style="float: left;width: 75%;height: 500px;overflow: scroll;">
			<table style="width: 100%;" class="tftable">
				<%-- <tr>
					<th colspan="6" align="center"><%=folder %></th>
				</tr> --%>
				<tr style="background-color:#3d6f74;color: white;"> 
					<td align="center" height="25"><strong>Folder Name</strong></td>
					<td align="center"><strong>Shared Rights</strong></td>
			        <td width="12%" align="center"><strong>Companies</strong></td>
				    <td width="15%" align="center"><strong>Departments</strong></td>
				    <!-- <td align="center"><strong>Document</strong></td>
				    <td align="center"><strong>Note</strong></td> -->
				    <td align="center" width="12%"><strong>Add More Files</strong></td>
				</tr>
				<%
				int sn=1,flagchk=0;
				String rights="",folderName="",subjectName="";
				ps  = con.prepareStatement("select * from mst_dmsfolder where CODE=" + code);
				rs = ps.executeQuery();
				while(rs.next()){
					folderName = rs.getString("FOLDER");
					if(rs.getInt("SHARED_ACCESS")==1){
					rights = "Full";
					}else{
					rights = "Read Only";
					}
					if(rs.getInt("SHARE_FLAG")==0){
						rights = "Sharing Off";
					}
					subjectName = rs.getString("SUBJECT");
				%>
				<tr> 
				  <td align="center"><%-- <%=rs.getString("SUBJECT") %> --%><strong><%=folder %></strong></td>
				  <td align="center"><%=rights %></td> 
				 <!--
					---------------------------------------------- Company ---------------------------------------------   
				 -->  
				  <td align="center">
				  <%
				  ps_chk = con.prepareStatement("select * from mst_comp where DMS_CODE="+code);
				  rs_chk = ps_chk.executeQuery();
				  while(rs_chk.next()){
					  if(rs_chk.getInt("COMPANY")==0){
						  flagchk = 1;
					  }
				  }
 				  if(flagchk==0){
				  ps_data = con.prepareStatement("SELECT company_name FROM complaintzilla.user_tbl_company where company_id in (SELECT company FROM complaintzilla.mst_comp where dms_code="+code+")");
				  rs_data = ps_data.executeQuery(); 
				  while(rs_data.next()){
				  %>
				  &nbsp;<%= rs_data.getString("company_name")%><b style="background-color: #eaf073">&nbsp;,&nbsp;</b>
				  <%
				  }
 				  }else{
 				  %>
 				  ALL
 				  <%	  
 				  }
 				  flagchk = 0;
				  %>
				  </td> 
				  <!--
					---------------------------------------------- Department ---------------------------------------------   
				  -->  
				  <td align="center">
				  <%
				  ps_chk = con.prepareStatement("select * from mst_comp where DMS_CODE="+code);
				  rs_chk = ps_chk.executeQuery();
				  while(rs_chk.next()){
					  if(rs_chk.getInt("COMPANY")==0){
						  flagchk = 1;
					  }
				  }
 				  if(flagchk==0){
				  ps_data = con.prepareStatement("SELECT department FROM complaintzilla.user_tbl_dept where dept_id in (SELECT dept FROM complaintzilla.mst_dept where dms_code="+code+")");
				  rs_data = ps_data.executeQuery(); 
				  while(rs_data.next()){
				  %>
				  &nbsp;<%= rs_data.getString("department")%><b style="background-color: #eaf073">&nbsp;,&nbsp;</b>
				  <%
				  }
 				  }else{
 				  %>
 				  ALL
 				  <%  
 				  }
 				  flagchk = 0;
				  %>
				  </td>
				  <td align="center" style="width: 2%;">
				  <%
				  if((rs.getInt("SHARE_FLAG")==1 && rs.getInt("SHARED_ACCESS")==1) || rs.getInt("USER")==uid){
				  %>
				  <img src="images/Add.png" style="height: 20px;cursor: pointer;width: 28px;" title="Add More Files" onClick="AddNewDocs('<%=rs.getInt("CODE") %>','<%=rs.getString("FOLDER") %>')">
				  <%
				  }else{
				  %>
				  <b title="view only" style="background-color:#e1e38a;cursor: pointer;">---</b>
				  <%
				  }
				  %>	
					<!-- <img src="images/edit.png" style="height: 17px;cursor: pointer;" title="Edit"> 
					<img src="images/delete.png" style="height: 17px;cursor: pointer;" title="Delete">  -->
				  </td>
			  </tr>
			  <%
			  sn++;
   				}
				sn=1;
			  %>
			</table> 
			<form action="Send_DMSApproval" method="post">
            <table style="width: 100%;" class="tftable">
				<tr style="background-color:#3d6f74;color: white;height: 23px;">
					<td align="center"><strong>Title</strong></td> 
					<td align="center"><strong>Document</strong></td>
				    <td align="center"><strong>Note</strong></td>
				  <%
				  if(dept_check.contains(7) && ins_check==7){
				  %>
				  <td align="center"><strong>Carried By</strong></td>
				  <td align="center"><strong>Bill No</strong></td>
				  <td align="center"><strong>Dated</strong></td>
				  <td align="center"><strong>For Rs</strong></td>
				  <td align="center"><strong>Pur Order</strong></td>
				  <td align="center"><strong>Creator</strong></td>
				   <td align="center"><strong>Approval Status</strong></td> 
				   <%
				  }
				   %>
			    </tr>
				<% 
				String carried="",billno="",dated="",forrs="",purorder="",creator="",approval="",approved_by="",dec_note="",doc_ref="",subject_title=subjectName;
				  int tran_relno=0;
				  ps_data = con.prepareStatement("SELECT * FROM tarn_dms where tran_no="+code +" order by approved");
				  rs_data = ps_data.executeQuery();
				  while(rs_data.next()){
				%>
				<tr>
				<%
				subject_title = rs_data.getString("subject_title"); 
				
				  if(subject_title==null){
					subject_title=subjectName;
				  }
				%>
				<td><%=subject_title %></td>
				<%
				subject_title=subjectName; 
				%>
			    <td align="left"   style="font-size:11px;word-wrap: break-word;max-width:100px;">
				  <%
					  ps_use = con.prepareStatement("select * from user_tbl where u_id="+rs_data.getInt("user"));
					  rs_use = ps_use.executeQuery();
					  while(rs_use.next()){
							 cr_use = rs_use.getString("u_name");
					  }
					  cr_note = rs_data.getString("note");
				%>
				<a href="Display_Doc.jsp?field=<%=rs_data.getInt("CODE")%>" style="color: #3a22c8;"  title="Created By <%=cr_use%>"><b><%=rs_data.getString("File_Name")%></b></a>
				</td>
			    <td align="left" style="font-size: 11px;"><%=cr_note %></td>
			     <%
				  if(dept_check.contains(7) && ins_check==7){
					  ps_use = con.prepareStatement("select code,decline_note,decline_filename,carried_out,bill_no,forrs,pur_order,creator,approval,approval_by,code,DATE_FORMAT(dated, \"%d/%m/%Y \") as dated  from tarn_dms_devrel where tran_code="+rs_data.getInt("CODE"));
					  rs_use = ps_use.executeQuery();
						while(rs_use.next()){
							 carried=rs_use.getString("carried_out");
							 billno=rs_use.getString("bill_no");
							 dated=rs_use.getString("dated");
							 forrs=rs_use.getString("forrs");
							 purorder=rs_use.getString("pur_order");
							 creator=rs_use.getString("creator");
							 approval=rs_use.getString("approval");
							 approved_by=rs_use.getString("approval_by");
							 tran_relno=rs_use.getInt("code");
							 dec_note = rs_use.getString("decline_note");
							 doc_ref = rs_use.getString("decline_filename");
						}
				  %>
				  <td align="left" style="font-size: 11px;"><%=carried %></td>
				  <td align="left" style="font-size: 11px;"><%=billno %></td>
				  <td align="left" style="font-size: 11px;"><%=dated %></td>
				  <td align="left" style="font-size: 11px;"><%=forrs %></td>
				  <td align="left" style="font-size: 11px;"><%=purorder %></td>
				  <td align="left" style="font-size: 11px;"><%=creator %></td>
			       <td align="left" width="150" style="font-size: 11px;">
			       <input type="hidden" name="folder_code" id="folder_code">
				   <input type="hidden" name="tran_no" id="tran_no">
				   <input type="hidden" name="hid_code" id="hid_code">
				   <input type="hidden" name="hid_tranrel" id="hid_tranrel">
				   <input type="hidden" name="hid_aprl" id="hid_aprl">
				   <%
				   if(my_depid==7 && to_emails.contains(String.valueOf(uid))){
					   if(approval==null){
				   %>
				   <input type="submit" name="approve" value="Approved" id="approve" onclick="validateApproval(this.value,'<%=code%>','<%=rs_data.getInt("CODE")%>','<%=tran_relno%>')" style="font-weight: bold;height: 20px;font-size: 11px;background-color: green;color: white;">
			       <input type="submit" name="decline" value="Declined"  id="decline" onclick="validateDeclined(this.value,'<%=code%>','<%=rs_data.getInt("CODE")%>','<%=tran_relno%>')"  style="font-weight: bold;height: 20px;font-size: 11px;background-color: red;color: white;">
			       <%
					   }else{
					%>
						<%=approval %> by <%=approved_by %>
				  <%		    
					   }
				   }else{
					   if(approval!=null){
					%>
					<%=approval %> by <%=approved_by %>
					<%
					   }else{
					%>
					Pending
					<%
					   }
				   }
			       %>
			       <%
			       if(dec_note!=null){
			       %>
			       - <b><%=dec_note %></b>
			       <a href="Display_RefDoc.jsp?field=<%=tran_relno%>" style="color: #3a22c8;font-family: Arial;font-size: 12px;" title="Documents Attached !!!"><b><%=doc_ref%></b></a>
			       <%
			       }
			       %>
			       </td>
			    <%
			    carried="";billno="";dated="";forrs="";purorder="";creator="";approval="";approved_by="";dec_note="";doc_ref="";
				tran_relno=0;
				  }
			    %>
			    </tr>
			    <%
			    sn++;
				  }
				%>
            </table>
            </form>
</div>
			<div style="float: right;width: 25%;height: 500px;overflow: scroll;">
			<table style="width: 100%;" class="tftable">
				<tr style="background-color:#3d6f74;color: white;">
					<td colspan="8" align="center"><b>FILE VIEW HISTORY</b></td>
				</tr>
				<tr style="background-color:#3d6f74;color: white;">
					<!-- <td align="center"><strong>Subject / File Name</strong></td> -->
					<td align="center"><strong>Document</strong></td>
			        <td align="center"><strong>Checked by</strong></td>
				    <td align="center"><strong>Date</strong></td>
				    <td align="center"><strong>Status</strong></td>
				</tr>
				<%
				ps  = con.prepareStatement("select * from mst_dmshist where DMS_CODE=" + code + " order by DATE desc");
				rs = ps.executeQuery();
				while(rs.next()){
				%>
				<tr>
				  <%-- <td><%=folderName %></td> --%>
				  <td  style="font-size:11px;word-wrap: break-word;max-width:80px;"><%=rs.getString("TRAN_FILE") %></td>
				  <td><%=rs.getString("USER") %></td>
				  <td><%=rs.getTimestamp("DATE")%></td>
				  <td><%=rs.getString("STATUS") %></td>
				 </tr>
				 <%
					}
				 %>
				 </table>
			</div>     
	    
	    
	    
	    
    </span>
</div>
</div>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>
		<div id="footer" style="width: 120%">
			<p class="style2">
				<a href="index.jsp">Home</a><a href="New_Requisition.jsp">New Requisition</a> <a href="Requisition_Status.jsp">Requisition Status</a>
				<a href="All_Requisitions.jsp">All Requisitions</a> <a href="Reports_User.jsp">Reports</a> <a href="Logout.jsp">Logout</a>
		 <br /> <a href="http://www.muthagroup.com">Mutha Group, Satara
				</a>
			</p>
		</div> 
</div>
</body>
</html>