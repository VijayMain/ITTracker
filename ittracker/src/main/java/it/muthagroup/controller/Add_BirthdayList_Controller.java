package it.muthagroup.controller;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class Add_BirthdayList_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Connection con = Connection_Utility.getConnection();
			String uid = request.getParameter("uid"); 
			String dd = request.getParameter("day");
			String mm = request.getParameter("month");
			String yyyy = request.getParameter("year");
			String bdate = yyyy+"-"+mm+"-"+dd; 
			String chkdate = dd+mm; 
			
			   SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM-dd");
			   java.util.Date date = sdf1.parse(bdate);
			   
			   java.sql.Date sqlbDate = new Date(date.getTime());
			   
			   
			   PreparedStatement ps_bdate = con.prepareStatement("update user_tbl set birth_date=?,Bdays=? where U_Id="+uid);
			   ps_bdate.setDate(1, sqlbDate);
			   ps_bdate.setString(2, chkdate);
			   int up = ps_bdate.executeUpdate();
			   
			   if(up>0){
				   response.sendRedirect("User_List.jsp");
			   }
			    
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
