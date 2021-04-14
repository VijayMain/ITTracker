package it.muthagroup.bo;

import it.muthagroup.dao.software_access_dao;
import it.muthagroup.vo.software_access_vo;

import javax.servlet.http.HttpSession;

public class software_access_bo {

	boolean flag=false;
	public boolean addAccess(HttpSession session, software_access_vo vo) {
	
		software_access_dao dao=new software_access_dao();
		flag=dao.addAccess(session,vo);
		return flag;
	}
	
}
