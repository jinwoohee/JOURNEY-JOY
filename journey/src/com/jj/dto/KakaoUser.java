package com.jj.dto;

import java.sql.Date;

public class KakaoUser {
	private Long id;
	private Date connected_at;
	private Object properties;
	private Object kakao_account;
	private String nickname;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public Date getConnected_at() {
		return connected_at;
	}
	public void setConnected_at(Date connected_at) {
		this.connected_at = connected_at;
	}
	public Object getProperties() {
		return properties;
	}
	public void setProperties(Object properties) {
		this.properties = properties;
	}
	public Object getKakao_account() {
		return kakao_account;
	}
	public void setKakao_account(Object kakao_account) {
		this.kakao_account = kakao_account;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	
	
	
}
