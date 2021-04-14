package it.muthagroup.controller;

import it.muthagroup.bo.software_access_bo;
import it.muthagroup.dao.software_access_dao;
import it.muthagroup.vo.software_access_vo;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class software_access_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		int uid=0;
		boolean flag=false;
		HttpSession session=request.getSession();
		String[] softNames= request.getParameterValues("software_selected");
		ArrayList<String> soft=new ArrayList<String>();	
		for(int i=0;i<softNames.length; i++)
		{
			soft.add(softNames[i]);
			//System.out.println("selected softwares.. "+softNames[i]);
		}
		//System.out.println("selected softwares.. "+soft);
		uid=Integer.parseInt(request.getParameter("uname"));
		//System.out.println("selected user Id .. "+uid);
		
		software_access_vo vo=new software_access_vo();
		
		vo.setSoft(soft);
		vo.setUid(uid);
		
		software_access_bo bo=new software_access_bo();
		
		flag=bo.addAccess(session,vo);
		
		if(flag==true)
		{
			response.sendRedirect("Software_Access.jsp");
		}
		else
		{
			response.sendRedirect("Error.jsp");
		}
		
		
	}

}
