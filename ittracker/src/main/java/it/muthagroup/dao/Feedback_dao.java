package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement; 
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.Date; 

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.Feedback_vo;  

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Feedback_dao {
	public void send_Feedback(Feedback_vo vo, HttpSession session, HttpServletResponse response) {
try{
	int uid = Integer.parseInt(session.getAttribute("uid").toString());
	Connection con = Connection_Utility.getConnection();
	int dept=0,comp=0;
	
	PreparedStatement ps = con.prepareStatement("select * from user_tbl where u_id="+uid);
	ResultSet rs = ps.executeQuery();
	while (rs.next()) {
		comp = rs.getInt("Company_Id");
		dept=rs.getInt("Dept_Id");
	}
	
	  SimpleDateFormat sdfFIrstDate = new SimpleDateFormat("yyyy-MM-dd");  
	  Date tdate = new Date();
	  java.sql.Date nowDate = new java.sql.Date(tdate.getTime());
	  
	  Date date = new Date();
	
		PreparedStatement ps_feedback = con.prepareStatement("insert into it_user_feedback(internet_speed,pc_laptop,inhouse,erp,it_satisfaction,comments,feedback_date,created_by,user,enable,company_id,dept_id)values(?,?,?,?,?,?,?,?,?,?,?,?)");
		ps_feedback.setInt(1, vo.getInternetandnetwork());
		ps_feedback.setInt(2, vo.getPclaptop());
		ps_feedback.setInt(3, vo.getInhouse());
		ps_feedback.setInt(4, vo.getErp());
		ps_feedback.setInt(5, vo.getSatisfiedit());
		ps_feedback.setString(6, vo.getComment());
		ps_feedback.setDate(7, nowDate);
		ps_feedback.setInt(8, uid);
		ps_feedback.setString(9, vo.getUerrname());
		ps_feedback.setInt(10, 1);
		ps_feedback.setInt(11, comp);
		ps_feedback.setInt(12, dept);
		
		int up = ps_feedback.executeUpdate();
 
		/*if(up>0){
			System.out.println("Email Set Up..................");
			String host = "send.one.com";
			String user = "itsupports@muthagroup.com";
			String pass = "itsupports@xyz";
 
			String from = "itsupports@muthagroup.com";
			String subject = "Customer Satisfaction Surve Received from " + vo.getUerrname();

			boolean sessionDebug = false;
			// *********************************************************************************************
			// multiple recipients : == >
			// ********************************************************************************************* 
			String recipients[] = {"vijaybm@muthagroup.com"};
			Properties props = System.getProperties();
			props.put("mail.host", host);
			props.put("mail.transport.protocol", "smtp");
					props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", 465);
			
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
			msg.setContent("<p> <b style='color: #0D265E;font-size: 9px;'>*** This is an automatically generated email from IT-Tracker ***</b></p>"
			+"<table border='1' width='100%'>"
			+"<tr style='font-size: 12px; background-color: #acc8cc; border-width: 1px; padding: 8px; border-style: solid; border-color: #729ea5; text-align: center;'>"
		+"<th height='25'>Network Speed</th>"
			+"<th>PC, Laptop, Printer Satisfaction</th>"
			+"<th>In-House Softwares</th>"
			+"<th>ERP</th>"
			+"<th>Overall Satisfied</th>"
			+"<th>Comments</th>"
			+"<th>User Name</th>"
			+"</tr>"
		 
		+"<tr>"
			+"<td align='right'>"+vo.getInternetandnetwork()+"</td>"
			+"<td align='right'>"+vo.getPclaptop()+"</td>"
			+"<td align='right'>"+vo.getInhouse()+"</td>"
			+"<td align='right'>"+vo.getErp()+"</td>"
			+"<td align='right'>"+vo.getSatisfiedit()+"</td>"
			+"<td>"+vo.getComment()+"</td>"
			+"<td>"+vo.getUerrname()+"</td>"
		+"</tr>" 
						+"</table><p><b>For more details ,</b> "
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
 			transport.close();
		}*/
		response.sendRedirect("index.jsp");
} catch (Exception e) {
	e.printStackTrace();
}	

}
}
