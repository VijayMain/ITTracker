package it.muthagroup.bo;

import it.muthagroup.dao.Search_Req_dao;
import it.muthagroup.vo.Search_Req_vo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Search_Req_bo {

	public void searchReq(Search_Req_vo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) 
	{
		Search_Req_dao dao=new Search_Req_dao();
		
		dao.SearchReq(vo,request,response,session);
		
		
	}

}
