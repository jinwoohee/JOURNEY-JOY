package com.jj.dto;

import java.sql.Date;
import java.util.Arrays;

public class Plan_review {
	private int pr_no;
	private String u_id;
	private int e_no;
	private String pr_title;
	private String pr_contents;
	private String pr_file;
	private String pr_file2;
	private String pr_file3;
	private Date pr_date;
	
	private String u_nickname;
	private String u_profile;
	private String e_destination;
	private String e_thema;
	private String e_detail_thema;
	
	public String getE_thema() {
		return e_thema;
	}
	public void setE_thema(String e_thema) {
		this.e_thema = e_thema;
	}
	public String getE_detail_thema() {
		return e_detail_thema;
	}
	public void setE_detail_thema(String e_detail_thema) {
		this.e_detail_thema = e_detail_thema;
	}
	public String getE_destination() {
		return e_destination;
	}
	public void setE_destination(String e_destination) {
		this.e_destination = e_destination;
	}
	public String getU_profile() {
		return u_profile;
	}
	public void setU_profile(String u_profile) {
		this.u_profile = u_profile;
	}
	public int getPr_no() {
		return pr_no;
	}
	public void setPr_no(int pr_no) {
		this.pr_no = pr_no;
	}

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

	public int getE_no() {
		return e_no;
	}

	public void setE_no(int e_no) {
		this.e_no = e_no;
	}

	public String getPr_title() {
		return pr_title;
	}

	public void setPr_title(String pr_title) {
		this.pr_title = pr_title;
	}

	public String getPr_contents() {
		return pr_contents;
	}

	public void setPr_contents(String pr_contents) {
		this.pr_contents = pr_contents;
	}

	public String getPr_file() {
		return pr_file;
	}

	public void setPr_file(String pr_file) {
		this.pr_file = pr_file;
	}

	public String getPr_file2() {
		return pr_file2;
	}

	public void setPr_file2(String pr_file2) {
		this.pr_file2 = pr_file2;
	}

	public String getPr_file3() {
		return pr_file3;
	}

	public void setPr_file3(String pr_file3) {
		this.pr_file3 = pr_file3;
	}

	public Date getPr_date() {
		return pr_date;
	}

	public void setPr_date(Date pr_date) {
		this.pr_date = pr_date;
	}

	public String getU_nickname() {
		return u_nickname;
	}

	public void setU_nickname(String u_nickname) {
		this.u_nickname = u_nickname;
	}

}
