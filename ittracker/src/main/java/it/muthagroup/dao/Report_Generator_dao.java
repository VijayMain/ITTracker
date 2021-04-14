package it.muthagroup.dao;

import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import it.muthagroup.vo.Report_Generator_vo;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;

public class Report_Generator_dao {

	JasperReport jasperReport;
	JasperPrint jasperPrint;
	boolean flag=false;
	Long i=(long) 0;
	public boolean generateReportForReqNo(Report_Generator_vo vo,
			HttpServletRequest request, HttpServletResponse response, Connection con) 
	{
		try {
			//System.out.println("Req No = " + vo.getReq_no());
			jasperReport = JasperCompileManager
					.compileReport("C:/JRXMLFILES/IT_Requisition_No_Wise.jrxml");

			Map parameters = new HashMap();
			parameters.put("U_Req_No", vo.getReq_no());
			vo.setReq_no(i);
			//System.out.println("after fetching .. generateReportForReqNo "+vo.getReq_no());
			jasperPrint = JasperFillManager.fillReport(jasperReport,
					parameters, con);
			
				
			JRExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT,
					jasperPrint);
			ServletOutputStream servletOutputStream = response
					.getOutputStream();
			JasperExportManager.exportReportToPdfStream(jasperPrint,
					servletOutputStream);
			
			servletOutputStream.flush();
			servletOutputStream.close();

			//exporter.exportReport();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean generateReportForRelToN2Dates(Report_Generator_vo vo,
			HttpServletRequest request, HttpServletResponse response, Connection con) 
	{
		try {
			//System.out.println("Rel to No = " + vo.getRel_to());
			jasperReport = JasperCompileManager
					.compileReport("C:/JRXMLFILES/IT_Company_And_Rel_To.jrxml");

			Map parameters = new HashMap();
			parameters.put("Rel_Id", vo.getRel_to());
			parameters.put("Company_Id",vo.getCompany_id());
			parameters.put("date1", vo.getFirst_date());
			parameters.put("date2", vo.getLast_date());
			
			
			jasperPrint = JasperFillManager.fillReport(jasperReport,
					parameters, con);

			vo.setReq_type(i);
				//System.out.println("after fetching .. generateReportForRelToN2Dates "+vo.getReq_type());
				vo.setCompany_id(i);
				//System.out.println("after fetching .. generateReportForRelToN2Dates "+vo.getCompany_id());
				vo.setFirst_date(null);
				//System.out.println("after fetching .. generateReportForRelToN2Dates "+vo.getFirst_date());
				vo.setLast_date(null);
				//System.out.println("after fetching .. generateReportForRelToN2Dates "+vo.getLast_date());
				vo.setRel_to(i);
				//System.out.println("after fetching .. generateReportForRelToN2Dates "+vo.getRel_to());
			
			JRExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT,
					jasperPrint);
			ServletOutputStream servletOutputStream = response
					.getOutputStream();
			JasperExportManager.exportReportToPdfStream(jasperPrint,
					servletOutputStream);
			
			servletOutputStream.flush();
			servletOutputStream.close();
			
			//exporter.exportReport();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
		
	}

	public boolean generateReportForReqTypeN2Dates(Report_Generator_vo vo,
			HttpServletRequest request, HttpServletResponse response,
			Connection con) 
	{
		
		try {
			//System.out.println("Req type No = " + vo.getReq_type());
			jasperReport = JasperCompileManager
					.compileReport("C:/JRXMLFILES/IT_Company_And_ReqTypeId_And_2Dates.jrxml");

			Map parameters = new HashMap();
			parameters.put("ReqType_Id", vo.getReq_type());
			parameters.put("Company_Id",vo.getCompany_id());
			parameters.put("Date1", vo.getFirst_date());
			parameters.put("Date2", vo.getLast_date());
			
			vo.setCompany_id(i);
			//System.out.println("after fetching .. generateReportForReqTypeN2Dates "+vo.getCompany_id());
			vo.setFirst_date(null);
			//System.out.println("after fetching .. generateReportForReqTypeN2Dates "+vo.getFirst_date());
			vo.setLast_date(null);
			//System.out.println("after fetching .. generateReportForReqTypeN2Dates "+vo.getLast_date());
			vo.setRel_to(i);
			//System.out.println("after fetching .. generateReportForReqTypeN2Dates "+vo.getRel_to());
			vo.setReq_type(i);
			//System.out.println("after fetching .. generateReportForReqTypeN2Dates "+vo.getReq_type());
			
			
			jasperPrint = JasperFillManager.fillReport(jasperReport,
					parameters, con);
			
			
			
			JRExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT,
					jasperPrint);
			ServletOutputStream servletOutputStream = response
					.getOutputStream();
			JasperExportManager.exportReportToPdfStream(jasperPrint,
					servletOutputStream);
			
				
			
			servletOutputStream.flush();
			servletOutputStream.close();
			
			//exporter.exportReport();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean generateReportForReqTypeRelToN2Dates(Report_Generator_vo vo,
			HttpServletRequest request, HttpServletResponse response,
			Connection con) {
		 
		try {
			//System.out.println("Req type No = " + vo.getReq_type());
			jasperReport = JasperCompileManager
					.compileReport("C:/JRXMLFILES/IT_Company_And_ReqTypeId_RelTo.jrxml");

			Map parameters = new HashMap();
			parameters.put("ReqType_Id", vo.getReq_type());
			parameters.put("Rel_To", vo.getRel_to());
			parameters.put("Company_Id",vo.getCompany_id());
			parameters.put("Date1", vo.getFirst_date());
			parameters.put("Date2", vo.getLast_date());
			
			vo.setCompany_id(i);
			//System.out.println("after fetching .. generateReportForReqTypeRelToN2Dates "+vo.getCompany_id());
			vo.setFirst_date(null);
			//System.out.println("after fetching .. generateReportForReqTypeRelToN2Dates "+vo.getFirst_date());
			vo.setLast_date(null);
			//System.out.println("after fetching .. generateReportForReqTypeRelToN2Dates "+vo.getLast_date());
			vo.setRel_to(i);
			//System.out.println("after fetching .. generateReportForReqTypeRelToN2Dates "+vo.getRel_to());
			vo.setReq_type(i);
			//System.out.println("after fetching .. generateReportForReqTypeRelToN2Dates "+vo.getReq_type());
			
			
			jasperPrint = JasperFillManager.fillReport(jasperReport,
					parameters, con);

			
			
			JRExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT,
					jasperPrint);
			ServletOutputStream servletOutputStream = response
					.getOutputStream();
			JasperExportManager.exportReportToPdfStream(jasperPrint,
					servletOutputStream);
			
			
				
			
			servletOutputStream.flush();
			servletOutputStream.close();
			
			//exporter.exportReport();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public boolean generateReportCompanyN2Dates(Report_Generator_vo vo,
			HttpServletRequest request, HttpServletResponse response,
			Connection con) {
		
		try {
			//System.out.println("Company No = " + vo.getCompany_id());
			jasperReport = JasperCompileManager
					.compileReport("C:/JRXMLFILES/IT_Company_And_2Dates.jrxml");

			Map parameters = new HashMap();
			
			parameters.put("Company_Id",vo.getCompany_id());
			parameters.put("date1", vo.getFirst_date());
			parameters.put("date2", vo.getLast_date());
			
			vo.setCompany_id(i);
			//System.out.println("after fetching .. generateReportCompanyN2Dates "+vo.getCompany_id());
			vo.setFirst_date(null);
			//System.out.println("after fetching .. generateReportCompanyN2Dates "+vo.getFirst_date());
			vo.setLast_date(null);
			//System.out.println("after fetching .. generateReportCompanyN2Dates "+vo.getLast_date());
			
			jasperPrint = JasperFillManager.fillReport(jasperReport,
					parameters, con);
			
			JRExporter exporter = new JRPdfExporter();
			exporter.setParameter(JRExporterParameter.JASPER_PRINT,
					jasperPrint);
			ServletOutputStream servletOutputStream = response
					.getOutputStream();
			JasperExportManager.exportReportToPdfStream(jasperPrint,
					servletOutputStream);
			

			servletOutputStream.flush();
			servletOutputStream.close();

			//exporter.exportReport();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public void errorPage(Report_Generator_vo vo, HttpServletRequest request,
			HttpServletResponse response, Connection con) {
		try {
			response.sendRedirect("Report_User_Error.jsp");
		} catch (IOException e) {
						e.printStackTrace();
		}
		
	}

}
