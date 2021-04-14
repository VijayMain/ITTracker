package it.muthagroup.vo;

import java.sql.Date;

public class Device_Repair_vo {
	private int dev_name, reqNo, partreplace, avail_stk, qtyused, partcond,
			repaired_by;
	private String details, pryes;
	private Date repaired_date = null;

	public String getPryes() {
		return pryes;
	}

	public void setPryes(String pryes) {
		this.pryes = pryes;
	}
 

	public int getDev_name() {
		return dev_name;
	}

	public void setDev_name(int dev_name) {
		this.dev_name = dev_name;
	}

	public int getReqNo() {
		return reqNo;
	}

	public void setReqNo(int reqNo) {
		this.reqNo = reqNo;
	}

	public int getPartreplace() {
		return partreplace;
	}

	public void setPartreplace(int partreplace) {
		this.partreplace = partreplace;
	}

	public int getAvail_stk() {
		return avail_stk;
	}

	public void setAvail_stk(int avail_stk) {
		this.avail_stk = avail_stk;
	}

	public int getQtyused() {
		return qtyused;
	}

	public void setQtyused(int qtyused) {
		this.qtyused = qtyused;
	}

	public int getPartcond() {
		return partcond;
	}

	public void setPartcond(int partcond) {
		this.partcond = partcond;
	}

	public int getRepaired_by() {
		return repaired_by;
	}

	public void setRepaired_by(int repaired_by) {
		this.repaired_by = repaired_by;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public Date getRepaired_date() {
		return repaired_date;
	}

	public void setRepaired_date(Date repaired_date) {
		this.repaired_date = repaired_date;
	}

}
