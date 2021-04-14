package it.muthagroup.bo;

import it.muthagroup.connectionUtility.*;
import java.sql.Connection;
import it.muthagroup.dao.Report_Generator_dao;
import it.muthagroup.vo.Report_Generator_vo;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Report_Generator_bo {

	public void genrateReport(Report_Generator_vo vo,
			HttpServletRequest request, HttpServletResponse response) {
		boolean flag = false;

		Report_Generator_dao dao = new Report_Generator_dao();
		Connection con = Connection_Utility.getConnection();
		try {

			if (vo.getCompany_id() != 0 && !vo.getFirst_date().equals("")
					&& !vo.getLast_date().equals("") && vo.getRel_to() != 0 && vo.getReq_type() == 0) {
				System.out.println("In Comp fistdate lastdate relto");
				flag = dao.generateReportForRelToN2Dates(vo, request, response,
						con);
			} else if (vo.getCompany_id() != 0
					&& !vo.getFirst_date().equals("")
					&& !vo.getLast_date().equals("") && vo.getRel_to() == 0 && vo.getReq_type() == 0) {

				System.out.println("In Comp fistdate lastdate");

				flag = dao.generateReportCompanyN2Dates(vo, request, response,
						con);
			} else if (vo.getCompany_id() != 0
					&& !vo.getFirst_date().equals("")
					&& !vo.getLast_date().equals("") && vo.getRel_to() == 0
					&& vo.getReq_type() != 0) {
				System.out.println("In Comp fistdate lastdate req type");
				flag = dao.generateReportForReqTypeN2Dates(vo, request,
						response, con);
			}else if (vo.getCompany_id() != 0
					&& !vo.getFirst_date().equals("")
					&& !vo.getLast_date().equals("") && vo.getRel_to() != 0
					&& vo.getReq_type() != 0) {
				System.out.println("In Comp fistdate lastdate req type rel to");
				flag = dao.generateReportForReqTypeRelToN2Dates(vo, request,response, con);
			}
			

			if (flag == false) {
				System.out.println("In error");
				response.sendRedirect("Report_User_Error.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
