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
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

public class Add_NewDMSDoc extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
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
		String fieldName, fieldValue = "";
		String file_stored = null;
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
		/**********************************************************************************************************
		 * For MultipartContent Separate FILE Fields and FORM Fields
		 **********************************************************************************************************/
		if (ServletFileUpload.isMultipartContent(request)) {

			
			// ******** Temporary storage for items =====>

			ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
			List fileItemsList; 
			fileItemsList = servletFileUpload.parseRequest(request);

			// Collect data into list

				FileItem fileItem = null;
				Iterator it = fileItemsList.iterator();
				Iterator it2 = fileItemsList.iterator();

				// iterate list to sort data(i.e. form / file Fields)

				while (it.hasNext()) {
					FileItem fileItemTemp = (FileItem) it.next();

					// if data is form field ==== >
					if (fileItemTemp.isFormField()) {

						// INPUT FORM FIELDS are ==== >
						fieldName = fileItemTemp.getFieldName();
						fieldValue = fileItemTemp.getString();
						// folder    subject   share  add_access   company    department   note  
					 	if (fieldName.equalsIgnoreCase("srno")) {
							bean.setSrno(Integer.parseInt(fieldValue)); 
						}
						
						if (fieldName.equalsIgnoreCase("folder")) {
							bean.setFolder(fieldValue);
						}
						if (fieldName.equalsIgnoreCase("subject")) {
							bean.setSubject(fieldValue);
						}
						if (fieldName.equalsIgnoreCase("share")) {
							bean.setShare_others(fieldValue);
						}
						if (fieldName.equalsIgnoreCase("add_fileAccess")) {
							bean.setShared_access(Integer.parseInt(fieldValue));
						}
						if (fieldName.equalsIgnoreCase("department")) {
							DMSDept_list.add(fieldValue);
						}
						if (fieldName.equalsIgnoreCase("company")) {
							DMSComp_list.add(fieldValue);
						}
						if (fieldName.equalsIgnoreCase("employee")) {
							DMSEmp_list.add(fieldValue);
						}
						if (fieldName.equalsIgnoreCase("note")) {
							bean.setNote(fieldValue);
						}
						// *****************************************************************************
						// Get Complaint date ===== >
						// ******************************************************************************
										
				}

					else {
						// *************************************************************************************************************
						// IF FILE inputs === >
						// *************************************************************************************************************
						
						fileItem = fileItemTemp;
						fieldName = fileItem.getFieldName();
						fieldValue = fileItem.getString();

						for (int k = 1; k <= bean.getSrno(); k++) { 
							// *************************************************************************************************************
							// if multiple files then there names are
							// inputName1,inputName2,inputName3,.......
							// *************************************************************************************************************
							if (fieldName.equalsIgnoreCase("inputName" + k)) {
								
								file_stored = fileItem.getName();
								if(FilenameUtils.getName(file_stored)!=""){
								bean.setBlob_name(FilenameUtils.getName(file_stored)); 
								}
							}
						}
					}
				} 
		
		// *************************************************************************************************************
		// *************************************************************************************************************
		// *************************************************************************************************************
		
		
				if(bean.getBlob_name()=="" || bean.getBlob_name()==null){
					String msg = "File Not selected....Data upload failed !!!"; 
					response.sendRedirect("DMS.jsp?msg=" + msg);
				}else{
					// *************************************************************************************************************
					// IF FILE inputs === >
					// *************************************************************************************************************
					  	while (it2.hasNext()) {
								FileItem fileItemTemp = (FileItem) it2.next(); 
								if (fileItemTemp.isFormField()) {
								}else{ 
									fileItem = fileItemTemp;
									fieldName = fileItem.getFieldName();
									fieldValue = fileItem.getString(); 
									for (int k = 1; k <= bean.getSrno(); k++) {  
						// *************************************************************************************************************
						// if multiple files then there names are inputName1,inputName2,inputName3,.......
						// *************************************************************************************************************
						if (fieldName.equalsIgnoreCase("inputName" + k)) {
							file_stored = fileItem.getName(); 
							if(FilenameUtils.getName(file_stored)!=""){ 
 							if (valcnt==1){
 								valcnt++;
 								bean.setBlob_name(FilenameUtils.getName(file_stored));
 	 							file_Input = new DataInputStream(fileItem.getInputStream());
 	 							bean.setBlob_file(file_Input); 
 								cnt_doc = dao.upload_newFolder(session,bean,DMSComp_list,DMSDept_list,DMSEmp_list);
 								bean.setDmscode(cnt_doc);
 								flag = true;
							}else{ 
								flag = false;
								bean.setBlob_name(FilenameUtils.getName(file_stored));
	 							file_Input = new DataInputStream(fileItem.getInputStream());
	 							bean.setBlob_file(file_Input); 
								flag = dao.attach_Filebase(bean, session);	
							}
						}
						}
						}
					}
				} 
					if(flag==true){
					String msg = "Successfully Submitted !!!"; 
					response.sendRedirect("DMS.jsp?msg=" + msg);
					}else{
						String msg = "Data upload failed !!!"; 
						response.sendRedirect("DMS.jsp?msg=" + msg);	
					}
				}
					}
				
				// *************************************************************************************************************
				// *************************************************************************************************************
				// *************************************************************************************************************
					
	} catch (Exception e) {
		e.printStackTrace();
	}
  }
}