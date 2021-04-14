package it.muthagroup.controller;
 
import it.muthagroup.dao.New_TermsCondition_dao;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
 
 
public class Add_TermsCondition_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			Date attached_date = null;
			String info ="";  
			String file_Name_ext = null;
			InputStream file_blob = null;
			try {
				HttpSession session = request.getSession();
				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date d;
				InputStream file_Input = null;
				boolean flag = false;
				// --------------------------------------------------------------------------------------------------------
				ArrayList attd=new ArrayList(); 
				New_TermsCondition_dao dao = new New_TermsCondition_dao();
				
				if (ServletFileUpload.isMultipartContent(request)) {
					String fieldName, fieldValue = "";
					// ******** Temporary storage for items =====>
					ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
					List fileItemsList; 
						fileItemsList = servletFileUpload.parseRequest(request);
						// Collect data into list
						FileItem fileItem = null;
						Iterator it = fileItemsList.iterator();
						// iterate list to sort data(i.e. form / file Fields) 
						while (it.hasNext()) {
							FileItem fileItemTemp = (FileItem) it.next();
							// if data is form field ==== >
							if (fileItemTemp.isFormField()) {
								// INPUT FORM FIELDS are ==== >
								fieldName = fileItemTemp.getFieldName();
								fieldValue = fileItemTemp.getString(); 
								// TO SELECT PARTICULAR FORM FIELD ====> 		 
								if(fieldName.equalsIgnoreCase("description")){ 
									info =fieldValue;  
								}
								
								if(fieldName.equalsIgnoreCase("attach_date")){ 
									attached_date = new java.sql.Date(dateFormat.parse(fieldValue).getTime());
								}						 							  
							}else {							
								// *************************************************************************************************************
								// IF FILE inputs === >
								// *************************************************************************************************************
								String file_stored = null;
								fileItem = fileItemTemp;
								fieldName = fileItem.getFieldName();
								fieldValue = fileItem.getString();						 
										System.out.println("File Name in java : "+ fieldName);
										file_stored = fileItem.getName(); 
										file_Name_ext =  FilenameUtils.getName(file_stored); 
										file_Input = new DataInputStream(fileItem.getInputStream());  
										// Attach file ====>
										file_blob = file_Input;
										}
							}
				} 
				dao.add_newTermsInfo(session,info,file_blob,file_Name_ext,attached_date,response);	 
				// --------------------------------------------------------------------------------------------------------
					 					
			} catch (Exception e) {
				e.printStackTrace();
			}

			
			
			
	}

}
