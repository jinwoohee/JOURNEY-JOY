package com.jj.dto;

public class Exchange {
	
	private String cur_unit; //통화코드
	private String cur_nm; //국가, 통화명
	private String tts; //매매
	
	public String getCur_unit() {
		return cur_unit;
	}
	public void setCur_unit(String cur_unit) {
		this.cur_unit = cur_unit;
	}
	public String getCur_nm() {
		return cur_nm;
	}
	public void setCur_nm(String cur_nm) {
		this.cur_nm = cur_nm;
	}
	public String getTts() {
		return tts;
	}
	public void setTts(String tts) {
		this.tts = tts;
	}
}
