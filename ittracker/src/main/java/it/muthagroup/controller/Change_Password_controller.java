package it.muthagroup.controller;

import it.muthagroup.bo.Change_Password_bo;
import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.Change_Password_vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class Change_Password_controller extends HttpServlet 
{

	String curr_pwd=null;
	String new_pwd=null;
	String new_r_pwd=null;
	int u_id=0;
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session=request.getSession();
		
		curr_pwd=request.getParameter("c_pwd");
		new_pwd=request.getParameter("new_pwd");
		new_r_pwd=request.getParameter("new_r_pwd");
		
		u_id=Integer.parseInt(session.getAttribute("uid").toString());
		
		Change_Password_vo vo=new Change_Password_vo();
		
		vo.setCurr_pwd(curr_pwd);
		vo.setNew_pwd(new_pwd);
		vo.setNew_r_pwd(new_r_pwd);
		vo.setU_id(u_id);
		
		Change_Password_bo bo=new Change_Password_bo();
		
		bo.chnage_pwd(session,request,response,vo);
		
		
		
		
		
	}

}
