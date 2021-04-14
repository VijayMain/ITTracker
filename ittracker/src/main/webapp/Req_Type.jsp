<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%!int i;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>State Page</title>

</head>
<body>
<table>
<%
			String str = request.getParameter("q");

			i = Integer.parseInt(str);

			Connection connection = null;
			try {
				connection = Connection_Utility.getConnection();
				PreparedStatement stmt = null;
				stmt = connection.prepareStatement("select * from it_requisition_type_tbl where Rel_Id="+ i);
				ResultSet rs = null;
				rs = stmt.executeQuery();
				while (rs.next()) {
			%>
			<tr>
				<td>
					<input type="radio" value="<%=rs.getInt("Req_Type_Id")%>" name="req_type"><label><%=rs.getString("Req_Type") %></label> 
				</td>
			</tr>
			<%				
					
				}
		
				}
			
			 catch (SQLException e) {
				e.printStackTrace();
				return;
			}
		%>
		</table>
	</select>

</body>
</html>
