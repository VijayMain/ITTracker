<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DMS Data</title> 
</head>
<body>
<span id="searchId">
<%
String code =request.getParameter("q");
if(code!=""){
%>
 <table style="width: 100%;" class="tftable">
				<tr style="background-color: #acc8cc;height: 25px;">
					<td align="center"><strong>Folder</strong></td>
					<td align="center"><strong>Subject/Title</strong></td>
					<td align="center"><strong>Document</strong></td>
				    <td align="center"><strong>Note</strong></td>
				  </tr>
   <%
   try{
	   Connection con = Connection_Utility.getConnection();
	   
	   
	   int uid = Integer.parseInt(session.getAttribute("uid").toString());
	   PreparedStatement ps = null,ps_dms=null,ps_use=null;
	   ResultSet rs = null,rs_dms=null,rs_use=null;
	   String uname = "",cr_use="";
	  int d_Id=0,comp_id=0;
	  String folder = "",subject_name="";
	  PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
		ResultSet rs_uname = ps_uname.executeQuery();
		while (rs_uname.next()) {
			d_Id = rs_uname.getInt("Dept_Id");
			comp_id = rs_uname.getInt("Company_Id");
			uname = rs_uname.getString("U_Name");
		}
	   ps = con.prepareStatement("SELECT * FROM complaintzilla.tarn_dms where FILE_NAME like '%"+code+"%' and tran_no in (SELECT code FROM complaintzilla.mst_dmsfolder where user="+uid+")");
	   rs = ps.executeQuery();
	   while(rs.next()){
		   subject_name = rs.getString("subject_title");
		   ps_dms = con.prepareStatement("select * from mst_dmsfolder where CODE="+rs.getInt("TRAN_NO"));
		   rs_dms = ps_dms.executeQuery();
		   while(rs_dms.next()){
			   folder=rs_dms.getString("FOLDER"); 
		   }
		   ps_use = con.prepareStatement("select * from user_tbl where u_id="+rs.getInt("user"));
			  rs_use = ps_use.executeQuery();
			  while(rs_use.next()){
					 cr_use = rs_use.getString("u_name");
			  }
	%>
	<tr>
	<td><%=folder %></td>
	<td><%=subject_name %></td>
	<td align="left"  style="font-size:11px;word-wrap: break-word;max-width:100px;">
<a href="Display_Doc.jsp?field=<%=rs.getInt("CODE")%>" style="color: #3a22c8;"  title="Created By <%=cr_use%>"><b><%=rs.getString("File_Name")%></b></a>
	</td>
	<td><%=rs.getString("NOTE") %></td>
	</tr>
	<% 
	folder="";
	cr_use="";
	subject_name = "";
	   }
	   ps = con.prepareStatement("SELECT * FROM complaintzilla.tarn_dms where FILE_NAME like '%" +code+ "%' and tran_no in (SELECT code FROM mst_dmsfolder where code in (SELECT dms_code FROM mst_comp where company in("+comp_id+",0)) and "+
			   " code in(SELECT dms_code FROM mst_dept where dept in("+d_Id+",0)) and code in(SELECT dms_code FROM mst_dmsuser "+ 
			   " where USER in('"+uname+"','0')) and share_flag=1 and user!="+uid +")");
	   rs = ps.executeQuery();
	   while(rs.next()){
		   subject_name = rs.getString("subject_title");
		   ps_dms = con.prepareStatement("select * from mst_dmsfolder where CODE="+rs.getInt("TRAN_NO"));
		   rs_dms = ps_dms.executeQuery();
		   while(rs_dms.next()){
			   folder=rs_dms.getString("FOLDER");
		   }
		   ps_use = con.prepareStatement("select * from user_tbl where u_id="+rs.getInt("user"));
			  rs_use = ps_use.executeQuery();
			  while(rs_use.next()){
					 cr_use = rs_use.getString("u_name");
			  }
	%>
	<tr>
	<td><%=folder %></td>
	<td><%=subject_name %></td>
	<td align="left"  style="font-size:11px;word-wrap: break-word;max-width:100px;">
<a href="Display_Doc.jsp?field=<%=rs.getInt("CODE")%>" style="color: #3a22c8;"  title="Created By <%=cr_use%>"><b><%=rs.getString("File_Name")%></b></a>
	</td>
	<td><%=rs.getString("NOTE") %></td>
	</tr>
	<% 
	folder="";
	cr_use="";
	subject_name="";
	   }
	   
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	</table>
	<%
	}
	%>
</span>
</body>
</html>