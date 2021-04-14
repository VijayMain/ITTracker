package it.muthagroup.controller;

import it.muthagroup.bo.Report_Generator_bo;
import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.dao.Report_Generator_dao;
import it.muthagroup.vo.Report_Generator_vo;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Report_Generator_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	Long req_no = (long) 0, company_id = (long) 0, rel_to = (long) 0,
			req_type = (long) 0;
	String first_date = null, last_date = null;
	Timestamp firstDate = null, lastDate = null;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Report_Generator_vo vo = new Report_Generator_vo();
		Report_Generator_dao dao = new Report_Generator_dao();
		Connection con = Connection_Utility.getConnection();
		if (!request.getParameter("req_no").equalsIgnoreCase("")) {
			System.out.println("requisition no is "
					+ request.getParameter("req_no"));
			req_no = Long.parseLong(request.getParameter("req_no"));
			vo.setReq_no(req_no);
			dao.generateReportForReqNo(vo, request, response, con);
		}

		if (!request.getParameter("company_name").equals("")) {
			System.out.println("controller ... Company no  is "
					+ request.getParameter("company_name"));
			company_id = Long.parseLong(request.getParameter("company_name"));
		}

		if (!request.getParameter("rel_to").equals("")) {
			System.out.println("controller ... Rel to no is "
					+ request.getParameter("rel_to"));
			rel_to = Long.parseLong(request.getParameter("rel_to"));
		}

		if (!request.getParameter("req_type").equals("")) {
			System.out.println("controller ... requisition type no is "
					+ request.getParameter("req_type"));
			req_type = Long.parseLong(request.getParameter("req_type"));
		}

		if (!request.getParameter("first_date").equals("")) {
			System.out.println("controller ... first date as a String "
					+ request.getParameter("first_date"));
			first_date = request.getParameter("first_date");

			SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
			try {
				firstDate = new java.sql.Timestamp(formatter.parse(first_date)
						.getTime());
				System.out.println("controller ... First date is .."
						+ firstDate);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}
		if (!request.getParameter("last_date").equals("")) {
			System.out.println("controller ... last date as a String "
					+ request.getParameter("last_date"));
			last_date = request.getParameter("last_date");
			SimpleDateFormat formatter = new SimpleDateFormat(
					"dd-MM-yyyy HH:mm:ss");

			try {
				lastDate = new java.sql.Timestamp(formatter.parse(last_date)
						.getTime());
				System.out.println("controller ... Last date is .." + lastDate);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}

		vo.setCompany_id(company_id);
		vo.setFirst_date(firstDate);
		vo.setLast_date(lastDate);
		vo.setRel_to(rel_to);
		vo.setReq_type(req_type);

		Report_Generator_bo bo = new Report_Generator_bo();

		bo.genrateReport(vo, request, response);

	}
}
