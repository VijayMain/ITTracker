package it.muthagroup.dao;

import it.muthagroup.connectionUtility.Connection_Utility;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session; 
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;

public class DMSApproval_dao {

	public void approvalGiven(String folder_code, String tran_no, String approval, String hid_tranrel, int uid, HttpServletResponse response) {
		try {
			boolean flag=false;
			Connection con = Connection_Utility.getConnection();
			String name_appr = "";
			String carried="",billno="",dated="",forrs="",purorder="",creator="",approval_status="",approved_by=""; 
			ResultSet rs_up=null,rs_use=null;
			PreparedStatement ps_use =null;
			java.util.Date date= new java.util.Date();
			Timestamp curr_Date = new Timestamp(date.getTime());
			PreparedStatement ps_uname = con.prepareStatement("select * from User_tbl where U_Id="+ uid);
			ResultSet rs_uname = ps_uname.executeQuery();
			while (rs_uname.next()) {
				name_appr = rs_uname.getString("U_Name");
			}
			 
			PreparedStatement ps_up = con.prepareStatement("update tarn_dms  set approved=?,approver=?,approve_date=?,update_date=?,Last_updated_by=? where CODE="+Integer.parseInt(tran_no));
			ps_up.setString(1, approval);
			ps_up.setString(2, name_appr);
			ps_up.setTimestamp(3, curr_Date);
			ps_up.setTimestamp(4, curr_Date);
			ps_up.setString(5, name_appr);
			
			int up = ps_up.executeUpdate();
			
			/*ps_up = con.prepareStatement("select * from  tarn_dms where CODE="+Integer.parseInt(tran_no));
			rs_up = ps_up.executeQuery();
			while (rs_up.next()) {
				System.out.println("update = " + hid_tranrel + " approval_status= " +approval  + " foldercode= " + folder_code  + " tran no= " + tran_no);	
			}*/
			
			if(up>0){
				ps_up = con.prepareStatement("update tarn_dms_devrel set approval=?,approval_by=? where CODE="+hid_tranrel);
				ps_up.setString(1, approval);
				ps_up.setString(2, name_appr);
				up=ps_up.executeUpdate();
				 
				/*String host = "send.one.com";
				String user = "itsupports@muthagroup.com";
				String pass = "itsupports@xyz";
				String from = "itsupports@muthagroup.com";*/
				String subject = "Development Record " + approval +" in Document system";
				boolean sessionDebug = false;
				// ********************************************************************************************* 
				//*****************************************************************************************************
				ArrayList emailArray=new ArrayList();
				String query = "SELECT * FROM it_requisition_mail_tbl where enable=1 and sentfor='DMS_Approved'";
				PreparedStatement ps_check = con.prepareStatement(query);
				ResultSet rs_check = ps_check.executeQuery();
				while(rs_check.next()){
					emailArray.add(rs_check.getString("email"));
				}

				String[] recipients = new String[emailArray.size()];
				for(int e=0;e<emailArray.size();e++){
					recipients[e]=emailArray.get(e).toString();
				}
				
				//*****************************************************************************************************
				String host = "", user = "", pass = "", from = "", smtpPort="";
				query = "select * from domain_config where enable=1";
				ps_check = con.prepareStatement(query);
				rs_check = ps_check.executeQuery();
				while(rs_check.next()){
					host = rs_check.getString("hostName");
					user = rs_check.getString("userName");
					pass = rs_check.getString("pass");
			 		from = rs_check.getString("mailFrom");
			 		smtpPort = rs_check.getString("smtpPort");
				}
				 	Properties props = System.getProperties();
					props.put("mail.host", host);
					props.put("mail.transport.protocol", "smtp");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", smtpPort);
				//*****************************************************************************************************	
				// ********************************************************************************************* 
				/*String report = "DMS_Approved";
				ArrayList to_emails = new ArrayList();
				Connection conLocal = Connection_Utility.getLocalDatabase();
				PreparedStatement ps_rec = conLocal.prepareStatement("select * from pending_approvee where type='to' and report='"+ report + "'");
				ResultSet rs_rec = ps_rec.executeQuery();
				while (rs_rec.next()) {
					to_emails.add(rs_rec.getString("email"));
				}
				
				Properties props = System.getProperties();
				props.put("mail.host", host);
				props.put("mail.transport.protocol", "smtp");
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.port", 2525);*/
				
				
				Session mailSession = Session.getDefaultInstance(props, null);
				mailSession.setDebug(sessionDebug);
				Message msg = new MimeMessage(mailSession);
				msg.setFrom(new InternetAddress(from));
				StringBuilder sb = new StringBuilder();
				sb.append("<b style='color: #0D265E;font-size: 9px;'>This is an automatically generated email for IT Tracker - Document Approval</p>");
				sb.append("<table border='1' width='100%' style='font-family: Arial;'>"+
					"<tr style='font-size: 12px;background-color:#94B4FE; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"+ 
								"<th height='25'>File Name</th> "+
								"<th>Carried Out By</th> "+
								"<th>Vide Bill No</th> "+
								"<th>Dated</th> "+
								"<th>For Rs.</th> "+
								"<th>Work / Purchase Order No</th>"+
								"<th>Note</th>"+
								 "<th>Approval</th>"+
					"</tr>");				
				ps_up = con.prepareStatement("select * from tarn_dms where CODE="+Integer.parseInt(tran_no));
				rs_up = ps_up.executeQuery();
				while (rs_up.next()) {
					 ps_use = con.prepareStatement("select code,carried_out,bill_no,forrs,pur_order,creator,approval,approval_by,code,DATE_FORMAT(dated, \"%d/%m/%Y \") as dated  from tarn_dms_devrel where tran_code="+rs_up.getInt("CODE"));
					 rs_use = ps_use.executeQuery();
					 while(rs_use.next()){
						 carried=rs_use.getString("carried_out");
						 billno=rs_use.getString("bill_no");
						 dated=rs_use.getString("dated");
						 forrs=rs_use.getString("forrs");
						 purorder=rs_use.getString("pur_order");
						 creator=rs_use.getString("creator");
						 approval_status=rs_use.getString("approval");
						 approved_by=rs_use.getString("approval_by"); 
					}
				sb.append("<tr>"+
								"<td>"+rs_up.getString("FILE_NAME")+"</td>"+
								"<td>"+carried+"</td>"+
								"<td>"+billno+"</td>"+
								"<td>"+dated+"</td>"+
								"<td>"+forrs+"</td>"+
								"<td>"+purorder+"</td>"+
								"<td>"+rs_up.getString("NOTE")+"</td>"+
								"<td>"+approval_status+" by " +approved_by+ "</td>"+
					"</tr>");
				}
 				sb.append("</table><p>"
						+ "<b style='font-family: Arial;'>Disclaimer :</b></p> <p><font face='Arial' size='1'>"
						+ "<b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which"
						+ "it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons"
						+ "or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b>"
						+ "</font></p>");
 				
 				InternetAddress[] addressTo = new InternetAddress[recipients.length];
 				
				for (int p = 0; p < recipients.length; p++) {
					addressTo[p] = new InternetAddress(recipients[p]);
				}
				
				msg.setRecipients(Message.RecipientType.TO, addressTo); 
				msg.setSubject(subject);
				msg.setSentDate(new Date());  
					msg.setContent(sb.toString(), "text/html");
					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients()); 
					transport.close();
					//System.out.println("Loop ENd.....");
					flag=true;
	   }
			if(flag==true){
				String msg = "Successfully Submitted !!!";
				response.sendRedirect("DMSApproved_Success.jsp?msg=" + msg+ "&q="+folder_code);
				}else{
					String msg = "Data upload failed !!!";
					response.sendRedirect("DMSApproved_Success.jsp?msg=" + msg+ "&q="+folder_code);
			}
     } catch (Exception e) {
			e.printStackTrace();
	}
	}
}