package it.muthagroup.vo;

import java.sql.Date;

public class Device_info_vo {
	private String devicename = "", pono = "", grn_no = "", modelno = "",
			serialno = "", imei_no = "", imei_no2 = "", product_code = "",
			item_code = "", sap_code = "", description = "", mac_address = "",
			online = "";
	private double basic_rate, tot_amt;
	private int dev_type, supplier, ip_address, os;
	private Date grndate = null, podate = null, received_date = null;

	public int getOs() {
		return os;
	}

	public void setOs(int os) {
		this.os = os;
	}

	public String getOnline() {
		return online;
	}

	public void setOnline(String online) {
		this.online = online;
	}

	public int getIp_address() {
		return ip_address;
	}

	public void setIp_address(int ip_address) {
		this.ip_address = ip_address;
	}

	public String getMac_address() {
		return mac_address;
	}

	public void setMac_address(String mac_address) {
		this.mac_address = mac_address;
	}

	public String getDevicename() {
		return devicename;
	}

	public void setDevicename(String devicename) {
		this.devicename = devicename;
	}

	public String getPono() {
		return pono;
	}

	public void setPono(String pono) {
		this.pono = pono;
	}

	public String getGrn_no() {
		return grn_no;
	}

	public void setGrn_no(String grn_no) {
		this.grn_no = grn_no;
	}

	public String getModelno() {
		return modelno;
	}

	public void setModelno(String modelno) {
		this.modelno = modelno;
	}

	public String getSerialno() {
		return serialno;
	}

	public void setSerialno(String serialno) {
		this.serialno = serialno;
	}

	public String getImei_no() {
		return imei_no;
	}

	public void setImei_no(String imei_no) {
		this.imei_no = imei_no;
	}

	public String getImei_no2() {
		return imei_no2;
	}

	public void setImei_no2(String imei_no2) {
		this.imei_no2 = imei_no2;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getItem_code() {
		return item_code;
	}

	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}

	public String getSap_code() {
		return sap_code;
	}

	public void setSap_code(String sap_code) {
		this.sap_code = sap_code;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getBasic_rate() {
		return basic_rate;
	}

	public void setBasic_rate(double basic_rate) {
		this.basic_rate = basic_rate;
	}

	public double getTot_amt() {
		return tot_amt;
	}

	public void setTot_amt(double tot_amt) {
		this.tot_amt = tot_amt;
	}

	public int getDev_type() {
		return dev_type;
	}

	public void setDev_type(int dev_type) {
		this.dev_type = dev_type;
	}

	public int getSupplier() {
		return supplier;
	}

	public void setSupplier(int supplier) {
		this.supplier = supplier;
	}

	public Date getGrndate() {
		return grndate;
	}

	public void setGrndate(Date grndate) {
		this.grndate = grndate;
	}

	public Date getPodate() {
		return podate;
	}

	public void setPodate(Date podate) {
		this.podate = podate;
	}

	public Date getReceived_date() {
		return received_date;
	}

	public void setReceived_date(Date received_date) {
		this.received_date = received_date;
	}

}
