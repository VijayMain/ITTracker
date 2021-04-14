package it.muthagroup.controller;
  
import it.muthagroup.dao.SurrenderNote_dao;
import it.muthagroup.vo.Surrender_vo;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat; 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Add_SurrenderNote_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");   
			
			Surrender_vo vo =new Surrender_vo(); 
			vo.setDevName(Integer.parseInt(request.getParameter("dev_name")));
			vo.setDev_cond(Integer.parseInt(request.getParameter("dev_cond")));
			vo.setSubmitby(Integer.parseInt(request.getParameter("submitby")));
			vo.setItperson(Integer.parseInt(request.getParameter("itperson")));
			vo.setSurrender_date(new java.sql.Date(dateFormat.parse(request.getParameter("surrender_date")).getTime()));
			vo.setDetails(request.getParameter("details"));
			
			SurrenderNote_dao dao = new SurrenderNote_dao();			
			dao.addSurrenderDevice(vo,session,response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
