package it.muthagroup.vo;

import java.sql.Date;

public class IssueNote_vo {

	private int dev_name, company, issuedto, issuedby, issueId;
	private String extra, location, contNo, email;
	private Date issuedate;

	public int getIssueId() {
		return issueId;
	}

	public void setIssueId(int issueId) {
		this.issueId = issueId;
	}

	public int getDev_name() {
		return dev_name;
	}

	public void setDev_name(int dev_name) {
		this.dev_name = dev_name;
	}

	public int getCompany() {
		return company;
	}

	public void setCompany(int company) {
		this.company = company;
	}

	public int getIssuedto() {
		return issuedto;
	}

	public void setIssuedto(int issuedto) {
		this.issuedto = issuedto;
	}

	public int getIssuedby() {
		return issuedby;
	}

	public void setIssuedby(int issuedby) {
		this.issuedby = issuedby;
	}

	public String getExtra() {
		return extra;
	}

	public void setExtra(String extra) {
		this.extra = extra;
	}

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getContNo() {
		return contNo;
	}

	public void setContNo(String contNo) {
		this.contNo = contNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getIssuedate() {
		return issuedate;
	}

	public void setIssuedate(Date issuedate) {
		this.issuedate = issuedate;
	}

}
