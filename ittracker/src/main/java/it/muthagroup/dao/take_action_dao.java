package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.take_action_vo;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class take_action_dao {

	public void addRemark(HttpSession session, HttpServletResponse response,
			take_action_vo vo) {
		try {
			int i = 0;
			String req_name = "", email_transferto = "";
			// To get Todays Date ====== >>>
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();
			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());
			Connection con = Connection_Utility.getConnection();
			PreparedStatement ps_addRemark = con
					.prepareStatement("insert into it_requisition_remark_tbl(U_Req_Id,U_Id,Remark_Date,Action_Details,Done_By,Status)values(?,?,?,?,?,?)");
			ps_addRemark.setInt(1, vo.getReq_no());
			ps_addRemark.setInt(2, vo.getUid());
			ps_addRemark.setTimestamp(3, timestamp);
			ps_addRemark.setString(4, vo.getRemark());
			ps_addRemark.setString(5, vo.getDone_by());
			ps_addRemark.setString(6, vo.getStatus());
			i = ps_addRemark.executeUpdate();
			int j = 0;
			int k = 0;
			if (i > 0) {
				PreparedStatement ps_status = con.prepareStatement("update it_user_requisition set status = '"
								+ vo.getStatus()
								+ "' where U_req_id ="
								+ vo.getReq_no());
				j = ps_status.executeUpdate();

				if (j > 0) {
					int rel_id = 0, req_type_id = 0, comp_id = 0;
					String req_details = null;
					Timestamp original_date = null;

					PreparedStatement ps_getDetails = con
							.prepareStatement("select * from it_user_requisition where U_req_id ="
									+ vo.getReq_no());
					ResultSet rs_getDetails = ps_getDetails.executeQuery();

					while (rs_getDetails.next()) {
						PreparedStatement ps_reqName = con
								.prepareStatement("select * from user_tbl where U_Id="
										+ rs_getDetails.getInt("U_Id"));
						ResultSet rs_reqName = ps_reqName.executeQuery();
						while (rs_reqName.next()) {
							req_name = rs_reqName.getString("U_Name");
						}
						rel_id = rs_getDetails.getInt("Rel_Id");
						req_type_id = rs_getDetails.getInt("Req_Type_Id");
						comp_id = rs_getDetails.getInt("Company_Id");
						req_details = rs_getDetails.getString("Req_Details");
						original_date = rs_getDetails.getTimestamp("Req_Date");
					}

					PreparedStatement ps_addReq_hist = con
							.prepareStatement("insert into it_user_requisition_Hist(U_Req_Date_Hist,U_Req_Id,U_Id,Rel_Id,Req_Type_Id,Req_Date,Req_Details,Status,Company_Id)values(?,?,?,?,?,?,?,?,?)");
					ps_addReq_hist.setTimestamp(1, timestamp);
					ps_addReq_hist.setInt(2, vo.getReq_no());
					ps_addReq_hist.setInt(3, vo.getUid());
					ps_addReq_hist.setInt(4, rel_id);
					ps_addReq_hist.setInt(5, req_type_id);
					ps_addReq_hist.setTimestamp(6, original_date);
					ps_addReq_hist.setString(7, req_details);
					ps_addReq_hist.setString(8, vo.getStatus());
					ps_addReq_hist.setInt(9, comp_id);

					k = ps_addReq_hist.executeUpdate();
				}
			}
			int dept_id = 0;
			// String userName="";
			PreparedStatement ps_userDept = con
					.prepareStatement("select dept_id,U_Name from user_tbl where u_id="
							+ vo.getUid());
			ResultSet rs_userDept = ps_userDept.executeQuery();
			while (rs_userDept.next()) {
				dept_id = rs_userDept.getInt("Dept_ID");
				// userName = rs_userDept.getString("U_Name");
			}

			if (k > 0) {
				if (dept_id == 18) {
					String transferCall = "None";
					int up_code = 0;
					if (vo.getTransfer_status() != 0) {
						PreparedStatement ps_trStat = con
								.prepareStatement("select * from it_requisition_handover_tbl where code="
										+ vo.getTransfer_status());
						ResultSet rs_trstat = ps_trStat.executeQuery();
						while (rs_trstat.next()) {
							transferCall = rs_trstat.getString("name");
						}
						ps_trStat = con
								.prepareStatement("insert into it_user_reqcalltransfer(transfer_to,date_transfer,req_id,transfer_status,created_by,explained)values(?,?,?,?,?,?)");
						ps_trStat.setInt(1, vo.getTransfer_status());
						ps_trStat.setTimestamp(2, timestamp);
						ps_trStat.setInt(3, vo.getReq_no());
						ps_trStat.setString(4, transferCall);
						ps_trStat.setString(5, vo.getDone_by());
						ps_trStat.setString(6, vo.getRemark());

						int upload = ps_trStat.executeUpdate();

						ps_trStat = con
								.prepareStatement("SELECT * FROM complaintzilla.it_requisition_remark_tbl where req_remark_id = (select max(req_remark_id) from complaintzilla.it_requisition_remark_tbl where U_req_id="
										+ vo.getReq_no() + ")");
						rs_trstat = ps_trStat.executeQuery();
						while (rs_trstat.next()) {
							up_code = rs_trstat.getInt("Req_Remark_Id");
						}
						ps_trStat = con
								.prepareStatement("update it_requisition_remark_tbl set transfer_call='"
										+ transferCall
										+ "' where Req_Remark_Id=" + up_code);
						upload = ps_trStat.executeUpdate();

						ps_trStat = con
								.prepareStatement("update it_user_requisition set transfer_call='"
										+ transferCall
										+ "' where U_Req_Id="
										+ vo.getReq_no());
						upload = ps_trStat.executeUpdate();

						ps_trStat = con
								.prepareStatement("select * from it_requisition_handover_tbl where code="
										+ vo.getTransfer_status());
						rs_trstat = ps_trStat.executeQuery();
						while (rs_trstat.next()) {
							email_transferto = rs_trstat.getString("email");
						}
					}
					// **************************************************************************************************************
					// ********************************************* Send an
					// Email **************************************************
					// **************************************************************************************************************
					String email = "", userNm = "", company = "", relate = "", typ = "", da = "", details = "", actionDet = "", status = "", doneBy = "";
					Timestamp remarKDate = null;
					PreparedStatement ps_reqDetails = con
							.prepareStatement("select * from IT_User_Requisition where U_Req_Id="
									+ vo.getReq_no());
					ResultSet rs_reqDetails = ps_reqDetails.executeQuery();
					while (rs_reqDetails.next()) {
						PreparedStatement ps_user = con
								.prepareStatement("select U_Name,U_Email from User_tbl where U_Id="
										+ rs_reqDetails.getString("U_Id"));
						ResultSet rs_user = ps_user.executeQuery();
						while (rs_user.next()) {
							userNm = rs_user.getString("U_Name");
							email = rs_user.getString("U_Email");
						}
						PreparedStatement ps_comp = con
								.prepareStatement("select Company_Name from User_tbl_Company where Company_Id="
										+ rs_reqDetails.getString("Company_Id"));
						ResultSet rs_comp = ps_comp.executeQuery();
						while (rs_comp.next()) {
							company = rs_comp.getString("Company_Name");
						}

						PreparedStatement ps_rel = con
								.prepareStatement("select Related_To from it_related_problem_tbl where Rel_Id="
										+ rs_reqDetails.getString("Rel_Id"));
						ResultSet rs_rel = ps_rel.executeQuery();
						while (rs_rel.next()) {
							relate = rs_rel.getString("Related_To");
						}
						PreparedStatement ps_type = con
								.prepareStatement("select Req_Type from it_requisition_type_tbl where Req_Type_Id="
										+ rs_reqDetails
												.getString("Req_Type_Id"));
						ResultSet rs_type = ps_type.executeQuery();
						while (rs_type.next()) {
							typ = rs_type.getString("Req_Type");
						}
						da = rs_reqDetails.getString("Req_Date");
						details = rs_reqDetails.getString("Req_Details");

					}
					PreparedStatement ps_reqRemark = con
							.prepareStatement("select * from it_requisition_remark_tbl where U_Req_Id="
									+ vo.getReq_no());
					ResultSet rs_reqRemark = ps_reqRemark.executeQuery();
					while (rs_reqRemark.next()) {
						remarKDate = rs_reqRemark.getTimestamp("Remark_Date");
						actionDet = rs_reqRemark.getString("Action_Details");
						status = rs_reqRemark.getString("Status");
						PreparedStatement ps_userName = con
								.prepareStatement("select U_Name from User_Tbl where U_Id="
										+ rs_reqRemark.getInt("U_Id"));
						ResultSet rs_userName = ps_userName.executeQuery();
						while (rs_userName.next()) {
							doneBy = rs_userName.getString("U_Name");
						}
					}
					//System.out.println("Email Set Up..................");
					/*String host = "send.one.com";
					String user = "itsupports@muthagroup.com";
					String pass = "itsupports@xyz"; 
					String from = "itsupports@muthagroup.com";*/
					
					String subject = "IT Tracker Requisition No " + vo.getReq_no() + " is " + status;

					boolean sessionDebug = false;
					// *********************************************************************************************
					// multiple recipients : == >
					// *********************************************************************************************

					/*
					 * String recipients[] =
					 * {"itsupports@muthagroup.com",email};
					 */

					/*String mail_id = "itsupports@muthagroup.com";
					

					String recipients[] = new String[3];

					if (vo.getTransfer_status() != 0) {
						recipients[0] = mail_id;
						recipients[1] = email;
						recipients[2] = email_transferto;
					} else {
						recipients[0] = mail_id;
						recipients[1] = email;
						recipients[2] = mail_id;
					}*/

					// System.out.println("Mail id = = " + mail_id);

					// String recipients[] = {mail_id.toString()};
					//*****************************************************************************************************
					ArrayList emailArray=new ArrayList();
					String query = "SELECT * FROM it_requisition_mail_tbl where enable =1 and sentfor='reply'";
					PreparedStatement ps_check = con.prepareStatement(query);
					ResultSet rs_check = ps_check.executeQuery();
					while(rs_check.next()){
						emailArray.add(rs_check.getString("email"));
					}

					if (vo.getTransfer_status() != 0) { 
						emailArray.add(email);
						emailArray.add(email_transferto);
					} else {
						emailArray.add(email); 
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
					//*****************************************************************************************************
					 

					Session mailSession = Session.getDefaultInstance(props,	null);
					mailSession.setDebug(sessionDebug);
					Message msg = new MimeMessage(mailSession);
					msg.setFrom(new InternetAddress(from));
					InternetAddress[] addressTo = new InternetAddress[recipients.length];

					for (int p = 0; p < recipients.length; p++) {
						addressTo[p] = new InternetAddress(recipients[p]);
					}

					msg.setRecipients(Message.RecipientType.TO, addressTo);

					msg.setSubject(subject);
					msg.setSentDate(new Date());

					// Create the message part
					//BodyPart messageBodyPart = new MimeBodyPart();
					// Fill the message
					// messageBodyPart.setText("This is message body");

					StringBuilder sb = new StringBuilder();
					sb.append("<p><b style='color: #0D265E;'>*** This is an automatically generated email from IT-Tracker ***</b>"
							+ "</p>"
							+ "<table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"
							+ "<th align='center'><b>Requisition No</b></th>"
							+ "<th align='center'><b>User Name</b></th>"
							+ "<th align='center'><b>Company Name</b></th>"
							+ "<th align='center'><b>Related To</b></th>"
							+ "<th align='center'><b>Req Type</b></th>"
							+ "<th align='center'><b>Req Date</b></th> "
							+ "<th align='center'><b>Call Transferred To/Remark</b></th> "
							+ "</tr><tr><td align='center'>"
							+ vo.getReq_no()
							+ "</td> "
							+ "<td align='center'>"
							+ userNm
							+ "</td> "
							+ "<td align='center'>"
							+ company
							+ "</td> "
							+ "<td align='center'>"
							+ relate
							+ "</td> "
							+ "<td align='center'>"
							+ typ
							+ "</td> "
							+ "<td align='center'>"
							+ da
							+ "</td>"
							+ "<td align='center'><b>"
							+ transferCall
							+ "</b></td>"
							+ "</tr>"
							+ "<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"
							+ "<td colspan='7' align='center'><b>Requisition Details</b></td></tr>"
							+ "<tr><td colspan='7' align='center'>"
							+ details
							+ "</td></tr>"
							+ "<tr></tr>"
							+ "<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"
							+ "<th align='center'><b>Action Date</b></th>"
							+ "<th colspan='4' align='center'><b>Remark</b></th>"
							+ "<th align='center'><b>Status</b></th>"
							+ "<th align='center'><b>Done By</b></th>"
							+ "</tr><tr><td align='center'>"
							+ remarKDate
							+ "</td>"
							+ "<td colspan='4' align='center'>"
							+ actionDet
							+ "</td>"
							+ "<td align='center'>"
							+ status
							+ "</td> "
							+ "<td align='center'>"
							+ doneBy + "</td> " + "</tr></table>");

					sb.append("<p><b>For more details ,</b>"
							+ "<a href='http://192.168.0.7/ittracker/'>Click Here</a>"
							+ " </p><p><b style='color: #330B73;'>Thanks & Regards </b></P><p> Mutha Group Satara </p>"
							+ "<hr>"
							+ "<p><b>Disclaimer :</b></p>"
							+ "<font face='Times New Roman' size='1'>"
							+ "<p><b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></p></font>");

					msg.setContent(sb.toString(), "text/html");

					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());
					// ******************************************************************************
					transport.close();
					response.sendRedirect("IT_New_Requisition.jsp");

					// **************************************************************************************************************
				} else {
					//System.out.println("Email Set Up..................");
					/*String host = "send.one.com";
					String user = "itsupports@muthagroup.com";
					String pass = "itsupports@xyz";*/
					// String to = "amitpawar4182@gmail.com";

					String user_name = null, company = null;
					int company_id = 0;
					PreparedStatement ps_uname = con
							.prepareStatement("select * from User_Tbl where U_Id="
									+ vo.getUid());
					ResultSet rs_uname = ps_uname.executeQuery();
					while (rs_uname.next()) {
						user_name = rs_uname.getString("U_Name");
						company_id = rs_uname.getInt("Company_id");
						PreparedStatement ps_companyName = con
								.prepareStatement("select company_name from User_Tbl_Company where Company_Id="
										+ company_id);
						ResultSet rs_companyName = ps_companyName
								.executeQuery();
						while (rs_companyName.next()) {
							company = rs_companyName.getString("Company_Name");
						}
					}

					String relTo = null, relType = null, remark = null, req_details = null;
					Timestamp remark_Date = null, req_Date = null;
					int re_remark_id = 0;
					PreparedStatement ps_maxReqID = con
							.prepareStatement("select max(Req_Remark_Id) from it_requisition_remark_tbl where U_Req_ID="
									+ vo.getReq_no());

					ResultSet rs_maxReqID = ps_maxReqID.executeQuery();
					while (rs_maxReqID.next()) {
						re_remark_id = rs_maxReqID.getInt("max(Req_Remark_Id)");
					}

					PreparedStatement ps_req_Details = con
							.prepareStatement("select * from it_requisition_remark_tbl where Req_Remark_Id="
									+ re_remark_id);
					ResultSet rs_Req_Details = ps_req_Details.executeQuery();
					while (rs_Req_Details.next()) {
						remark = rs_Req_Details.getString("Action_Details");
						remark_Date = rs_Req_Details
								.getTimestamp("Remark_Date");
					}

					PreparedStatement ps_User_reqDetails = con
							.prepareStatement("select * from it_user_requisition where U_Req_Id="
									+ vo.getReq_no());
					ResultSet rs_User_reqDetails = ps_User_reqDetails
							.executeQuery();

					while (rs_User_reqDetails.next()) {
						req_details = rs_User_reqDetails
								.getString("Req_Details");

						req_Date = rs_User_reqDetails.getTimestamp("Req_Date");

						PreparedStatement ps_relatedTo = con
								.prepareStatement("select * from it_related_problem_tbl where rel_id="
										+ rs_User_reqDetails.getInt("Rel_Id"));
						ResultSet rs_relatedTo = ps_relatedTo.executeQuery();
						while (rs_relatedTo.next()) {
							relTo = rs_relatedTo.getString("Related_To");
						}

						PreparedStatement ps_relType = con
								.prepareStatement("select * from it_requisition_type_tbl where Req_Type_Id="
										+ rs_User_reqDetails
												.getInt("Req_Type_Id"));
						ResultSet rs_relType = ps_relType.executeQuery();

						while (rs_relType.next()) {
							relType = rs_relType.getString("Req_Type");
						}

					}

					String subject = "IT Tracker Requisition No " + vo.getReq_no() + " is Reopened by " + user_name + " for " + company;

					boolean sessionDebug = false;
					// *********************************************************************************************
					// multiple recipients : == >
					// *********************************************************************************************
					//*****************************************************************************************************
					ArrayList emailArray=new ArrayList();
					String query = "SELECT * FROM it_requisition_mail_tbl where enable=1 and sentfor='reply'";
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
					/*String recipients[] = { "itsupports@muthagroup.com" };

					Properties props = System.getProperties(); 
					props.put("mail.host", host);
					props.put("mail.transport.protocol", "smtp");
					props.put("mail.smtp.auth", "true");
					props.put("mail.smtp.port", 2525);*/
					
					
					// *********************************************************************************************

					Session mailSession = Session.getDefaultInstance(props,	null);
					mailSession.setDebug(sessionDebug);
					Message msg = new MimeMessage(mailSession);
					msg.setFrom(new InternetAddress(from));
					InternetAddress[] addressTo = new InternetAddress[recipients.length];

					for (int p = 0; p < recipients.length; p++) {
						addressTo[p] = new InternetAddress(recipients[p]);
					}

					msg.setRecipients(Message.RecipientType.TO, addressTo);

					msg.setSubject(subject);
					msg.setSentDate(new Date());

					// Create the message part
					//BodyPart messageBodyPart = new MimeBodyPart();
					// Fill the message
					// messageBodyPart.setText("This is message body");
					msg.setContent(
							"<p><b style='color: #0D265E;'>*** This is an automatically generated email from IT-Tracker ***</b>"
									+ "</p>"
									+ "<table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"
									+ "	<th width='5%' height='25'> Req. No </th>"
									+ "	<th>Problem Related To </th>"
									+ "	<th>Type </th>"
									+ "	<th>Requisitions Details </th>"
									+ "	<th>Company </th>"
									+ "	<th>Requisition Received from</th>"
									+ "	<th>Requisition Received date </th>"
									+ "	<th style='background-color: red;'>Reopen Remark</th>"
									+ "	<th style='background-color: red;'>Remark Date</th>"
									+ "	</tr>"
									+ "	<tr style='font-size: 12px;text-align: center;'>"
									+ "	<td>"
									+ vo.getReq_no()
									+ "</td>"
									+ "	<td>"
									+ relTo
									+ "</td>"
									+ "	<td>"
									+ relType
									+ "</td>"
									+ "	<td>"
									+ req_details
									+ "</td>"
									+ "	<td>"
									+ company
									+ "</td>"
									+ "	<td>"
									+ user_name
									+ "</td>"
									+ "	<td>"
									+ req_Date
									+ "</td>"
									+ "	<td>"
									+ remark
									+ "</td>"
									+ "	<td>"
									+ remark_Date
									+ "</td>"
									+ "	</tr>"
									+ "	</table>"

									+ "<p><b>For more details ,</b> "
									+ "<a href='http://192.168.0.7/ittracker/'>Click Here</a>"
									+ " </p><p><b style='color: #330B73;'>Thanks & Regards </b></P><p> Mutha Group Satara </p>"
									+ "<hr>"
									+ "<p><b>Disclaimer :</b></p>"
									+ "<font face='Times New Roman' size='1'>"
									+ "<p><b style='color: #49454F;'>The information transmitted, including attachments, is intended only for the person(s) or entity to which it is addressed and may contain confidential and/or privileged material. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information by persons or entities other than the intended recipient is prohibited. If you received this in error, please contact the sender and destroy any copies of this information.</b></p></font>",
							"Text/html");

					Transport transport = mailSession.getTransport("smtp");
					transport.connect(host, user, pass);
					transport.sendMessage(msg, msg.getAllRecipients());

					// ******************************************************************************

					transport.close();

					response.sendRedirect("Requisition_Status.jsp");
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
