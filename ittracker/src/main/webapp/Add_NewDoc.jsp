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
</head>
<body>
	<%
		try {
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int deptId=0;
			PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
			ResultSet rs_uname = ps_uname.executeQuery();
			while (rs_uname.next()) {
				deptId = rs_uname.getInt("Dept_Id");
			}
	%>
	<span id="new_dms">
		<%
				if(deptId!=7){
		%>
		<form action="Add_NewDMSDoc" method="post" enctype="multipart/form-data" onSubmit="return validateForm();">
			<table style="width: 80%;" class="tftable">
				<tr>
					<th colspan="7" align="center"><strong>Add New Document</strong></th>
				</tr>
				<tr>
					<td width="15%" align="left"><b>Header / Folder Name</b></td>
					<td colspan="6" align="left">
					<input type="text" id="folder" name="folder" style="background-color:#d5f1ff;" maxlength="45"  onkeyup="get_allAvailFolders(this.value)"/>
					<span id="availFolder">
					<input type="hidden" name="avail" id="avail" value="1">
					</span>					</td>
				</tr>
				<tr>
					<td align="left"><b>Subject / File Name</b></td>
					<td colspan="6" align="left"><input type="text" id="subject" name="subject" size="60" readonly="readonly" style="background-color:#d5f1ff;"/></td>
				</tr>
				<!-- <tr>
					<td align="left"><b>Share To Others</b></td>
					<td colspan="6" align="left"><input type="radio" name="share" value="1" id="share_yes" /> Yes
					<input type="radio" name="share" value="0" id="share_no" /> No</td>
				</tr> -->
				<tr>
					<td align="left"><input type="hidden" name="share" value="1" id="share_yes">
					<b>Shared User Access</b><br>(If Shared)</td>
					<td colspan="6" align="left">
					<input type="checkbox" name="add_fileAccess" value="1" id="add_access"/>  Add More Files</td>
				</tr>
				<tr>
					<td align="left"><b>Share To (If Yes)</b><br>Use Ctrl to select Multiple </td>
					<td  align="left"><b>Company :</b> &nbsp;&nbsp;&nbsp;</td>
				    <td  align="left">
				    <select name="company" id="company" size="7" multiple="multiple" tabindex="1" style="width: 150px;background-color:#d5f1ff;">
                    <option value="0">- - - - - All - - - - -</option>
                      <%
							PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where company_id !=6");
							ResultSet rs_comp = ps_comp.executeQuery();
							while(rs_comp.next()){
					  %>
                      <option value="<%=rs_comp.getInt("Company_Id")%>"><%=rs_comp.getString("Company_Name") %></option>
                      <%
							}
					  %>
                    </select></td>
				    <td align="left"><b>Department :</b> &nbsp;</td>
				    <td align="left">
				    <select name="department" id="department" size="7" multiple="multiple" tabindex="1" style="width: 200px;background-color:#d5f1ff;">
                      <option value="0">- - - - - All - - - - -</option>
                      <%
					  PreparedStatement ps_dept = con.prepareStatement("select distinct(Department),dept_id from user_tbl_dept order by Department");
					  ResultSet rs_dept = ps_dept.executeQuery();
					  while(rs_dept.next()){
					  %>
                      <option value="<%=rs_dept.getInt("dept_id")%>"><%=rs_dept.getString("Department") %></option>
                      <%
					   }
					  %>
                    </select></td>
				    <td align="left"><b>Employee :</b></td>
			      <td align="left">
			      <select name="employee" id="employee"  size="7" multiple="multiple" tabindex="1" style="width: 200px;background-color:#d5f1ff;">
                    <option value="0">- - All Selected Dept. users - -</option>
                     <%
					  PreparedStatement ps_emp = con.prepareStatement("select distinct(U_Name) from user_tbl where Enable_id=1 order by u_name");
					  ResultSet rs_emp = ps_emp.executeQuery();
					  while(rs_emp.next()){
					  %>
                      <option value="<%=rs_emp.getString("U_Name")%>"><%=rs_emp.getString("U_Name") %></option>
                      <%
					   }
					  %>
                  </select>  
                  </td>
				</tr> 
				<tr>
					<td align="left"><b>Document</b></td>
					<td colspan="6" align="left">
					<table id="tblSample">
						<tr>&nbsp;&nbsp;&nbsp;
						<strong><input type="button" value="  Click To ADD Files  " name="button" onClick="addRowToTable();" /></strong> &nbsp;&nbsp;
								<input type="button" value=" Delete [Selected] " onClick="deleteChecked();" />&nbsp;&nbsp;
								<input type="hidden" id="srno" name="srno" value="">
						</tr>
						<tbody></tbody>
					 </table>				    </td>
				</tr>
				<tr>
				  <td align="left"><strong>Note</strong></td>
			      <td colspan="6" align="left"><textarea name="note" id="note" rows="2" cols="50" style="background-color:#d5f1ff;"></textarea></td>
		      	</tr> 
				<tr>
					<td colspan="7" align="left" style="padding-left: 20px;">
						<input type="submit" id="submit" name="submit" value="   SAVE   " style="height: 30px; width: 200px; font-weight: bold;" />					</td>
				</tr>
			</table>
	</form>
	<%
				}else{
	%>
	<form action="Add_NewDMS_DEVDoc" method="post"  onSubmit="return validateForm();">
			<table style="width: 80%;" class="tftable">
				<tr>
					<th colspan="7" align="center"><strong>Add New Document</strong></th>
				</tr>
				<tr>
					<td width="15%" align="left"><b>Header / Folder Name</b></td>
					<td colspan="6" align="left">
					<input type="text" id="folder" name="folder" style="background-color:#d5f1ff;" maxlength="45"  onkeyup="get_allAvailFolders(this.value)"/>
					<span id="availFolder">
					<input type="hidden" name="avail" id="avail" value="1">
					</span>					</td>
				</tr>
				<tr>
					<td align="left"><b>Subject / File Name</b></td>
					<td colspan="6" align="left"><input type="text" id="subject" name="subject" size="60" readonly="readonly" style="background-color:#d5f1ff;"/></td>
				</tr>
				<!-- <tr>
					<td align="left"><b>Share To Others</b></td>
					<td colspan="6" align="left"><input type="radio" name="share" value="1" id="share_yes" /> Yes
					<input type="radio" name="share" value="0" id="share_no" /> No</td>
				</tr> -->
				<tr>
					<td align="left"><input type="hidden" name="share" value="1" id="share_yes"> <b>Shared User Access</b><br>(If Shared)</td>
					<td colspan="6" align="left"><input type="checkbox" name="add_fileAccess" value="1" id="add_access"/>  Add More Files</td>
				</tr>
				<tr>
					<td align="left"><b>Share To (If Yes)</b><br>Use Ctrl to select Multiple </td>
					<td  align="left"><b>Company :</b> &nbsp;&nbsp;&nbsp;</td>
				    <td  align="left">
				    <select name="company" id="company" size="7" multiple="multiple" tabindex="1" style="width: 150px;background-color:#d5f1ff;">
                    <option value="0">- - - - - All - - - - -</option>
                      <%
							PreparedStatement ps_comp = con.prepareStatement("select * from user_tbl_company where company_id !=6");
							ResultSet rs_comp = ps_comp.executeQuery();
							while(rs_comp.next()){
					  %>
                      <option value="<%=rs_comp.getInt("Company_Id")%>"><%=rs_comp.getString("Company_Name") %></option>
                      <%
							}
					  %>
                    </select></td>
				    <td align="left"><b>Department :</b> &nbsp;</td>
				    <td align="left">
				    <select name="department" id="department" size="7" multiple="multiple" tabindex="1" style="width: 200px;background-color:#d5f1ff;">
                      <option value="0">- - - - - All - - - - -</option>
                      <%
					  PreparedStatement ps_dept = con.prepareStatement("select distinct(Department),dept_id from user_tbl_dept order by Department");
					  ResultSet rs_dept = ps_dept.executeQuery();
					  while(rs_dept.next()){
					  %>
                      <option value="<%=rs_dept.getInt("dept_id")%>"><%=rs_dept.getString("Department") %></option>
                      <%
					   }
					  %>
                    </select></td>
				    <td align="left"><b>Employee :</b></td>
			      <td align="left">
			      <select name="employee" id="employee"  size="7" multiple="multiple" tabindex="1" style="width: 200px;background-color:#d5f1ff;">
                    <option value="0">- - All Selected Dept. users - -</option>
                     <%
					  PreparedStatement ps_emp = con.prepareStatement("select distinct(U_Name) from user_tbl where Enable_id=1 order by u_name");
					  ResultSet rs_emp = ps_emp.executeQuery();
					  while(rs_emp.next()){
					  %>
                      <option value="<%=rs_emp.getString("U_Name")%>"><%=rs_emp.getString("U_Name") %></option>
                      <%
					   }
					  %>
                  </select>  
                  </td>
				</tr>
				<tr>
					<td colspan="7" align="left" style="padding-left: 20px;">
						<input type="submit" name="submit" value="   SAVE   " style="height: 30px; width: 200px; font-weight: bold;" />					</td>
				</tr>
			</table>
	</form>
	<%				
				}
	%>
	</span>
	<%
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>