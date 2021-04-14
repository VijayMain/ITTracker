package it.muthagroup.bo;

import it.muthagroup.dao.Change_Password_dao;
import it.muthagroup.vo.Change_Password_vo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Change_Password_bo {

	public void chnage_pwd(HttpSession session, HttpServletRequest request,
			HttpServletResponse response, Change_Password_vo vo) {
		
		Change_Password_dao dao=new Change_Password_dao();
		
		dao.change_pwd(session,request,response,vo);
		
	}

}
