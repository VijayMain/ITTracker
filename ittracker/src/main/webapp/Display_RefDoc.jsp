<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%> 
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%> 
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ref Attachment</title>
</head>
<body>
<!--======================== Ref Attachment ==================================-->
<!--=========================================================================================-->
	<%
		try {
			final int BUFFER_SIZE = 8096;
			Connection con = Connection_Utility.getConnection();
			int trnCode = Integer.parseInt(request.getParameter("field"));
			 
			PreparedStatement ps = con.prepareStatement("select * from tarn_dms_devrel where CODE=" + trnCode);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				String name = rs.getString("decline_filename"); 
				Blob blob = rs.getBlob("decline_file");
				InputStream inputStream = blob.getBinaryStream();
				int filelength = inputStream.available();
				ServletContext context = getServletContext();

				String mimeType = context.getMimeType(name);
				if (mimeType == null) {
					mimeType = "application/octet-stream";
				}

				response.setContentType(mimeType);
				response.setContentLength(filelength);
				String headerKey = "Content-Disposition";
				String headerValue = String.format("attachment; filename=\"%s\"", rs.getString("decline_filename"));
				response.setHeader(headerKey, headerValue);

				OutputStream outStream = response.getOutputStream();

				byte[] buffer = new byte[BUFFER_SIZE];
				int bytesRead = -1;

				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outStream.write(buffer, 0, bytesRead);
				} 
				inputStream.close();
				outStream.close(); 
				
			} else {
				response.getWriter().println("File not found for the id: " + request.getParameter("field"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	%> 
<!--============================================================================--> 
<!--============================================================================-->
</body>
</html>