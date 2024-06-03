package com.jj.dto;

public class InqNotice {
	private String u_id; //로그인한 user id
	private int p_no; //패키지 번호
	private String p_uid; //패키지 작성id
	
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public String getP_uid() {
		return p_uid;
	}
	public void setP_uid(String p_uid) {
		this.p_uid = p_uid;
	}
	
}
