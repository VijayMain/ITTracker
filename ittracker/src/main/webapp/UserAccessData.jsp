<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head> 
<title>User Access</title>
</head>
<body>
<span id="accessData">
<%
			String str = request.getParameter("q");
			int i = Integer.parseInt(str);
			int srno=1;
			Connection con  = Connection_Utility.getConnection();
			String name = "";
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy"); 
			PreparedStatement ps_user = con.prepareStatement("select * from user_tbl where U_Id="+i);
			ResultSet rs_user = ps_user.executeQuery();
			while(rs_user.next()){
				name = rs_user.getString("U_Name");
			}
%>
<table border="1" style="font-size: 12px; color: #333333; width: 100%; border-width: 1px; border-color: #729ea5; border-collapse: collapse;">
	<tr>
	<td colspan="4" style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Available Access Detail for <%=name %></b></td> 
	</tr>
	<tr>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Sr. No</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Access Provided</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Date</b></td>
	<td style="background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b>Notes</b></td> 
	</tr>
	<%
	PreparedStatement ps_useraccess = con.prepareStatement("select * from it_asset_access_tbl where user_name="+i);
	ResultSet rs_useraccess = ps_useraccess.executeQuery();
	while(rs_useraccess.next()){
	%>
	<tr>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><%=srno %></td>
	<%
	PreparedStatement ps_access = con.prepareStatement("select * from it_asset_accesslist_tbl where accesslist_id="+rs_useraccess.getInt("accesslist_id"));
	ResultSet rs_access = ps_access.executeQuery();
	while(rs_access.next()){
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b><%=rs_access.getString("access_name") %></b></td>
	<%
	}
	%>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b><%=formatter.format(rs_useraccess.getDate("approve_date"))%></b></td>
	<td style="border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;"><b><%=rs_useraccess.getString("notes") %></b></td> 
	</tr>
	<%
	srno++;
	} 
	%>
	</table>
	</span>
</body>
</html>