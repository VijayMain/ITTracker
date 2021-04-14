<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<title>Avail stock</title>
</head>
<body>
<%
try{
	Connection con = Connection_Utility.getConnection();
	int i = Integer.parseInt(request.getParameter("q"));
	int partId = 0; 
	PreparedStatement ps_rel=con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where asset_deviceitem_mst_id="+i);
	ResultSet rs_rel=ps_rel.executeQuery();
	while(rs_rel.next()){
	%>
	<span id="getstk"><strong><%=rs_rel.getInt("Available_qty") %> </strong> </span> 
	<input type="hidden" name="avail_stk" id="avail_stk" value="<%=rs_rel.getInt("Available_qty") %>"/>
<%
	}
}catch(Exception e){
	e.printStackTrace();
}
%>
</body>
</html>