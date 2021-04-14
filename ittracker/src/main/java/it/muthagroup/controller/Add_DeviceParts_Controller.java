package it.muthagroup.controller;

import it.muthagroup.dao.Add_DeviceParts_dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Add_DeviceParts_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			                
			int devicename=Integer.parseInt(request.getParameter("devicename"));
			int parttype=Integer.parseInt(request.getParameter("parttype"));
			int qty=Integer.parseInt(request.getParameter("qty"));
			String specification = request.getParameter("specification");
			
		    HttpSession session = request.getSession(); 
		    Add_DeviceParts_dao dao = new Add_DeviceParts_dao();
			dao.addNewDeviceParts(devicename,parttype,qty,specification,session,response); 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
