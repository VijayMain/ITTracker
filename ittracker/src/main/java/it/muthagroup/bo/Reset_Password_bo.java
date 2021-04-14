package it.muthagroup.bo;

import it.muthagroup.dao.Reset_Password_dao;
import it.muthagroup.vo.Reset_Password_vo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Reset_Password_bo {

	
		

		public void reset_pwd(Reset_Password_vo vo, HttpSession session, HttpServletResponse response) 
		{
			Reset_Password_dao dao=new Reset_Password_dao();
			dao.reset_password(vo,session,response);
			
		}
		
		
	

}
