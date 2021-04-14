package it.muthagroup.controller;

import it.muthagroup.bo.Reset_Password_bo;
import it.muthagroup.vo.Reset_Password_vo;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Reset_Password extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String pwd1=null;
		String pwd2=null;
		int user_id=0;
		
		HttpSession session=request.getSession();
		
		pwd1= request.getParameter("pwd1");
		pwd2=request.getParameter("pwd2");
		user_id=Integer.parseInt(request.getParameter("user_id")); 
		if(pwd1.equals(pwd2))
		{
			Reset_Password_vo vo=new Reset_Password_vo();
			
			vo.setPwd1(pwd1);
			vo.setPwd2(pwd2);
			vo.setUser_id(user_id);
			
			Reset_Password_bo bo=new Reset_Password_bo();
			bo.reset_pwd(vo,session,response);
			
		}
		else
		{
			response.sendRedirect("Reset_Password_Error.jsp?u_id="+user_id);
			System.out.println("Error Page");
		}
		
	}

}
