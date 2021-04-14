package it.muthagroup.dao;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

public class New_TermsCondition_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
	public void add_newTermsInfo(HttpSession session, String info, InputStream file_blob,String file_Name_ext, Date attached_date,HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			
			PreparedStatement ps_att=con.prepareStatement("insert into it_asset_it_terms_tbl" +
					"(file_name,Attachment,attached_by,attached_date,Enable_id,description,created_date)values(?,?,?,?,?,?,?)");
			ps_att.setString(1, file_Name_ext);
			ps_att.setBlob(2, file_blob);
			ps_att.setInt(3, uid);
			ps_att.setDate(4, attached_date);
			ps_att.setInt(5, 1);
			ps_att.setString(6, info);
			ps_att.setDate(7, curr_Date);
			
			int up = ps_att.executeUpdate();
			if(up>0){ 
				String success = "Data inserted successfully....";
				response.sendRedirect("Terms_cond.jsp?success="+success);
			}else {
				String error = "Failed !!!";
				response.sendRedirect("Terms_cond.jsp?error="+error);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
 
}
