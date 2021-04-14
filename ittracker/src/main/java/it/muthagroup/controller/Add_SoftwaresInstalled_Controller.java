package it.muthagroup.controller;

import it.muthagroup.bo.software_access_bo;
import it.muthagroup.dao.Software_Installed_dao;
import it.muthagroup.vo.software_access_vo;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Add_SoftwaresInstalled_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			int note=0;
			boolean flag=false;
			HttpSession session=request.getSession();
			String[] softNames= request.getParameterValues("software_selected");
			ArrayList<String> soft=new ArrayList<String>();	
			for(int i=0;i<softNames.length; i++)
			{
				soft.add(softNames[i]);
				System.out.println("selected softwares.. "+softNames[i]);
			}
			System.out.println("selected softwares.. "+soft);
			note=Integer.parseInt(request.getParameter("uname"));
			System.out.println("selected user Id .. "+note);
			
			software_access_vo vo=new software_access_vo();
			
			vo.setSoft(soft);
			vo.setUid(note);
			
			Software_Installed_dao dao=new Software_Installed_dao();
			
			flag=dao.addSoftInstalled(session,vo);
			
			if(flag==true)
			{
				response.sendRedirect("Asset_Master.jsp");
			}
			else
			{
				response.sendRedirect("Asset_Master.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
