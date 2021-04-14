package it.muthagroup.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
@WebServlet("/UserWise_CountReport")
public class UserWise_CountReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 try {
			String fromdate = request.getParameter("fromUserwiseDate");
			String todate = request.getParameter("toUserwiseDate");
			response.sendRedirect("UserWise_Count.jsp?from="+fromdate+"&to="+todate);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
