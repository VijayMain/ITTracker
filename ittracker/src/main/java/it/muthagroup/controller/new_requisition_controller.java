package it.muthagroup.controller;

import it.muthagroup.bo.new_requisition_bo;
import it.muthagroup.vo.new_requisition_vo;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class new_requisition_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int req_no=0,rel_id=0,req_type_id=0;
		
		String req_details=null;
		
		boolean flag=false;
		
		HttpSession session=request.getSession();
		new_requisition_vo vo=new new_requisition_vo();
		
		PrintWriter out=response.getWriter();
		String it_req="";
		if(request.getParameter("it_req")!=null){
			it_req=request.getParameter("it_req");
			vo.setIt_req(it_req);
		}
		
		req_no=Integer.parseInt(request.getParameter("req_no"));
		rel_id=Integer.parseInt(request.getParameter("rel_to"));
		req_type_id=Integer.parseInt(request.getParameter("req_type"));
		req_details=request.getParameter("req_details"); 
		
		vo.setReq_no(req_no);
		vo.setRel_id(rel_id);
		vo.setReq_type_id(req_type_id);
		vo.setReq_details(req_details);
		
		new_requisition_bo bo=new new_requisition_bo();
		
		flag=bo.addReq(vo,session);
		
		if(flag==true && vo.getIt_req().equalsIgnoreCase(""))
		{
			response.sendRedirect("Requisition_Status.jsp");
		}else if(flag==true && vo.getIt_req().equalsIgnoreCase("it_req")){
			response.sendRedirect("IT_Role_Req.jsp");
		}
		else
		{
			out.println("Error.....");
		}
	} 
}