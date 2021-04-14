package it.muthagroup.controller;

import it.muthagroup.dao.DMS_DAO;
import it.muthagroup.dao.DMS_DevDAO;
import it.muthagroup.vo.DMS_VO;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
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

@WebServlet("/Add_NewDMSDEVFile")
public class Add_NewDMSDEVFile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try{
			DMS_VO bean = new DMS_VO();
			DMS_DevDAO dao = new DMS_DevDAO();
			HttpSession session = request.getSession();
			boolean flag = false;
			InputStream file_Input = null;
			String fieldName, fieldValue = "";
			String file_stored = null;
			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields
			 **********************************************************************************************************/
			if (ServletFileUpload.isMultipartContent(request)) {
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
							
							if (fieldName.equalsIgnoreCase("code")) {
								bean.setCode(Integer.parseInt(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("folder")) {
								bean.setFolder(fieldValue);
							} 
							if (fieldName.equalsIgnoreCase("carriedout")) {
								bean.setCarriedout(fieldValue);
							}	
							if (fieldName.equalsIgnoreCase("videbill")) {
								bean.setVidebill(fieldValue);
							}	
							if (fieldName.equalsIgnoreCase("dated")) {
								bean.setDate_dms(fieldValue);
								Timestamp convertedDate = null;
								convertedDate = new java.sql.Timestamp(formatter.parse(fieldValue).getTime());
								bean.setDemo4(convertedDate);  
							}	
							if (fieldName.equalsIgnoreCase("forrs")) {
								bean.setForrs(fieldValue);
							}	
							if (fieldName.equalsIgnoreCase("purorder")) {
								bean.setPurorder(fieldValue);
							}
							if (fieldName.equalsIgnoreCase("remark")) {
								bean.setNote(fieldValue);
							}
							if (fieldName.equalsIgnoreCase("subject_title")) {
								bean.setSubject_title(fieldValue);
							}
					} else {
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString();
							
								if (fieldName.equalsIgnoreCase("filename")) {
									file_stored = fileItem.getName();
									if(FilenameUtils.getName(file_stored)!=""){
									bean.setBlob_name(FilenameUtils.getName(file_stored));  
		 							file_Input = new DataInputStream(fileItem.getInputStream());
		 							bean.setBlob_file(file_Input);
								 }
							 }
						}
					}
					dao.uploadFileDevDMS(session,bean,response);
					 
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
