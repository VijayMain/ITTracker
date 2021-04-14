package it.muthagroup.controller;
 
import it.muthagroup.dao.IssueNote_dao;
import it.muthagroup.vo.IssueNote_vo; 
import java.io.IOException; 
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList; 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class IssueNote_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	try {
		HttpSession session = request.getSession();
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
		IssueNote_vo vo=new IssueNote_vo();
		ArrayList soft=new ArrayList();
		
		vo.setDev_name(Integer.parseInt(request.getParameter("dev_name")));  
		vo.setCompany(Integer.parseInt(request.getParameter("company")));
		vo.setIssuedto(Integer.parseInt(request.getParameter("issuedto")));
		vo.setIssuedate(new java.sql.Date(dateFormat.parse(request.getParameter("issuedate")).getTime())); 
		vo.setIssuedby(Integer.parseInt(request.getParameter("issuedby")));
		vo.setExtra(request.getParameter("extra"));
		vo.setLocation(request.getParameter("location"));
		vo.setContNo(request.getParameter("contNo"));
		vo.setEmail(request.getParameter("email"));
		vo.setIssueId(Integer.parseInt(request.getParameter("noteId")));
		
		System.out.println("Note Id ======= " + vo.getIssueId());
		
		String[] software = request.getParameterValues("software");      
		    if (software!=null) {
		       for (int index=0; index<software.length; index++) {    
		            soft.add(software[index]);
		       }
		    }
		//System.out.println("Software name = " + soft);
		IssueNote_dao dao = new IssueNote_dao();
		dao.addIssueNote(session,vo,response,soft);
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	}

}
