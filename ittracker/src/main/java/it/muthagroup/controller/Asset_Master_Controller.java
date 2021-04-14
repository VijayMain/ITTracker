package it.muthagroup.controller;

import it.muthagroup.dao.Device_info_dao;
import it.muthagroup.vo.Device_info_vo;

import java.io.IOException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
public class Asset_Master_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {	                    
			
			Device_info_vo vo=new Device_info_vo();
			HttpSession session = request.getSession();
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date podate,grndate,received_date;		
			String mac = request.getParameter("1")+":"+request.getParameter("2")+":"+request.getParameter("3")+":"+request.getParameter("4")+":"+request.getParameter("5")+":"+request.getParameter("6");
			
			vo.setDevicename(request.getParameter("devicename"));
			vo.setOnline(request.getParameter("online"));
			vo.setSupplier(Integer.parseInt(request.getParameter("supplier")));
			vo.setPono(request.getParameter("pono"));
			vo.setGrn_no(request.getParameter("grn_no"));
			if(request.getParameter("basic_rate")!=""){
			vo.setBasic_rate(Double.parseDouble(request.getParameter("basic_rate")));
			}
			if(request.getParameter("tot_amt")!=""){
			vo.setTot_amt(Double.parseDouble(request.getParameter("tot_amt")));
			}
			
			vo.setDev_type(Integer.parseInt(request.getParameter("dev_type")));
			vo.setModelno(request.getParameter("modelno"));
			vo.setSerialno(request.getParameter("serialno"));
			vo.setImei_no(request.getParameter("imei_no"));
			vo.setImei_no2(request.getParameter("imei_no2"));
			vo.setProduct_code(request.getParameter("product_code"));
			vo.setItem_code(request.getParameter("item_code"));
			vo.setSap_code(request.getParameter("sap_code")); 
			vo.setDescription(request.getParameter("description"));  
			
			if(request.getParameter("ip_address")!=""){
			vo.setIp_address(Integer.parseInt(request.getParameter("ip_address")));
			}
			
			if(request.getParameter("osname")!=""){
				vo.setOs(Integer.parseInt(request.getParameter("osname")));
			}
			
			vo.setMac_address(mac);
			
			if(!request.getParameter("podate").equalsIgnoreCase("")){
				podate = new java.sql.Date(dateFormat.parse(request.getParameter("podate")).getTime());
				vo.setPodate(podate);
			}
			if(!request.getParameter("grndate").equalsIgnoreCase("")){
				grndate = new java.sql.Date(dateFormat.parse(request.getParameter("grndate")).getTime());
				vo.setGrndate(grndate);
			}
			if(!request.getParameter("received_date").equalsIgnoreCase("")){
				received_date = new java.sql.Date(dateFormat.parse(request.getParameter("received_date")).getTime());
				vo.setReceived_date(received_date);
			} 
			
			Device_info_dao dao = new Device_info_dao();
			dao.addDeviceInfo(session,vo,response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
