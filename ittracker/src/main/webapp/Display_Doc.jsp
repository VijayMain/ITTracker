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
<title>Delete Attachment</title>
</head>
<body>
<!--======================== Delete My Document Attachment ==================================-->
<!--=========================================================================================-->
	<%
		try {
			final int BUFFER_SIZE = 8096;
			Connection con = Connection_Utility.getConnection();
			int trnCode = Integer.parseInt(request.getParameter("field"));
			
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			String reg_uname=""; 
			
			 
			java.util.Date date= new java.util.Date();
			Timestamp sqlDate = new Timestamp(date.getTime());
			
			
			PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
			ResultSet rs_uname = ps_uname.executeQuery();
			while (rs_uname.next()) { 
				reg_uname = rs_uname.getString("U_Name");
			}
			 
			
			
			PreparedStatement ps = con.prepareStatement("select * from tarn_dms where CODE=" + trnCode);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				String name = rs.getString("FILE_NAME");
				int dmscode = rs.getInt("TRAN_NO");
				Blob blob = rs.getBlob("FILE");
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
				String headerValue = String.format("attachment; filename=\"%s\"", rs.getString("FILE_NAME"));
				response.setHeader(headerKey, headerValue);

				OutputStream outStream = response.getOutputStream();

				byte[] buffer = new byte[BUFFER_SIZE];
				int bytesRead = -1;

				while ((bytesRead = inputStream.read(buffer)) != -1) {
					outStream.write(buffer, 0, bytesRead);
				}

				inputStream.close();
				outStream.close();
				
				PreparedStatement ps_fileHist = con.prepareStatement("insert into mst_dmshist(DMS_CODE,TRAN_FILE,USER,DATE,STATUS,TRAN_CODE)values(?,?,?,?,?,?)");
				ps_fileHist.setInt(1, dmscode);
				ps_fileHist.setString(2, name);
				ps_fileHist.setString(3, reg_uname);
				ps_fileHist.setTimestamp(4, sqlDate);
				ps_fileHist.setString(5, "Downloaded");
				ps_fileHist.setInt(6, trnCode);
				
				int up_hist =  ps_fileHist.executeUpdate();
				
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