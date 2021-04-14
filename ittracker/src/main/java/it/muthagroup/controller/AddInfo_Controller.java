package it.muthagroup.controller;
 
import it.muthagroup.dao.User_info_dao;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
public class AddInfo_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String uid = request.getParameter("uid");
			String phone = request.getParameter("phone");		
			
			User_info_dao dao = new User_info_dao();
			dao.addUserInfo(uid,phone,response); 
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}