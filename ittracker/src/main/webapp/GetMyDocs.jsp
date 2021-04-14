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
<title>Get My Doc</title>
</head>
<body>
<span id="new_dms">
   <%
   try{
	   Connection con = Connection_Utility.getConnection();
	   int code = Integer.parseInt(request.getParameter("q"));
	   String folder = request.getParameter("r");
	   PreparedStatement ps_use = null;
	   ResultSet rs_use = null;
	   String cr_use="",cr_note="";
	   PreparedStatement ps_data = null,ps_chk=null;
		ResultSet rs_data = null,rs_chk=null;
		int my_depid=0;
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			my_depid = rs_uname.getInt("Dept_Id"); 
		}
		 
		ArrayList to_emails = new ArrayList();
		//Connection conLocal = Connection_Utility.getLocalDatabase();
		PreparedStatement ps_rec = con.prepareStatement("select distinct(uid) from it_requisition_mail_tbl where enable=1 and sentfor='DMS_Approved'");
		ResultSet rs_rec = ps_rec.executeQuery();
		while (rs_rec.next()) {
			to_emails.add(rs_rec.getString("uid"));
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
				PreparedStatement ps  = con.prepareStatement("select * from mst_dmsfolder where CODE=" + code);
				ResultSet rs = ps.executeQuery();
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
				//  System.out.println(code + "test = " + flagchk);
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
			<form action="Send_DMSApproval" method="post" id="dmsApprove" name="dmsApprove">
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
					  // System.out.println("test = " + to_emails);
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
	<%
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
</span>
</body>
</html>