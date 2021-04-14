package it.muthagroup.controller;

import it.muthagroup.dao.Device_Repair_dao;
import it.muthagroup.vo.Device_Repair_vo;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DeviceRepair_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			boolean flag_replace = false;
			String dev_name="",reqNo="",partreplace="",pryes="",avail_stk="",qtyused="",partcond="",repaired_by="";
			 dev_name = request.getParameter("dev_name");
			 reqNo = request.getParameter("reqNo");
			 partreplace = request.getParameter("partreplace");
			 pryes = request.getParameter("pryes"); 
			 avail_stk = request.getParameter("avail_stk");
			 qtyused = request.getParameter("qtyused");
			 partcond = request.getParameter("partcond");
			 repaired_by = request.getParameter("repaired_by");
			// String repaired_date =request.getParameter("repaired_date");
			String details = request.getParameter("details");
			Device_Repair_vo vo = new Device_Repair_vo();
			if (pryes.equalsIgnoreCase("yes")) {
				vo.setQtyused(Integer.parseInt(qtyused));
				vo.setPartcond(Integer.parseInt(partcond));
				System.out.println("Patr COnd"+ vo.getPartcond());
				flag_replace = true;
			}
			if (pryes.equalsIgnoreCase("no")) { 
				flag_replace = false;
			}

			vo.setDev_name(Integer.parseInt(dev_name));
			vo.setReqNo(Integer.parseInt(reqNo));
			vo.setPartreplace(Integer.parseInt(partreplace));
			
			vo.setRepaired_by(Integer.parseInt(repaired_by));
			vo.setRepaired_date(new java.sql.Date(dateFormat.parse(request.getParameter("repaired_date")).getTime()));
			vo.setDetails(details);
			Device_Repair_dao dao = new Device_Repair_dao();

			vo.setPryes(pryes);  
			vo.setAvail_stk(Integer.parseInt(avail_stk));
			

			dao.addDevice_repairDetails(vo, session, response, flag_replace);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
