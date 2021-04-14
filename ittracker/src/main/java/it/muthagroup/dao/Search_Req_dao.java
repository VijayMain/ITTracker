package it.muthagroup.dao;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.Search_Req_vo;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Search_Req_dao {

	public void SearchReq(Search_Req_vo vo, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {

		int u_id = 0, rel_to = 0, req_type = 0;
		Timestamp fdate = null, sdate = null;
		ArrayList U_Req_Id = new ArrayList();

		Connection con = Connection_Utility.getConnection();
		String str = null;

		u_id = vo.getU_id();
		rel_to = vo.getRel_to();
		req_type = vo.getReq_type();
		fdate = vo.getF_date();
		sdate = vo.getS_date();

		if (u_id != 0 && rel_to == 0 && req_type == 0 && fdate == null
				&& sdate == null) {
			str = "select * from it_user_requisition where u_id=" + u_id;

		} else if (u_id != 0 && rel_to != 0 && req_type == 0 && fdate == null
				&& sdate == null) {
			str = "select * from it_user_requisition where u_id=" + u_id
					+ " and Rel_Id=" + rel_to;
		} else if (u_id != 0 && rel_to != 0 && req_type != 0 && fdate == null
				&& sdate == null) {
			str = "select * from it_user_requisition where u_id=" + u_id
					+ " and Rel_Id=" + rel_to + " and Req_Type_Id=" + req_type;
		} else if (u_id != 0 && rel_to != 0 && req_type != 0 && fdate != null
				&& sdate != null) {
			str = "select * from it_user_requisition where u_id=" + u_id
					+ " and Rel_Id=" + rel_to + " and Req_Type_Id=" + req_type
					+ " and Req_Date between '" + fdate + "' and '" + sdate
					+ "'";
		} else if (u_id != 0 && rel_to == 0 && req_type != 0 && fdate == null
				&& sdate == null) {
			str = "select * from it_user_requisition where u_id=" + u_id
					+ " and Req_Type_Id=" + req_type;
		} else if (u_id != 0 && rel_to == 0 && req_type != 0 && fdate != null
				&& sdate != null) {
			str = "select * from it_user_requisition where u_id=" + u_id
					+ " and Req_Type_Id=" + req_type
					+ " and Req_Date between '" + fdate + "' and '" + sdate
					+ "'";
		} else if (u_id != 0 && rel_to == 0 && req_type == 0 && fdate != null
				&& sdate != null) {
			str = "select * from it_user_requisition where u_id=" + u_id
					+ " and Req_Date between '" + fdate + "' and '" + sdate
					+ "'";
		} else if (u_id == 0 && rel_to != 0 && req_type == 0 && fdate == null
				&& sdate == null) {
			str = "select * from it_user_requisition where Rel_Id=" + rel_to;
		} else if (u_id == 0 && rel_to != 0 && req_type == 0 && fdate != null
				&& sdate != null) {
			str = "select * from it_user_requisition where Rel_Id=" + u_id
					+ " and Req_Date between '" + fdate + "' and '" + sdate
					+ "'";
		} else if (u_id == 0 && rel_to == 0 && req_type != 0 && fdate != null
				&& sdate != null) {
			str = "select * from it_user_requisition where Req_Type_Id="
					+ req_type + " and Req_Date between '" + fdate + "' and '"
					+ sdate + "'";
		} else if (u_id == 0 && rel_to == 0 && req_type != 0 && fdate == null
				&& sdate == null) {
			str = "select * from it_user_requisition where Req_Type_Id="
					+ req_type;
		} else if (u_id == 0 && rel_to != 0 && req_type != 0 && fdate == null
				&& sdate == null) {
			str = "select * from it_user_requisition where Req_Type_Id="
					+ req_type + " and Rel_Id=" + rel_to;
		} else if (u_id == 0 && rel_to != 0 && req_type != 0 && fdate != null
				&& sdate != null) {
			str = "select * from it_user_requisition where Req_Type_Id="
					+ req_type + " and Rel_Id=" + rel_to
					+ " and Req_Date between '" + fdate + "' and '" + sdate
					+ "'";
		}

		try {
			PreparedStatement ps_searchResult = ps_searchResult = con
					.prepareStatement(str);
			ResultSet rs_searchResult = ps_searchResult.executeQuery();
			while (rs_searchResult.next()) {
				U_Req_Id.add(rs_searchResult.getInt("U_Req_Id"));
			}

			//System.out.println("Req No List by search... : " + U_Req_Id);

			//System.out.println("Req No List by search... : " + U_Req_Id);

			RequestDispatcher rd = request
					.getRequestDispatcher("/Search_Result.jsp");
			request.setAttribute("arry", U_Req_Id);
			rd.forward(request, response);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
