package it.muthagroup.controller;
 
import it.muthagroup.dao.Device_info_dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Add_NewSpares_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try { 
		    String new_spare=	request.getParameter("new_spare");
		    String avil_stock=	request.getParameter("avil_stock");
		    String details=	request.getParameter("details");
		    HttpSession session = request.getSession(); 
			Device_info_dao dao = new Device_info_dao();
			dao.addNewSpares(new_spare,avil_stock,details,session,response); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
