package it.muthagroup.bo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.muthagroup.dao.login_dao;
import it.muthagroup.vo.login_vo;

public class login_bo {

	
	public void chkLogin(login_vo vo, HttpServletResponse response, HttpSession session) {
		login_dao dao=new login_dao();
		dao.checkLogin(vo,response,session);
	
	}
	
	

}
