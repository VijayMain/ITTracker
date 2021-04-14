package it.muthagroup.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import it.muthagroup.connectionUtility.Connection_Utility;
import it.muthagroup.vo.MIS_access_vo;
import javax.servlet.http.HttpSession;

public class MIS_access_dao {

	public boolean addAccess(HttpSession session, MIS_access_vo vo) {
		int uid = 0;
		boolean flag = false, flag1 = false;
		ArrayList soft = new ArrayList();
		try {
			Connection con = Connection_Utility.getConnection();
			
			soft = vo.getSoft();
			uid = vo.getUid();
			 
			
			int registerer_id = 0;
			int company_id = 0;
			int j = 0;
			int cnt = 0;
			int cnt1 = 0;
			registerer_id = Integer.parseInt(session.getAttribute("uid").toString());
			Iterator it = soft.iterator();

			PreparedStatement ps_chkUser = con.prepareStatement("select count(*) from mis_access_tbl where u_id="+ uid);
			ResultSet rs_chkUser = ps_chkUser.executeQuery();

			while (rs_chkUser.next()) {
				cnt1 = rs_chkUser.getInt("count(*)");
			}

			if (cnt1 > 0) {
				PreparedStatement ps_deluser = con.prepareStatement("delete from mis_access_tbl where U_Id="+ uid);
				ps_deluser.executeUpdate();
				flag1 = true;
			} else {
				flag1 = true;
			}

			if (flag1 == true) {
 

				while (it.hasNext()) {
					PreparedStatement ps_getSoftId = con.prepareStatement("Select *  from mis_report_tbl  where report_name='" + it.next() + "'");
					ResultSet rs_getSoftId = ps_getSoftId.executeQuery();
					while (rs_getSoftId.next()) {
						PreparedStatement ps_addAccess = con.prepareStatement("insert into mis_access_tbl(report_id,u_id,mis_type_id,Enable_Id,Ceated_By)values(?,?,?,?,?)");
						ps_addAccess.setInt(1, rs_getSoftId.getInt("report_id"));
						ps_addAccess.setInt(2, uid);
						ps_addAccess.setInt(3, rs_getSoftId.getInt("mis_type_id"));
						ps_addAccess.setInt(4, 1);
						ps_addAccess.setInt(5, registerer_id);

						j = ps_addAccess.executeUpdate();
						if (j > 0) {
							cnt++;
						}
					}
				}
				if (soft.size() == cnt) {
					flag = true;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return flag;
	}
}
