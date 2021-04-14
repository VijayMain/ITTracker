package it.muthagroup.vo;

import java.io.InputStream;
import java.sql.Timestamp;

public class DMS_VO {

	private int srno, dmscode, shared_access = 0, code, tran_dmscode,
			tranrelCode, folder_code;
	private String folder, subject, file, share_others, blob_name, note,
			date_dms, carriedout, videbill, forrs, purorder, subject_title;
	private InputStream blob_file = null;
	private Timestamp demo4 = null;

	public int getFolder_code() {
		return folder_code;
	}

	public void setFolder_code(int folder_code) {
		this.folder_code = folder_code;
	}

	public String getSubject_title() {
		return subject_title;
	}

	public void setSubject_title(String subject_title) {
		this.subject_title = subject_title;
	}

	public int getTranrelCode() {
		return tranrelCode;
	}

	public void setTranrelCode(int tranrelCode) {
		this.tranrelCode = tranrelCode;
	}

	public int getTran_dmscode() {
		return tran_dmscode;
	}

	public void setTran_dmscode(int tran_dmscode) {
		this.tran_dmscode = tran_dmscode;
	}

	public int getCode() {
		return code;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public int getDmscode() {
		return dmscode;
	}

	public void setDmscode(int dmscode) {
		this.dmscode = dmscode;
	}

	public int getSrno() {
		return srno;
	}

	public void setSrno(int srno) {
		this.srno = srno;
	}

	public String getFolder() {
		return folder;
	}

	public void setFolder(String folder) {
		this.folder = folder;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getFile() {
		return file;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public String getShare_others() {
		return share_others;
	}

	public void setShare_others(String share_others) {
		this.share_others = share_others;
	}

	public int getShared_access() {
		return shared_access;
	}

	public void setShared_access(int shared_access) {
		this.shared_access = shared_access;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getBlob_name() {
		return blob_name;
	}

	public void setBlob_name(String blob_name) {
		this.blob_name = blob_name;
	}

	public InputStream getBlob_file() {
		return blob_file;
	}

	public void setBlob_file(InputStream blob_file) {
		this.blob_file = blob_file;
	}

	public String getCarriedout() {
		return carriedout;
	}

	public void setCarriedout(String carriedout) {
		this.carriedout = carriedout;
	}

	public String getVidebill() {
		return videbill;
	}

	public void setVidebill(String videbill) {
		this.videbill = videbill;
	}

	public String getForrs() {
		return forrs;
	}

	public void setForrs(String forrs) {
		this.forrs = forrs;
	}

	public String getPurorder() {
		return purorder;
	}

	public void setPurorder(String purorder) {
		this.purorder = purorder;
	}

	public Timestamp getDemo4() {
		return demo4;
	}

	public void setDemo4(Timestamp demo4) {
		this.demo4 = demo4;
	}

	public String getDate_dms() {
		return date_dms;
	}

	public void setDate_dms(String date_dms) {
		this.date_dms = date_dms;
	}

}
