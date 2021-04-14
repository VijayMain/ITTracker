package it.muthagroup.controller;

import it.muthagroup.bo.Search_Req_bo;
import it.muthagroup.vo.Search_Req_vo;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


public class Search_requisition_controller extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	int u_id=0,rel_to=0,req_type=0;
	String fdate=null,sdate=null;
	
	Timestamp f_date=null,s_date=null;
	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		u_id=Integer.parseInt(request.getParameter("user_id"));
		rel_to=Integer.parseInt(request.getParameter("rel_id"));
		req_type=Integer.parseInt(request.getParameter("req_type"));
		fdate=request.getParameter("first_date");
		sdate=request.getParameter("last_date");
		HttpSession session=request.getSession();
		
		SimpleDateFormat formatter = new SimpleDateFormat(
				"dd-MM-yyyy HH:mm:ss");
		
		if(fdate!="")
		{
		
			try {
				f_date = new java.sql.Timestamp(
					formatter.parse(fdate).getTime());
			} catch (ParseException e) {
				
				e.printStackTrace();
			}

		}
		else
		{
			f_date=null;
		}
		
		
		if(sdate!="")
		{
			try {
				s_date = new java.sql.Timestamp(
					formatter.parse(sdate).getTime());
			} catch (ParseException e) {
				
				e.printStackTrace();
			}
		
		}
		else
		{
			s_date=null;
		}
		
		Search_Req_vo vo=new Search_Req_vo();
		
		vo.setF_date(f_date);
		vo.setRel_to(rel_to);
		vo.setReq_type(req_type);
		vo.setS_date(s_date);
		vo.setU_id(u_id);
		
		Search_Req_bo bo=new Search_Req_bo();
		
		bo.searchReq(vo,request,response,session);
		
	}

}
