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
<title>Disable User</title>
</head>
<body>

	<%
		try {

			String IdStr = request.getParameter("q");
			int id = Integer.parseInt(IdStr);
			System.out.println("AJAX Page");
			int st = 0;
			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps_status = con
					.prepareStatement("select * from user_tbl where U_Id="
							+ id);
			ResultSet rs_status = ps_status.executeQuery();
			while (rs_status.next()) {
				st = rs_status.getInt("Enable_id");
			}

			if (st == 1) {
				System.out.println("Loop 1");

				PreparedStatement ps_disable = con
						.prepareStatement("update user_tbl set Enable_id=0 where U_Id="
								+ id);
				ps_disable.executeUpdate();
			} else {
				System.out.println("Loop 2");
				PreparedStatement ps_enable = con
						.prepareStatement("update user_tbl set Enable_id=1 where U_Id="
								+ id);
				ps_enable.executeUpdate();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

</body>
</html>