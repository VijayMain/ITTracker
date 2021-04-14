<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.PreparedStatement"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head> 
<title>Asset Master</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/script.js"></script>  
<link rel="stylesheet" type="text/css" href="styles.css" /> 
<script>
	$(function() {
		$("#tabs").tabs();
	});
	
	$(document).ready(
			   
			  function () {
			    $( "#datepicker" ).datepicker({
			      changeMonth: true,//this option for allowing user to select month
			      changeYear: true //this option for allowing user to select from year range
			    });
			    $("#grndate").datepicker({
			    	changeMonth: true,//this option for allowing user to select month
				      changeYear: true //this option for allowing user to select from year range
				    });
			    	 
					$("#podate").datepicker({
						changeMonth: true,//this option for allowing user to select month
					      changeYear: true //this option for allowing user to select from year range
					    });
 
					$("#received_date").datepicker({
						changeMonth: true,//this option for allowing user to select month
					      changeYear: true //this option for allowing user to select from year range
					    });
 
					$("#issuedate").datepicker({
						changeMonth: true,//this option for allowing user to select month
					      changeYear: true //this option for allowing user to select from year range
					    });
 
					$("#repaired_date").datepicker({
						changeMonth: true,//this option for allowing user to select month
					      changeYear: true //this option for allowing user to select from year range
					    }); 
			  }

			);
			     
</script> 
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
function multiSelectList(){
    var x=document.getElementById("software");
    x.multiple=true;
}
</script>
<script type="text/javascript">
function showDevDetails(str) {
	var xmlhttp;
	var xmlhttp1;
	var xmlhttp2;
	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
		xmlhttp1 = new XMLHttpRequest();
		xmlhttp2 = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp2 = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			document.getElementById("devRepairsData").innerHTML = xmlhttp.responseText; 
		}
	};
	xmlhttp1.onreadystatechange = function() {
		if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) { 
			document.getElementById("partreplaced").innerHTML = xmlhttp1.responseText; 
		}
	};
	xmlhttp2.onreadystatechange = function() {
		if (xmlhttp2.readyState == 4 && xmlhttp2.status == 200) { 
			document.getElementById("user").innerHTML = xmlhttp2.responseText; 
		}
	};
	xmlhttp.open("POST", "AvailDeviceInfo_DevRepairs.jsp?q=" + str, true); 
	xmlhttp1.open("POST", "Availpart_Toreplace.jsp?q=" + str, true);
	xmlhttp2.open("POST", "userDetails.jsp?q=" + str, true);
	xmlhttp.send();
	xmlhttp1.send();
	xmlhttp2.send();
};
</script>
<script type="text/javascript">
function showstock(str) {
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
			document.getElementById("getstk").innerHTML = xmlhttp.responseText;
			//document.getElementById("approvers").innerHTML = xmlhttp.responseText;

		}
	};
	xmlhttp.open("POST", "Available_stock.jsp?q=" + str, true);
	xmlhttp.send();
};

function showSoftwares(str) {
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
			document.getElementById("soft").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("POST", "Software_Installed.jsp?q=" + str, true);
	xmlhttp.send();
	
};
</script>
<script type="text/javascript">
	function ClearList(OptionList, TitleName) {
		OptionList.length = 0;
	}

	function move(side, form_name) {
		var temp1 = new Array();
		var temp2 = new Array();
		var current1 = 0;
		var current2 = 0;
		var attribute;

		//assign what select attribute treat as attribute1 and attribute2
		if (side == "right") {
			attribute1 = document.getElementById('software_name');
			attribute2 = document.getElementById('software_selected');
		} else {
			attribute2 = document.getElementById('software_name');
			attribute1 = document.getElementById('software_selected');
		}

		//fill an array with old values
		for ( var i = 0; i < attribute2.length; i++) {
			temp1[current1++] = attribute2.options[i].value;
		}

		//assign new values to arrays
		for ( var i = 0; i < attribute1.length; i++) {
			if (attribute1.options[i].selected) {
				temp1[current1++] = attribute1.options[i].value;
			} else {
				temp2[current2++] = attribute1.options[i].value;
			}
		}

		//generating new options 
		for ( var i = 0; i < temp1.length; i++) {
			attribute2.options[i] = new Option();
			attribute2.options[i].value = temp1[i];
			attribute2.options[i].text = temp1[i];
			attribute2.options[i].selected = "selected";
		}

		//generating new options
		ClearList(attribute1, attribute1);
		if (temp2.length > 0) {
			for ( var i = 0; i < temp2.length; i++) {
				attribute1.options[i] = new Option();
				attribute1.options[i].value = temp2[i];
				attribute1.options[i].text = temp2[i];
				attribute1.options[i].text = temp2[i];
			}
		}
	}
</script>
<script type="text/javascript">
function showDetails(str) {
	var xmlhttp;
	var xmlhttp1;

	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
		xmlhttp1 = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			document.getElementById("devData").innerHTML = xmlhttp.responseText; 

		}
	};
	xmlhttp1.onreadystatechange = function() {
		if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) { 
			document.getElementById("prevUserData").innerHTML = xmlhttp1.responseText; 
		}
	};
	xmlhttp.open("POST", "AvailDeviceInfo_issuenote.jsp?q=" + str, true);
	xmlhttp1.open("POST", "Prev_Device_IssueInfo.jsp?q=" + str, true);
	xmlhttp.send();
	xmlhttp1.send();
};
</script>
<script type="text/javascript">
function chk_Avilable(str) {
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
			document.getElementById("chkDeviceNm").innerHTML = xmlhttp.responseText;
		}
	};
	xmlhttp.open("POST", "Check_AvailableDevice.jsp?q=" + str, true);
	xmlhttp.send();

}
           
function validateIssueForm() { 
	var dev_name = document.getElementById("dev_name");  
	var company = document.getElementById("company");
	var issuedto = document.getElementById("issuedto");
	var issuedate = document.getElementById("issuedate");
	var issuedby = document.getElementById("issuedby");
	var extra = document.getElementById("extra");
	var location = document.getElementById("location");
	var contNo = document.getElementById("contNo");
	var email = document.getElementById("email");
	var software = document.getElementById("software");
	 
		if (dev_name.value=="0" || dev_name.value==null || dev_name.value=="" || dev_name.value=="null") {
			alert("Please Provide Device Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (company.value=="0" || company.value==null || company.value=="" || company.value=="null") {
			alert("Please Provide Company !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (issuedto.value=="0" || issuedto.value==null || issuedto.value=="" || issuedto.value=="null") {
			alert("Please Provide issued User Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (issuedate.value=="0" || issuedate.value==null || issuedate.value=="" || issuedate.value=="null") {
			alert("Please Provide Issue Date !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (issuedby.value=="0" || issuedby.value==null || issuedby.value=="" || issuedby.value=="null") {
			alert("Please Provide material issued by !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (extra.value=="0" || extra.value==null || extra.value=="" || extra.value=="null") {
			alert("Please Provide Other Information !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (location.value=="0" || location.value==null || location.value=="" || location.value=="null") {
			alert("Please Provide User Location At Mutha Group !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (contNo.value=="0" || contNo.value==null || contNo.value=="" || contNo.value=="null") {
			alert("Please Provide User's Contact No !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (email.value=="0" || email.value==null || email.value=="" || email.value=="null") {
			alert("Please Provide User's E-Mail !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (software.value=="0" || software.value==null || software.value=="" || software.value=="null") {
			alert("Please Provide Software Access !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		
		document.getElementById("ADD").disabled = true;
		return true;
	} 
	
	
	
function validateDownloadForm() {
	var dev_name = document.getElementById("dev_namedownload");   
	 
		if (dev_name.value=="0" || dev_name.value==null || dev_name.value=="" || dev_name.value=="null") {
			alert("Please Provide Device Name !!!"); 
			document.getElementById("ADDDownload_IssueNote").disabled = false;
			return false;
		}
		
		document.getElementById("ADDDownload_IssueNote").disabled = true;
		return true;
}

function validateImport() {
	var it_doc = document.getElementById("it_doc");   
	 
		if (it_doc.value=="0" || it_doc.value==null || it_doc.value=="" || it_doc.value=="null") {
			alert("Please select file to upload !!!");  
			return false;
		}
		return true;
}
	
</script>
<script type="text/javascript">  
function add_compAssets() {
	window.location="Add_newCompanyAsset.jsp";
}
function add_printerRefill() {
	window.location="Add_printerRefill.jsp";
}
function add_TonerRefill() {
	window.location="Add_tonerRefill.jsp";
}
function add_devparts() {
	window.location="Add_newDeviceParts.jsp";
}
function add_spareparts() {
	window.location="Add_newspareparts.jsp";
}
function addDev_Type() {
	window.location="Add_newDeviceType.jsp";
}
function addSupplier() {
	window.location="Add_newSupplier.jsp";
}
function addSoftwares() {
	window.location="Add_newSoftwares.jsp";
}
function addOS() {
	window.location="Add_newOS.jsp";
}
function addadapter() {
	window.location="Add_newAdapter.jsp";
}
function addNewIpAddress() {
	window.location="Add_newIPAddress.jsp";
}
function add_amcbtn() {
	window.location="Add_newAMC_info.jsp";
}
function add_terms_cond() {
	window.location="Terms_cond.jsp";
}
function add_attachIssueNote() {
	window.location="AttachIssueNote.jsp";
}
function surrender_note(){
	window.location="MakeSurrenderNote.jsp";
}

function Addto_Scrap() {
	window.location="Add_newScrapData.jsp";
}

function add_AccessList() {
	window.location="Add_accessMaster.jsp";
}
function add_user_Access() {
	window.location="Add_userAccess.jsp";
}

	// Form validation code will come here.
	function validateForm() {
	var devicename = document.getElementById("devicename");  
	var dev_type = document.getElementById("dev_type");
	var supplier = document.getElementById("supplier");
	//var basic_rate = document.getElementById("basic_rate");
//	var tot_amt = document.getElementById("tot_amt");
	var modelno = document.getElementById("modelno");
	var description = document.getElementById("description");
	
	/* var mac1 = document.getElementById("1");
	var mac2 = document.getElementById("2");
	var mac3 = document.getElementById("3");
	var mac4 = document.getElementById("4");
	var mac5 = document.getElementById("5");
	var mac6 = document.getElementById("6"); 
	var received_date = document.getElementById("received_date");*/	
	var onlineyes = document.getElementById("onlineyes");
	var onlineno = document.getElementById("onlineno");
	
		if (devicename.value=="0" || devicename.value==null || devicename.value=="" || devicename.value=="null") {
			alert("Please Provide Device Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (onlineyes.checked== false  && onlineno.checked== false ) {
			alert("Online Purchase ?"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (supplier.value=="0" || supplier.value==null || supplier.value=="" || supplier.value=="null") {
			alert("Please Provide Supplier Name !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		/* if (basic_rate.value=="0" || basic_rate.value==null || basic_rate.value=="" || basic_rate.value=="null") {
			alert("Please Provide Basic Rate!!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (tot_amt.value=="0" || tot_amt.value==null || tot_amt.value=="" || tot_amt.value=="null") {
			alert("Please Provide Total Amount!!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		} */		
		if (dev_type.value=="0" || dev_type.value==null || dev_type.value=="" || dev_type.value=="null") {
			alert("Please Provide Device Type !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		/* if (dev_type.value=="2") {			
			if(mac1.value=="" || mac2.value=="" ||  mac3.value=="" || mac4.value=="" || mac5.value=="" || mac6.value==""){
				alert("Please Provide MAC Address !!!"); 
				document.getElementById("ADD").disabled = false;
				return false;				
			}						
		}	
		if (dev_type.value=="3") {			
			if(mac1.value=="" || mac2.value=="" ||  mac3.value=="" || mac4.value=="" || mac5.value=="" || mac6.value==""){
				alert("Please Provide MAC Address !!!"); 
				document.getElementById("ADD").disabled = false;
				return false;				
			}						
		} */
		if (modelno.value=="0" || modelno.value==null || modelno.value=="" || modelno.value=="null") {
			alert("Please Provide Model no!!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		if (description.value=="0" || description.value==null || description.value=="" || description.value=="null") {
			alert("Please Provide Description/Particulars !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		}
		/* if (received_date.value=="0" || received_date.value==null || received_date.value=="" || received_date.value=="null") {
			alert("Please Provide Material Received Date !!!"); 
			document.getElementById("ADD").disabled = false;
			return false;
		} */
		
		document.getElementById("ADD").disabled = true;
		return true;
	}
	
	                                       
	function validateDevRepairForm() {
		var dev_name =  document.getElementById('dev_name1');
		var reqNo = document.getElementById('reqNo'); 		
		var partreplaced = document.getElementById('partreplace');
		var yes = document.getElementById('yes'); 
		var no = document.getElementById('no'); 
		var avail_stk = document.getElementById('avail_stk');
		var qtyused = document.getElementById('qtyused'); 
		var partcond = document.getElementById('partcond');        
		var repaired_by = document.getElementById('repaired_by'); 
		var repaired_date = document.getElementById('repaired_date'); 
		var details = document.getElementById('details');
 		 
			if (dev_name.value=="0" || dev_name.value==null || dev_name.value=="" || dev_name.value=="null") {
				alert("Please Provide Device Name !!!"); 
				document.getElementById("ADD").disabled = false;
				return false;
			} 
			if (reqNo.value=="0" || reqNo.value==null || reqNo.value=="" || reqNo.value=="null") {
				alert("Please Provide Requisition No !!!"); 
				document.getElementById("ADD").disabled = false;
				return false;
			} 
			if (partreplaced.value=="" || partreplaced.value==null || partreplaced.value=="0" || partreplaced.value=="null") {
				alert("Please Provide Part Repaired !!!"); 
				document.getElementById("ADD").disabled = false;
				return false;
			}
			if (yes.checked== false  && no.checked== false ) {
				alert("Part Replaced ?"); 
				document.getElementById("ADD").disabled = false;
				return false;
			}
			if (yes.checked== true) {
				if (avail_stk.value=="" || qtyused.value=="0") {
					alert("Available stock ?"); 
					document.getElementById("ADD").disabled = false;
					return false;
				}
				if (qtyused.value=="" || qtyused.value==null || qtyused.value=="0" || qtyused.value=="null") {
					alert("Part Qty used ?");
					document.getElementById("ADD").disabled = false;
					return false;
				}
				if (partcond.value=="" || partcond.value==null || partcond.value=="0" || partcond.value=="null") {
					alert("Old Part Condition ?"); 
					document.getElementById("ADD").disabled = false;
					return false;
				}	
				if(qtyused.value > avail_stk.value){
					alert("Stock is not available ?"); 
					document.getElementById("ADD").disabled = false;
					return false;
				}
			}                    
			if (repaired_by.value=="" || repaired_by.value==null || repaired_by.value=="0" || repaired_by.value=="null") {
				alert("Repaired By ?"); 
				document.getElementById("ADD").disabled = false;
				return false;
			}
			if (repaired_date.value=="" || repaired_date.value==null || repaired_date.value=="0" || repaired_date.value=="null") {
				alert("Repaire Date ?"); 
				document.getElementById("ADD").disabled = false;
				return false;
			}
			if (details.value=="" || details.value==null || details.value=="0" || details.value=="null") {
				alert("Repaire Details ?"); 
				document.getElementById("ADD").disabled = false;
				return false;
			}
			document.getElementById("ADD").disabled = true;
			return true;
		}	
</script>
<script type="text/javascript">
function showDownload(str) {
	var xmlhttp;
	var xmlhttp1;

	if (window.XMLHttpRequest) {
		// code for IE7+, Firefox, Chrome, Opera, Safari
		xmlhttp = new XMLHttpRequest();
		xmlhttp1 = new XMLHttpRequest();
	} else {
		// code for IE6, IE5
		xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange = function() {
		if (xmlhttp.readyState == 4 && xmlhttp.status == 200) { 
			document.getElementById("devDataDownload").innerHTML = xmlhttp.responseText;  
		}
	};
	xmlhttp1.onreadystatechange = function() {
		if (xmlhttp1.readyState == 4 && xmlhttp1.status == 200) { 
			document.getElementById("userdownload").innerHTML = xmlhttp1.responseText;  
		}
	};
	xmlhttp.open("POST", "avail_partData.jsp?q=" + str, true);
	xmlhttp1.open("POST", "userDetails.jsp?q=" + str, true);
	xmlhttp.send();
	xmlhttp1.send();
};
</script>
<style type="text/css">
table.gridtable {
	font-family: verdana, arial, sans-serif;
	font-size: 11px;
	border-width: 1px;
	border-color: #666666;
	border-collapse: collapse;
}

table.gridtable tr { 
	padding: 8px;
	font-size: 11px; 
}

table.gridtable td { 
	padding: 8px;
	font-size: 11px; 
	background-color: #ffffff;
}
</style>
</head>
<body>
<%
try {
	
	int dept_id=0;
	String department="";
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
    <h3><strong>Asset Master</strong> </h3> 
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
 
  <div style="width:99%; height: 100%; padding-left: 10px;padding-right:5px; padding-bottom: 5px;padding-top: 5px;">
  
  		 <div id="tabs">
				<ul>
					<li><a href="#tabs-1" style="cursor: pointer; font-size: 13px;">Master</a></li>  
					<li><a href="#tabs-2" style="cursor: pointer; font-size: 13px;">New Device</a></li> 
						<li><a href="#tabs-3" style="cursor: pointer; font-size: 13px;">Issue Note</a></li>
						<li><a href="#tabs-10" style="cursor: pointer; font-size: 13px;">Software Installed</a></li>
						<li><a href="#tabs-4" style="cursor: pointer; font-size: 13px;">Attach Issue Documents </a></li>
						<li><a href="#tabs-5" style="cursor: pointer; font-size: 13px;">Device Repairs</a></li>   
						<li><a href="#tabs-6" style="cursor: pointer; font-size: 13px;">Device Surrender </a></li>
						<li><a href="#tabs-7" style="cursor: pointer; font-size: 13px;">Add to Scrap </a></li>
						<li><a href="#tabs-8" style="cursor: pointer; font-size: 13px;">Download Issue Note</a></li>
						<li><a href="#tabs-9" style="cursor: pointer; font-size: 13px;">Import Data</a></li>          
				</ul>
					<div id="tabs-1" style="height: 100%;width: 20%">
				<div style="float: right;padding-left: 10px;">  
				<table width="90%" border="0" class="gridtable" style="border: none; background-color: white;">
				<tr>
					<td><input type="button" id="add_TonerRefill" style="width: 250px;height: 35px;" class="groovybutton"  value="   Printer Toner Refill  " onclick="add_TonerRefill()" /> </td>
					<td></td>
				</tr>
				<tr>
					<td><input type="button" id="add_printerRefill" style="width: 250px;height: 35px;" class="groovybutton"  value="   Printer Ink Refill  " onclick="add_printerRefill()" /> </td>
					<td></td>
				</tr>
				<tr>
					<td><input type="button" id="add_companyAssets" style="width: 250px;height: 35px;" class="groovybutton" name="add_companyAssets" value="Add Company Assets" onclick="add_compAssets()" /> </td>
					<td></td>
				</tr>
			<tr>
				<td><input type="button" id="add_devparts" style="width: 250px;height: 35px;" class="groovybutton" name="add_devparts" value="Add Device Parts" onclick="add_devparts()" /> </td>
				<td> </td>
			</tr>
			<tr>
				<td><input type="button" id="add_Spareparts" style="width: 250px;height: 35px;" class="groovybutton" name="add_Spareparts" value="Add Spare Parts" onclick="add_spareparts()" /> </td>
				<td> </td>
			</tr>
			<tr>
				<td><input type="button" id="add_devtypebtn" style="width: 250px;height: 35px;" class="groovybutton" name="add_devtypebtn" value="Add New Device Type" onclick="addDev_Type()" /> </td>
				<td> </td>
			</tr>
			<tr>
				<td><input type="button" id="add_supplier" style="width: 250px;height: 35px;" class="groovybutton" name="add_supplier" value="Add New Supplier" onclick="addSupplier()" /> </td>
				<td> </td>
			</tr>
			<tr>
				<td><input type="button" id="add_softwares" style="width: 250px;height: 35px;" class="groovybutton" name="add_softwares" value="Add New Software" onclick="addSoftwares()" /> </td>
				<td> </td>
			</tr>
			<tr>
				<td><input type="button" style="width: 250px;height: 35px;" class="groovybutton" id="add_os" name="add_os" value="Add New Operating System" onclick="addOS()" /> </td>
				<td> </td>
			</tr>
			<!-- <tr>
				<td><input type="button" style="width: 250px;height: 35px;" class="groovybutton" id="add_adapter" name="add_adapter" value="Add New Adapter" onclick="addadapter()" /> </td>
				<td> </td>
			</tr> -->
			<tr>
				<td><input type="button" style="width: 250px;height: 35px;" class="groovybutton" id="add_ipaddress" name="add_adapter" value="Add New IP Address" onclick="addNewIpAddress()" /> </td>
				<td> </td>
			</tr>
			<tr>
				<td><input type="button" style="width: 250px;height: 35px;" class="groovybutton" id="add_amcbtn" name="add_amcbtn" value="Add New AMC Details" onclick="add_amcbtn()" /> </td>
				<td> </td>
			</tr> 
			<tr>
				<td><input type="button" style="width: 250px;height: 35px;" class="groovybutton" id="add_terms_cond" name="add_terms_cond" value="IT Documents" onclick="add_terms_cond()" /> </td>
				<td> </td>
			</tr>
			<tr>
				<td><input type="button" style="width: 250px;height: 35px;" class="groovybutton" id="add_accessList" name="add_accessList" value="Access List" onclick="add_AccessList()" /> </td>
				<td> </td>
			</tr>
			<tr>
				<td><input type="button" style="width: 250px;height: 35px;" class="groovybutton" id="add_user_access" name="add_user_access" value="Add User Access" onclick="add_user_Access()" /> </td>
				<td> </td>
			</tr>
		</table> 
				</div> 
				 <br/>  <br/><br/><br/>  <br/><br/>  <br/> <br/>  <br/> <br/>  <br/>  <br/>   <br/>  <br/>    <br/>  <br/>  <br/>  <br/>  <br/>  <br/>   <br/>  <br/> <br/> <br/>  <br/>  <br/> <br/> <br/><br/> <br/> <br/> <br/> <br/>
				 <br/>  <br/><br/><br/>  <br/><br/>  <br/> <br/>  <br/> <br/>  <br/>  <br/>   <br/>  <br/>    <br/>  <br/>  <br/>     	
		</div>
				
				<!-- 
				////////////////////////////////////////////// Add Device Info Start /////////////////////////////////////////
				 -->   
				<div id="tabs-2">
				<form action="Asset_Master_Controller" method="post" id="myForm" name="myForm" onSubmit="return validateForm();">
				<table width="100%" border="0" class="gridtable" style="border: none; background-color: white;border-style: solid;border-width: 1px;">
					<tr align="left" style="background-color: #B0C9D6">
						<th height="33" scope="col" colspan="8">&nbsp;&nbsp; Add New Device &#8658; </th>  
					</tr> 		 
					<tr>
						<td>Device Name</td>
						<td><strong>:</strong></td>
						<td colspan="3"><input type="text" name="devicename" id="devicename" size="25" style="height: 20px;"/>
					<span id="chkDeviceNm"><input type="button" name="chk_avail" id="chk_avail" value="Check Availability" onclick="chk_Avilable(devicename.value)"/></span>	
						</td>  
					</tr>
					<tr>
						<td>Online Purchase</td>
						<td><strong>:</strong></td>
						<td colspan="3">
						<b><input type="radio" name="online" id="onlineyes" value="yes" style="width: 40px;">Yes
						<input type="radio" name="online" id="onlineno" value="no" style="width: 40px;">No</b>
						</td> 					
						 <td>Supplier Name</td>
						<td><strong>:</strong></td>
						<td><select name="supplier" id="supplier"  style="height: 30px;">
						<option value="">- - - - - select - - - - -</option>
						<%
						PreparedStatement ps_sup=con.prepareStatement("select * from it_asset_supplier_mst_tbl");
						ResultSet rs_sup=ps_sup.executeQuery();
						while(rs_sup.next()){
						%>
						<option value="<%=rs_sup.getInt("asset_supplier_mst_id")%>"><%=rs_sup.getString("supplier")%></option>
						<%
						}
						rs_sup.close();
						ps_sup.close();
						%>
						</select> </td>							
					</tr>
					
					
					
					
					<tr>
						<td>PO Number</td>
						<td><strong>:</strong></td>
						<td colspan="3"><input name="pono" type="text" id="pono"  size="20" style="height: 20px;"/></td>		
						 <td height="30">PO Date</td>
						<td><strong>:</strong></td>
						<td><input type="text" name="podate" id="podate" style="height: 20px;" readonly="readonly"/>&nbsp;&nbsp;yyyy-mm-dd  </td>						
					</tr>
					<tr>
						<td>GRN_No</td>
						<td><strong>:</strong></td>
						<td  colspan="3"><input name="grn_no" type="text" id="po_no" size="20" style="height: 20px;"/></td>						
						 <td height="30">GRN Date </td>
						<td><strong>:</strong></td>
						<td><input type="text" name="grndate" id="grndate" style="height: 20px;" readonly="readonly"/>&nbsp;&nbsp;yyyy-mm-dd </td>						
					</tr>					 
					 <tr>
						<td height="30">Basic Rate</td>
						<td><strong>:</strong></td>
						<td colspan="3"><input type="text" name="basic_rate" id="basic_rate" style="height: 20px;" onKeyPress="return validatenumerics(event);"/> </td>	
						 <td>Total Amount</td>
						<td><strong>:</strong></td>
						<td><input name="tot_amt" type="text" id="tot_amt" size="20" style="height: 20px;" onKeyPress="return validatenumerics(event);"/></td>					
					</tr>
					 
					  <tr>
						<td>Device Type</td>
						<td><strong>:</strong></td>
						<td colspan="3"><select id="dev_type" name="dev_type" style="height: 30px;width: 150px;">
						<option value="">- - - - - select - - - - -</option>
						<%
						PreparedStatement ps_devtype=con.prepareStatement("select * from it_asset_devicetype_mst_tbl");
						ResultSet rs_devtype=ps_devtype.executeQuery();
						while(rs_devtype.next()){
						%>
						<option value="<%=rs_devtype.getInt("devicetype_mst_id")%>"><%=rs_devtype.getString("device_type")%></option>
						<%
						}
						ps_devtype.close();
						rs_devtype.close();
						%>
						</select> </td>						
						 <td height="30">Hardware / <br />MAC Address (if any)</td>
						<td><strong>:</strong></td>
						<td><input type="text" name="1" id="1" size="2" maxlength="2" style="height: 20px;"/><strong>:</strong>
							<input type="text" name="2" id="2" size="2" maxlength="2" style="height: 20px;"/><strong>:</strong>
							<input type="text" name="3" id="3" size="2" maxlength="2" style="height: 20px;"/><strong>:</strong>
							<input type="text" name="4" id="4" size="2" maxlength="2" style="height: 20px;"/><strong>:</strong>
							<input type="text" name="5" id="5" size="2" maxlength="2" style="height: 20px;"/><strong>:</strong>
							<input type="text" name="6" id="6" size="2" maxlength="2" style="height: 20px;"/>
						</td>						
					</tr>	
					 <tr>
						<td height="30">Model No</td>
						<td><strong>:</strong></td>
						<td colspan="3"><input type="text" name="modelno" id="modelno" size="30" style="height: 20px;"/></td>	
						 <td height="30">Serial No</td>
						<td><strong>:</strong></td>
						<td><input type="text" name="serialno" id="serialno" size="30" style="height: 20px;"/></td>						
					</tr>
					<tr>
						<td height="30">IMEI No 1 (If any)</td>
						<td><strong>:</strong></td>
						<td colspan="3"><input type="text" name="imei_no" id="imei_no" size="30" style="height: 20px;"/></td>		
						 <td height="30">IMEI No 2 (If any)</td>
						<td><strong>:</strong></td>
						<td><input type="text" name="imei_no2" id="imei_no2" size="30" style="height: 20px;"/></td>						
					</tr>
					
					
					<tr>
						<td>Product Code</td>
						<td><strong>:</strong></td>
						<td colspan="3"><input type="text" name="product_code" id="product_code" size="30" style="height: 20px;"/></td>						
						 <td height="30">Item Code (If any)</td>
						<td><strong>:</strong></td>
						<td><input type="text" name="item_code" id="item_code" size="30" style="height: 20px;"/></td>				
					</tr>					 
					 <tr>
						<td height="30">SAP Code (If any)</td>
						<td><strong>:</strong></td>
						<td colspan="3"><input type="text" name="sap_code" id="sap_code" size="30" style="height: 20px;"/></td>					
						 <td height="30">Received Date (At IT)</td>
						<td><strong>:</strong></td>
						<td><input type="text" name="received_date" id="received_date" size="30" style="height: 20px;" readonly="readonly"/>&nbsp;&nbsp;yyyy-mm-dd </td>				
					</tr>
					<tr>
						<td height="30">Operating System</td>
						<td><strong>:</strong></td>
						<td colspan="3"><select name="osname" id="osname"  style="height: 30px;font-size: 14px;">
				<option value="">- - - - - Select - - - - -</option>
				<%
				PreparedStatement ps_os=con.prepareStatement("select * from it_asset_os_mst_tbl");
				ResultSet rs_os=ps_os.executeQuery();
				while(rs_os.next()){
				PreparedStatement ps_ostype = con.prepareStatement("select * from it_asset_licencetype_mst_tbl where licence_type_id="+rs_os.getInt("licence_type_id"));
				ResultSet rs_ostype = ps_ostype.executeQuery();
				while(rs_ostype.next()){
				%>
				<option value="<%=rs_os.getInt("asset_OS_id")%>"><%=rs_os.getString("os_name") %> --> <%=rs_ostype.getString("licence_type") %></option>
				<%
				} 
				}
				%>				
				</select> </td>					
						 <td height="30">IP Address(if any)</td>
						<td><strong>:</strong></td>
						<td>
						<select id="ip_address" name="ip_address" style="height: 30px;width: 150px;">
						<option value="">- - - - - select - - - - -</option>
						<%
						PreparedStatement ps_ip=con.prepareStatement("select * from it_asset_ipaddress_mst_tbl where flag=1");
						ResultSet rs_ip=ps_ip.executeQuery();
						while(rs_ip.next()){
						%>
						<option value="<%=rs_ip.getInt("asset_ipaddress_id")%>"><%=rs_ip.getString("ip_address")%></option>
						<%
						}
						ps_ip.close();
						rs_ip.close();
						%>
						</select>
						</td>						
					</tr>
							 
					 <tr>
						<td>Description /<br />Particulars</td>
						<td><strong>:</strong></td>
						<td colspan="3"><textarea rows="4" cols="40" id="description" name="description"></textarea> </td>						
						 <td height="30"></td>
						<td></td>
						<td></td>				
					</tr>
					
					<tr>						
						<td colspan="2" align="left">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" name="submit" id="ADD"  class="groovybutton" value="ADD"
							style="width: 155px;height: 35px;"/>						
						</td>
						<td colspan="6">
						<%
						if(request.getParameter("success")!=null){
						%>
						<span style="color: green;"><%=request.getParameter("success") %></span>
						<% 	
						}if(request.getParameter("fail")!=null){
						%>
						<span style="color: red;"><%=request.getParameter("fail") %></span>	
						<%	
						}
						else{
						%>
						&nbsp;
						<%	
						}
						%>
						</td> 
					</tr>					
				</table>
				</form>
				<br/>
				</div>
				<!-- 
				////////////////////////////////////////////// Add Device Info END /////////////////////////////////////////
				 -->				
			
		
			
		<div id="tabs-3">
<!-- 
*******************************************************************************************************************************
 -->		
<div style="float: left; width: 40%" >
<form action="IssueNote_Controller" method="post" id="myForm" name="myForm" onsubmit ="return validateIssueForm();">
				<table width="100%" border="0" class="gridtable" style="border: none; background-color: white;border-style: solid;border-width: 1px;font-size: 10px;">
					<tr align="left" style="background-color: #B0C9D6">
						<th height="33" scope="col" colspan="5">&nbsp;&nbsp; New Material Issue Note: &#8658; </th>  
					</tr> 
					<tr>
						<td>Issue Note No</td>
						<td><strong>:</strong></td>
						<td colspan="2">
					 	<%
					 	int maxId=0;
					 	PreparedStatement ps_issueNo=con.prepareStatement("select max(asset_issueNote_id) from it_asset_issuenote_tbl");
					 	ResultSet rs_issueNo=ps_issueNo.executeQuery();
					 	rs_issueNo.last();
						int issueID = rs_issueNo.getRow();
						rs_issueNo.beforeFirst();
						if (issueID > 0) {
							while(rs_issueNo.next()){
						 		maxId=rs_issueNo.getInt("max(asset_issueNote_id)");
						 	}
						}
					 	maxId++;					 	
					 	%>
					 	<input type="hidden" name="noteId" id="noteId" value="<%=maxId%>"/>
					 	<strong style="font-size: 23px;"><%=maxId %></strong>
						</td>  
					</tr>				 
					<tr>
						<td>Device Name</td>
						<td><strong>:</strong></td>
						<td colspan="2">
						<select name="dev_name" id="dev_name" style="height: 27px;font-size: 12px;" onchange="showDetails(this.value)">
						<option value=""> - - - - - Select Material - - - - - </option>
						<%
						PreparedStatement ps_devName=con.prepareStatement("select * from it_asset_deviceinfo_tbl where available_flag=1 and scrap_flag=0");
						ResultSet rs_devName=ps_devName.executeQuery();
						while(rs_devName.next()){ 
						%>
						<option value="<%=rs_devName.getInt("asset_deviceinfo_id")%>"><%=rs_devName.getString("device_name")%></option>
						<%
						}
						ps_devName.close();
						rs_devName.close();
						%>
						</select>	
						</td>  
					</tr> 
					<tr>
						<td>Company</td>
						<td><strong>:</strong></td>
						<td colspan="2">
						<select name="company" id="company" style="height: 27px;font-size: 12px;">
						<option value=""> - - - - - Select User - - - - - </option>
						<%
						PreparedStatement ps_compName=con.prepareStatement("select * from user_tbl_company where Company_Id!=6");
						ResultSet rs_compName=ps_compName.executeQuery();
						while(rs_compName.next()){ 
						%>
						<option value="<%=rs_compName.getInt("Company_Id")%>"><%=rs_compName.getString("Company_Name")%></option>
						<%
						}
						ps_compName.close();
						rs_compName.close();
						%>
						</select>
						</td>  
					</tr>
					<tr>
						<td>Issue To <br />(User Name) </td>
						<td><strong>:</strong></td>
						<td colspan="2">
						<select name="issuedto" id="issuedto" style="height: 27px;font-size: 12px;">
						<option value=""> - - - - - Select User - - - - - </option>
						<%
						PreparedStatement ps_Name=con.prepareStatement("select * from user_tbl where Enable_id=1 order by U_Name");
						ResultSet rs_Name=ps_Name.executeQuery();
						while(rs_Name.next()){ 
							PreparedStatement ps_department = con.prepareStatement("select * from user_tbl_dept where dept_id="+rs_Name.getInt("dept_id"));
							ResultSet rs_department = ps_department.executeQuery();
							while(rs_department.next()){
								department = rs_department.getString("Department");
							}
						%>
						<option value="<%=rs_Name.getInt("U_Id")%>"><%=rs_Name.getString("U_Name")%>&nbsp;&nbsp;&nbsp;&#8658;&nbsp;<%=department %></option>
						<%
						}
						ps_Name.close();						
						rs_Name.close();
						%>
						</select>
						</td>  
					</tr> 
					<tr>
						<td>Issue Date </td>
						<td><strong>:</strong></td>
						<td colspan="2"><input type="text" name="issuedate" id="issuedate" style="height: 20px; font-size: 12px;" readonly="readonly"/>&nbsp;&nbsp;yyyy-mm-dd  
						</td>  
					</tr> 
					<tr>
						<td>Issued By</td>
						<td><strong>:</strong></td>
						<td colspan="2">
						<select name="issuedby" id="issuedby" style="height: 27px;font-size: 12px;">
						<option value=""> - - - - - Select User - - - - - </option>
						<%
						PreparedStatement ps_givenbyName=con.prepareStatement("select * from user_tbl where Enable_id=1 and Dept_Id=18 order by U_Name");
						ResultSet rs_givenbyName=ps_givenbyName.executeQuery();
						while(rs_givenbyName.next()){ 
						%>
						<option value="<%=rs_givenbyName.getInt("U_Id")%>"><%=rs_givenbyName.getString("U_Name")%></option>
						<%
						}
						ps_givenbyName.close();						
						rs_givenbyName.close();
						%>
						</select>  
						</td>  
					</tr>
					<tr>
						<td>Other Information</td>
						<td><strong>:</strong></td>
						<td colspan="2"><textarea rows="6" cols="35" name="extra" id="extra"></textarea> </td>  
					</tr>
					<tr>
						<td>User Location</td>
						<td><strong>:</strong></td>
						<td colspan="2"><input type="text" name="location" id="location" size="35" style="height: 20px; font-size: 12px;"/></td>  
					</tr>
					<tr>
						<td>User Contact No</td>
						<td><strong>:</strong></td>
						<td colspan="2"><input type="text" name="contNo" id="contNo" size="35" style="height: 20px; font-size: 12px;"/></td>  
					</tr>
					<tr>
						<td>User E-Mail</td>
						<td><strong>:</strong></td>
						<td colspan="2"><input type="text" name="email" id="email" size="35" style="height: 20px; font-size: 12px;"/></td>  
					</tr>  
					<tr>
						<td>Software Installed/Access<br />(Select Multiple) </td>
						<td><strong>:</strong></td>
						<td colspan="2">
						<select name="software" id="software" onclick="multiSelectList()" size="10" style="width: 300px;font-size: 12px;">
						<%
						PreparedStatement ps_soft=con.prepareStatement("select * from it_asset_software_mst_tbl");
						ResultSet rs_soft=ps_soft.executeQuery();
						while(rs_soft.next()){
						%>
						<option value="<%=rs_soft.getInt("asset_software_id")%>"><%=rs_soft.getString("software_name")%></option>
						<%
						}
						%> 
						</select>
						
						</td>  
					</tr>
					<tr>						
						<td align="left" colspan="5"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" name="submit" id="ADD"  class="groovybutton" value="SAVE"
							style="width: 255px;height: 38px;"/>
						<%
						if(request.getParameter("Notesuccess")!=null){
						%>
						<span style="color: green;"><%=request.getParameter("Notesuccess") %></span>
						<% 	
						}if(request.getParameter("Notefail")!=null){
						%>
						<span style="color: red;"><%=request.getParameter("Notefail") %></span>	
						<%	
						}
						else{
						%>
						&nbsp;
						<%	
						}
						%>
						</td> 
					</tr>					
				</table>
				</form>
				</div>
	<div style="float: right; width: 58%;overflow: scroll;">
	<span id="prevUserData"></span>
	<span id="devData"></span>
	</div>
<!-- 
*******************************************************************************************************************************
 -->
 <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
 <br /> <br /> <br /> <br />  <br /> <br /> <br /> <br />  <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
 <br /> <br /> <br /> <br />  <br /> <br /> <br /> <br />  <br /> <br /> <br /> <br />
 
		</div>	
		
		
		
		<div id="tabs-10">
  	<form action="Add_SoftwaresInstalled_Controller" method="post"  onsubmit="return validateSoftwares();">
  		<table align="left">
					<thead> 
						<tr>
							<td align="left"><b>Softwares Installed on Laptop/Desktop :</b></td>
							<td align="left"><select name="uname" onchange="showSoftwares(this.value)" style="height: 30px;font-size: 15px;">
									<option value="0">- - - - - - - - - - - - Select - - - - - - - - - - - -</option>
									<%
									PreparedStatement ps_inote=null,ps_devn=null;
									ResultSet rs_inote=null,rs_devn=null;
										PreparedStatement ps_user = con.prepareStatement("select * from User_Tbl where Enable_id=1 order by U_Name");
											ResultSet rs_user = ps_user.executeQuery();
											while (rs_user.next()) {
												ps_inote = con.prepareStatement("select * from it_asset_issuenote_tbl where issued_to="+rs_user.getInt("U_Id") +" and surrender_flag=0");
												rs_inote = ps_inote.executeQuery();
												while(rs_inote.next()){
													ps_devn = con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+rs_inote.getInt("asset_deviceinfo_id"));
													rs_devn = ps_devn.executeQuery();
													while(rs_devn.next()){
									%>
									<option value="<%=rs_inote.getInt("asset_issueNote_id")%>"><%=rs_user.getString("U_Name")%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&#8658;&nbsp;&nbsp;<%=rs_devn.getString("device_name") %></option>
									<%
													}
												}
										}
									%>
							</select>
						</td>
						</tr>
					</thead>
				</table>
				<div id="soft" style="width: 100%">
					<table align="left">
						<tr>
							<td colspan="1"><b>Softwares Available</b></td>
							<td></td>
							<td colspan="1"><b>Softwares Installed</b></td>
						</tr>

						<tr>
							<td colspan="1" align="left"><select id="software_name"
								name="software_name" multiple="multiple" size="5"
								style="width: 480px;height: 280px;font-size: 13px;" title="Softwares"
								onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
								onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"> 
									<%
										PreparedStatement ps_softIssued = con.prepareStatement("select * from it_asset_software_mst_tbl");
										ResultSet rs_softIssued = ps_softIssued.executeQuery();
										while (rs_softIssued.next()) {
									%>
									<option value="<%=rs_softIssued.getString("Software_Name")%>"><%=rs_softIssued.getString("Software_Name")%></option>
									<%
										}
									%>
							</select></td>
							<td style="width: 50px;" align="center" align="center"><input
								value="&#8658;" onclick="move('right', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 13px;"><br>
								<input value="&#8656;" onclick="move('left', 'rep')"
								type="button" style="width: 60px;height: 40px;font-size: 13px;"></td>
							<td colspan="1" align="right"><select id="software_selected"
								name="software_selected" multiple="multiple" size="5"
								style="width: 480px;height: 280px;font-size: 13px;" title="Selected Softwares"
								onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
								onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"></select></td>
						</tr> 
					</table>
				</div>  <br />  
				<table width="100%"> 
					<tr>
						<td align="left">  
						<input type="submit" value="Save" style="width: 200px;height: 30px;"/>
						</td>
					</tr> 
				</table> 
	</form>
	<br /> 
	<strong style="font-size: 20px;"><a href="Asset_Master.jsp">&#8656; BACK</a></strong>
  
		
		
		
		
		
		</div>
		
		<div id="tabs-4">
<!-- 
********************************************************************************************************************************
 -->
 		<table>
  			<tr>
				<td><input type="button" style="width: 200px;height: 35px;" class="groovybutton" id="add_terms_cond" name="add_terms_cond" value="Attach Issue Documents" onclick="add_attachIssueNote()" /> </td>
				<td> </td>
			</tr>
 		</table> 
		</div> 
		
		<div id="tabs-5">
		<div style="float: left; width: 48%" >
		<form action="DeviceRepair_Controller" method="post" id="DevRepForm" name="DevRepForm" onSubmit="return validateDevRepairForm();">
				<table width="90%" border="0" class="gridtable" style="border: none; background-color: white;border-style: solid;border-width: 1px;">
				<tr align="left" style="background-color: #B0C9D6">
					<th height="33" scope="col" colspan="5">&nbsp;&nbsp;Device Repairs/Part Replaced &#8658; </th>  
				</tr>
					<tr>
						<td>Device Name</td>
						<td><strong>:</strong></td>
						<td colspan="2">
						<select name="dev_name" id="dev_name1" style="height: 30px;width: 280px;font-size: 14px;" onchange="showDevDetails(this.value)">
						<option value=""> - - - - - Select Device Name - - - - - </option>
					<%
						PreparedStatement ps_devNM=con.prepareStatement("select * from it_asset_deviceinfo_tbl where available_flag=0 and scrap_flag=0");
						ResultSet rs_devNm=ps_devNM.executeQuery();
						while(rs_devNm.next()){  
					%>
					<option value="<%=rs_devNm.getInt("asset_deviceinfo_id")%>"><%=rs_devNm.getString("device_name")%></option>
					<% 						
						} 
					%>	 		
						</select>	
						</td>  
					</tr> 				
					
					<tr>
						<td>Requisition No</td>
						<td><strong>:</strong></td>
						<td colspan="2"><select name="reqNo" id="reqNo" style="height: 30px;width: 80px;font-size: 14px;">
						<option value="">Select</option>
						<%
						PreparedStatement ps_reqNo = con.prepareStatement("select U_Req_Id from it_user_requisition order by U_Req_Id desc");
						ResultSet rs_reqNo = ps_reqNo.executeQuery();
						while(rs_reqNo.next()){
						%>
						<option value="<%=rs_reqNo.getInt("U_Req_Id")%>"><%=rs_reqNo.getInt("U_Req_Id")%></option>
						<%
						}
						%>
						</select>
						</td> 
					</tr> 				
					<tr>
						<td>Part Repaired</td>
						<td><strong>:</strong></td>
						<td colspan="2"> 
						<span id="partreplaced">
				<select name="partreplace" id="partreplace"  style="height: 30px;width: 250px;" onchange="showstock(this.value)">
				<option value=""> - - - - none - - - - </option>			 
				</select>
				</span>
				 		</td>  
					</tr>					
					<tr>
						<td>Part Replaced ?</td>
						<td><strong>:</strong></td>
						<td colspan="2">
						<input type="radio" name="pryes" id="yes" value="yes"/>Yes
						<input type="radio" name="pryes" id="no" value="no"/>No
						</td>  
					</tr>		
					<tr>
						<td>Available stock</td>
						<td><strong>:</strong></td>
						<td colspan="2">
						<span id="getstk">
						<input type="hidden" name="avail_stk" id="avail_stk"/>
						</span>
						</td>  
					</tr>	
					<tr>
						<td>Qty used</td>
						<td><strong>:</strong></td>
						<td colspan="2"><input type="text" name="qtyused" id="qtyused" size="5"  style="height: 25px;text-align: left;" onKeyPress="return validatenumerics(event);"/>
						</td>  
					</tr>					
					<tr>
						<td>Old Part Condition<br/> (if replaced)</td>
						<td><strong>:</strong></td>
						<td colspan="2">
						<select name="partcond" id="partcond"  style="height: 30px;width: 250px;">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				PreparedStatement ps_partcond=con.prepareStatement("select * from it_asset_device_surrender_condition_tbl");
				ResultSet rs_partcond=ps_partcond.executeQuery();
				while(rs_partcond.next()){
				%>
				<option value="<%=rs_partcond.getInt("asset_device_sur_condi_id") %>"><%=rs_partcond.getString("device_condition") %></option>
				<%
				} 
				%>
				</select>
						</td>  
					</tr>
					<tr>
						<td>Repaired By</td>						
						<td><strong>:</strong></td>
						<td colspan="2">
						<select name="repaired_by" id="repaired_by" style="height: 30px;width: 250px;">
						<option value="">- - - - Select - - - - </option>
						<%
						PreparedStatement ps_repby=con.prepareStatement("select * from user_tbl where Dept_Id=18 and Enable_Id=1 order by U_Name");
						ResultSet replyby = ps_repby.executeQuery();
						while(replyby.next()){
						%>
						<option value="<%=replyby.getInt("U_Id")%>"><%=replyby.getString("U_Name")%></option>
						<%
						}
						ps_repby.close();
						replyby.close();
						%>
						</select> 
						</td>  
					</tr>
					<tr>
						<td>Repaire Date</td>
						<td><strong>:</strong></td>
						<td colspan="2"><input type="text" name="repaired_date" id="repaired_date" readonly="readonly" style="height: 25px;text-align:left;"/> </td>  
					</tr>
					<tr>
						<td>Repaire Details</td>
						<td><strong>:</strong></td>
						<td colspan="2"><textarea rows="6" cols="35" name="details" id="details"></textarea> </td>  
					</tr>
					
					
					
					<tr>						
						<td align="left" colspan="5"><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
						<input type="submit" name="submit" id="ADD"  class="groovybutton" value="Save"
							style="width: 255px;height: 35px;"/> 
						</td> 
					</tr>					
				</table>
				</form>
				</div>
	<div style="float: right; width: 51%; height:500px;overflow: scroll;">
	<span id="user"></span>
	<span id="devRepairsData"></span>
	</div>	
	<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
	<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
	<br /> <br /> <br /> <br /> <br /> <br /> <br /> <br /> <br />
	</div>
		<div id="tabs-6">
		<table>
			<tr>
				<td><input type="button" id="surrenderNote" style="width: 280px;height: 35px;" class="groovybutton" name="surrenderNote" value="Make Device Surrender Note" onclick="surrender_note()" /> </td>
				<td> </td>
			</tr> 
		</table>		
		</div> 
		<div id="tabs-7">
		<table>
			<tr>
				<td><input type="button" id="addtoscrap" style="width: 280px;height: 35px;" class="groovybutton" name="addtoScrap" value="Add to Scrap" onclick="Addto_Scrap()" /> </td>
				<td> </td>
			</tr> 
		</table>	
		</div>
		<div id="tabs-8">
		<div style="width:40%;float: left;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;">
		
		<form action="Issue_Note" method="post" onsubmit ="return validateDownloadForm();">
		<table width="90%" border="0" class="gridtable" style="border: none; background-color: white;border-style: solid;border-width: 1px;">
				<tr align="left" style="background-color: #B0C9D6">
					<th height="33" scope="col" colspan="2">&nbsp;&nbsp; Download Issue Note &#8658; </th>  
				</tr>
			<tr>
				<td>Device Name :</td>
				<td>
				<select name="dev_namedownload" id="dev_namedownload" style="height: 30px;width: 300px;font-size: 14px;" onchange="showDownload(this.value)">
				<option value=""> - - - - - Select - - - - - </option>
				<%
				String nameUser = ""; 
					 					 
						 PreparedStatement ps=con.prepareStatement("select * from it_asset_issuenote_tbl where surrender_flag=0");	
							ResultSet rs = ps.executeQuery();
							while(rs.next()){
								PreparedStatement psur=con.prepareStatement("select * from user_tbl where U_Id="+rs.getInt("issued_to"));	
								ResultSet rsur = psur.executeQuery();
								while(rsur.next()){
									nameUser = rsur.getString("U_Name");
								} 
							PreparedStatement ps_dev=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+rs.getInt("asset_deviceinfo_id"));
							 ResultSet rs_dev=ps_dev.executeQuery();
							 while(rs_dev.next()){
				%>				
				<option value="<%=rs_dev.getInt("asset_deviceinfo_id")%>"><%=rs_dev.getString("device_name")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;----><%=nameUser %> </option>
				<% 
					 }		
				}
				%>
				</select>
				</td>
			</tr> 
			<tr>
			<td colspan="2"> 
			<input type="submit" name="submit" id="ADDDownload_IssueNote"  class="groovybutton" value="Download Issue Note" style="width: 255px;height: 35px;"/>
			</td> 
			</tr>
			</table>
			</form>
			
			</div>
			
<div style="width:58%; height: 450px;float: right;padding-left: 10px;padding-bottom: 5px;padding-top: 5px;overflow: scroll;">
  		<span id="userdownload"></span>
	 	<span id="devDataDownload"></span>
</div>
			
			<br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/><br/><br/>
		</div>
		<div id="tabs-9">
		<div style="width: 60%;float: left;">
		
		<form action="AddConfig_Controller" enctype="multipart/form-data"  method="post" onsubmit="return validateImport();"> 
 			<table width="100%" border="0" class="gridtable" style="border: none; background-color: white;border-style: solid;border-width: 1px;">
				<tr align="left" style="background-color: #B0C9D6">
					<th height="33" scope="col" colspan="3">&nbsp;&nbsp; Import IT Configuration Document &#8658; </th>  
				</tr>
				<tr>
					<td width="20%"><b style="color: red;">*</b>Select file to import</td>
					<td width="1%">:</td>
					<td><input type="file" name="it_doc" id="it_doc"/></td>
				</tr>
				<tr>
					<td colspan="3"><input type="submit" value="     Import     " style="height: 27px;"/></td>
				</tr>
		 </table>
			</form>
		</div>
		<div style="width: 39%;float: right;">
			<table width="100%" border="0" class="gridtable" style="border: none; background-color: white;border-style: solid;border-width: 1px;">
				<tr align="left" style="background-color: #B0C9D6">
					<th height="33" scope="col" colspan="3">&nbsp;&nbsp; Computer Configuration History &#8658; </th>  
				</tr>
				<%
				int k=1;
				PreparedStatement ps_update = null;
				ResultSet rs_update = null;
				PreparedStatement ps_show_file = con.prepareStatement("select * from master_filler order by code desc");
				ResultSet rs_show_file = ps_show_file.executeQuery();
				while(rs_show_file.next()){
				%>
				<tr>
						<td align="right"><b><%=k %>.</b></td>
						<td align="left">
						<a href="Display_ConfigSheet.jsp?field=<%=rs_show_file.getInt("code")%>" style="text-decoration: none;color: green;"> <b> <%=rs_show_file.getString("file_name")%>(<%=rs_show_file.getDate("date_upload") %>)</b></a></td>
						<%
						ps_update = con.prepareStatement("select * from user_tbl where U_Id="+rs_show_file.getInt("uploaded_by"));
						rs_update = ps_update.executeQuery();
						while(rs_update.next()){
						%>
						<td align="left">Uploaded by <b><%=rs_update.getString("U_Name") %></b></td>
						<%
						}
						%>
				</tr>
				<%
				k++;
				}
				ps_show_file.close();
				rs_show_file.close();
				%>
				</table>
		</div>
		<br/><br/><br/><br/><br/><br/>
			<br/><br/><br/><br/><br/><br/> 
		</div>
		
  </div>
   
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
