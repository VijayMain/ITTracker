package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.DMS_VO;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DMS_DAO {
	//private static final java.sql.Date curr_Date = new java.sql.Date(System.currentTimeMillis());
	public boolean attach_Filebase(DMS_VO bean, HttpSession session) {
		boolean flag = false;
		try {
			Connection con = Connection_Utility.getConnection();
			java.util.Date date= new java.util.Date();
			Timestamp curr_Date = new Timestamp(date.getTime());
			
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			int up = 0;
			//  System.out.println(" = "+flag);
			PreparedStatement ps = con.prepareStatement("insert into tarn_dms(TRAN_NO,FILE,FILE_NAME,USER,TRAN_DATE,STATUS,NOTE,SYS_DATE)values(?,?,?,?,?,?,?,?)");
			ps.setInt(1, bean.getDmscode());
			ps.setBlob(2, bean.getBlob_file());
			ps.setString(3, bean.getBlob_name());
			ps.setInt(4, uid);
			ps.setTimestamp(5, curr_Date);
			ps.setInt(6, 1);
			ps.setString(7, bean.getNote());
			ps.setTimestamp(8, curr_Date);
			
			
			
			up = ps.executeUpdate();
			
			if(up>0){
				flag=true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public int upload_newFolder(HttpSession session, DMS_VO bean, ArrayList dMSComp_list, ArrayList dMSDept_list, ArrayList dMSEmp_list) {
		int cnt_code = 0,up=0;
		try {
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			java.util.Date date= new java.util.Date();
			Timestamp curr_Date = new Timestamp(date.getTime());
			/* 
			************************************ Insert Into Main DMS Table ******************************************** 
			*/
			// System.out.println("shres access = " + bean.getShared_access());
			PreparedStatement ps = con.prepareStatement("insert into mst_dmsfolder (FOLDER,SUBJECT,SHARE_FLAG,NOTE,STATUS,USER,TRAN_DATE,SYS_DATE,SHARED_ACCESS)values(?,?,?,?,?,?,?,?,?)");
			ps.setString(1, bean.getFolder());
			ps.setString(2, bean.getSubject());
			ps.setInt(3, Integer.parseInt(bean.getShare_others()));
			ps.setString(4, bean.getNote());
			ps.setInt(5, 1);
			ps.setInt(6, uid);
			ps.setTimestamp(7, curr_Date);
			ps.setTimestamp(8, curr_Date);
			ps.setInt(9, bean.getShared_access());
			
			up = ps.executeUpdate();
			
			/*
			*
			************************************ Get max count from Main DMS Table ******************************************** 
			*
			*/
			
			if(up>0){
			ps = con.prepareStatement("select max(CODE) from mst_dmsfolder");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				cnt_code = rs.getInt("max(CODE)"); 
			}
			
			/*
			*
			************************************ Insert Into tarn_dms Table ******************************************** 
			*
			*/
			
			
			ps = con.prepareStatement("insert into tarn_dms(TRAN_NO,FILE,FILE_NAME,USER,TRAN_DATE,STATUS,NOTE,SYS_DATE)values(?,?,?,?,?,?,?,?)");
			ps.setInt(1, cnt_code);
			ps.setBlob(2, bean.getBlob_file());
			ps.setString(3, bean.getBlob_name());
			ps.setInt(4, uid);
			ps.setTimestamp(5, curr_Date);
			ps.setInt(6, 1);
			ps.setString(7, bean.getNote());
			ps.setTimestamp(8, curr_Date);
			
			up = ps.executeUpdate();
			 
			/*
			************************************ Insert data into  mst_dept Table ******************************************** 
			*/ 
			
			if(dMSDept_list.contains("0")){
			ps = con.prepareStatement("insert into mst_dept(DMS_CODE,DEPT)values(?,?)");
			ps.setInt(1, cnt_code);
			ps.setInt(2, 0);
			up = ps.executeUpdate();
			}else{
				for(int i=0;i<dMSDept_list.size();i++){
					ps = con.prepareStatement("insert into mst_dept(DMS_CODE,DEPT)values(?,?)");
					ps.setInt(1, cnt_code);
					ps.setInt(2, Integer.parseInt(dMSDept_list.get(i).toString()));
					up = ps.executeUpdate();
					}
			}
			
			/*
			*
			************************************ Insert data into  mst_comp Table ******************************************** 
			*
			*/
			
			if(dMSComp_list.contains("0")){
				ps = con.prepareStatement("insert into mst_comp(DMS_CODE,COMPANY)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setInt(2, 0);
				up = ps.executeUpdate();
			}else{
			for(int i=0;i<dMSComp_list.size();i++){
				ps = con.prepareStatement("insert into mst_comp(DMS_CODE,COMPANY)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setInt(2, Integer.parseInt(dMSComp_list.get(i).toString()));
				up = ps.executeUpdate();
			}
			}
			}
			/*
			*
			************************************ Insert data into  mst_dmsuser Table ******************************************** 
			*
			*/
			
			if(dMSEmp_list.contains("0")){
				ps = con.prepareStatement("insert into mst_dmsuser(DMS_CODE,USER)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setInt(2, 0);
				up = ps.executeUpdate();
			}else{
			for(int i=0;i<dMSEmp_list.size();i++){
				ps = con.prepareStatement("insert into mst_dmsuser(DMS_CODE,USER)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setString(2, dMSEmp_list.get(i).toString());
				up = ps.executeUpdate();
			}
			} 
			/**************************************************** Upload Finish *************************************************/
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return cnt_code;
	}

	public boolean attach_NewDMSFile(DMS_VO bean, HttpSession session) {
		boolean flag=false;
		try {
			

			java.util.Date date= new java.util.Date();
			Timestamp sqlDate = new Timestamp(date.getTime());
			
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			PreparedStatement ps = con.prepareStatement("insert into tarn_dms(TRAN_NO,FILE,FILE_NAME,USER,TRAN_DATE,STATUS,NOTE,SYS_DATE,subject_title)values(?,?,?,?,?,?,?,?,?)");
			ps.setInt(1, bean.getCode());
			ps.setBlob(2, bean.getBlob_file());
			ps.setString(3, bean.getBlob_name());
			ps.setInt(4, uid);
			ps.setTimestamp(5, sqlDate);
			ps.setInt(6, 1);
			ps.setString(7, bean.getNote());
			ps.setTimestamp(8, sqlDate);
			ps.setString(9, bean.getSubject_title());
			
			int up = ps.executeUpdate();
			if(up>0){
				String reg_uname = "";
				int trncode=0;
				PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
				ResultSet rs_uname = ps_uname.executeQuery();
				while (rs_uname.next()) { 
					reg_uname = rs_uname.getString("U_Name");
				}
				
				ps_uname = con.prepareStatement("select max(CODE) from tarn_dms");
				rs_uname = ps_uname.executeQuery();
				while (rs_uname.next()) {
					trncode = rs_uname.getInt("max(CODE)");
				}
				
				PreparedStatement ps_fileHist = con.prepareStatement("insert into mst_dmshist(DMS_CODE,TRAN_FILE,USER,DATE,STATUS,TRAN_CODE)values(?,?,?,?,?,?)");
				ps_fileHist.setInt(1, bean.getCode());
				ps_fileHist.setString(2, bean.getBlob_name());
				ps_fileHist.setString(3, reg_uname);
				ps_fileHist.setTimestamp(4, sqlDate);
				ps_fileHist.setString(5, "New File");
				ps_fileHist.setInt(6, trncode);
				
				int up_hist =  ps_fileHist.executeUpdate();
				
				flag=true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	public void upload_newDevFolder(HttpSession session, DMS_VO bean, ArrayList dMSComp_list, ArrayList dMSDept_list, ArrayList dMSEmp_list, HttpServletResponse response) {
		int cnt_code = 0,up=0;
		try {
			boolean flag=false;
			Connection con = Connection_Utility.getConnection();
			int uid = Integer.parseInt(session.getAttribute("uid").toString());
			java.util.Date date= new java.util.Date();
			Timestamp curr_Date = new Timestamp(date.getTime());
			/* ************************************ Insert Into Main DMS Table ******************************************** */
			// System.out.println("shres access = " + bean.getShared_access());
			PreparedStatement ps = con.prepareStatement("insert into mst_dmsfolder (FOLDER,SUBJECT,SHARE_FLAG,NOTE,STATUS,USER,TRAN_DATE,SYS_DATE,SHARED_ACCESS)values(?,?,?,?,?,?,?,?,?)");
			ps.setString(1, bean.getFolder());
			ps.setString(2, bean.getSubject());
			ps.setInt(3, Integer.parseInt(bean.getShare_others()));
			ps.setString(4, bean.getNote());
			ps.setInt(5, 1);
			ps.setInt(6, uid);
			ps.setTimestamp(7, curr_Date);
			ps.setTimestamp(8, curr_Date);
			ps.setInt(9, bean.getShared_access());
			up = ps.executeUpdate();
		/* ************************************ Get max count from Main DMS Table ******************************************** */
			if(up>0){
				flag=true;
			ps = con.prepareStatement("select max(CODE) from mst_dmsfolder");
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				cnt_code = rs.getInt("max(CODE)"); 
			}
		
			/* 
			ps = con.prepareStatement("insert into tarn_dms(TRAN_NO,FILE,FILE_NAME,USER,TRAN_DATE,STATUS,NOTE,SYS_DATE)values(?,?,?,?,?,?,?,?)");
			ps.setInt(1, cnt_code);
			ps.setBlob(2, bean.getBlob_file());
			ps.setString(3, bean.getBlob_name());
			ps.setInt(4, uid);
			ps.setTimestamp(5, curr_Date);
			ps.setInt(6, 1);
			ps.setString(7, bean.getNote());
			ps.setTimestamp(8, curr_Date); 
			up = ps.executeUpdate(); 
			************************************ Insert data into  mst_dept Table ******************************************** 
			*/			
			if(dMSDept_list.contains("0")){
			ps = con.prepareStatement("insert into mst_dept(DMS_CODE,DEPT)values(?,?)");
			ps.setInt(1, cnt_code);
			ps.setInt(2, 0);
			up = ps.executeUpdate();
			}else{
				for(int i=0;i<dMSDept_list.size();i++){
					ps = con.prepareStatement("insert into mst_dept(DMS_CODE,DEPT)values(?,?)");
					ps.setInt(1, cnt_code);
					ps.setInt(2, Integer.parseInt(dMSDept_list.get(i).toString()));
					up = ps.executeUpdate();
				}
			}
			/************************************* Insert data into  mst_comp Table ******************************************** */
			
			if(dMSComp_list.contains("0")){
				ps = con.prepareStatement("insert into mst_comp(DMS_CODE,COMPANY)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setInt(2, 0);
				up = ps.executeUpdate();
			}else{
			for(int i=0;i<dMSComp_list.size();i++){
				ps = con.prepareStatement("insert into mst_comp(DMS_CODE,COMPANY)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setInt(2, Integer.parseInt(dMSComp_list.get(i).toString()));
				up = ps.executeUpdate();
			}
			}
			 
			}
			/* ************************************ Insert data into  mst_dmsuser Table ******************************************** */
			if(dMSEmp_list.contains("0")){
				ps = con.prepareStatement("insert into mst_dmsuser(DMS_CODE,USER)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setInt(2, 0);
				up = ps.executeUpdate();
			}else{
			for(int i=0;i<dMSEmp_list.size();i++){
				ps = con.prepareStatement("insert into mst_dmsuser(DMS_CODE,USER)values(?,?)");
				ps.setInt(1, cnt_code);
				ps.setString(2, dMSEmp_list.get(i).toString());
				up = ps.executeUpdate();
			}
			}
			
			
			/**************************************************** Upload Finish *************************************************/
			if(flag==true){
				String msg = "Successfully Submitted !!!"; 
				response.sendRedirect("DMS.jsp?msg=" + msg);
				}else{
					String msg = "Data upload failed !!!"; 
					response.sendRedirect("DMS.jsp?msg=" + msg);	
				}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		
	}
}