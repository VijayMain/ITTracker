package it.muthagroup.controller;
 
import it.muthagroup.dao.MIS_access_dao;
import it.muthagroup.vo.MIS_access_vo;  
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class MIS_AccessController extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
try {
	int uid=0;
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
	
	uid=Integer.parseInt(request.getParameter("uname"));
	
	System.out.println("selected user Id .. "+uid);
	
	MIS_access_vo vo=new MIS_access_vo();
	
	
	Set<String> se =new HashSet();
	se.addAll(soft);
	soft.clear();
	soft = new ArrayList<String>(se);
	
	
	vo.setSoft(soft);
	vo.setUid(uid);
	
	MIS_access_dao dao=new MIS_access_dao();
	
	flag=dao.addAccess(session,vo);
	
	if(flag==true)
	{
		response.sendRedirect("MISAccess.jsp");
	}
	else
	{
		response.sendRedirect("MISAccess_Error.jsp");
	}
	} catch (Exception e) {
	e.printStackTrace();
	}
  }
}