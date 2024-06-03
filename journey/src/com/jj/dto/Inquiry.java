package com.jj.dto;

import java.sql.Date;

public class Inquiry {
	private int i_no;
	private int p_no;
	private String p_uid; //패키지 작성자 id
	private String p_title;
	private String u_id; //로그인한 id
	private String i_contents;
	private Date i_date;
	private int i_flag; //구분자, 0이면 미확인, 1이면 확인
	
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public String getI_contents() {
		return i_contents;
	}
	public void setI_contents(String i_contents) {
		this.i_contents = i_contents;
	}
	public Date getI_date() {
		return i_date;
	}
	public void setI_date(Date i_date) {
		this.i_date = i_date;
	}
	public int getI_no() {
		return i_no;
	}
	public void setI_no(int i_no) {
		this.i_no = i_no;
	}
	public String getP_uid() {
		return p_uid;
	}
	public void setP_uid(String p_uid) {
		this.p_uid = p_uid;
	}
	public String getP_title() {
		return p_title;
	}
	public void setP_title(String p_title) {
		this.p_title = p_title;
	}
	public int getI_flag() {
		return i_flag;
	}
	public void setI_flag(int i_flag) {
		this.i_flag = i_flag;
	}
	
}
