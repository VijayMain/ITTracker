package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.new_requisition_vo;

import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

public class new_requisition_dao {

	boolean flag = false;

	public boolean addReq(new_requisition_vo vo, HttpSession session) {
		try {
			int uid = 0;
			int comp_id = 0;
			uid = Integer.parseInt(session.getAttribute("uid").toString());

			Connection con = Connection_Utility.getConnection();

			PreparedStatement ps_user_comp = con.prepareStatement("select Company_Id from user_tbl where U_Id=" + uid);
			ResultSet rs_user_comp = ps_user_comp.executeQuery();

			while (rs_user_comp.next()) {
				comp_id = rs_user_comp.getInt("Company_Id");
			}

			// To get Todays Date ====== >>>
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			// get current date time with Date()
			Date date = new Date();

			java.sql.Timestamp timestamp = new java.sql.Timestamp(
					date.getTime());

			PreparedStatement ps_addReq = con
					.prepareStatement("insert into it_user_requisition(U_Req_Id,U_Id,Rel_Id,Req_Type_Id,Req_Date,Req_Details,Status,Company_Id)values(?,?,?,?,?,?,?,?)");
			ps_addReq.setInt(1, vo.getReq_no());
			ps_addReq.setInt(2, uid);
			ps_addReq.setInt(3, vo.getRel_id());
			ps_addReq.setInt(4, vo.getReq_type_id());
			ps_addReq.setTimestamp(5, timestamp);
			ps_addReq.setString(6, vo.getReq_details());
			ps_addReq.setString(7, "Pending");
			ps_addReq.setInt(8, comp_id);

			int i = ps_addReq.executeUpdate();
			int j = 0;

			if (i > 0) {
				PreparedStatement ps_addReq_hist = con
						.prepareStatement("insert into it_user_requisition_Hist(U_Req_Date_Hist,U_Req_Id,U_Id,Rel_Id,Req_Type_Id,Req_Date,Req_Details,Status,Company_Id)values(?,?,?,?,?,?,?,?,?)");
				ps_addReq_hist.setTimestamp(1, timestamp);
				ps_addReq_hist.setInt(2, vo.getReq_no());
				ps_addReq_hist.setInt(3, uid);
				ps_addReq_hist.setInt(4, vo.getRel_id());
				ps_addReq_hist.setInt(5, vo.getReq_type_id());
				ps_addReq_hist.setTimestamp(6, timestamp);
				ps_addReq_hist.setString(7, vo.getReq_details());
				ps_addReq_hist.setString(8, "Pending");
				ps_addReq_hist.setInt(9, comp_id);

				j = ps_addReq_hist.executeUpdate();

				flag = true;

				if (j > 0) {
					// ************************************************************************************************************************
					//System.out.println("Email Set Up..................");
					/*String host = "send.one.com";
					String user = "itsupports@muthagroup.com";
					String pass = "itsupports@xyz";*/

					String user_name = null, company = null;
					int company_id = 0;
					PreparedStatement ps_uname = con
							.prepareStatement("select * from User_Tbl where U_Id="
									+ uid);
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

					String relTo = null, relType = null;
					PreparedStatement ps_relatedTo = con
							.prepareStatement("select * from it_related_problem_tbl where rel_id="
									+ vo.getRel_id());
					ResultSet rs_relatedTo = ps_relatedTo.executeQuery();
					while (rs_relatedTo.next()) {
						relTo = rs_relatedTo.getString("Related_To");
					}

					PreparedStatement ps_relType = con
							.prepareStatement("select * from it_requisition_type_tbl where Req_Type_Id="
									+ vo.getReq_type_id());
					ResultSet rs_relType = ps_relType.executeQuery();

					while (rs_relType.next()) {
						relType = rs_relType.getString("Req_Type");
					}

					// String from = "itsupports@muthagroup.com";
					String subject = "New Requisition Received from " + user_name + " for " + company;

					boolean sessionDebug = false;
					// *********************************************************************************************
					// multiple recipients : == >
					// *********************************************************************************************
					//*****************************************************************************************************
					ArrayList emailArray=new ArrayList();
					String query = "SELECT * FROM it_requisition_mail_tbl where enable=1 and sentfor='New'";
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

					Session mailSession = Session.getDefaultInstance(props, null);
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
					BodyPart messageBodyPart = new MimeBodyPart();
					// Fill the message
					// messageBodyPart.setText("This is message body");
					msg.setContent("<p><b style='color: #0D265E;'>*** This is an automatically generated email from IT-Tracker ***</b>"
									+ "</p>"
									+

									"<table border='1' width='100%'><tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid;border-color: #729ea5;text-align: center;'>"
									+ "	<th width='5%' height='25'> Req. No </th>"
									+ "	<th>Problem Related To </th>"
									+ "	<th>Type </th>"
									+ "	<th>Requisitions Details </th>"
									+ "	<th>Company </th>"
									+ "	<th>Requisition Received from</th>"
									+ "	<th>Requisition Received date </th>"
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
									+ vo.getReq_details()
									+ "</td>"
									+ "	<td>"
									+ company
									+ "</td>"
									+ "	<td>"
									+ user_name
									+ "</td>"
									+ "	<td>"
									+ timestamp
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

					// ************************************************************************************************************************

					transport.close();
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}
}