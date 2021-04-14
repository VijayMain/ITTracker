package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat; 
import java.util.ArrayList;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.Device_info_vo;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

public class Device_info_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
	public void addDeviceInfo(HttpSession session, Device_info_vo vo,HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			int ins=0;
			
			if(vo.getOs()>0){
			if(vo.getIp_address()>0){
			PreparedStatement ps_ins_Device = con.prepareStatement("insert into it_asset_deviceinfo_tbl(po_no,po_date,asset_supplier_mst_id,GRN_No,GRN_Date,basic_rate,total_amt,hrd_mac_address,description,created_by,created_date,device_name,devicetype_mst_id,model_no,serialno,imei_no,item_code,it_rec_date,imei2_no,asset_ipaddress_id,available_flag,scrap_flag,online_purchase,asset_OS_id)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps_ins_Device.setString(1, vo.getPono());
			ps_ins_Device.setDate(2, vo.getPodate());
			ps_ins_Device.setInt(3, vo.getSupplier());
			ps_ins_Device.setString(4, vo.getGrn_no());
			ps_ins_Device.setDate(5, vo.getGrndate());
			ps_ins_Device.setDouble(6, vo.getBasic_rate());
			ps_ins_Device.setDouble(7, vo.getTot_amt());
			ps_ins_Device.setString(8, vo.getMac_address());
			ps_ins_Device.setString(9, vo.getDescription());
			ps_ins_Device.setInt(10, uid);
			ps_ins_Device.setDate(11, curr_Date);
			ps_ins_Device.setString(12, vo.getDevicename());
			ps_ins_Device.setInt(13, vo.getDev_type());
			ps_ins_Device.setString(14, vo.getModelno());
			ps_ins_Device.setString(15, vo.getSerialno());
			ps_ins_Device.setString(16, vo.getImei_no());
			ps_ins_Device.setString(17, vo.getItem_code());
			ps_ins_Device.setDate(18, vo.getReceived_date());
			ps_ins_Device.setString(19, vo.getImei_no2());
			ps_ins_Device.setInt(20, vo.getIp_address());
			ps_ins_Device.setInt(21, 1);
			ps_ins_Device.setInt(22, 0);
			ps_ins_Device.setString(23,vo.getOnline());
			ps_ins_Device.setInt(24,vo.getOs());
		ins = ps_ins_Device.executeUpdate();
			}else {
				PreparedStatement ps_ins_Device = con.prepareStatement("insert into it_asset_deviceinfo_tbl(po_no,po_date,asset_supplier_mst_id,GRN_No,GRN_Date,basic_rate,total_amt,hrd_mac_address,description,created_by,created_date,device_name,devicetype_mst_id,model_no,serialno,imei_no,item_code,it_rec_date,imei2_no,available_flag,scrap_flag,online_purchase,asset_OS_id)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				ps_ins_Device.setString(1, vo.getPono());
				ps_ins_Device.setDate(2, vo.getPodate());
				ps_ins_Device.setInt(3, vo.getSupplier());
				ps_ins_Device.setString(4, vo.getGrn_no());
				ps_ins_Device.setDate(5, vo.getGrndate());
				ps_ins_Device.setDouble(6, vo.getBasic_rate());
				ps_ins_Device.setDouble(7, vo.getTot_amt());
				ps_ins_Device.setString(8, vo.getMac_address());
				ps_ins_Device.setString(9, vo.getDescription());
				ps_ins_Device.setInt(10, uid);
				ps_ins_Device.setDate(11, curr_Date);
				ps_ins_Device.setString(12, vo.getDevicename());
				ps_ins_Device.setInt(13, vo.getDev_type());
				ps_ins_Device.setString(14, vo.getModelno());
				ps_ins_Device.setString(15, vo.getSerialno());
				ps_ins_Device.setString(16, vo.getImei_no());
				ps_ins_Device.setString(17, vo.getItem_code());
				ps_ins_Device.setDate(18, vo.getReceived_date());
				ps_ins_Device.setString(19, vo.getImei_no2());
				ps_ins_Device.setInt(20, 1);
				ps_ins_Device.setInt(21, 0);
				ps_ins_Device.setString(22, vo.getOnline());
				ps_ins_Device.setInt(23, vo.getOs());
			ins = ps_ins_Device.executeUpdate();	
			}
			}else{
				if(vo.getIp_address()>0){
					PreparedStatement ps_ins_Device = con.prepareStatement("insert into it_asset_deviceinfo_tbl(po_no,po_date,asset_supplier_mst_id,GRN_No,GRN_Date,basic_rate,total_amt,hrd_mac_address,description,created_by,created_date,device_name,devicetype_mst_id,model_no,serialno,imei_no,item_code,it_rec_date,imei2_no,asset_ipaddress_id,available_flag,scrap_flag,online_purchase)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					ps_ins_Device.setString(1, vo.getPono());
					ps_ins_Device.setDate(2, vo.getPodate());
					ps_ins_Device.setInt(3, vo.getSupplier());
					ps_ins_Device.setString(4, vo.getGrn_no());
					ps_ins_Device.setDate(5, vo.getGrndate());
					ps_ins_Device.setDouble(6, vo.getBasic_rate());
					ps_ins_Device.setDouble(7, vo.getTot_amt());
					ps_ins_Device.setString(8, vo.getMac_address());
					ps_ins_Device.setString(9, vo.getDescription());
					ps_ins_Device.setInt(10, uid);
					ps_ins_Device.setDate(11, curr_Date);
					ps_ins_Device.setString(12, vo.getDevicename());
					ps_ins_Device.setInt(13, vo.getDev_type());
					ps_ins_Device.setString(14, vo.getModelno());
					ps_ins_Device.setString(15, vo.getSerialno());
					ps_ins_Device.setString(16, vo.getImei_no());
					ps_ins_Device.setString(17, vo.getItem_code());
					ps_ins_Device.setDate(18, vo.getReceived_date());
					ps_ins_Device.setString(19, vo.getImei_no2());
					ps_ins_Device.setInt(20, vo.getIp_address());
					ps_ins_Device.setInt(21, 1);
					ps_ins_Device.setInt(22, 0);
					ps_ins_Device.setString(23,vo.getOnline());
				ins = ps_ins_Device.executeUpdate();
					}else {
						PreparedStatement ps_ins_Device = con.prepareStatement("insert into it_asset_deviceinfo_tbl(po_no,po_date,asset_supplier_mst_id,GRN_No,GRN_Date,basic_rate,total_amt,hrd_mac_address,description,created_by,created_date,device_name,devicetype_mst_id,model_no,serialno,imei_no,item_code,it_rec_date,imei2_no,available_flag,scrap_flag,online_purchase)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
						ps_ins_Device.setString(1, vo.getPono());
						ps_ins_Device.setDate(2, vo.getPodate());
						ps_ins_Device.setInt(3, vo.getSupplier());
						ps_ins_Device.setString(4, vo.getGrn_no());
						ps_ins_Device.setDate(5, vo.getGrndate());
						ps_ins_Device.setDouble(6, vo.getBasic_rate());
						ps_ins_Device.setDouble(7, vo.getTot_amt());
						ps_ins_Device.setString(8, vo.getMac_address());
						ps_ins_Device.setString(9, vo.getDescription());
						ps_ins_Device.setInt(10, uid);
						ps_ins_Device.setDate(11, curr_Date);
						ps_ins_Device.setString(12, vo.getDevicename());
						ps_ins_Device.setInt(13, vo.getDev_type());
						ps_ins_Device.setString(14, vo.getModelno());
						ps_ins_Device.setString(15, vo.getSerialno());
						ps_ins_Device.setString(16, vo.getImei_no());
						ps_ins_Device.setString(17, vo.getItem_code());
						ps_ins_Device.setDate(18, vo.getReceived_date());
						ps_ins_Device.setString(19, vo.getImei_no2());
						ps_ins_Device.setInt(20, 1);
						ps_ins_Device.setInt(21, 0);
						ps_ins_Device.setString(22, vo.getOnline());
					ins = ps_ins_Device.executeUpdate();	
					}	
				
			}
			if(ins>0){
				if(vo.getIp_address()>0){
					PreparedStatement ps_ip = con.prepareStatement("update it_asset_ipaddress_mst_tbl set flag=0,created_by="+uid+" where asset_ipaddress_id="+vo.getIp_address());
					int up = ps_ip.executeUpdate();
				}
				con.close();
				String success = "Data inserted successfully....";
				response.sendRedirect("Asset_Master.jsp?success="+success); 
			}else {
				con.close();
				String success = "Error Occurred !!!!";
				response.sendRedirect("Asset_Master.jsp?fail="+success); 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	public void addNewDeviceType(String device_Type, HttpSession session,
			HttpServletResponse response) {
		try {
			boolean flag = false;
			int devup = 0;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_gettype = con.prepareStatement("select * from it_asset_devicetype_mst_tbl");
			ResultSet rs_getType=ps_gettype.executeQuery(); 			
			while(rs_getType.next()){
				if(rs_getType.getString("device_type").equalsIgnoreCase(device_Type)){
					flag = true;
				}
			}
			ps_gettype.close();
			rs_getType.close();
			if(flag==true){
				con.close();
				String avail = "Already Available....";
				response.sendRedirect("Add_newDeviceType.jsp?avail="+avail); 				
			}else {
				PreparedStatement ps_devtype = con.prepareStatement("insert into it_asset_devicetype_mst_tbl(device_type,created_by)values(?,?)");
				ps_devtype.setString(1, device_Type);
				ps_devtype.setInt(2, uid);
				devup = ps_devtype.executeUpdate();	
				ps_devtype.close();
				if(devup>0){
					con.close();
					String success = "Data inserted successfully....";
					response.sendRedirect("Add_newDeviceType.jsp?success="+success); 
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addNewSupplier(String supplier, HttpSession session,
			HttpServletResponse response) {
			try {
				boolean flag = false;
				int supp = 0;
				Connection con = Connection_Utility.getConnection(); 
				int uid = Integer.parseInt(session.getAttribute("uid").toString());
				
				PreparedStatement ps_getsup = con.prepareStatement("select * from it_asset_supplier_mst_tbl");
				ResultSet rs_getsup=ps_getsup.executeQuery(); 			
				while(rs_getsup.next()){
					if(rs_getsup.getString("supplier").equalsIgnoreCase(supplier)){
						flag = true;
					}
				}
				rs_getsup.close();
				ps_getsup.close();
				if(flag==true){
					con.close();
					String avail = "Already Available....";
					response.sendRedirect("Add_newSupplier.jsp?avail="+avail); 				
				}else {
					PreparedStatement ps_devsup = con.prepareStatement("insert into it_asset_supplier_mst_tbl(supplier,created_by)values(?,?)");
					ps_devsup.setString(1, supplier);
					ps_devsup.setInt(2, uid);
					supp = ps_devsup.executeUpdate();
					ps_devsup.close();
					if(supp>0){
						con.close();
						String success = "Data inserted successfully....";
						response.sendRedirect("Add_newSupplier.jsp?success="+success); 
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}		
	}
	public void addNewSoftware(String soft, int softype, HttpSession session,HttpServletResponse response) {
		try {
			boolean flag = false;
			int sf = 0;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_getsoft = con.prepareStatement("select * from it_asset_software_mst_tbl");
			ResultSet rs_getsoft=ps_getsoft.executeQuery(); 			
			while(rs_getsoft.next()){
				if(rs_getsoft.getString("software_name").equalsIgnoreCase(soft) && rs_getsoft.getInt("licence_type_id")==softype){
					flag = true;
				}
			}
			ps_getsoft.close();
			rs_getsoft.close();
			if(flag==true){
				con.close();
				String avail = "Already Available....";
				response.sendRedirect("Add_newSoftwares.jsp?avail="+avail); 				
			}else {
				PreparedStatement ps_devsup = con.prepareStatement("insert into it_asset_software_mst_tbl(software_name,created_by,licence_type_id)values(?,?,?)");
				ps_devsup.setString(1, soft);
				ps_devsup.setInt(2, uid);
				ps_devsup.setInt(3, softype);
				sf = ps_devsup.executeUpdate();
				ps_devsup.close();
				if(sf>0){
					con.close();
					String success = "Data inserted successfully....";
					response.sendRedirect("Add_newSoftwares.jsp?success="+success); 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addNewOS(String new_os, int ostype, HttpSession session,
			HttpServletResponse response) {
		try {
			boolean flag = false;
			int sf = 0;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_getos = con.prepareStatement("select * from it_asset_os_mst_tbl");
			ResultSet rs_getos=ps_getos.executeQuery(); 			
			while(rs_getos.next()){
				if(rs_getos.getString("os_name").equalsIgnoreCase(new_os) && rs_getos.getInt("licence_type_id")==ostype){
					flag = true;
				}
			}
			ps_getos.close();
			rs_getos.close();
			if(flag==true){
				con.close();
				String avail = "Already Available....";
				response.sendRedirect("Add_newOS.jsp?avail="+avail); 				
			}else {
				PreparedStatement ps_osup = con.prepareStatement("insert into it_asset_os_mst_tbl(os_name,created_by,licence_type_id)values(?,?,?)");
				ps_osup.setString(1, new_os);
				ps_osup.setInt(2, uid);
				ps_osup.setInt(3, ostype);
				sf = ps_osup.executeUpdate();
				ps_osup.close();
				if(sf>0){
					con.close();
					String success = "Data inserted successfully....";
					response.sendRedirect("Add_newOS.jsp?success="+success); 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	public void addNewAdapter(String new_adapter, String serialno,
			String inputoutput, HttpSession session,
			HttpServletResponse response) { 
		try {
			boolean flag = false;
			int sf = 0;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_getadp = con.prepareStatement("select * from it_asset_adapter_mst_tbl");
			ResultSet rs_getadp=ps_getadp.executeQuery(); 			
			while(rs_getadp.next()){
				if(rs_getadp.getString("adapter_model_name").equalsIgnoreCase(new_adapter) && rs_getadp.getString("serial_no").equalsIgnoreCase(serialno) && rs_getadp.getString("input_output").equalsIgnoreCase(inputoutput)){
					flag = true;
				}
			}
			ps_getadp.close();
			rs_getadp.close();
			if(flag==true){
				con.close();
				String avail = "Already Available....";
				response.sendRedirect("Add_newAdapter.jsp?avail="+avail); 				
			}else {
				PreparedStatement ps_osup = con.prepareStatement("insert into it_asset_adapter_mst_tbl(adapter_model_name,serial_no,input_output,created_by)values(?,?,?,?)");
				ps_osup.setString(1, new_adapter);
				ps_osup.setString(2, serialno);
				ps_osup.setString(3, inputoutput);
				ps_osup.setInt(4, uid); 
				sf = ps_osup.executeUpdate();
				ps_osup.close();
				if(sf>0){
					con.close();
					String success = "Data inserted successfully....";
					response.sendRedirect("Add_newAdapter.jsp?success="+success); 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addNewIPAddress(String ipaddress, HttpSession session,HttpServletResponse response) {
		try {
			boolean flag = false;
			int sf = 0;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_getip = con.prepareStatement("select * from it_asset_ipaddress_mst_tbl");
			ResultSet rs_getip=ps_getip.executeQuery(); 			
			while(rs_getip.next()){
				if(rs_getip.getString("ip_address").equalsIgnoreCase(ipaddress)){
					flag = true;
				}
			}
			ps_getip.close();
			rs_getip.close();
			if(flag==true){
				con.close();
				String avail = "Already Available....";
				response.sendRedirect("Add_newIPAddress.jsp?avail="+avail); 				
			}else {
				PreparedStatement ps_osup = con.prepareStatement("insert into it_asset_ipaddress_mst_tbl(ip_address,flag,created_by)values(?,?,?)");
				ps_osup.setString(1, ipaddress);
				ps_osup.setInt(2, 1); 
				ps_osup.setInt(3, uid); 
				sf = ps_osup.executeUpdate();
				ps_osup.close();
				if(sf>0){
					con.close();
					String success = "Data inserted successfully....";
					response.sendRedirect("Add_newIPAddress.jsp?success="+success); 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addNewAMCInfo(int devicename, String location, String provider,
			HttpSession session, HttpServletResponse response) {
		try {
			boolean flag = false;
			int sf = 0,amcInfoId=0,infoId=0;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_getip = con.prepareStatement("select * from it_asset_compasset_tbl");
			ResultSet rs_getip=ps_getip.executeQuery();
			
			rs_getip.last(); 
			int b = rs_getip.getRow();
			rs_getip.beforeFirst();
			
			while(rs_getip.next()){
				if(rs_getip.getInt("asset_deviceinfo_id")==devicename && rs_getip.getString("location").equalsIgnoreCase(location) && rs_getip.getString("amc_provider").equalsIgnoreCase(provider)){
					flag = true;
				}
				if(rs_getip.getInt("asset_deviceinfo_id")==devicename){
					infoId = 1;
				}
			}
			ps_getip.close();
			rs_getip.close();
			if(flag==true){
				con.close();
				String avail = "Already Available....";
				response.sendRedirect("Add_newAMC_info.jsp?avail="+avail); 				
			}else {
				//if AMC info already available
				if(infoId==0){
				PreparedStatement ps_osup = con.prepareStatement("insert into it_asset_compasset_tbl(asset_deviceinfo_id,location,amc_provider,created_by)values(?,?,?,?)");
				ps_osup.setInt(1, devicename);
				ps_osup.setString(2, location); 
				ps_osup.setString(3, provider);
				ps_osup.setInt(4, uid); 
				sf = ps_osup.executeUpdate();
				ps_osup.close();
				if(sf>0){
					PreparedStatement ps_amc=con.prepareStatement("select max(asset_compAsset_id) from it_asset_compasset_tbl");
					ResultSet rs_amc = ps_amc.executeQuery();
					while(rs_amc.next()){
						amcInfoId = rs_amc.getInt("max(asset_compAsset_id)");
					}
					ps_amc.close();
					rs_amc.close();
					con.close(); 
					response.sendRedirect("Add_AMC_contactInfo.jsp?amcId="+amcInfoId); 
				}
				
				}else{
					System.out.println("Available AMC !!!");
					
					PreparedStatement ps_amc=con.prepareStatement("select * from it_asset_compasset_tbl where asset_deviceinfo_id="+devicename);
					ResultSet rs_amc = ps_amc.executeQuery();
					while(rs_amc.next()){
						amcInfoId = rs_amc.getInt("asset_compAsset_id");
					}
					ps_amc.close();
					rs_amc.close();
					
					PreparedStatement ps_up=con.prepareStatement("update it_asset_compasset_tbl set location='"+location+"',amc_provider='"+provider+"',created_by="+uid+" where asset_deviceinfo_id="+devicename);
					ps_up.executeUpdate();
					con.close(); 
					response.sendRedirect("Add_AMC_contactInfo.jsp?amcId="+amcInfoId);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addNewAMC_ContactInfo(String cont_name, String cont_no,
			int asset_id, HttpSession session, HttpServletResponse response) {
		try {
			boolean flag = false;
			int sf = 0,st=0,amcid=0;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_getip = con.prepareStatement("select * from it_asset_assetamc_rel_tbl where asset_compAsset_id="+asset_id);
			ResultSet rs_getip=ps_getip.executeQuery(); 			
			while(rs_getip.next()){
				PreparedStatement ps_getcn = con.prepareStatement("select * from it_asset_amc_tbl where asset_AMC_id="+rs_getip.getInt("asset_AMC_id"));
				ResultSet rs_getcn=ps_getcn.executeQuery();
				while(rs_getcn.next()){
					if(rs_getcn.getString("name").equalsIgnoreCase(cont_name) && rs_getcn.getString("contact").equalsIgnoreCase(cont_no)){
						flag = true;
					}	
				}				
			}
			ps_getip.close();
			rs_getip.close();
			if(flag==true){
				con.close();
				String avail = "Already Available....";
				response.sendRedirect("Add_AMC_contactInfo.jsp?amcId="+asset_id+"&avail="+avail); 				
			}else {
				PreparedStatement ps_osup = con.prepareStatement("insert into it_asset_amc_tbl(name,contact,created_by)values(?,?,?)");
				ps_osup.setString(1, cont_name);
				ps_osup.setString(2, cont_no); 
				ps_osup.setInt(3, uid); 
				sf = ps_osup.executeUpdate();
				ps_osup.close();			
				
				
				if(sf>0){
					
					PreparedStatement ctget=con.prepareStatement("select max(asset_AMC_id) from it_asset_amc_tbl");
					ResultSet rs_amc=ctget.executeQuery();
					while(rs_amc.next()){
						amcid = rs_amc.getInt("max(asset_AMC_id)");
					}
					ctget.close();
					rs_amc.close();
					
					PreparedStatement ps_rel = con.prepareStatement("insert into it_asset_assetamc_rel_tbl(asset_compAsset_id,asset_AMC_id,created_by)values(?,?,?)");
					ps_rel.setInt(1, asset_id);
					ps_rel.setInt(2, amcid);
					ps_rel.setInt(3, uid);
					st = ps_rel.executeUpdate();
					ps_osup.close();
					
					con.close();
					String success = "Data inserted successfully....";
					response.sendRedirect("Add_AMC_contactInfo.jsp?amcId="+asset_id+"&success="+success); 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addNewSpares(String new_spare, String avil_stock,
			String details, HttpSession session, HttpServletResponse response) {
	try {
		boolean flag = false;
		int spup = 0;
		Connection con = Connection_Utility.getConnection(); 
		int uid = Integer.parseInt(session.getAttribute("uid").toString());
		
		PreparedStatement ps_getspare = con.prepareStatement("select * from it_asset_deviceitem_mst_tbl");
		ResultSet rs_getspare=ps_getspare.executeQuery(); 			
		while(rs_getspare.next()){
			if(rs_getspare.getString("device_parts").equalsIgnoreCase(new_spare)){
				flag = true;
			}
		}
		ps_getspare.close();
		rs_getspare.close();
		if(flag==true){
			con.close();
			String avail = "Already Available....";
			response.sendRedirect("Add_newspareparts.jsp?avail="+avail); 				
		}else {
			PreparedStatement ps_devspares = con.prepareStatement("insert into it_asset_deviceitem_mst_tbl(device_parts,Available_qty,created_date,created_by,spares_details)values(?,?,?,?,?)");
			ps_devspares.setString(1, new_spare);
			ps_devspares.setInt(2,Integer.parseInt(avil_stock));
			ps_devspares.setDate(3, curr_Date);
			ps_devspares.setInt(4, uid);
			ps_devspares.setString(5, details);
			spup = ps_devspares.executeUpdate();	
			ps_devspares.close();
			if(spup>0){
				con.close();
				String success = "Data inserted successfully....";
				response.sendRedirect("Add_newspareparts.jsp?success="+success); 
			}
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
		
	}
	public void addNewCompany_DeviceInfo(int dev_name, ArrayList soft, int company,int installed_by, String location, String dateinstall, String details, HttpSession session, HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int newdev=0,up=0,s=0; 
			
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
			PreparedStatement ps_cmpasset=con.prepareStatement("insert into it_asset_companydevice_tbl" +
					"(asset_deviceinfo_id,location,date_installed,last_updated_date,details,created_by,installed_by,scrap_flag,used_flag,company_id)values(?,?,?,?,?,?,?,?,?,?)");
			ps_cmpasset.setInt(1, dev_name);
			ps_cmpasset.setString(2, location);
			ps_cmpasset.setDate(3, new java.sql.Date(dateFormat.parse(dateinstall).getTime()));
			ps_cmpasset.setDate(4, new java.sql.Date(dateFormat.parse(dateinstall).getTime()));
			ps_cmpasset.setString(5, details);
			ps_cmpasset.setInt(6, uid);
			ps_cmpasset.setInt(7, installed_by); 
			ps_cmpasset.setInt(8, 0);
			ps_cmpasset.setInt(9, 1);
			ps_cmpasset.setInt(10, company);
			newdev = ps_cmpasset.executeUpdate();
			
			String updateDevQry = "update it_asset_deviceinfo_tbl set available_flag=0,Updated_date='"+curr_Date+"',updated_by="+uid+" where asset_deviceinfo_id="+dev_name;
			PreparedStatement psUpdate=con.prepareStatement(updateDevQry);
			up = psUpdate.executeUpdate();
			psUpdate.close();
			
			for (int i=0; i < soft.size(); i++) {
				PreparedStatement ps_sft=con.prepareStatement("insert into it_assetcompsoft_tbl(asset_deviceinfo_id,asset_software_id,created_by,created_date)values(?,?,?,?)");
				ps_sft.setInt(1, dev_name);
				ps_sft.setInt(2,Integer.parseInt(soft.get(i).toString()));
				ps_sft.setInt(3, uid);
				ps_sft.setDate(4, curr_Date);
				s = ps_sft.executeUpdate();
			}
			
			if(newdev>0){
				con.close();
				String success = "Data inserted successfully....";
				response.sendRedirect("Add_newCompanyAsset.jsp?success="+success); 
			}else{
				con.close();
				String error = "Error Occurred !!!";
				response.sendRedirect("Add_newCompanyAsset.jsp?success="+error);
			}			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addNewScrapInfo(int dev_name, String scrap_date, String reason,
			int checkedby, HttpSession session, HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int ipup=0;
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
			PreparedStatement ps_scrap = con.prepareStatement("insert into it_asset_scrap_tbl(asset_deviceinfo_id,scrap_date,done_by,scrap_details,created_date,created_by)values(?,?,?,?,?,?)");
			ps_scrap.setInt(1, dev_name);
			ps_scrap.setDate(2, new java.sql.Date(dateFormat.parse(scrap_date).getTime()));
			ps_scrap.setInt(3, checkedby);
			ps_scrap.setString(4, reason);
			ps_scrap.setDate(5, curr_Date);
			ps_scrap.setInt(6, uid);
			int scr=ps_scrap.executeUpdate();
			
			PreparedStatement ps_updatedevice = con.prepareStatement("update it_asset_deviceinfo_tbl set available_flag=?,scrap_flag=?,Updated_date=?  where asset_deviceinfo_id="+dev_name);
			ps_updatedevice.setInt(1, 1);
			ps_updatedevice.setInt(2, 1);
			ps_updatedevice.setDate(3, curr_Date);			
			int updateDev=ps_updatedevice.executeUpdate();
			  
			PreparedStatement ps_ip=con.prepareStatement("select * from it_asset_deviceinfo_tbl where asset_deviceinfo_id="+dev_name);			
			ResultSet rs_ip=ps_ip.executeQuery();
			while(rs_ip.next()){
				if(rs_ip.getInt("asset_ipaddress_id")!=0){
					PreparedStatement ps_ipup=con.prepareStatement("update it_asset_ipaddress_mst_tbl set flag=?,created_by=? where asset_ipaddress_id="+rs_ip.getInt("asset_ipaddress_id"));
					ps_ipup.setInt(1, 1);
					ps_ipup.setInt(2, uid);					
					ipup = ps_ipup.executeUpdate();
				} 
			}
			PreparedStatement ps_compAsset = con.prepareStatement("update it_asset_companydevice_tbl set used_flag=0 and scrap_flag=1 where asset_deviceinfo_id="+dev_name +" and used_flag=1 and scrap_flag=0");
			int update = ps_compAsset.executeUpdate();
			
			if(scr>0){
				con.close();
				String success = "Data inserted successfully....";
				response.sendRedirect("Add_newScrapData.jsp?success="+success); 
			}else{
				con.close();
				String error = "Error Occurred !!!";
				response.sendRedirect("Add_newScrapData.jsp?success="+error);
			}				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addprinterRefill(String dev_name, String beforeRefill,
			String afterRefill, String inkused, String avg_count,
			String refilldate, String itperson, String details,
			HttpSession session, HttpServletResponse response) {
		try {
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
			
			PreparedStatement ps_scrap = con.prepareStatement("insert into it_asset_printerrefill_tbl (asset_deviceinfo_id,prev_print_count,current_print_count,avg_count,ink_used,refillDate,log_date,notes,created_by,refilled_by)values(?,?,?,?,?,?,?,?,?,?)");
			ps_scrap.setInt(1, Integer.parseInt(dev_name));
			ps_scrap.setString(2, beforeRefill);
			ps_scrap.setString(3, afterRefill);
			ps_scrap.setString(4, avg_count);
			ps_scrap.setString(5, inkused);
			ps_scrap.setDate(6, new java.sql.Date(dateFormat.parse(refilldate).getTime()));
			ps_scrap.setDate(7, curr_Date);
			ps_scrap.setString(8, details);
			ps_scrap.setInt(9, uid);
			ps_scrap.setInt(10, Integer.parseInt(itperson));			
			int scr=ps_scrap.executeUpdate();			
			 
			if(scr>0){
				con.close();
				String success = "Data inserted successfully....";
				response.sendRedirect("Add_printerRefill.jsp?success="+success); 
			}else{
				con.close();
				String error = "Error Occurred !!!";
				response.sendRedirect("Add_printerRefill.jsp?success="+error);
			}				
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void addNewAccess(String name_access, HttpSession session,
			HttpServletResponse response) {
		try {
			boolean flag = false;
			int sf = 0;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			
			PreparedStatement ps_getaccess = con.prepareStatement("select * from it_asset_accesslist_tbl");
			ResultSet rs_getaccess=ps_getaccess.executeQuery(); 			
			while(rs_getaccess.next()){
				if(rs_getaccess.getString("access_name").equalsIgnoreCase(name_access)){
					flag = true;
				}
			}
			rs_getaccess.close();
			ps_getaccess.close();
			if(flag==true){
				con.close();
				String avail = "Already Available....";
				response.sendRedirect("Add_accessMaster.jsp?avail="+avail); 				
			}else {
				PreparedStatement ps_access = con.prepareStatement("insert into it_asset_accesslist_tbl(access_name,created_by,created_date)values(?,?,?)");
				ps_access.setString(1, name_access);
				ps_access.setInt(2, uid); 
				ps_access.setDate(3, curr_Date); 
				sf = ps_access.executeUpdate();
				ps_access.close();
				if(sf>0){
					con.close();
					String success = "Data inserted successfully....";
					response.sendRedirect("Add_accessMaster.jsp?success="+success); 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	public void add_UserAccess(String username, String accessdate,
			ArrayList accesslist, String notes, HttpSession session,
			HttpServletResponse response) {
		try { 
			int sf = 0,del=0,up=0,ins=0;
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
			PreparedStatement ps_getaccess = con.prepareStatement("select * from it_asset_access_tbl where user_name="+username);
			ResultSet rs_getaccess=ps_getaccess.executeQuery();
			
			rs_getaccess.last(); 
			int ch = rs_getaccess.getRow();
			rs_getaccess.beforeFirst();
			
			if(ch>0){ 
				PreparedStatement ps_del = con.prepareStatement("delete from it_asset_access_tbl where user_name="+username);
				del = ps_del.executeUpdate();
				for (int i=0; i < accesslist.size(); i++) {
				PreparedStatement ps_up = con.prepareStatement("insert into it_asset_access_tbl(accesslist_id,user_name,created_by,created_date,approve_date,notes)values(?,?,?,?,?,?)");
				ps_up.setInt(1, Integer.parseInt(accesslist.get(i).toString()));
				ps_up.setInt(2, Integer.parseInt(username));
				ps_up.setInt(3, uid);
				ps_up.setDate(4, curr_Date);
				ps_up.setDate(5, new java.sql.Date(dateFormat.parse(accessdate).getTime()));
				ps_up.setString(6, notes);
				up = ps_up.executeUpdate();
				}
			}else{
				for (int i=0; i < accesslist.size(); i++) {
				PreparedStatement ps_up = con.prepareStatement("insert into it_asset_access_tbl(accesslist_id,user_name,created_by,created_date,approve_date,notes)values(?,?,?,?,?,?)");
				ps_up.setInt(1, Integer.parseInt(accesslist.get(i).toString()));
				ps_up.setInt(2, Integer.parseInt(username));
				ps_up.setInt(3, uid);
				ps_up.setDate(4, curr_Date);
				ps_up.setDate(5, new java.sql.Date(dateFormat.parse(accessdate).getTime()));
				ps_up.setString(6, notes);
				ins = ps_up.executeUpdate();
				}
			}
			if(up>0 || ins>0){
				con.close();
				String success = "Data inserted successfully....";
				response.sendRedirect("Add_userAccess.jsp?success="+success); 
			}else {
				con.close();
				String error = "Error Occurred !!!";
				response.sendRedirect("Add_userAccess.jsp?error="+error);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}
	public void addtonerRefill(String dev_name, String operation,
			String refilldate, String count, String itperson, String details,
			String amount, HttpSession session, HttpServletResponse response) {
		try {
			boolean flag = false;
			int sf = 0;
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd"); 
			
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			
			PreparedStatement ps_getaccess = con.prepareStatement("select * from it_asset_printerToner_tbl where asset_deviceinfo_id="+Integer.parseInt(dev_name));
			ResultSet rs_getaccess=ps_getaccess.executeQuery(); 			
			while(rs_getaccess.next()){
				if(rs_getaccess.getString("refill_date").equalsIgnoreCase(refilldate)){ 
					flag = true;
				}
			} 
			rs_getaccess.close();
			ps_getaccess.close();
			
			if(flag == true){
				con.close();
				String avail = "Already Available....";
				response.sendRedirect("Add_tonerRefill.jsp?avail="+avail);
			}else {
				PreparedStatement ps_ton = con.prepareStatement("insert into it_asset_printertoner_tbl" +
						"(asset_deviceinfo_id,toner_operation,reading,amount_paid,refill_date,created_by,refilled_by,created_date,notes)value(?,?,?,?,?,?,?,?,?)");
				ps_ton.setInt(1, Integer.parseInt(dev_name)); 
				ps_ton.setString(2, operation);
				ps_ton.setString(3, count);
				ps_ton.setString(4, amount);
				ps_ton.setDate(5, new java.sql.Date(dateFormat.parse(refilldate).getTime()));
				ps_ton.setInt(6, uid);
				ps_ton.setInt(7, Integer.parseInt(itperson));
				ps_ton.setDate(8, curr_Date);
				ps_ton.setString(9, details);
				
				sf = ps_ton.executeUpdate();
				con.close();
				String success = "Data inserted successfully....";
				response.sendRedirect("Add_tonerRefill.jsp?success="+success); 
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		
	}
	 
}