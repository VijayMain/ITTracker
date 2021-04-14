package it.muthagroup.controller;

import it.muthagroup.dao.DMS_DAO;
import it.muthagroup.vo.DMS_VO;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

@WebServlet("/Add_NewDMS_DEVDoc")
public class Add_NewDMS_DEVDoc extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			DMS_VO bean = new DMS_VO();
			DMS_DAO dao = new DMS_DAO();
			HttpSession session = request.getSession();
			int valcnt=1,cnt_doc=0;
			ArrayList DMSComp_list = new ArrayList();
			ArrayList DMSDept_list = new ArrayList();
			ArrayList DMSEmp_list = new ArrayList();
			boolean flag = false;
			InputStream file_Input = null; 
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			 
								bean.setFolder(request.getParameter("folder"));  
								bean.setSubject(request.getParameter("subject")); 
								bean.setShare_others(request.getParameter("share")); 
								 
								if(request.getParameter("add_fileAccess")!=null){
									bean.setShared_access(Integer.valueOf(request.getParameter("add_fileAccess")));	
								}
								
							/*DMSDept_list.add(request.getParameter("department")); 
								DMSComp_list.add(request.getParameter("company"));  
								DMSEmp_list.add(request.getParameter("employee"));*/

								String[] dept= request.getParameterValues("department");
								String[] comp= request.getParameterValues("company");
								String[] emp= request.getParameterValues("employee");
								  
								for(int i=0;i<dept.length; i++)
								{
									DMSDept_list.add(dept[i]);
								}
								for(int j=0;j<comp.length; j++)
								{
									DMSComp_list.add(comp[j]);
								}
								for(int k=0;k<emp.length; k++)
								{
									DMSEmp_list.add(emp[k]);
								}
								
								dao.upload_newDevFolder(session,bean,DMSComp_list,DMSDept_list,DMSEmp_list,response);				
													
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}