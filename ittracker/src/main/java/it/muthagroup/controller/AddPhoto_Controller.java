package it.muthagroup.controller;

import it.muthagroup.dao.Photo_dao;
import it.muthagroup.vo.Photo_vo;

import java.io.DataInputStream;
import java.io.IOException;
import java.io.InputStream;
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
 
public class AddPhoto_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FileItem fileItem = null;
		InputStream file_Input = null;
		try {
			Photo_vo bean = new Photo_vo();
			ArrayList visible = new ArrayList();
			Photo_dao dao = new Photo_dao(); 
			HttpSession session = request.getSession();
			InputStream doc_Input = null,photo_Input = null; 
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			/**********************************************************************************************************
			 * For MultipartContent Separate FILE Fields and FORM Fields 
			 **********************************************************************************************************/
			if (ServletFileUpload.isMultipartContent(request)) {
				String fieldName, fieldValue = "";
 				ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
				List fileItemsList;  
					fileItemsList = servletFileUpload.parseRequest(request); 
					Iterator it = fileItemsList.iterator(); 

					while (it.hasNext()) {
						FileItem fileItemTemp = (FileItem) it.next();
 
						if (fileItemTemp.isFormField()) {
 
							fieldName = fileItemTemp.getFieldName();
							fieldValue = fileItemTemp.getString(); 
							
							if (fieldName.equalsIgnoreCase("uid")) { 
								bean.setUid(Integer.parseInt(fieldValue));
							} 
						}
						// *****************************************************************************************************
						else {
							// *************************************************************************************************************
							// IF FILE inputs === >
							// *************************************************************************************************************
							String file_stored = null; 
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString(); 		
								if (fieldName.equalsIgnoreCase("photo")) { 
									file_stored = fileItem.getName();
									bean.setPhotofilename(FilenameUtils.getName(file_stored));
									file_Input = new DataInputStream(fileItem.getInputStream());
									bean.setBlob_photo(file_Input);
								}
							}
					}
			}
			dao.attach_Photo(bean, session,response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
