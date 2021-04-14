package it.muthagroup.controller;

import it.muthagroup.dao.Device_info_dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Add_NewSoftware_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	try {		
		String soft = request.getParameter("new_soft");
		int softype = Integer.parseInt(request.getParameter("softtype"));
	    HttpSession session = request.getSession(); 
		Device_info_dao dao = new Device_info_dao();
		dao.addNewSoftware(soft,softype,session,response); 
	} catch (Exception e) {
		e.printStackTrace();
	}
	}

}
