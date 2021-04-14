<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<title>Asset Info</title>

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
<script>
	$(function() {
		$("#tabs").tabs();
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#grndate").datepicker({

		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#podate").datepicker({

		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#received_date").datepicker({

		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#issuedate").datepicker({

		});
	});
	$(function() {
		//	$("#datepicker").datepicker();
		$("#repaired_date").datepicker({

		});
	});
</script> 
<style type="text/css">
.tftable {
	font-size: 15px;
	color: #333333;
	width: 100%; 
}

.tftable th {
	font-size: 14px;
	background-color: #acc8cc; 
	padding: 8px; 
	text-align: center;
}

.tftable tr {
	background-color: white;
}

.tftable td {
	font-size: 14px; 
	padding: 8px; 
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
<script type="text/javascript">
function showDetails(str) {
	var xmlhttp;
	var xmlhttp1;
	var xmlhttp2;
	var xmlhttp3;
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
		xmlhttp1 = new XMLHttpRequest();
		xmlhttp2 = new XMLHttpRequest();
		xmlhttp3 = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp3 = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			document.getElementById("devData").innerHTML = xmlhttp.responseText;  
		}
	};
	xmlhttp1.onreadystatechange = function() {
		if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) { 
			document.getElementById("user").innerHTML = xmlhttp1.responseText;  
		}
	};
	xmlhttp2.onreadystatechange = function() {
		if (xmlhttp2.readyState == 4 && xmlhttp2.status == 200) { 
			document.getElementById("tonerRef").innerHTML = xmlhttp2.responseText;  
		}
	};
	xmlhttp3.onreadystatechange = function() {
		if (xmlhttp3.readyState == 4 && xmlhttp3.status == 200) { 
			document.getElementById("printData").innerHTML = xmlhttp3.responseText;  
		}
	};
	xmlhttp.open("POST", "avail_partData.jsp?q=" + str, true);
	xmlhttp1.open("POST", "userDetails.jsp?q=" + str, true);
	xmlhttp2.open("POST", "GetToner_Refill.jsp?q=" + str, true);
	xmlhttp3.open("POST", "PrinterRefill_history.jsp?q=" + str, true);
	
	xmlhttp.send(); 
	xmlhttp1.send();
	xmlhttp2.send();
	xmlhttp3.send();
	
};
</script>
<script language="javascript">
	function compAsset(val) {
		var val1 = val; 
		document.getElementById("hid").value = val1;
		comp_info.submit();
	}
	function userAsset_Info(val){
		var val1 = val; 
		document.getElementById("hid_user").value = val1;
		userissue.submit();
	} 
</script>
</head>
<body>
<%
try {	
	int dept_id=0;
	String modelNo="";
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
    <h3><strong>Asset Info</strong> </h3> 
  </div>
  <div id="menu">
		<ul>
				<li><a href="IT_index.jsp">Home</a></li>
				<li><a href="IT_New_Requisition.jsp">New</a></li>
				<li><a href="Closed_Requisitions.jsp">Closed</a></li>
				<li><a href="IT_All_Requisitions.jsp">All</a></li> 
				<li><a href="Asset_info.jsp">Asset Info </a></li>
				<li><a href="Asset_Master.jsp">Asset Master </a></li> 
				<li><a href="Software_Access.jsp">Software Access</a></li>
				<li><a href="MISAccess.jsp">MIS Access</a></li> 
				<li><a href="IT_Reports.jsp">Reports</a></li>
				<li><a href="DMS.jsp">DMS</a></li>
				<li><a href="Logout.jsp">Logout<strong style="color: blue; font-size: x-small;"> <%=uname%></strong></a></li>
			</ul>
		</div>
 
  <div style="width:100%; height: 500px;width:99%; padding-left: 5px;padding-bottom: 5px;">  
  		 <div id="tabs" style="width: 99%">
				<ul>
					<li><a href="#tabs-1" style="cursor: pointer; font-size: 16px;">Company Assets</a></li>
					<li><a href="#tabs-2" style="cursor: pointer; font-size: 16px;">Users Issue</a></li>
					<li><a href="#tabs-3" style="cursor: pointer; font-size: 16px;">Printer Refill Data</a></li>      
				</ul>
				<div id="tabs-1" style="height: 500px;width:95% ;overflow: scroll;">		
				
		<form action="Company_DeviceInfo.jsp" method="post" name="comp_info" id="comp_info">		
		<input type="hidden" name="hid" id="hid"/>		 
			<table border="0" width="100%" class="tftable">
				<tr>
				<th align="center" width="5%"><b>Sr. No</b></th>
  				<th align="center"><b>Device Name</b></th>
  				<th align="center"><b>Device Type</b></th>
  				<th align="center"><b>Location</b></th>
  				<th align="center"><b>Company Name</b></th>
  				<th align="center"><b>Model No</b></th>   
				</tr>
				<%		
				int sr=1;
				PreparedStatement ps_compAsset = con.prepareStatement("select * from it_asset_companydevice_tbl where used_flag=1 and scrap_flag=0 order by company_id");
				ResultSet rs_compAsset = ps_compAsset.executeQuery();
				while(rs_compAsset.next()){
				%>				 
				<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="compAsset('<%=rs_compAsset.getInt("asset_companyDevice_id")%>');" style="cursor: pointer;" align="center">
					<td align="center"><%=sr %></td>
				<%
				 PreparedStatement ps_dev=con.prepareStatement("select * from it_asset_deviceinfo_tbl where scrap_flag=0 and available_flag=0 and asset_deviceinfo_id="+rs_compAsset.getInt("asset_deviceinfo_id")+" ");
				 ResultSet rs_dev=ps_dev.executeQuery();
				 while(rs_dev.next()){
				%> 
					<td><%=rs_dev.getString("device_name") %></td>
				<%
				 PreparedStatement ps_devtype=con.prepareStatement("select * from it_asset_devicetype_mst_tbl where devicetype_mst_id="+rs_dev.getInt("devicetype_mst_id"));
				 ResultSet rs_devtype=ps_devtype.executeQuery();
				 while(rs_devtype.next()){
				%>	 	
					<td><%=rs_devtype.getString("device_type") %></td>
				<%
				 }
				 modelNo = rs_dev.getString("model_no");
				 }
				 %>
				<td><%=rs_compAsset.getString("location") %></td>
				 <%
				 PreparedStatement ps_devcomp=con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_compAsset.getInt("company_id"));
				 ResultSet rs_devcomp=ps_devcomp.executeQuery();
				 while(rs_devcomp.next()){
				%>
					<td><%=rs_devcomp.getString("Company_Name") %></td>
				<%
				 }
				%> 
				<td><%=modelNo %></td>
				</tr>
				<% 
				sr++; 
				} 
				%>				
			</table> 
			</form>			
				</div>
		<div id="tabs-2"  style="height: 500px;width:99% ;overflow: scroll;">
			<form action="UserIssue_Details.jsp" method="post" id="userissue" name="userissue">	
			<input type="hidden" name="hid_user" id="hid_user"/>
				<table border="0" width="100%" class="tftable">
				<tr>
				<th align="center" width="6%"><b>Issue No</b></th>
  				<th align="center" width="10%"><b>Device Name</b></th>
  				<th align="center" width="10%"><b>Device Type</b></th>
  				<th align="center" width="15%"><b>Location</b></th>
  				<th align="center" width="10%"><b>Company Name</b></th>
  				<th align="center" width="15%"><b>User Name</b></th>
  				<th align="center" width="10%"><b>Department</b></th> 
				</tr>  
				<%
				String devname="",devtype="",location="",companyName="",username="",department="";
				PreparedStatement ps_isueinfo = con.prepareStatement("select * from it_asset_issuenote_tbl where surrender_flag=0 order by Company_Id");
				ResultSet rs_issueInfo = ps_isueinfo.executeQuery();
				while(rs_issueInfo.next()){
				PreparedStatement ps_devnm=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+rs_issueInfo.getInt("asset_deviceinfo_id"));
				ResultSet rs_devnm = ps_devnm.executeQuery();
				while(rs_devnm.next()){
				devname = rs_devnm.getString("device_name"); 
				PreparedStatement ps_devtype = con.prepareStatement("select * from it_asset_devicetype_mst_tbl where devicetype_mst_id="+rs_devnm.getInt("devicetype_mst_id"));
				ResultSet rs_devtype = ps_devtype.executeQuery();
				while(rs_devtype.next()){
					devtype = rs_devtype.getString("device_type");
				}				
					}
				location =  rs_issueInfo.getString("location");
				PreparedStatement ps_devcomp = con.prepareStatement("select * from user_tbl_company where Company_Id="+rs_issueInfo.getInt("Company_Id"));
				ResultSet rs_devcomp = ps_devcomp.executeQuery();
				while(rs_devcomp.next()){
					companyName = rs_devcomp.getString("Company_Name");
				}
				PreparedStatement ps_devuser = con.prepareStatement("select * from user_tbl where U_Id="+rs_issueInfo.getInt("issued_to"));
				ResultSet rs_devuser = ps_devuser.executeQuery();
				while(rs_devuser.next()){
					username = rs_devuser.getString("U_Name");
				
				PreparedStatement ps_devdept = con.prepareStatement("select * from user_tbl_dept where dept_id="+rs_devuser.getInt("dept_id"));
				ResultSet rs_devdept = ps_devdept.executeQuery();
				while(rs_devdept.next()){
					department = rs_devdept.getString("Department");
				}
				}
				 
				%>
				<tr onmouseover="ChangeColor(this, true);" onmouseout="ChangeColor(this, false);" onclick="userAsset_Info('<%=rs_issueInfo.getInt("asset_deviceinfo_id")%>');" style="cursor: pointer;" align="center">
				<td><%=rs_issueInfo.getInt("asset_issueNote_id")  %></td>  
				<td><%=devname %></td> 
				<td><%=devtype %></td> 
				<td><%=location %></td> 
				<td><%=companyName %></td> 
				<td><%=username %></td> 
				<td><%=department %></td>  
				</tr>
				<%  
				}
				%>				  
			</table> 
			</form>
				</div>
				<div id="tabs-3" style="height: 500px;width: 99%;overflow: scroll;"> 
				<table border="0">
			<tr>
				<td>Device Name :</td>
				<td> <select name="dev_name" id="dev_name" style="height: 30px;font-size: 16px;" onchange="showDetails(this.value)">
						<option value=""> - - - - - Select Material - - - - - </option>
						<%
						String nameUser="";
						PreparedStatement ps_devName=con.prepareStatement("select * from it_asset_deviceinfo_tbl where available_flag=0 and scrap_flag=0 and devicetype_mst_id=3");
						ResultSet rs_devName=ps_devName.executeQuery();
						while(rs_devName.next()){		  
							PreparedStatement ps_isueinfoname = con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id="+rs_devName.getInt("asset_deviceinfo_id"));
							ResultSet rs_issueInfoname = ps_isueinfoname.executeQuery();
							while(rs_issueInfoname.next()){
								PreparedStatement ps_devuser = con.prepareStatement("select * from user_tbl where U_Id="+rs_issueInfoname.getInt("issued_to"));
								ResultSet rs_devuser = ps_devuser.executeQuery();
								while(rs_devuser.next()){
									nameUser = rs_devuser.getString("U_Name");
								}
							}
							if(nameUser.equalsIgnoreCase("")){
								nameUser="Company Asset";
							}
					%>
					<option value="<%=rs_devName.getInt("asset_deviceinfo_id")%>"><%=rs_devName.getString("device_name")%>&nbsp;&nbsp;&nbsp;&#8658;&nbsp;&nbsp;&nbsp;<%=nameUser %></option>
					<% 			
						nameUser ="";
						}
						ps_devName.close();
						rs_devName.close();
					%>	 						 
						</select>	
				</td>
			</tr>
			</table>
			 		<span id="user"></span>
  					<span id="tonerRef"></span>
  					<span id="printData"></span>   
  					<span id="devData"></span> 
  				 
				
  </div>
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
