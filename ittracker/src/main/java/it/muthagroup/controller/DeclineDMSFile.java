package it.muthagroup.controller;

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

@WebServlet("/DeclineDMSFile")
public class DeclineDMSFile extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
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
							
							if (fieldName.equalsIgnoreCase("note")) {
								bean.setNote(fieldValue.replaceAll("\\'",""));
							} 	
							if (fieldName.equalsIgnoreCase("tran_dmscode")) {
								bean.setTran_dmscode(Integer.valueOf(fieldValue));
							}
							if (fieldName.equalsIgnoreCase("tran_dms_rel")) {
								bean.setTranrelCode(Integer.valueOf(fieldValue));
							}		
							if (fieldName.equalsIgnoreCase("folder_code")) {
								bean.setFolder_code(Integer.valueOf(fieldValue));
							}
					} else {
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString();
							
								if (fieldName.equalsIgnoreCase("decline_file")) {
									file_stored = fileItem.getName();
									if(FilenameUtils.getName(file_stored)!=""){
									bean.setBlob_name(FilenameUtils.getName(file_stored));  
		 							file_Input = new DataInputStream(fileItem.getInputStream());
		 							bean.setBlob_file(file_Input);
								 }
							 }
						}
					}
					dao.declineDMSfile(session,bean,response);
					 
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
