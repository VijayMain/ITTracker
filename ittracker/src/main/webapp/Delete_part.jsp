<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Date"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>Delete Part</title>
</head>
<body>
<!--============================================================================-->
	<!--================== Delete Attachment =================================-->
	<!--============================================================================-->
	<%
		try {
			int termid = Integer.parseInt(request.getParameter("termid"));
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			
			Date curr_Date = new Date(System.currentTimeMillis());
			PreparedStatement ps_att = con.prepareStatement("update it_asset_it_terms_tbl set deleted_by=?,delete_date=?,Enable_id=? where asset_IT_Terms_id=" + termid);
			ps_att.setInt(1, uid);
			ps_att.setDate(2, curr_Date);
			ps_att.setInt(3, 0);
			int up = ps_att.executeUpdate();
			
			if(up>0){
	%>
	<table border="1" id="delete" style="font-size: 12px; color: #333333; width: 80%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="4" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Available Terms and Conditions </b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>File Description </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Date </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Attachments </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Delete </b></td> 
	</tr>
	<%
	PreparedStatement ps_term=con.prepareStatement("select * from it_asset_it_terms_tbl where Enable_id=1");
	ResultSet rs_term = ps_term.executeQuery();
	while(rs_term.next()){
	%>
	<tr>
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_term.getString("description") %></td>
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_term.getDate("attached_date") %></td>
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">
		<a href="Display_terms.jsp?field=<%=rs_term.getInt("asset_IT_Terms_id")%>"><%=rs_term.getString("file_name")%></a>
		</td>		
		<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">		
		<input type="button" name="delete" value="Delete" onclick="delother('<%=rs_term.getInt("asset_IT_Terms_id")%>')" />			
</td>
	</tr>
	<%
	}
	%> 
	</table>
	<%			
	}else{
	%>
	<table border="1" id="delete" style="font-size: 12px; color: #333333; width: 80%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="4" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Available Terms and Conditions </b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>File Description </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Date </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Attachments </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Delete </b></td> 
	</tr>
	<tr>
	<td colspan="4"><span style="color: red;"> Error Occurred !!!</span> </td>
	</tr>
	</table>
	<%			
		}

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<!--============================================================================-->
	<!--============================================================================-->

</body>
</html>