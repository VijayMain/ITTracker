 <%@page import="java.sql.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
 <title>Delete Internal Parts</title>
</head>
<body> 
<%
try{
			int i=0;
			String str = request.getParameter("partId");
			
			Date curr_Date = new Date(System.currentTimeMillis());
			System.out.println("In loop" + curr_Date);
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int deviceitem_rel_id = Integer.parseInt(str);
			Connection con  = Connection_Utility.getConnection();
			  
			PreparedStatement ps_updevitem = con.prepareStatement("update it_asset_deviceitem_rel_tbl set avail_flag=?,updated_by=?,update_date=? where asset_deviceitem_rel_id="+deviceitem_rel_id);
			ps_updevitem.setInt(1, 0);
			ps_updevitem.setInt(2, uid);
			ps_updevitem.setDate(3, curr_Date);
			int update = ps_updevitem.executeUpdate();
			ps_updevitem.close(); 
%>
<span id="data_availPart">
  <table border="1"  style="font-size: 14px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="4" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Details</b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Part Name </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Quantity </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Specification </b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Remove </b></td>  
	</tr>
	<%
	PreparedStatement ps_adev=con.prepareStatement("select * from it_asset_deviceitem_rel_tbl where asset_deviceitem_rel_id="+deviceitem_rel_id+" and avail_flag=1 and scrap_flag=0");
	ResultSet rs_adev=ps_adev.executeQuery();
	while(rs_adev.next()){   
	%>
	<tr align="center"> 
	<%
	PreparedStatement ps_partname=con.prepareStatement("select * from it_asset_devicetype_mst_tbl where devicetype_mst_id="+rs_adev.getInt("devicetype_mst_id"));
	ResultSet rs_partname=ps_partname.executeQuery();
	while(rs_partname.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_partname.getString("device_type") %></td>
	<%
	}
	ps_partname.close();
	rs_partname.close();
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_adev.getString("qty") %></td> 
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=rs_adev.getString("specification") %></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;">
<input type="button" id="delete" name="delete" value="Delete" onclick="delother('<%=rs_adev.getInt("asset_deviceitem_rel_id")%>')" />
</td>
	</tr>
	<% 
		} 	
	}catch(Exception e){
	e.printStackTrace();
	}
	%>
	</table> 
	</span>
</body>
</html>