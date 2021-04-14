package it.muthagroup.controller;

import it.muthagroup.dao.Device_info_dao;

import java.io.IOException; 
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Add_CompanyAssets_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
		try { 
			int dev_name = Integer.parseInt(request.getParameter("dev_name"));
			int company = Integer.parseInt(request.getParameter("company"));
			int installed_by = Integer.parseInt(request.getParameter("installed_by"));
			String location = request.getParameter("location");
			String dateinstall = request.getParameter("dateinstall");
			String details = request.getParameter("details");
			ArrayList soft=new ArrayList();
			
			//new java.sql.Date(dateFormat.parse(request.getParameter("dateinstall")).getTime());
			
			String[] software = request.getParameterValues("software");   
		    if (software!=null) {
		       for (int index=0; index<software.length; index++) {
		            soft.add(software[index]);
		       }
		    }
			
		    HttpSession session = request.getSession();
			Device_info_dao dao = new Device_info_dao();
			
			dao.addNewCompany_DeviceInfo(dev_name,soft,company,installed_by,location,dateinstall,details,session,response);			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
