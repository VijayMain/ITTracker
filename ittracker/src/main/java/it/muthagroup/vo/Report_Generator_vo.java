package it.muthagroup.vo;

import java.sql.Timestamp;

public class Report_Generator_vo {

	Long req_no=(long) 0,company_id=(long) 0,rel_to=(long) 0,req_type=(long) 0;
	Timestamp first_date=null,last_date=null;
	
	
	
	public Timestamp getFirst_date() {
		return first_date;
	}
	public void setFirst_date(Timestamp first_date) {
		this.first_date = first_date;
	}
	public Timestamp getLast_date() {
		return last_date;
	}
	public void setLast_date(Timestamp last_date) {
		this.last_date = last_date;
	}
	public Long getReq_no() {
		return req_no;
	}
	public void setReq_no(Long req_no) {
		this.req_no = req_no;
	}
	public Long getCompany_id() {
		return company_id;
	}
	public void setCompany_id(Long company_id) {
		this.company_id = company_id;
	}
	public Long getRel_to() {
		return rel_to;
	}
	public void setRel_to(Long rel_to) {
		this.rel_to = rel_to;
	}
	public Long getReq_type() {
		return req_type;
	}
	public void setReq_type(Long req_type) {
		this.req_type = req_type;
	}

	
	
}
