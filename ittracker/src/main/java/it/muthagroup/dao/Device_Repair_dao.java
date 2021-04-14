package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.Device_Repair_vo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Device_Repair_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(
			System.currentTimeMillis());

	public void addDevice_repairDetails(Device_Repair_vo vo,HttpSession session, HttpServletResponse response,boolean flag_replace) {
		try {
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			boolean flag = false;
			int r = 0,rup=0,ruphis=0,qtyAvail=0;

			if (flag_replace == true) {
				PreparedStatement ps_devRep = con
						.prepareStatement("insert into it_asset_device_partrepair_tbl"
								+ "(asset_deviceinfo_id,U_Req_Id,part_repaired,no_of_partused,asset_device_sur_condi_id,"
								+ "repaired_by,created_by,repaire_date,created_date,repaire_details)values(?,?,?,?,?,?,?,?,?,?)");
				ps_devRep.setInt(1, vo.getDev_name());
				ps_devRep.setInt(2, vo.getReqNo());
				ps_devRep.setInt(3, vo.getPartreplace());
				ps_devRep.setInt(4, vo.getQtyused());
				ps_devRep.setInt(5, vo.getPartcond());
				ps_devRep.setInt(6, vo.getRepaired_by());
				ps_devRep.setInt(7, uid);
				ps_devRep.setDate(8, vo.getRepaired_date());
				ps_devRep.setDate(9, curr_Date);
				ps_devRep.setString(10, vo.getDetails());
				r = ps_devRep.executeUpdate();
				if(r>0){
					qtyAvail = vo.getAvail_stk() - vo.getQtyused();
					System.out.println("Avail Qty = " + qtyAvail);
					PreparedStatement ps_upavail =con.prepareStatement("update it_asset_deviceitem_mst_tbl set Available_qty="+qtyAvail+" where asset_deviceitem_mst_id="+vo.getPartreplace());
					rup = ps_upavail.executeUpdate();
					if(rup>0){
						PreparedStatement ps_upahis=con.prepareStatement("insert into it_asset_deviceitem_mst_hist_tbl" +
								"(asset_deviceitem_mst_id,new_qty,created_by,created_date,new_availQty)values(?,?,?,?,?)");
						ps_upahis.setInt(1, vo.getPartreplace());
						ps_upahis.setInt(2, vo.getQtyused());
						ps_upahis.setInt(3, uid);
						ps_upahis.setDate(4, curr_Date);
						ps_upahis.setInt(5, qtyAvail);
						ruphis =ps_upahis.executeUpdate();
					}
					
					if(vo.getPartcond()==3){
						PreparedStatement ps_addscrap = con.prepareStatement("insert into it_asset_scrap_item_tbl" +
								"(asset_deviceitem_mst_id,asset_device_sur_condi_id,scrap_date,done_by,created_date,created_by)values(?,?,?,?,?,?)");
						ps_addscrap.setInt(1, vo.getPartreplace());
						ps_addscrap.setInt(2, vo.getPartcond());
						ps_addscrap.setDate(3, vo.getRepaired_date());
						ps_addscrap.setInt(4, vo.getRepaired_by());
						ps_addscrap.setDate(5, curr_Date);
						ps_addscrap.setInt(6, uid); 
						int scr = ps_addscrap.executeUpdate();
					}
				}
			}
			if (flag_replace == false) {
				PreparedStatement ps_devRep = con.prepareStatement("insert into it_asset_device_partrepair_tbl (asset_deviceinfo_id,U_Req_Id,part_repaired,repaired_by,created_by,repaire_date,created_date,repaire_details)values(?,?,?,?,?,?,?,?)");
				ps_devRep.setInt(1, vo.getDev_name());
				ps_devRep.setInt(2, vo.getReqNo());
				ps_devRep.setInt(3, vo.getPartreplace());
				ps_devRep.setInt(4, vo.getRepaired_by());
				ps_devRep.setInt(5, uid);
				ps_devRep.setDate(6, vo.getRepaired_date());
				ps_devRep.setDate(7, curr_Date);
				ps_devRep.setString(8, vo.getDetails());
				r = ps_devRep.executeUpdate();
			}
			if(r>0){
				String success = "Data inserted successfully....";
				response.sendRedirect("Asset_Master.jsp?success=" + success); 
			}else{
				String fail = "Error Occurred !!!";
				response.sendRedirect("Asset_Master.jsp?error=" + fail);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
}
