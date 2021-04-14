<%@page import="it.muthagroup.connectionUtility.Connection_Utility"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%!int i;%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>State Page</title>

<script type="text/javascript">
	function ChangeColor(tableRow, highLight) {
		if (highLight) {
			tableRow.style.backgroundColor = '#CFCFCF';
		} else {
			tableRow.style.backgroundColor = '#EDEDED';
		}
	}
</script>
<script type="text/javascript">
	function ClearList(OptionList, TitleName) {
		OptionList.length = 0;
	}

	function move(side, form_name) {
		var temp1 = new Array();
		var temp2 = new Array();
		var current1 = 0;
		var current2 = 0;
		var attribute;

		//assign what select attribute treat as attribute1 and attribute2
		if (side == "right") {
			attribute1 = document.getElementById('software_name');
			attribute2 = document.getElementById('software_selected');
		} else {
			attribute2 = document.getElementById('software_name');
			attribute1 = document.getElementById('software_selected');
		}

		//fill an array with old values
		for ( var i = 0; i < attribute2.length; i++) {
			temp1[current1++] = attribute2.options[i].value;
		}

		//assign new values to arrays
		for ( var i = 0; i < attribute1.length; i++) {
			if (attribute1.options[i].selected) {
				temp1[current1++] = attribute1.options[i].value;
			} else {
				temp2[current2++] = attribute1.options[i].value;
			}
		}

		//generating new options 
		for ( var i = 0; i < temp1.length; i++) {
			attribute2.options[i] = new Option();
			attribute2.options[i].value = temp1[i];
			attribute2.options[i].text = temp1[i];
			attribute2.options[i].selected = "selected";
		}

		//generating new options
		ClearList(attribute1, attribute1);
		if (temp2.length > 0) {
			for ( var i = 0; i < temp2.length; i++) {
				attribute1.options[i] = new Option();
				attribute1.options[i].value = temp2[i];
				attribute1.options[i].text = temp2[i];
				attribute1.options[i].text = temp2[i];
			}
		}
	}
</script>



</head>
<body>
	<table align="left">
						<tr>
							<td colspan="1"><b>Softwares Available</b></td>
							<td></td>
							<td colspan="1"><b>Softwares Installed</b></td>
						</tr>

						<tr>
							<td colspan="1" align="left"><select id="software_name"
								name="software_name" multiple="multiple" size="5"
								style="width: 480px;height: 280px;font-size: 13px;" title="Softwares"
								onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
								onfocus="if (this.innerHTML == '') {this.innerHTML = '';}"> 
				<%
				try {
					String str = request.getParameter("q");
					
					i = Integer.parseInt(str);
					
					System.out.println("Issue Id = "+i);
					
					Connection connection = null;
				
						connection = Connection_Utility.getConnection();
						PreparedStatement ps_soft=connection.prepareStatement("select * from it_asset_software_mst_tbl where asset_software_id not in (SELECT it_asset_software_mst_tbl.asset_software_id FROM it_asset_software_mst_tbl inner join"+
								" it_asset_issuesoft_rel_tbl"+
								" on it_asset_software_mst_tbl.asset_software_id=it_asset_issuesoft_rel_tbl.asset_software_id and it_asset_issuesoft_rel_tbl.asset_issueNote_id="+i+")");
						ResultSet rs_soft=ps_soft.executeQuery();
						while(rs_soft.next())
						{
				%>
						<option value="<%=rs_soft.getString("Software_Name")%>"><%=rs_soft.getString("Software_Name")%></option>
				<%
					}
						rs_soft.close();
				%>

		</select></td>
							<td style="width: 50px;" align="center" align="center"><input value="&#8658;" onclick="move('right', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 13px;">
							<br> <input value="&#8656;" onclick="move('left', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 13px;"></td>
							<td colspan="1" align="right"><select id="software_selected"
								name="software_selected" multiple="multiple" size="5"
								style="width: 480px;height: 280px;font-size: 13px;" title="Selected Softwares"
								onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
								onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
			<%
					PreparedStatement ps_soft_selected=connection.prepareStatement("SELECT it_asset_software_mst_tbl.Software_Name FROM it_asset_software_mst_tbl inner join"+
								" it_asset_issuesoft_rel_tbl"+
								" on it_asset_software_mst_tbl.asset_software_id=it_asset_issuesoft_rel_tbl.asset_software_id and it_asset_issuesoft_rel_tbl.asset_issueNote_id="+i+"");
						ResultSet rs_soft_selected=ps_soft_selected.executeQuery();
						while(rs_soft_selected.next())
						{
							
				%>
						<option value="<%=rs_soft_selected.getString("Software_Name")%>"><%=rs_soft_selected.getString("Software_Name")%></option>
				<%
						}
						rs_soft_selected.close(); 
				%>
		</select>
			</td>
	</tr>
</table>
	<%
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
	%>
</body>
</html>
