package it.muthagroup.vo;

import java.sql.Timestamp;

public class Search_Req_vo 
{
	int u_id=0,rel_to=0,req_type=0;
	
	Timestamp f_date=null,s_date=null;

	public int getU_id() {
		return u_id;
	}

	public void setU_id(int u_id) {
		this.u_id = u_id;
	}

	public int getRel_to() {
		return rel_to;
	}

	public void setRel_to(int rel_to) {
		this.rel_to = rel_to;
	}

	public int getReq_type() {
		return req_type;
	}

	public void setReq_type(int req_type) {
		this.req_type = req_type;
	}

	public Timestamp getF_date() {
		return f_date;
	}

	public void setF_date(Timestamp f_date) {
		this.f_date = f_date;
	}

	public Timestamp getS_date() {
		return s_date;
	}

	public void setS_date(Timestamp s_date) {
		this.s_date = s_date;
	}
	
	
}
