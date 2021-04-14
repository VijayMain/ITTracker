<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<span id="availFolder">
<%
try{ 
	String name = request.getParameter("q"); 
	boolean flag = false;
	Connection con = Connection_Utility.getConnection();
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	PreparedStatement ps_dept = con.prepareStatement("select * from mst_dmsfolder where USER=" + uid + " and FOLDER ='"+name +"'");
	ResultSet rs_dept = ps_dept.executeQuery();
	while(rs_dept.next()){
		flag=true;
	}
		if(flag==true){
	%>
		<b style="font-size: 10px;color: red;">Already Available !!!</b>
		<input type="hidden" name="avail" id="avail" value="1">
	<%			
		}else{
		%>
			<input type="hidden" name="avail" id="avail" value="0">
		<%			
		}
}catch(Exception e){
	e.printStackTrace();
}
%>
</span>
</body>
</html>