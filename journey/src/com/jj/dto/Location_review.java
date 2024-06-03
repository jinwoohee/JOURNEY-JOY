package com.jj.dto;

import java.util.Date;

public class Location_review {
	
	private int lr_no;			//장소리뷰번호 auto_increment
	private String u_id;		//작성자ID
	private int pl_eat_no;		//관광번호
	private String lr_contents;	//내용
	private String lr_file1;	//첨부파일1
	private String lr_file2;	//첨부파일2
	private String lr_file3;	//첨부파일3
	private Date lr_date;		//작성일시
	private int lr_star;		//별점
	
	private String u_nickname;
	private String u_profile;	//프로필이미지
	public String getU_profile() {
		return u_profile;
	}
	public void setU_profile(String u_profile) {
		this.u_profile = u_profile;
	}
	public String getPlac_name() {
		return plac_name;
	}
	public void setPlac_name(String plac_name) {
		this.plac_name = plac_name;
	}
	public String getEat_name() {
		return eat_name;
	}
	public void setEat_name(String eat_name) {
		this.eat_name = eat_name;
	}
	private String plac_name;	//관광지명
	private String eat_name;	//음식점명
	
	public int getLr_no() {
		return lr_no;
	}
	public void setLr_no(int lr_no) {
		this.lr_no = lr_no;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public int getPl_eat_no() {
		return pl_eat_no;
	}
	public void setPl_eat_no(int pl_eat_no) {
		this.pl_eat_no = pl_eat_no;
	}
	public String getLr_contents() {
		return lr_contents;
	}
	public void setLr_contents(String lr_contents) {
		this.lr_contents = lr_contents;
	}
	public String getLr_file1() {
		return lr_file1;
	}
	public void setLr_file1(String lr_file1) {
		this.lr_file1 = lr_file1;
	}
	public String getLr_file2() {
		return lr_file2;
	}
	public void setLr_file2(String lr_file2) {
		this.lr_file2 = lr_file2;
	}
	public String getLr_file3() {
		return lr_file3;
	}
	public void setLr_file3(String lr_file3) {
		this.lr_file3 = lr_file3;
	}
	public Date getLr_date() {
		return lr_date;
	}
	public void setLr_date(Date lr_date) {
		this.lr_date = lr_date;
	}
	public int getLr_star() {
		return lr_star;
	}
	public void setLr_star(int lr_star) {
		this.lr_star = lr_star;
	}
	public String getU_nickname() {
		return u_nickname;
	}
	public void setU_nickname(String u_nickname) {
		this.u_nickname = u_nickname;
	}
	
	
}
