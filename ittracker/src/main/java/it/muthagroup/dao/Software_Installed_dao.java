package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList; 

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.software_access_vo;

import javax.servlet.http.HttpSession;

public class Software_Installed_dao {
boolean flag=false;
private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());	
	public boolean addSoftInstalled(HttpSession session, software_access_vo vo) {
	try {
		int issue_id=0;
		int j = 0;
		int cnt = 0;
		int cnt_info=0;
		ArrayList soft = new ArrayList();
		Connection con = Connection_Utility.getConnection();
		PreparedStatement ps_addAccess = null;
		soft = vo.getSoft();
		issue_id = vo.getUid();
		
	
		
		int registered_by = Integer.parseInt(session.getAttribute("uid").toString()); 
		 
		
		PreparedStatement ps_cnt = con.prepareStatement("select count(*) from it_asset_issuesoft_rel_tbl where asset_issueNote_id="+issue_id);
		ResultSet rs_cnt = ps_cnt.executeQuery();
		while(rs_cnt.next()){
			cnt_info = rs_cnt.getInt("count(*)");
		}
		
		if(cnt_info!=0){
		PreparedStatement ps_del_inst = con.prepareStatement("delete from it_asset_issuesoft_rel_tbl where asset_issueNote_id="+issue_id);
		int del = ps_del_inst.executeUpdate();
		}
		
		for(int i=0;i<soft.size();i++){
			PreparedStatement ps_getSoftId = con.prepareStatement("Select * from it_asset_software_mst_tbl where software_name='" + soft.get(i).toString() + "'");
			ResultSet rs_getSoftId = ps_getSoftId.executeQuery();
			while (rs_getSoftId.next()) {
				
				ps_addAccess =  con.prepareStatement("insert into it_asset_issuesoft_rel_tbl(asset_issueNote_id,asset_software_id,created_by,created_date)values(?,?,?,?)");

				ps_addAccess.setInt(1, issue_id);
				ps_addAccess.setInt(2, rs_getSoftId.getInt("asset_software_id"));
				ps_addAccess.setInt(3, registered_by);
				ps_addAccess.setDate(4, curr_Date);
 
				j = ps_addAccess.executeUpdate();
				
				if (j > 0) {
					cnt++;
				}
			}
		}
		if (soft.size() == cnt) {
			flag = true;
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
		return flag;
	}
}
