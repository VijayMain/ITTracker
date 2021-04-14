package it.muthagroup.vo;

public class take_action_vo {

	String status = null, remark = null, done_by = null;

	int req_no = 0, uid = 0, transfer_status = 0;

	public int getTransfer_status() {
		return transfer_status;
	}

	public void setTransfer_status(int transfer_status) {
		this.transfer_status = transfer_status;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getDone_by() {
		return done_by;
	}

	public void setDone_by(String done_by) {
		this.done_by = done_by;
	}

	public int getReq_no() {
		return req_no;
	}

	public void setReq_no(int req_no) {
		this.req_no = req_no;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

}
