package it.muthagroup.bo;

import it.muthagroup.dao.take_action_dao;
import it.muthagroup.vo.take_action_vo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class take_action_bo {

	public void takeAction(HttpSession session, HttpServletResponse response, take_action_vo vo) {
		take_action_dao dao=new take_action_dao();
		dao.addRemark(session,response,vo);
	}

}
