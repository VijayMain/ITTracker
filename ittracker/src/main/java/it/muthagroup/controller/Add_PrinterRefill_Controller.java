package it.muthagroup.controller;

import it.muthagroup.dao.Device_info_dao;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Add_PrinterRefill_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {                          
			String dev_name = request.getParameter("dev_name");
			String beforeRefill = request.getParameter("beforeRefill");
			String afterRefill = request.getParameter("afterRefill");
			String inkused = request.getParameter("inkused");
			String avg_count = request.getParameter("avg_count");
			String refilldate = request.getParameter("refilldate");
			String itperson = request.getParameter("itperson"); 
			String details = request.getParameter("details"); 
			if(Integer.parseInt(beforeRefill) <= Integer.parseInt(afterRefill)){ 
		    HttpSession session = request.getSession(); 
			Device_info_dao dao = new Device_info_dao();
			dao.addprinterRefill(dev_name,beforeRefill,afterRefill,inkused,avg_count,refilldate,itperson,details,session,response);
			}else {
				String error = "Wrong Print Count !!!";
				response.sendRedirect("Add_printerRefill.jsp?error="+error);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
