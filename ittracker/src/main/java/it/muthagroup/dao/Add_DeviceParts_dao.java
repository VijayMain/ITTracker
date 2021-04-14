package it.muthagroup.dao;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.sql.Connection;
import java.sql.PreparedStatement; 
import java.sql.ResultSet;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Add_DeviceParts_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());	
	public void addNewDeviceParts(int devicename, int parttype, int qty,
			String specification, HttpSession session,
			HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			int up=0,avil=0; 
			PreparedStatement ps_part = con.prepareStatement("insert into it_asset_deviceitem_rel_tbl(asset_deviceitem_mst_id,asset_deviceinfo_id,qty,specification,scrap_flag,avail_flag,created_by,created_date)values(?,?,?,?,?,?,?,?)");
			ps_part.setInt(1, parttype);
			ps_part.setInt(2, devicename);
			ps_part.setInt(3, qty);
			ps_part.setString(4, specification);
			ps_part.setInt(5, 0);
			ps_part.setInt(6, 1);
			ps_part.setInt(7, uid);
			ps_part.setDate(8, curr_Date);			
			up = ps_part.executeUpdate();
		 
			PreparedStatement ps_availqty = con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where asset_deviceitem_mst_id="+parttype);
			ResultSet rs_availqty = ps_availqty.executeQuery();
			while(rs_availqty.next()){
				avil = rs_availqty.getInt("Available_qty");
			}
			avil = avil - qty;
			PreparedStatement ps_devParts = con.prepareStatement("update it_asset_deviceitem_mst_tbl set Available_qty=? where asset_deviceitem_mst_id="+parttype);
			ps_devParts.setInt(1, avil);
			up = ps_devParts.executeUpdate();
						
			if(up>0){
				con.close();
				String success = "Data inserted successfully....";
				response.sendRedirect("Add_newDeviceParts.jsp?success="+success);
			}else {
				con.close();
				String fail = "Error Occurred !!!";
				response.sendRedirect("Add_newDeviceParts.jsp?fail="+fail);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
}
