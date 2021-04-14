package it.muthagroup.controller;

import it.muthagroup.dao.Feedback_dao;
import it.muthagroup.vo.Feedback_vo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Feedback_controller")
public class Feedback_controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
				Feedback_vo vo = new Feedback_vo();
				Feedback_dao dao = new Feedback_dao();	
				HttpSession session=request.getSession();
				
				vo.setInternetandnetwork(Integer.valueOf(request.getParameter("internetandnetwork")));
				vo.setPclaptop(Integer.valueOf(request.getParameter("pclaptop")));
				vo.setInhouse(Integer.valueOf(request.getParameter("inhouse")));
				vo.setErp(Integer.valueOf(request.getParameter("erp")));
				vo.setSatisfiedit(Integer.valueOf(request.getParameter("satisfiedit")));
				vo.setComment(request.getParameter("comment"));
				vo.setUerrname(request.getParameter("uerrname"));
				
				dao.send_Feedback(vo,session,response);
				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
