package it.muthagroup.controller;

import it.muthagroup.dao.Device_info_dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Add_NewAdapter_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {  
			String new_adapter = request.getParameter("new_adapter");
			String serialno = request.getParameter("serialno");
			String inputoutput = request.getParameter("inputoutput"); 
			
		    HttpSession session = request.getSession(); 
			Device_info_dao dao = new Device_info_dao();
			dao.addNewAdapter(new_adapter,serialno,inputoutput,session,response); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
