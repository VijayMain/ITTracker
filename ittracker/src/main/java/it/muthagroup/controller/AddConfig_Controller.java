package it.muthagroup.controller;
 
import it.muthagroup.dao.FileUpload_dao;
import it.muthagroup.vo.FileUpload_vo; 
import java.io.DataInputStream;
import java.io.IOException;  
import java.io.InputStream; 
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
 
public class AddConfig_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		FileItem fileItem = null;
		InputStream file_Input = null;
		try {
			FileUpload_vo bean = new FileUpload_vo();
			FileUpload_dao dao = new FileUpload_dao();
			
			HttpSession session = request.getSession(); 
			/**********************************************************************************************************
			  For MultipartContent Separate FILE Fields and FORM Fields 
			 **********************************************************************************************************/
			if (ServletFileUpload.isMultipartContent(request)) {
				String fieldName, fieldValue = "";
 				ServletFileUpload servletFileUpload = new ServletFileUpload(new DiskFileItemFactory());
				List fileItemsList;  
					fileItemsList = servletFileUpload.parseRequest(request); 
					Iterator it = fileItemsList.iterator(); 

					while (it.hasNext()) {
						FileItem fileItemTemp = (FileItem) it.next();
						
						if (!fileItemTemp.isFormField()) { 
							// *************************************************************************************************************
							// IF FILE inputs === >
							// *************************************************************************************************************
							String file_stored = null; 
							fileItem = fileItemTemp;
							fieldName = fileItem.getFieldName();
							fieldValue = fileItem.getString(); 
							
								if (fieldName.equalsIgnoreCase("it_doc")) {
									file_stored = fileItem.getName();
									bean.setFilename(FilenameUtils.getName(file_stored));
									file_Input = new DataInputStream(fileItem.getInputStream());
									bean.setBlob_file(file_Input);
								}
							}
					}
			} 
			
			dao.uploadFile(session,bean,response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}