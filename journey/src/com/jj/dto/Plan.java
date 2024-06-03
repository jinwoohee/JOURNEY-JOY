package com.jj.dto;

import java.sql.Date;

public class Plan {
	private int plan_no;
	private int e_no;
	private String plan_title;
	private String plan_product;
	private Date plan_date;
	private String plan_url;
	
	public int getPlan_no() {
		return plan_no;
	}
	public void setPlan_no(int plan_no) {
		this.plan_no = plan_no;
	}
	public int getE_no() {
		return e_no;
	}
	public void setE_no(int e_no) {
		this.e_no = e_no;
	}
	public String getPlan_title() {
		return plan_title;
	}
	public void setPlan_title(String plan_title) {
		this.plan_title = plan_title;
	}
	public String getPlan_product() {
		return plan_product;
	}
	public void setPlan_product(String plan_product) {
		this.plan_product = plan_product;
	}
	public Date getPlan_date() {
		return plan_date;
	}
	public void setPlan_date(Date plan_date) {
		this.plan_date = plan_date;
	}
	public String getPlan_url() {
		return plan_url;
	}
	public void setPlan_url(String plan_url) {
		this.plan_url = plan_url;
	}
	
	
}
