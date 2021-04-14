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
<title>MIS Report</title>

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
	<table align="center">
	<tr>
  						<td colspan="1"><b>MIS Report</b></td>
								<td></td>
								<td colspan="1"><b>Selected MIS Report</b></td>
							</tr>
							<tr>
		<td colspan="1" align="left"><select id="software_name"
			name="software_name" multiple="multiple" size="5"
			style="width: 500px;height: 250px;font-size: 13px;font-family: Arial;" title="MIS Reports"
			onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
			onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
				<%
					String str = request.getParameter("q");
					
					i = Integer.parseInt(str);
					
					System.out.println("User Id..."+i);
					
					Connection connection = null;
					try {
						connection = Connection_Utility.getConnection();
						String name="";
						PreparedStatement ps_soft=connection.prepareStatement("select * from mis_report_tbl where report_id  not in (select mis_report_tbl.report_id  from   mis_access_tbl  inner join  mis_report_tbl on mis_report_tbl.report_id = mis_access_tbl.report_id and mis_access_tbl.u_id="+i+")");
						ResultSet rs_soft=ps_soft.executeQuery();
						while(rs_soft.next())
						{
							if(rs_soft.getInt("mis_type_id")==1){
								name = "Machine Shop MIS";
							}
							if(rs_soft.getInt("mis_type_id")==2){
								name = "Foundry MIS ";
							}
				%>
				<option value="<%=rs_soft.getString("report_name")%>"><%=rs_soft.getString("report_name")%>&nbsp;&nbsp;&#8658;&nbsp;(<%=name %>)</option>
				<%
						}
						rs_soft.close(); 	
				%>

		</select></td>
		<td align="center"><input value="&#8658;" onclick="move('right', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 15px;"><br>
			<input value="&#8656;" onclick="move('left', 'rep')" type="button" style="width: 60px;height: 40px;font-size: 15px;"></td>
		<td colspan="1" align="right">
		<select id="software_selected"
			name="software_selected" multiple="multiple" size="5"
			style="width: 500px;height: 250px;font-size: 13px;font-family: Arial;" title="Selected MIS Reports"
			onblur="if (this.innerHTML == '') {this.innerHTML = '';}"
			onfocus="if (this.innerHTML == '') {this.innerHTML = '';}">
			<%
			PreparedStatement ps_soft2=connection.prepareStatement("select * from mis_report_tbl inner join mis_access_tbl on mis_report_tbl.report_id =mis_access_tbl.report_id where u_id="+ i);
			ResultSet rs_soft2=ps_soft2.executeQuery();
			while(rs_soft2.next())
			{
				if(rs_soft2.getInt("mis_type_id")==1){
					name = "Machine Shop MIS";
				}
				if(rs_soft2.getInt("mis_type_id")==2){
					name = "Foundry MIS ";
				}
	%>
	<option value="<%=rs_soft2.getString("report_name")%>"><%=rs_soft2.getString("report_name")%>&nbsp;&nbsp;&#8658;&nbsp;(<%=name %>)</option>
	<%
			} 
			rs_soft2.close();
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
	</select>

</body>
</html>
