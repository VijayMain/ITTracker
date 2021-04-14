package it.muthagroup.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.Change_Password_vo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Change_Password_dao {

	public void change_pwd(HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Change_Password_vo vo) 
	{
		
		Connection con=Connection_Utility.getConnection();
		
		try 
		{
			PreparedStatement ps_chkPwd=con.prepareStatement("select Login_Password from User_tbl where U_Id="+vo.getU_id());
		
			int i=0;
			ResultSet rs_chkPwd=ps_chkPwd.executeQuery();
	
			if(vo.getNew_pwd().equals(vo.getNew_r_pwd()))
			{
				while(rs_chkPwd.next())
				{
					if(rs_chkPwd.getString("Login_Password").equals(vo.getCurr_pwd()))
							{
								PreparedStatement ps_updatePwd = con.prepareStatement("update user_tbl set login_password = ? where U_id = "+vo.getU_id());
								ps_updatePwd.setString(1, vo.getNew_pwd());
								
								i=ps_updatePwd.executeUpdate();
								
								if(i>0)
								{
									response.sendRedirect("index.jsp");
								}
							}
					else
					{
						response.sendRedirect("Change_Password_Error.jsp?error_msg=Current Password is Wrong");
					}
				}
				
			}
			else
			{
				response.sendRedirect("Change_Password_Error.jsp?error_msg=New Passwords Not Match");
			}
			
			
		
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}

}
