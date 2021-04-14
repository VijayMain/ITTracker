package it.muthagroup.dao;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList; 
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import it.muthagroup.connectionUtility.Connection_Utility; 
import it.muthagroup.vo.FileUpload_vo; 
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 
import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
 

public class FileUpload_dao {
	private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
	public void uploadFile(HttpSession session, FileUpload_vo bean, HttpServletResponse response) {
		try {
				Connection con = Connection_Utility.getConnection();
				int uid = Integer.parseInt(session.getAttribute("uid").toString());
				int val = 0;
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				
				PreparedStatement ps_additdoc = con.prepareStatement("insert into master_filler(file_name,file_blob,date_upload,uploaded_by)values(?,?,?,?)");
				ps_additdoc.setString(1, bean.getFilename());
				ps_additdoc.setBlob(2, bean.getBlob_file());
				ps_additdoc.setDate(3, curr_Date);
				ps_additdoc.setInt(4, uid);
				
				int up = ps_additdoc.executeUpdate();
				
				int insertUp = 0;
				int ct = 0,del_file=0;
				PreparedStatement ps_ct = con.prepareStatement("select max(code) from master_filler");
				ResultSet rs_ct = ps_ct.executeQuery();
				while (rs_ct.next()) {
					ct = rs_ct.getInt("max(code)");
				}
				del_file = ct-2;
				PreparedStatement ps_del_file = con.prepareStatement("delete from master_filler where code<"+del_file);
				ps_del_file.executeUpdate();
				
				PreparedStatement ps_blb = con.prepareStatement("select * from master_filler where code=" + ct);
				ResultSet rs_blb = ps_blb.executeQuery();
				while (rs_blb.next()) {

					Blob blob = rs_blb.getBlob("file_blob");

					InputStream in = blob.getBinaryStream();

					ArrayList alistFile = new ArrayList();
					File folder = new File("C:/reportxls");
					File[] listOfFiles = folder.listFiles();
					String listname = "";
					val = listOfFiles.length + 1;

					File exlFile = new File("C:/reportxls/DataUpload_IT" + val + ".xls");

					OutputStream out = new FileOutputStream(exlFile);
					byte[] buff = new byte[4096]; // how much of the blob to
													// read/write at a time
					int len = 0;

					while ((len = in.read(buff)) != -1) {
						out.write(buff, 0, len);
					}

				}

				Workbook wrk1 = Workbook.getWorkbook(new File("C:/reportxls/DataUpload_IT" + val + ".xls"));
				//*************************************************************************************************************************************************************
				// Get all Spares ====>
				//*************************************************************************************************************************************************************
				Sheet sheet1 = wrk1.getSheet(0);
				int rows = sheet1.getRows();
				int cols = sheet1.getColumns();
				//System.out.println("Columns " + rows + "   " + cols);
				PreparedStatement ps_check=null,ps_upload=null;
				ResultSet rs_check=null,rs_upload=null;  
				int cnt =0 ; 
				for(int i=1;i<rows;i++){
					Cell colArow1 = sheet1.getCell(0, i);
					Cell colArow2 = sheet1.getCell(1, i);
					String str_colArow1 = colArow1.getContents();
					String str_colArow2 = colArow2.getContents();
					
					ps_check = con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where device_parts='"+str_colArow1+"'");
					rs_check = ps_check.executeQuery();
					rs_check.last();
					int itemChk = rs_check.getRow();
					rs_check.beforeFirst();
					if (itemChk > 0) {
						// System.out.println("Available in DB = " + str_colArow1);
					}else{
						ps_upload = con.prepareStatement("insert into it_asset_deviceitem_mst_tbl(device_parts,Available_qty,created_date,created_by,spares_details)values(?,?,?,?,?)");
						ps_upload.setString(1, str_colArow1);
						ps_upload.setInt(2, 0);
						ps_upload.setDate(3, curr_Date);
						ps_upload.setInt(4, uid);
						ps_upload.setString(5, str_colArow2);
						
						cnt = ps_upload.executeUpdate();
					}
				}
					//*************************************************************************************************************************************************************
					// To get Device Type ===>
					//*************************************************************************************************************************************************************
					Sheet sheet2 = wrk1.getSheet(1);
					int rows1 = sheet2.getRows();
					int cols1 = sheet2.getColumns();
					//System.out.println("Columns " + rows + "   " + cols);
					PreparedStatement ps_check1=null,ps_upload1=null;
					ResultSet rs_check1=null,rs_upload1=null;   
					for(int i1=1;i1<rows1;i1++){
						Cell colArow11 = sheet2.getCell(0, i1); 
						String str_colArow11 = colArow11.getContents(); 
						
						ps_check1 = con.prepareStatement("select * from it_asset_devicetype_mst_tbl where device_type='"+str_colArow11+"'");
						rs_check1 = ps_check1.executeQuery();
						rs_check1.last();
						int itemChk1 = rs_check1.getRow();
						rs_check1.beforeFirst();
						if (itemChk1 > 0) {
							// System.out.println("Available in DB = " + str_colArow11);
						}else{
							ps_upload1 = con.prepareStatement("insert into it_asset_devicetype_mst_tbl(device_type,created_by)values(?,?)");
							ps_upload1.setString(1, str_colArow11); 
							ps_upload1.setInt(2, uid); 
							
							cnt = ps_upload1.executeUpdate();
						} 
				}
					//*************************************************************************************************************************************************************
					// To get Operating System  ===>
					//*************************************************************************************************************************************************************
					Sheet sheet3 = wrk1.getSheet(2);
					int rows2 = sheet3.getRows();
					int cols2 = sheet3.getColumns();
					//System.out.println("Columns " + rows2 + "   " + cols2);
					PreparedStatement ps_check2=null,ps_upload2=null;
					ResultSet rs_check2=null,rs_upload2=null;   
					for(int i=1;i<rows2;i++){
						Cell colArow1 = sheet3.getCell(0, i);
						Cell colArow2 = sheet3.getCell(1, i);
						String str_colArow12 = colArow1.getContents();
						String str_colArow22 = colArow2.getContents();
						
						ps_check2 = con.prepareStatement("select * from it_asset_os_mst_tbl where os_name='"+str_colArow12+"'");
						rs_check2 = ps_check2.executeQuery();
						rs_check2.last();
						int itemChk = rs_check2.getRow();
						rs_check2.beforeFirst();
						if (itemChk > 0) {
							// System.out.println("Available in DB = " + str_colArow1);
						}else{
							ps_upload2 = con.prepareStatement("insert into it_asset_os_mst_tbl(os_name,licence_type_id,created_by)values(?,?,?)");
							ps_upload2.setString(1, str_colArow12);
							ps_upload2.setInt(2, Integer.parseInt(str_colArow22));
							ps_upload2.setInt(3, uid); 
							
							cnt = ps_upload2.executeUpdate();
						}
					}
					
					
					
					
					
					
					//************************************************************************************************************************************************************* 
					// To Add New Device ===> 18
					//*************************************************************************************************************************************************************
					
					Sheet sheet4 = wrk1.getSheet(3);
					int rows4 = sheet4.getRows();
					int cols4 = sheet4.getColumns();
					
					//System.out.println("Columns " + rows4 + "   " + cols4);
					PreparedStatement ps_check4=null,ps_upload4=null,ps_devtype=null,ps_ipAddress=null,ps_os=null;
					ResultSet rs_check4=null,rs_upload4=null,rs_devtype=null,rs_ipAddress=null,rs_os=null;
					Date podate_dev = null;
					Date grndate_dev = null;
					double basicrate_dev=0,totalamt_dev=0;		
					int os_installed_dev=0,devTypeId=0,ipaddress_dev=0;
					
					System.out.println("date is open for  =  " + rows4 + " colls " + cols4);
					
					for(int i=1;i<rows4;i++){
						
						
						Cell dev_name = sheet4.getCell(0, i);
						Cell dev_type = sheet4.getCell(1, i);
						Cell model_no = sheet4.getCell(2, i);
						Cell description = sheet4.getCell(3, i);
						Cell pono = sheet4.getCell(4, i);
						Cell podate = sheet4.getCell(5, i);
						Cell grnno = sheet4.getCell(6, i);
						Cell grndate = sheet4.getCell(7, i);
						Cell basicrate = sheet4.getCell(8, i);
						Cell totalamt = sheet4.getCell(9, i);
						Cell mac = sheet4.getCell(10, i);
						Cell serialno = sheet4.getCell(11, i);
						Cell imeiNo = sheet4.getCell(12, i);
						Cell itemcode = sheet4.getCell(13, i);
						Cell imei2No = sheet4.getCell(14, i);
						Cell ipaddress = sheet4.getCell(15, i);
						Cell onlinepurchase = sheet4.getCell(16, i);
						Cell os_installed = sheet4.getCell(17, i);
						
						String device_name = dev_name.getContents();  
						
						if(podate.getContents()!=""){
							podate_dev = new java.sql.Date(sdf.parse(podate.getContents()).getTime()); 
						}
						if(grndate.getContents()!=""){
							grndate_dev = new java.sql.Date(sdf.parse(grndate.getContents()).getTime());
						}
						if(basicrate.getContents()!=""){
							basicrate_dev =Double.parseDouble(basicrate.getContents());
						}
						if(totalamt.getContents()!=""){
							totalamt_dev =Double.parseDouble(totalamt.getContents());
						} 
						 
						
						if(ipaddress.getContents()!=""){
						ps_ipAddress = con.prepareStatement("select * from it_asset_ipaddress_mst_tbl where ip_address='"+ ipaddress.getContents()+"'");
						rs_ipAddress = ps_ipAddress.executeQuery();
						while(rs_ipAddress.next()){
							ipaddress_dev = rs_ipAddress.getInt("asset_ipaddress_id");
						} 
						}
						if(os_installed.getContents()!=""){
							ps_os = con.prepareStatement("select * from it_asset_os_mst_tbl where os_name='"+ os_installed.getContents()+"'");
							rs_os = ps_os.executeQuery();
							while(rs_os.next()){
								os_installed_dev = rs_os.getInt("asset_OS_id");
							} 
							}
						if(dev_type.getContents()!=""){
						ps_devtype = con.prepareStatement("select * from it_asset_devicetype_mst_tbl where device_type='"+dev_type.getContents()+"'");
						rs_devtype = ps_devtype.executeQuery();
						while(rs_devtype.next()){
							devTypeId = rs_devtype.getInt("devicetype_mst_id");
						} 
						}
						if(device_name!=""){
						ps_check4 = con.prepareStatement("select * from it_asset_deviceinfo_tbl where device_name='"+device_name+"'");
						rs_check4 = ps_check4.executeQuery();
						rs_check4.last();
						int itemChk = rs_check4.getRow();
						rs_check4.beforeFirst();
						if (itemChk > 0) {
							System.out.println("Available in DB = " + device_name);
						}else{
							
							ps_upload4 = con.prepareStatement("insert into it_asset_deviceinfo_tbl" +
									"(po_no, po_date, asset_supplier_mst_id, GRN_No, GRN_Date, basic_rate, total_amt, hrd_mac_address, description, " +
									"created_by, created_date, device_name, devicetype_mst_id, model_no, serialno, imei_no, item_code, it_rec_date, imei2_no, " +
									"asset_ipaddress_id, available_flag, scrap_flag, Updated_date, updated_by, online_purchase, asset_OS_id)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
							ps_upload4.setString(1, pono.getContents());
						 	ps_upload4.setDate(2, podate_dev);
						 	ps_upload4.setInt(3, 1);
						 	ps_upload4.setString(4, grnno.getContents());
						 	ps_upload4.setDate(5, grndate_dev);
						 	ps_upload4.setDouble(6, basicrate_dev);
						 	ps_upload4.setDouble(7, totalamt_dev);
						 	ps_upload4.setString(8, mac.getContents());
						 	ps_upload4.setString(9, description.getContents());
						 	ps_upload4.setInt(10, uid);
						 	ps_upload4.setDate(11, curr_Date);
						 	ps_upload4.setString(12, device_name);
						 	ps_upload4.setInt(13, devTypeId);
						 	ps_upload4.setString(14, model_no.getContents());
						 	ps_upload4.setString(15, serialno.getContents());
						 	ps_upload4.setString(16, imeiNo.getContents());
						 	ps_upload4.setString(17, itemcode.getContents());
						 	ps_upload4.setDate(18, curr_Date);
						 	ps_upload4.setString(19, imei2No.getContents());
						 	ps_upload4.setInt(20, ipaddress_dev);
						 	ps_upload4.setInt(21, 1);
						 	ps_upload4.setInt(22, 0);
						 	ps_upload4.setDate(23, curr_Date);
						 	ps_upload4.setInt(24, uid);
						 	ps_upload4.setString(25, onlinepurchase.getContents());
						 	ps_upload4.setInt(26, os_installed_dev);
							
							cnt = ps_upload4.executeUpdate();
						}
						}
					}
					
					
					//*************************************************************************************************************************************************************
					// To get Device Parts ===>
					//*************************************************************************************************************************************************************
					Sheet sheet5 = wrk1.getSheet(4);
					int rows5 = sheet5.getRows();
					int cols5 = sheet5.getColumns(); 
					PreparedStatement ps_check5=null,ps_upload5=null;
					ResultSet rs_check5=null;
					for(int i=1;i<rows5;i++){
						Cell colDev_name = sheet5.getCell(0, i);
						Cell colItem_name = sheet5.getCell(1, i);
						Cell colQty = sheet5.getCell(2, i);
						Cell colSpec = sheet5.getCell(3, i);
						
						String str_colDevName = colDev_name.getContents();
						String str_colItemName = colItem_name.getContents();
						String str_colQty = colQty.getContents();
						String str_colSpec = colSpec.getContents();
						
						int dev_name_id =0,part_id=0;
						if(str_colDevName!=""){
						PreparedStatement ps_devId = con.prepareStatement("select * from it_asset_deviceinfo_tbl where device_name='"+str_colDevName+"'");
						ResultSet rs_devId = ps_devId.executeQuery();
						while (rs_devId.next()){
							dev_name_id = rs_devId.getInt("asset_deviceinfo_id");
						}
						}
						if(str_colItemName!=""){
							PreparedStatement ps_devId = con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where device_parts='"+str_colItemName+"'");
							ResultSet rs_devId = ps_devId.executeQuery();
							while (rs_devId.next()){
								part_id = rs_devId.getInt("asset_deviceitem_mst_id");
							}
						}
						if(part_id!=0 && dev_name_id!=0 && str_colQty!="" && str_colSpec!=""){
						ps_check5 = con.prepareStatement("select * from it_asset_deviceitem_rel_tbl where asset_deviceinfo_id="+dev_name_id +" and asset_deviceitem_mst_id="+part_id);
						rs_check5 = ps_check5.executeQuery();
						rs_check5.last();
						int itemChk = rs_check5.getRow();
						rs_check5.beforeFirst();
						if (itemChk > 0) {
							// System.out.println("Available in DB = " + str_colArow1);
						}else{
							// System.out.println("  DB = " + part_id + "   =   " + dev_name_id);
							ps_upload5 = con.prepareStatement("insert into it_asset_deviceitem_rel_tbl (asset_deviceitem_mst_id,asset_deviceinfo_id,qty,specification,scrap_flag,avail_flag,created_by,created_date,updated_by,update_date)values(?,?,?,?,?,?,?,?,?,?)");
							ps_upload5.setInt(1, part_id);
							ps_upload5.setInt(2, dev_name_id);
							ps_upload5.setInt(3, Integer.parseInt(str_colQty));
							ps_upload5.setString(4, str_colSpec);
							ps_upload5.setInt(5, 0);
							ps_upload5.setInt(6, 1);
							ps_upload5.setInt(7, uid);
							ps_upload5.setDate(8, curr_Date);
							ps_upload5.setInt(9, uid);
							ps_upload5.setDate(10, curr_Date);
							
							cnt = ps_upload5.executeUpdate();
						}
					}
					}
					//************************************************************************************************************************************************************* 
					//*************************************************************************************************************************************************************
					// To get Operating System  ===>
					//*************************************************************************************************************************************************************
					Sheet sheet6 = wrk1.getSheet(5);
					int rows6 = sheet6.getRows();
					int cols6 = sheet6.getColumns();
					//System.out.println("Columns " + rows2 + "   " + cols2);
					PreparedStatement ps_check6=null,ps_upload6=null,ps_getdevId=null,ps_issueUser=null,ps_issuedBy=null,ps_compIssue=null;
					ResultSet rs_check6=null,rs_upload6=null,rs_getdevId=null,rs_issueUser=null,rs_issuedBy=null,rs_compIssue=null;;   
					for(int i=1;i<rows6;i++){ 
						Cell issue_devname = sheet6.getCell(0, i);
						Cell issue_comp = sheet6.getCell(1, i);
						Cell issueTo = sheet6.getCell(2, i);
						Cell issue_date = sheet6.getCell(3, i);
						Cell issueby = sheet6.getCell(4, i);
						Cell issue_location = sheet6.getCell(5, i);
						Cell issue_cno = sheet6.getCell(6, i);
						Cell issue_email = sheet6.getCell(7, i);
						Cell issue_extra = sheet6.getCell(8, i);
						
						String issue_device = issue_devname.getContents(); 
						String issue_user = issueTo.getContents();
						String issuedate = issue_date.getContents();
						String issue_by = issueby.getContents();
						String issuedComp = issue_comp.getContents(); 
						int issue_deviceId=0,issue_User=0,issued_by=0,issuetoCompany=0,issuenoteId=0;
						if(issue_device!="" && issue_user!="" && issuedate!="" && issue_by !="" && issuedComp!=""){
							
						java.util.Date date = sdf.parse(issuedate); 
						java.sql.Date sql_issueDate = new Date(date.getTime()); 
						
						ps_getdevId = con.prepareStatement("select * from it_asset_deviceinfo_tbl where device_name='"+issue_device+"' and available_flag=1 and scrap_flag=0");
						rs_getdevId = ps_getdevId.executeQuery();
						while (rs_getdevId.next()) {
							issue_deviceId = rs_getdevId.getInt("asset_deviceinfo_id");
						}
						ps_issueUser = con.prepareStatement("select * from user_tbl where U_Name='"+issue_user+"'");
						rs_issueUser = ps_issueUser.executeQuery();
						while (rs_issueUser.next()) {
							issue_User = rs_issueUser.getInt("U_Id");
						}

						ps_issuedBy = con.prepareStatement("select * from user_tbl where U_Name='"+issue_by+"'");
						rs_issuedBy = ps_issuedBy.executeQuery();
						while (rs_issuedBy.next()) {
							issued_by = rs_issuedBy.getInt("U_Id");
						}
							
						ps_issuedBy = con.prepareStatement("select * from user_tbl_company  where Company_Name='"+issuedComp+"'");
						rs_compIssue = ps_issuedBy.executeQuery();
						while (rs_compIssue.next()) {
							issuetoCompany = rs_compIssue.getInt("Company_Id");
						}
						if(issue_deviceId !=0){
						ps_compIssue = con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id='"+issue_deviceId+"' and surrender_flag=0");
						rs_check6 = ps_compIssue.executeQuery();
						rs_check6.last();
						int itemChk = rs_check6.getRow();
						rs_check6.beforeFirst();
						if (itemChk > 0) {
							// System.out.println("Available in DB = " + str_colArow1);
						}else{
							ps_upload6 = con.prepareStatement("insert into it_asset_issuenote_tbl" +
									"(asset_deviceinfo_id,issued_to,issue_date,given_by,extra_info,created_by,created_date,Company_Id," +
									"location,contact_no,Email,surrender_flag)values(?,?,?,?,?,?,?,?,?,?,?,?)");
							ps_upload6.setInt(1, issue_deviceId);
							ps_upload6.setInt(2, issue_User);
							ps_upload6.setDate(3, sql_issueDate);
							ps_upload6.setInt(4, issued_by);
							ps_upload6.setString(5, issue_extra.getContents());
							ps_upload6.setInt(6, uid);
							ps_upload6.setDate(7, curr_Date);
							ps_upload6.setInt(8, issuetoCompany);
							ps_upload6.setString(9, issue_location.getContents());
							ps_upload6.setString(10, issue_cno.getContents());
							ps_upload6.setString(11, issue_email.getContents());
							ps_upload6.setInt(12, 0);
							
							cnt = ps_upload6.executeUpdate();
							
							String updateDevQry = "update it_asset_deviceinfo_tbl set available_flag=0,Updated_date='"+curr_Date+"',updated_by="+uid+" where asset_deviceinfo_id="+issue_deviceId;
							PreparedStatement psUpdate=con.prepareStatement(updateDevQry);
							up = psUpdate.executeUpdate();
							psUpdate.close();
						}
						}
					}
				}
					 
					//*************************************************************************************************************************************************************
					// To Device Installed Softwares  ===>
					//*************************************************************************************************************************************************************
					Sheet sheet7 = wrk1.getSheet(6);
					int rows7 = sheet7.getRows();
					int cols7 = sheet7.getColumns(); 
					int dev_id=0;
					int soft_id=0;
					int dev_issueID =0;
					List<Integer> all_softID=new ArrayList(); 
					int all_delsoftID=0;
					
					PreparedStatement ps_check7=null,ps_upload7=null,devname_ps=null,dev_soft_ps=null,ps_dev_issue=null;
					ResultSet rs_check7=null,devname_rs=null,dev_soft_rs=null,rs_dev_issue=null;
					for(int i=1;i<rows7;i++){
						Cell device_Issued = sheet7.getCell(0, i);
						Cell softwareInstalled = sheet7.getCell(1, i);
						String str_colArow12 = device_Issued.getContents();
						String str_colArow22 = softwareInstalled.getContents();
						if(str_colArow12 !="" && str_colArow22 !=""){
						 
						devname_ps = con.prepareStatement("select * from it_asset_deviceinfo_tbl where device_name='"+str_colArow12+"'");
						devname_rs = devname_ps.executeQuery();
						while(devname_rs.next()){
							dev_id = devname_rs.getInt("asset_deviceinfo_id");
							
							ps_dev_issue = con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id="+dev_id);
							rs_dev_issue = ps_dev_issue.executeQuery();
							while(rs_dev_issue.next()){
								dev_issueID = rs_dev_issue.getInt("asset_issueNote_id");
							}
						}
						
						dev_soft_ps = con.prepareStatement("select * from it_asset_software_mst_tbl where software_name='"+str_colArow22+"'");
						dev_soft_rs= dev_soft_ps.executeQuery();
						while(dev_soft_rs.next()){
							soft_id = dev_soft_rs.getInt("asset_software_id");
						}
						all_softID.add(soft_id);
						 
						ps_check7 = con.prepareStatement("select * from it_asset_issuesoft_rel_tbl where asset_issueNote_id="+dev_issueID);
						rs_check7 = ps_check7.executeQuery();
						rs_check7.last();
						int itemChk = rs_check7.getRow();
						rs_check7.beforeFirst();
						if (itemChk > 0) {
							all_delsoftID = 1;
						}
					}
				}
					
					if(all_delsoftID==1){
						PreparedStatement ps_delids = con.prepareStatement("delete from it_asset_issuesoft_rel_tbl where asset_issueNote_id="+dev_issueID);
						int delID = ps_delids.executeUpdate();
					}
					
					if(all_softID.size()>0){ 
						
						Set<Integer> hs = new HashSet();
						hs.addAll(all_softID);
						all_softID.clear();
						all_softID.addAll(hs);
						
					for(int j=0;j<all_softID.size();j++){	
					ps_upload7 = con.prepareStatement("insert into it_asset_issuesoft_rel_tbl(asset_issueNote_id,asset_software_id,created_by,created_date)values(?,?,?,?)");
					ps_upload7.setInt(1, dev_issueID);
					ps_upload7.setInt(2, Integer.parseInt(all_softID.get(j).toString()));
					ps_upload7.setInt(3, uid);
					ps_upload7.setDate(4, curr_Date);
					
					cnt = ps_upload7.executeUpdate();
					}
					}
					
					//************************************************************************************************************************************************************* 
					//*************************************************************************************************************************************************************
					// To get Device Repaire ===>
					//*************************************************************************************************************************************************************
					Sheet sheet8 = wrk1.getSheet(7);
					int rows8 = sheet8.getRows();
					int cols8 = sheet8.getColumns();
					int get_devID = 0,get_partID=0,repaire_person=0,partCondID=0; 
					PreparedStatement ps_check8=null,ps_upload8=null,ps_setrepaire=null,ps_surrCond=null,part_no_ps=null,spname_ps=null;
					ResultSet rs_check8=null,rs_upload8=null,rs_setrepaire=null,rs_surrCond=null,part_no_rs=null,spname_rs=null;
					for(int i1=1;i1<rows8;i1++){
						
						Cell colDev = sheet8.getCell(0, i1);
						Cell colreqno = sheet8.getCell(1, i1);
						Cell colpartnm = sheet8.getCell(2, i1); 
						Cell colpartreplace = sheet8.getCell(3, i1); 
						Cell colqty = sheet8.getCell(4, i1); 
						Cell colpartCondition = sheet8.getCell(5, i1); 
						Cell colrepairedBy = sheet8.getCell(6, i1); 
						Cell colrepaireDate = sheet8.getCell(7, i1); 
						Cell colrepaireDetails = sheet8.getCell(8, i1); 
						
						String str_colDev = colDev.getContents(); 
						String str_colreqno = colreqno.getContents(); 
						String str_colpartnm = colpartnm.getContents(); 
						String str_colpartreplace = colpartreplace.getContents(); 
						String str_colqty = colqty.getContents(); 
						String str_colpartCondition = colpartCondition.getContents(); 
						String str_colrepairedBy = colrepairedBy.getContents(); 
						String str_colrepaireDate = colrepaireDate.getContents(); 
						String str_colrepaireDetails = colrepaireDetails.getContents(); 
						
						
						if(str_colDev!="" && str_colreqno!="" && str_colpartnm!="" && str_colpartreplace.equalsIgnoreCase("No") && str_colrepairedBy!="" && str_colrepaireDate!="" && str_colrepaireDetails!=""){
						
							//ps_surrCond = con.prepareStatement("select * from it_asset_device_surrender_condition_tbl where device_condition='"++"'");
							
							java.util.Date repairedate = sdf.parse(str_colrepaireDate);
							java.sql.Date sql_repaireDate = new Date(repairedate.getTime());
							
							part_no_ps = con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where device_parts='"+str_colpartnm+"'");
							part_no_rs = part_no_ps.executeQuery();
							while (part_no_rs.next()) {
								get_partID = part_no_rs.getInt("asset_deviceitem_mst_id");
							}
							
							spname_ps = con.prepareStatement("select * from user_tbl where U_Name='"+str_colrepairedBy+"'");
							spname_rs = spname_ps.executeQuery();
							while (spname_rs.next()) {
								repaire_person = spname_rs.getInt("U_Id");
							}
							
							ps_check8 = con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id=(select asset_deviceinfo_id from it_asset_deviceinfo_tbl where device_name='"+str_colDev+"')");
							rs_check8 = ps_check8.executeQuery();
							while (rs_check8.next()) { 
								get_devID = rs_check8.getInt("asset_deviceinfo_id"); 
								ps_setrepaire = con.prepareStatement("select * from it_asset_device_partrepair_tbl where asset_deviceinfo_id="+get_devID + " and repaire_date='"+sql_repaireDate+"' and repaire_details='"+str_colrepaireDetails+"' and part_repaired="+get_partID);
								rs_setrepaire = ps_setrepaire.executeQuery();
								rs_setrepaire.last();
								int itemrepchk = rs_setrepaire.getRow();
								rs_setrepaire.beforeFirst();
								
								if (itemrepchk > 0) {
									System.out.println("already available");
								}else{
									ps_upload8 = con.prepareStatement("insert into it_asset_device_partrepair_tbl" +
											"(asset_deviceinfo_id,U_Req_Id,part_repaired,repaired_by,created_by," +
											"repaire_date,created_date,repaire_details)values(?,?,?,?,?,?,?,?)");
									
									ps_upload8.setInt(1, get_devID);
									ps_upload8.setInt(2, Integer.parseInt(str_colreqno));
									ps_upload8.setInt(3, get_partID);
									ps_upload8.setInt(4, repaire_person);
									ps_upload8.setInt(5, uid);
									ps_upload8.setDate(6, sql_repaireDate);
									ps_upload8.setDate(7, curr_Date);
									ps_upload8.setString(8, str_colrepaireDetails);
									
									cnt = ps_upload8.executeUpdate();
								}
							}
						/*ps_check8 = con.prepareStatement("select * from it_asset_device_partrepair_tbl where device_type='"+str_colArow11+"'");
						rs_check8 = ps_check8.executeQuery();
						rs_check8.last();
						int itemChk1 = rs_check8.getRow();
						rs_check8.beforeFirst();
						
						if (itemChk1 > 0) {
							// System.out.println("Available in DB = " + str_colArow11);
						}else{
							ps_upload8 = con.prepareStatement("insert into it_asset_devicetype_mst_tbl(device_type,created_by)values(?,?)");
							ps_upload8.setString(1, "");
							ps_upload8.setInt(2, uid);
							
							cnt = ps_upload8.executeUpdate();
						}*/
						
							System.out.println("In loop of Part repaired");
						}
						if(str_colDev!="" && str_colreqno!="" &&  str_colpartnm!="" && str_colpartreplace.equalsIgnoreCase("Yes") && str_colqty!="" && str_colpartCondition!="" && str_colrepairedBy!="" && str_colrepaireDate!="" && str_colrepaireDetails!=""){
							
							java.util.Date repairedate = sdf.parse(str_colrepaireDate);
							java.sql.Date sql_repaireDate = new Date(repairedate.getTime());
							
							part_no_ps = con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where device_parts='"+str_colpartnm+"'");
							part_no_rs = part_no_ps.executeQuery();
							while (part_no_rs.next()) {
								get_partID = part_no_rs.getInt("asset_deviceitem_mst_id");
							}
							
							spname_ps = con.prepareStatement("select * from user_tbl where U_Name='"+str_colrepairedBy+"'");
							spname_rs = spname_ps.executeQuery();
							while (spname_rs.next()) {
								repaire_person = spname_rs.getInt("U_Id");
							}
							
							ps_surrCond = con.prepareStatement("select * from it_asset_device_surrender_condition_tbl where device_condition='"+str_colpartCondition+"'");
							rs_surrCond = ps_surrCond.executeQuery();
							while (rs_surrCond.next()) {
								partCondID = rs_surrCond.getInt("asset_device_sur_condi_id");
							}
							
							ps_check8 = con.prepareStatement("select * from it_asset_issuenote_tbl where asset_deviceinfo_id=(select asset_deviceinfo_id from it_asset_deviceinfo_tbl where device_name='"+str_colDev+"')");
							rs_check8 = ps_check8.executeQuery();
							while (rs_check8.next()) { 
								get_devID = rs_check8.getInt("asset_deviceinfo_id"); 
								ps_setrepaire = con.prepareStatement("select * from it_asset_device_partrepair_tbl where asset_deviceinfo_id="+get_devID + " and repaire_date='"+sql_repaireDate+"' and repaire_details='"+str_colrepaireDetails+"' and part_repaired="+get_partID);
								rs_setrepaire = ps_setrepaire.executeQuery();
								rs_setrepaire.last();
								int itemrepchk = rs_setrepaire.getRow();
								rs_setrepaire.beforeFirst();
								
								if (itemrepchk > 0) {
									System.out.println("already available");
								}else{
									ps_upload8 = con.prepareStatement("insert into it_asset_device_partrepair_tbl" +
											"(asset_deviceinfo_id,U_Req_Id,part_repaired,repaired_by,created_by," +
											"repaire_date,created_date,repaire_details,no_of_partused,asset_device_sur_condi_id)values(?,?,?,?,?,?,?,?,?,?)");
									
									ps_upload8.setInt(1, get_devID);
									ps_upload8.setInt(2, Integer.parseInt(str_colreqno));
									ps_upload8.setInt(3, get_partID);
									ps_upload8.setInt(4, repaire_person);
									ps_upload8.setInt(5, uid);
									ps_upload8.setDate(6, sql_repaireDate);
									ps_upload8.setDate(7, curr_Date);
									ps_upload8.setString(8, str_colrepaireDetails);
									ps_upload8.setInt(9, Integer.parseInt(str_colqty));
									ps_upload8.setInt(10, partCondID);
									
									cnt = ps_upload8.executeUpdate();
								}
							}
							
							
							
							System.out.println("In loop of Part repaired Yes datra ");
						}		
					  }
					//*************************************************************************************************************************************************************
				response.sendRedirect("Asset_Master.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
	}
}
