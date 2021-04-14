package it.muthagroup.controller;

import it.muthagroup.connectionUtility.Connection_Utility;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement; 
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
public class AddNewStock_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int spareId = Integer.parseInt(request.getParameter("spareId"));
			int qty = Integer.parseInt(request.getParameter("qty"));
			HttpSession session = request.getSession();
			Connection con = Connection_Utility.getConnection(); 
			int uid = Integer.parseInt(session.getAttribute("uid").toString()); 
			int up=0,getqty=0; 
			Date curr_Date = new java.sql.Date(System.currentTimeMillis());
			
			PreparedStatement ps_sel=con.prepareStatement("select * from it_asset_deviceitem_mst_tbl where asset_deviceitem_mst_id="+spareId);
			ResultSet rs_sel = ps_sel.executeQuery();
			while(rs_sel.next()){
				getqty = rs_sel.getInt("Available_qty");
			}
			ps_sel.close();
			rs_sel.close();
			getqty = qty+getqty;
			PreparedStatement ps_stock = con.prepareStatement("update it_asset_deviceitem_mst_tbl set Available_qty="+getqty +" where asset_deviceitem_mst_id="+spareId); 			
			up = ps_stock.executeUpdate();			
			if(up>0){
				PreparedStatement ps_stkhis=con.prepareStatement("insert into it_asset_deviceitem_mst_hist_tbl(asset_deviceitem_mst_id,new_qty,created_by,created_date)values(?,?,?,?)");
				ps_stkhis.setInt(1, spareId);
				ps_stkhis.setInt(2, qty);
				ps_stkhis.setInt(3, uid);
				ps_stkhis.setDate(4, curr_Date);
				int his = ps_stkhis.executeUpdate();
				ps_stkhis.close();
				con.close();
				System.out.println("Success");
				response.sendRedirect("Add_newspareparts.jsp");
			}else {
				con.close();
				System.out.println("Error Occurred !!!"); 
				response.sendRedirect("Add_newspareparts.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}	     
}
