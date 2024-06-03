package com.jj.dto;

public class Purchase {
	private String u_id;
	private int p_no;
	private int adult_num;
	private int std_num;
	private int child_num;
	private String Date;
	
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
	public int getAdult_num() {
		return adult_num;
	}
	public void setAdult_num(int adult_num) {
		this.adult_num = adult_num;
	}
	public int getStd_num() {
		return std_num;
	}
	public void setStd_num(int std_num) {
		this.std_num = std_num;
	}
	public int getChild_num() {
		return child_num;
	}
	public void setChild_num(int child_num) {
		this.child_num = child_num;
	}
	public String getDate() {
		return Date;
	}
	public void setDate(String date) {
		Date = date;
	}
}
