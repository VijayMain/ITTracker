package it.muthagroup.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.login_vo;

public class login_dao {

	String uname=null;
	String pwd=null;
	boolean flag=false;
	public void checkLogin(login_vo vo,HttpServletResponse response, HttpSession session){
		try {
		uname=vo.getU_name();
		pwd=vo.getU_pwd();
		
		Connection con=Connection_Utility.getConnection();
		
		PreparedStatement ps_user;
		ResultSet rs_user;
		

			ps_user = con.prepareStatement("select * from user_tbl where Enable_id=1");
			rs_user = ps_user.executeQuery();
		
		int uid = 0;
		int dept_id=0;
		int software_id=3;	
			session.setMaxInactiveInterval(-1);
			
			while (rs_user.next()) 
			{
				if (rs_user.getString("Login_Name").equalsIgnoreCase(vo.getU_name())
						&& rs_user.getString("Login_Password").equalsIgnoreCase(vo.getU_pwd())) 
				{
					uid = rs_user.getInt("U_Id");
					// System.out.println("User Id matched = "+uid);
					dept_id=rs_user.getInt("dept_id");
					// System.out.println("Department Id . . "+dept_id);
					PreparedStatement ps_swAccess=con.prepareStatement("select * from it_software_access_tbl where U_Id="+uid);
					ResultSet rs_swAccess=ps_swAccess.executeQuery();
					
					while(rs_swAccess.next())
					{
						if(software_id==rs_swAccess.getInt("Software_Id") && rs_swAccess.getInt("Enable_Id")==1)
						{
							// System.out.println("IT User Login =."+uid);
							session.setAttribute("uid", rs_user.getInt("U_Id"));
							flag=true;
						}
					}
					rs_swAccess.close();
				}
			}
			rs_user.close();
			
			if(flag==true)
			{
				if(dept_id==18)
				{
					try {
						response.sendRedirect("IT_index.jsp");
					} catch (IOException e) {
						
						e.printStackTrace();
					}
				}
				else
				{
					try {
						response.sendRedirect("index.jsp");
					} catch (IOException e) {
						
						e.printStackTrace();
					}
				}
			}
			else
			{
				try {
					response.sendRedirect("login_Fail.jsp");
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				System.out.println("Error Occured....");
			}
			
		} catch (SQLException e) {
		
			e.printStackTrace();
		}
		
		
		
	}

	

}
