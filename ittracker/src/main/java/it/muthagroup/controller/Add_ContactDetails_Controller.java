package it.muthagroup.controller;

import it.muthagroup.dao.Device_info_dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Add_ContactDetails_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	try {
		String cont_name =request.getParameter("cont_name");
		String cont_no = request.getParameter("cont_no");
		int asset_id = Integer.parseInt(request.getParameter("asset_id")); 
		
	    HttpSession session = request.getSession(); 
		Device_info_dao dao = new Device_info_dao();
		dao.addNewAMC_ContactInfo(cont_name,cont_no,asset_id,session,response); 
	} catch (Exception e) {
		e.printStackTrace();
	}
	}

}
