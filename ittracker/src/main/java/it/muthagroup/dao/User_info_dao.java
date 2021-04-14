package it.muthagroup.dao;

import it.muthagroup.connectionUtility.Connection_Utility;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.http.HttpServletResponse;

public class User_info_dao {

	public void addUserInfo(String uid, String phone, HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection();
			String success ="";
			
			PreparedStatement ps = con.prepareStatement("update user_tbl set phone_no='"+phone+"' where U_Id="+uid);
			int up = ps.executeUpdate();
			
			if(up>0){
				success = "Information is added...";
				response.sendRedirect("Profile.jsp?success="+success);
			}else{
				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
