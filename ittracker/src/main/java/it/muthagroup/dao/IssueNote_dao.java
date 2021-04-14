package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList; 

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.IssueNote_vo;
 
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport; 

public class IssueNote_dao {	
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());	
	public void addIssueNote(HttpSession session, IssueNote_vo vo,
			HttpServletResponse response, ArrayList soft) {
		try {
			JasperReport jasperReport;
			JasperPrint jasperPrint;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			int up=0,save=0,issue=0,s=0,ipavail=0;
			boolean flag=false;
			String issueQry = "insert into it_asset_issuenote_tbl(asset_deviceinfo_id,issued_to,issue_date,given_by,extra_info,created_by,created_date,Company_Id,location,contact_no,Email,surrender_flag)values(?,?,?,?,?,?,?,?,?,?,?,?)";
			
			PreparedStatement ps_issuenote=con.prepareStatement(issueQry);
			ps_issuenote.setInt(1, vo.getDev_name());
			ps_issuenote.setInt(2, vo.getIssuedto());
			ps_issuenote.setDate(3, vo.getIssuedate());
			ps_issuenote.setInt(4, vo.getIssuedby());
			ps_issuenote.setString(5, vo.getExtra());
			ps_issuenote.setInt(6, uid);
			ps_issuenote.setDate(7, curr_Date); 
			ps_issuenote.setInt(8, vo.getCompany());
			ps_issuenote.setString(9, vo.getLocation());
			ps_issuenote.setString(10, vo.getContNo());
			ps_issuenote.setString(11, vo.getEmail());
			ps_issuenote.setInt(12, 0);
			
			save = ps_issuenote.executeUpdate();
			
			if(save>0){
				String updateDevQry = "update it_asset_deviceinfo_tbl set available_flag=0,Updated_date='"+curr_Date+"',updated_by="+uid+" where asset_deviceinfo_id="+vo.getDev_name();
				PreparedStatement psUpdate=con.prepareStatement(updateDevQry);
				up = psUpdate.executeUpdate();
				psUpdate.close();
				
				PreparedStatement ps_issuesoft=con.prepareStatement("select max(asset_issueNote_id) from it_asset_issuenote_tbl");
				ResultSet rs_issuesoft = ps_issuesoft.executeQuery();
				while(rs_issuesoft.next()){
					issue = rs_issuesoft.getInt("max(asset_issueNote_id)");
				}
				ps_issuesoft.close();
				rs_issuesoft.close(); 
				 if(issue==0){
					 issue++;
				 }
					for (int i=0; i < soft.size(); i++) {
					PreparedStatement ps_sft=con.prepareStatement("insert into it_asset_issuesoft_rel_tbl(asset_issueNote_id,asset_software_id,created_by,created_date)values(?,?,?,?)");
					ps_sft.setInt(1, issue);
					ps_sft.setInt(2,Integer.parseInt(soft.get(i).toString()));
					ps_sft.setInt(3, uid);
					ps_sft.setDate(4, curr_Date);
					s = ps_sft.executeUpdate();
				}
				
				if(up>0){
					flag=true; 
					PreparedStatement ps_dev1=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+vo.getDev_name());
				    ResultSet rs_dev1 = ps_dev1.executeQuery();
					while(rs_dev1.next()){
						ipavail = rs_dev1.getInt("asset_ipaddress_id");
					}
			}
			
				if(flag==true){ 
					response.sendRedirect("Asset_Master.jsp"); 
				}else{ 
					response.sendRedirect("Asset_Master.jsp");
				}  
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
