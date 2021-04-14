<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<html>
<head>
<title>Get Device Name</title>
</head>
<body>
	<%
		try {
			String IdStr = request.getParameter("q");
			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps_status = con
					.prepareStatement("select * from it_asset_deviceinfo_tbl where device_name!='"
							+ IdStr + "'");
			ResultSet rs_status = ps_status.executeQuery();

			rs_status.last();
			int data = rs_status.getRow();
			rs_status.beforeFirst();

			if (data>0 && IdStr != "") {
	%>
	<span id="chkDeviceNm"><img alt="images/tick.png"
		src="images/tick.png" height="20px"><a href="Asset_Master.jsp">&nbsp;&nbsp;&nbsp;<strong style="background-color: #DBDBDB">Reset</strong> </a> </span>
	<%
		} else if(IdStr == "") {
	%>
	<span id="chkDeviceNm"><strong style="color: red;">Blank Device Name !!!</strong><a href="Asset_Master.jsp">&nbsp;&nbsp;&nbsp;<strong  style="background-color: #DBDBDB">Reset</strong> </a>  </span>
	<%
		}else{
	%>
	<span id="chkDeviceNm"><strong style="color: red;">Not Available</strong><a href="Asset_Master.jsp">&nbsp;&nbsp;&nbsp;<strong  style="background-color: #DBDBDB">Reset</strong> </a>  </span>
	<%		
		}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
</body>
</html>