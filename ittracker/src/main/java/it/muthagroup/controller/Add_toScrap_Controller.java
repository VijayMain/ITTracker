package it.muthagroup.controller;

import it.muthagroup.dao.Device_info_dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Add_toScrap_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {     
			int dev_name = Integer.parseInt(request.getParameter("dev_name")); 
			String scrap_date = request.getParameter("scrap_date");
			String reason = request.getParameter("reason");
			int checkedby = Integer.parseInt(request.getParameter("checkedby")); 
			
		    HttpSession session = request.getSession();
			Device_info_dao dao = new Device_info_dao();  
			dao.addNewScrapInfo(dev_name,scrap_date,reason,checkedby,session,response);			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
