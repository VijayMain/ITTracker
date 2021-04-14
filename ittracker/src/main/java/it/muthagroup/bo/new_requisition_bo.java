package it.muthagroup.bo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import it.muthagroup.dao.new_requisition_dao;
import it.muthagroup.vo.new_requisition_vo;

public class new_requisition_bo {

	boolean flag=false;
	public boolean addReq(new_requisition_vo vo, HttpSession session) 
	{
		new_requisition_dao dao=new new_requisition_dao();
		flag=dao.addReq(vo,session);
		return flag;
	}

}
