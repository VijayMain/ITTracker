package it.muthagroup.vo;

import java.sql.Date;

public class Surrender_vo {

	private String details;
	private int devName, dev_cond, submitby, itperson, issueNote;
	private Date surrender_date;

	public int getIssueNote() {
		return issueNote;
	}

	public void setIssueNote(int issueNote) {
		this.issueNote = issueNote;
	}

	public Date getSurrender_date() {
		return surrender_date;
	}

	public void setSurrender_date(Date surrender_date) {
		this.surrender_date = surrender_date;
	}

	public String getDetails() {
		return details;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public int getDevName() {
		return devName;
	}

	public void setDevName(int devName) {
		this.devName = devName;
	}

	public int getDev_cond() {
		return dev_cond;
	}

	public void setDev_cond(int dev_cond) {
		this.dev_cond = dev_cond;
	}

	public int getSubmitby() {
		return submitby;
	}

	public void setSubmitby(int submitby) {
		this.submitby = submitby;
	}

	public int getItperson() {
		return itperson;
	}

	public void setItperson(int itperson) {
		this.itperson = itperson;
	}

}
