package it.muthagroup.vo;

public class Change_Password_vo {
	String curr_pwd=null;
	String new_pwd=null;
	String new_r_pwd=null;
	int u_id=0;
	
	public String getCurr_pwd() {
		return curr_pwd;
	}
	public void setCurr_pwd(String curr_pwd) {
		this.curr_pwd = curr_pwd;
	}
	public String getNew_pwd() {
		return new_pwd;
	}
	public void setNew_pwd(String new_pwd) {
		this.new_pwd = new_pwd;
	}
	public String getNew_r_pwd() {
		return new_r_pwd;
	}
	public void setNew_r_pwd(String new_r_pwd) {
		this.new_r_pwd = new_r_pwd;
	}
	public int getU_id() {
		return u_id;
	}
	public void setU_id(int u_id) {
		this.u_id = u_id;
	}
	
	
}
