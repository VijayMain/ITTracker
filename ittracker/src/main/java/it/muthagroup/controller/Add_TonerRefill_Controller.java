package it.muthagroup.controller;

import it.muthagroup.dao.Device_info_dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Add_TonerRefill_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {                                             
			String dev_name = request.getParameter("dev_name"); 
			String operation = request.getParameter("operation");
			String refilldate = request.getParameter("refilldate");
			String count = request.getParameter("count");
			String itperson = request.getParameter("itperson");
			String details = request.getParameter("details");
			String amount = request.getParameter("amount");  
		
		    HttpSession session = request.getSession(); 
			Device_info_dao dao = new Device_info_dao();
			dao.addtonerRefill(dev_name,operation,refilldate,count,itperson,details,amount,session,response);
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
