package it.muthagroup.controller;

import it.muthagroup.bo.login_bo;
import it.muthagroup.dao.Reset_Password_dao;
import it.muthagroup.vo.login_vo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Reset_atLogin_Controller")
public class Reset_atLogin_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Reset_atLogin_Controller() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			/*String old_pass = request.getParameter("oldPassword");*/
			String new_pass = request.getParameter("newPassword");
			int uid = Integer.parseInt(request.getParameter("uid"));
			HttpSession session = request.getSession();
  
			login_vo vo = new login_vo();
			vo.setUserid(uid);
			vo.setNew_pass(new_pass); 
			/*vo.setOld_pass(old_pass);*/
			int dept_id = 0; 

			// System.out.println("Login = " + old_pass + " = " + new_pass + " = " + uid);

			Reset_Password_dao dao = new Reset_Password_dao();
			dao.resetAtLogin(vo, session, response);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}