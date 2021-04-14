package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.Photo_vo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

public class Photo_dao {

	public void attach_Photo(Photo_vo bean, HttpSession session,
			HttpServletResponse response) {
		 try {
			 Connection con = Connection_Utility.getConnection();
			 
			 PreparedStatement ps = con.prepareStatement("update user_tbl set user_photoName=?,user_photo=? where U_Id="+bean.getUid());
			 ps.setString(1, bean.getPhotofilename());
			 ps.setBlob(2, bean.getBlob_photo());
			 int up = ps.executeUpdate();
			 if(up>0){
				 response.sendRedirect("Profile.jsp");
			 }
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
