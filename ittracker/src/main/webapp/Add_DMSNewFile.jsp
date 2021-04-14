<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.PreparedStatement"%>
<html>
<head> 
<title>Add New File DMS</title>
<link rel="stylesheet" href="js/jquery-ui.css" />
<script src="js/jquery-1.9.1.js"></script>
<script src="js/jquery-ui.js"></script>
</head>
<body>
	<%
		try {
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int code = Integer.parseInt(request.getParameter("q"));
			String folder = request.getParameter("r");
			PreparedStatement ps_data = null,ps_chk=null,ps_use = null;
			ResultSet rs_data = null,rs_chk=null,rs_use = null;
			int flagchk=0;
		    String rights="",cr_use="",cr_note = "";
		    ArrayList dept_check=new ArrayList();
		    
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
	%>
	<span id="new_dms">
	<div style="float: left;width: 74.9%;height: 550px;overflow: scroll;">
        <table style="width: 100%;" class="tftable">
			<%-- <tr>
						<th colspan="6" align="center"><strong>Add New Document to <b style="color: #525c05"><%=folder %></b></strong></th>
					</tr>
			--%>
				<tr  style="background-color:#3d6f74;color: white;">
					<td align="center" height="25">Folder</td>
				    <td align="center">Shared Rights</td>
				    <td align="center">Companies</td>
				    <td align="center">Departments</td>
			<!-- <td align="center">Document</td>  -->
			    </tr>
			    <%
			    PreparedStatement ps =con.prepareStatement("select * from mst_dmsfolder where CODE=" + code);
			    ResultSet rs = ps.executeQuery();
			    while(rs.next()){
			    	if(rs.getInt("SHARED_ACCESS")==1){
						rights = "Full";
						}else{
						rights = "Read Only";
						}
						if(rs.getInt("SHARE_FLAG")==0){
							rights = "Sharing Off";
						}
			    %>
			    <tr> 
				  <td align="center"><%=folder %> <%--rs.getString("SUBJECT") --%></td>
				  <td align="center"><%=rights %></td>
				  <td align="center">
				 <!--
					---------------------------------------------- Company ---------------------------------------------   
				 -->
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
				  <!--
				  ------------------------------------------------------------------------------------------------------------- 
				   -->
				  </td>
				  <%-- <td align="center">
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
				   <!--
					---------------------------------------------- Department ---------------------------------------------   
				  -->  
				  </td> --%>
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
				  <!--
					---------------------------------------------- Documents ---------------------------------------------   
				  --> 
				  <%-- <td align="left">
				 <%
				  ps_data = con.prepareStatement("SELECT * FROM tarn_dms where tran_no="+code);
				  rs_data = ps_data.executeQuery(); 
				  while(rs_data.next()){
					  ps_use = con.prepareStatement("select * from user_tbl where u_id="+rs_data.getInt("user"));
						rs_use = ps_use.executeQuery();
						while(rs_use.next()){
							 cr_use = rs_use.getString("u_name");
						}
						cr_note = rs_data.getString("note");
				  %>
				  &nbsp;<a href="Display_Doc.jsp?field=<%=rs_data.getInt("CODE")%>" style="color: #3a22c8" 
				  title="Created By <%=cr_use%>
Note : <%=rs_data.getString("note")%>"><b><%=rs_data.getString("File_Name")%></b></a><font style="color: black;font-family: Arial;">---<%= cr_note%></font>
				  <br>
				  <%
				  }
				  %>
				  </td> --%>
		  		</tr>
		  		<%
			    }
		  		%>
         </table> 
         <%
			if(!dept_check.contains(7) || ins_check!=7){
		%>
		<form action="Add_NewDMSFile" method="post" enctype="multipart/form-data" onSubmit="return validateNewDMSFile();">
         <input type="hidden" name="code" id="code" value="<%=code%>">
         <input type="hidden" name="folder" id="folder" value="<%=folder%>">
			<table style="width: 100%;" class="tftable"> 
				<tr  style="background-color:#3d6f74;color: white;">
					<td colspan="2" height="25"><strong>Add New Document &#8658;</strong></td>
				</tr>
				<tr>
				  <td align="left"><strong>Subject/Title</strong></td>
			      <td align="left"><input type="text" name="subject_title" id="subject_titleHome"  size="30" style="background-color:#d5f1ff;"></td>
		      	</tr>
				<tr>
					<td width="12%" align="left"><strong>Attach file</strong></td>
					<td width="88%" align="left">
                    <table id="tblSample">
						<tr>&nbsp;&nbsp;&nbsp;
						<strong><input type="button" value="  Click To ADD Files  " name="button" onClick="addRowToTable();" />
						</strong> &nbsp;&nbsp;
						<input type="button" value=" Delete [Selected] " onClick="deleteChecked();" />
						&nbsp;&nbsp;<input type="hidden" id="srno" name="srno" value="">
						</tr>
						<tbody></tbody>
					 </table>
                    </td>
			    </tr>
				<tr>
				  <td align="left"><strong>Note</strong></td>
			      <td align="left"><textarea name="note" id="note" rows="2" cols="50" style="background-color:#d5f1ff;"></textarea></td>
		      	</tr>
				<tr>
					<td colspan="2" align="left" style="padding-left: 20px;">
						<input type="submit" name="submit" value="   SAVE   " style="height: 30px; width: 200px; font-weight: bold;" />					</td>
				</tr>
			</table>
			</form>
			<%
			}else{
			%>       
		 <form action="Add_NewDMSDEVFile" method="post" enctype="multipart/form-data" onSubmit="return validateDEVDMSFile();">
         <input type="hidden" name="code" id="code" value="<%=code%>">
         <input type="hidden" name="folder" id="folder" value="<%=folder%>">
			<table style="width: 100%;" class="tftable">
				 <tr style="background-color:#3d6f74;color: white;">
						<td colspan="2" height="25"><strong>Add New Document &#8658;</strong></td>
				 </tr>
				 <tr>
					  <td width="16%" align="left"><strong>Subject/Title</strong></td>
					  <td width="84%" align="left"><input type="text" name="subject_title" id="subject_title" size="30" style="background-color:#d5f1ff;"></td>
				  </tr>
				  <tr>
					  <td width="16%" align="left"><strong>Work Carried out by</strong></td>
					  <td width="84%" align="left"><input type="text" name="carriedout" id="carriedout" size="30" style="background-color:#d5f1ff;"></td>
				  </tr>
					<tr>
					  <td align="left"><strong>Vide Bill No</strong></td>
					  <td align="left"><input type="text" name="videbill" id="videbill" size="30" style="background-color:#d5f1ff;"></td>
				  </tr>
					<tr>
					  <td align="left"><strong>Dated</strong></td>
					  <td align="left">
					  <input id="demo4" name="dated" onclick="javascript:NewCal('demo4','ddmmyyyy',true,24)"    style="background-color:#d5f1ff;"
										type="text" size="25" readonly="readonly"
										TITLE="Click on Date Picker" /> <a
										href="javascript:NewCal('demo4','ddmmyyyy',true,24)"> <img
											src="cal.gif" width="16" height="16" border="0"
											alt="Pick a date"  style="background-color:#d5f1ff;"/></a> </td>
				  </tr>
					<tr>
					  <td align="left"><strong>For Rs.</strong></td>
					  <td align="left"><input type="text" name="forrs" id="forrs" size="30" style="background-color:#d5f1ff;"  onkeypress ="return validatenumerics(event);"></td>
				  </tr>
				 <tr>
					  <td align="left"><strong>Purchase/work Order No</strong></td>
					  <td align="left"><input type="text" name="purorder" id="purorder" size="30" style="background-color:#d5f1ff;"></td>
				  </tr>
				  <tr>
					  <td align="left"><strong>Attach File</strong></td>
					  <td align="left"><input type="file" name="filename" id="filename" size="30" style="background-color:#d5f1ff;"></td>
				  </tr>
					<tr>
					  <td align="left"><strong>Remark</strong></td>
				      <td align="left"><textarea name="remark" id="remark" rows="2" cols="50" style="background-color:#d5f1ff;"></textarea></td>
			      	</tr>
					<tr>
						<td colspan="2" align="left" style="padding-left: 20px;">
							<input type="submit" name="submit" id="submit" value="   SAVE   " style="height: 30px; width: 200px; font-weight: bold;" />						
						</td>
					</tr>
				</table>
			</form>
			<%
			}
			%>
			</div>
			<!-- <div style="float: right;width: 45%;height: 500px;overflow: scroll;">
			<table style="width: 100%;" class="tftable"> 
					<tr  style="background-color:#3d6f74;color: white;">
						<td colspan="2" height="25"><strong>Add New Document &#8658;</strong></td>
					</tr>
			</table>		
			</div> -->
	</span>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>