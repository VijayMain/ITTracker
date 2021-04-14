<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<title>Avail Part</title>
</head>
<body>
	<%
try{
	Connection con = Connection_Utility.getConnection();
	String devId = request.getParameter("q");
	 
	int i = Integer.parseInt(devId);
	int partId = 0;
	PreparedStatement ps_rel=con.prepareStatement("select * from it_asset_deviceitem_rel_tbl where asset_deviceinfo_id="+i);
	ResultSet rs_rel=ps_rel.executeQuery();
	while(rs_rel.next()){
		partId = rs_rel.getInt("asset_deviceitem_mst_id");
	}
	
	%> 
	<span id="partreplaced">
	<select name="partreplace" id="partreplace"
		style="height: 30px; width: 250px;" onchange="showstock(this.value)">
		<option value="">- - - - - Select - - - - -</option>
		<%
			PreparedStatement ps_part = con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where asset_deviceitem_mst_id="+partId);
			ResultSet rs_part = ps_part.executeQuery();
			while (rs_part.next()) {
		%>
		<option value="<%=rs_part.getInt("asset_deviceitem_mst_id")%>"><%=rs_part.getString("device_parts")%></option>
		<%
			}
			ps_part.close();
			rs_part.close();
		%>
		
	</select> 
	</span>
<% 
con.close();
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>