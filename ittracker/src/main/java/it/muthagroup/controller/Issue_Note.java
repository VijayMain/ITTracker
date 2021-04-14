package it.muthagroup.controller;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
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
 
public class Issue_Note extends HttpServlet {
	private static final long serialVersionUID = 1L; 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Connection con = Connection_Utility.getConnection();
			int dev_id=Integer.parseInt(request.getParameter("dev_namedownload"));
			PreparedStatement ps_issuenote = con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id="+dev_id);
			ResultSet rs_issuenote = ps_issuenote.executeQuery();
			while (rs_issuenote.next()) {
				PreparedStatement ps_issueid = con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+rs_issuenote.getInt("asset_deviceinfo_id"));
				ResultSet rs_issueid = ps_issueid.executeQuery();
				while (rs_issueid.next()) {
				if(rs_issueid.getInt("devicetype_mst_id")==1 || rs_issueid.getInt("devicetype_mst_id")==2){
					JasperReport jasperReport;
					JasperPrint jasperPrint;
					jasperReport = JasperCompileManager.compileReport("C:/JRXMLFILES/Issue_NoteDevice.jrxml");

					Map parameters = new HashMap();
					parameters.put("Issue_note", rs_issuenote.getInt("asset_issueNote_id"));
					jasperPrint = JasperFillManager.fillReport(jasperReport,parameters, con);

					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,jasperPrint);
					ServletOutputStream servletOutputStream = response.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();
				}else{
					JasperReport jasperReport;
					JasperPrint jasperPrint;
					jasperReport = JasperCompileManager.compileReport("C:/JRXMLFILES/Issue_NotePrinter.jrxml");

					Map parameters = new HashMap();
					parameters.put("Issue_note", rs_issuenote.getInt("asset_issueNote_id"));
					jasperPrint = JasperFillManager.fillReport(jasperReport,parameters, con);

					JRExporter exporter = new JRPdfExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT,jasperPrint);
					ServletOutputStream servletOutputStream = response.getOutputStream();
					JasperExportManager.exportReportToPdfStream(jasperPrint,servletOutputStream);
					servletOutputStream.flush();
					servletOutputStream.close();
				}
				}
				
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
