package it.muthagroup.vo;

public class new_requisition_vo {

	int req_no = 0, rel_id = 0, req_type_id = 0;
	String req_details = null, it_req = "";

	public int getReq_no() {
		return req_no;
	}

	public void setReq_no(int req_no) {
		this.req_no = req_no;
	}

	public int getRel_id() {
		return rel_id;
	}

	public void setRel_id(int rel_id) {
		this.rel_id = rel_id;
	}

	public int getReq_type_id() {
		return req_type_id;
	}

	public void setReq_type_id(int req_type_id) {
		this.req_type_id = req_type_id;
	}

	public String getReq_details() {
		return req_details;
	}

	public void setReq_details(String req_details) {
		this.req_details = req_details;
	}

	public String getIt_req() {
		return it_req;
	}

	public void setIt_req(String it_req) {
		this.it_req = it_req;
	}

}
