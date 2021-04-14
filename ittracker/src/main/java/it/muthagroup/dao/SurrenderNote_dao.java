package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement; 
import java.sql.ResultSet;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.Surrender_vo; 
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SurrenderNote_dao {
	
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
	
	public void addSurrenderDevice(Surrender_vo vo, HttpSession session,
			HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			int scrap = 0;
			int updateDev=0,ipup=0;
			PreparedStatement ps_issuenote = con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id="+vo.getDevName()+" and surrender_flag=0");
			ResultSet rs_issuenote=ps_issuenote.executeQuery();
			while(rs_issuenote.next()){
				vo.setIssueNote(rs_issuenote.getInt("asset_issueNote_id"));
				System.out.println("issuneoye = = =  =" + rs_issuenote.getInt("asset_issueNote_id"));
			}
			
			
			PreparedStatement ps_att=con.prepareStatement("insert into it_asset_device_surrender_tbl " +
				"(asset_issueNote_id,surrender_date,surrended_by,accepted_by,created_by,created_date,extra_info," +
				"asset_deviceinfo_id,asset_device_sur_condi_id)values(?,?,?,?,?,?,?,?,?)");
			ps_att.setInt(1, vo.getIssueNote());
			ps_att.setDate(2, vo.getSurrender_date());
			ps_att.setInt(3, vo.getSubmitby());
			ps_att.setInt(4, vo.getItperson());
			ps_att.setInt(5, uid);
			ps_att.setDate(6, curr_Date);
			ps_att.setString(7, vo.getDetails());
			ps_att.setInt(8, vo.getDevName());
			ps_att.setInt(9, vo.getDev_cond());			
			
			int up = ps_att.executeUpdate();
			
			if(vo.getDev_cond()==3){
				scrap = 1;
			}
			
			PreparedStatement ps_issuesurred = con.prepareStatement("update it_asset_issuenote_tbl set surrender_flag=1 where asset_issueNote_id="+vo.getIssueNote());
			int surId=ps_issuesurred.executeUpdate();
			 
			PreparedStatement ps_updatedevice = con.prepareStatement("update it_asset_deviceinfo_tbl set available_flag=?,scrap_flag=?,Updated_date=?  where asset_deviceinfo_id="+vo.getDevName());
			ps_updatedevice.setInt(1, 1);
			ps_updatedevice.setInt(2, scrap);
			ps_updatedevice.setDate(3, curr_Date);			
			updateDev=ps_updatedevice.executeUpdate();
			 
			if(scrap==1){
			PreparedStatement ps_ip=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+vo.getDevName());			
			ResultSet rs_ip=ps_ip.executeQuery();
			while(rs_ip.next()){
				if(rs_ip.getInt("asset_ipaddress_id")!=0){
					PreparedStatement ps_ipup=con.prepareStatement("update it_asset_ipaddress_mst_tbl set flag=?,created_by=? where asset_ipaddress_id="+rs_ip.getInt("asset_ipaddress_id"));
					ps_ipup.setInt(1, 1);
					ps_ipup.setInt(2, uid);					
					ipup = ps_ipup.executeUpdate();
				}
			}
			}
			
			if(up>0 && surId>0){
				con.close();
				String success = "Data inserted successfully....";
				response.sendRedirect("MakeSurrenderNote.jsp?success="+success);
			}else {
				con.close();
				String error = "Failed !!!";
				response.sendRedirect("MakeSurrenderNote.jsp?error="+error);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
