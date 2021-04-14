package it.muthagroup.controller;

import it.muthagroup.bo.login_bo;
import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.login_vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Login_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	String u_name=null;
	String pwd=null;
	boolean flag=false;
	Connection con=Connection_Utility.getConnection();
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try{
			
		u_name=request.getParameter("u_name");
		pwd=request.getParameter("u_pwd");
		HttpSession session = request.getSession();
		login_vo vo=new login_vo();
		
		vo.setU_name(u_name);
		vo.setU_pwd(pwd);
		
		int dept_id=0;
		login_bo bo=new login_bo();
			
		bo.chkLogin(vo,response,session);
		
		
		}catch(Exception e)
		{
			e.printStackTrace();
		}
	}

}
