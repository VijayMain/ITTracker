<%@page import="java.sql.ResultSet"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Prev. Printer Refill</title>
</head>
<body> 
		<%
 		try {
 		String str = request.getParameter("q");
 		String val = "0";
 		int cnt = 0;
 		int i = Integer.parseInt(str);
 		Connection con = Connection_Utility.getConnection();
 		PreparedStatement ps_prev = con.prepareStatement("select max(asset_printerRefill_id) from it_asset_printerrefill_tbl where asset_deviceinfo_id=" + i);
 		ResultSet rs_prev = ps_prev.executeQuery();
 		while(rs_prev.next()){
 			cnt=rs_prev.getInt("max(asset_printerRefill_id)");
 		}
 		PreparedStatement ps_prevcnt = con.prepareStatement("select * from it_asset_printerrefill_tbl where asset_printerRefill_id=" + cnt);
 		ResultSet rs_prevcnt = ps_prevcnt.executeQuery();
 		while(rs_prevcnt.next()){
 			val=rs_prevcnt.getString("current_print_count");
 		}
 		%>
 		 <span id="userRefill"><input type="text" name="beforeRefill" id="beforeRefill" value="<%=val %>" onkeyup="getAverage()" onkeypress="return validatenumerics(event);"/></span>
 		<%	 		
 		} catch (Exception e) {
 		e.printStackTrace();
	 	}
 %> 
</body>
</html>