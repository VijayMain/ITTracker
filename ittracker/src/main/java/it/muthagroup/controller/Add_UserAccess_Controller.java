package it.muthagroup.controller;

import it.muthagroup.dao.Device_info_dao;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Add_UserAccess_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {		           
			String username = request.getParameter("username");
			String accessdate = request.getParameter("accessdate");
			String notes = request.getParameter("notes");
			
			ArrayList accesslist=new ArrayList();			
			String[] list = request.getParameterValues("accesslist");      
		    if (list!=null) {
		       for (int index=0; index<list.length; index++) {    
		    	   accesslist.add(list[index]);
		       }
		    }  
		    HttpSession session = request.getSession(); 
			Device_info_dao dao = new Device_info_dao();
			dao.add_UserAccess(username,accessdate,accesslist,notes,session,response); 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
