package com.jj.dto;

public class Departure_csv { /* csv파일 */
	private String nation; //국가
	private int sum;       //월별 출국자 합계
	
	public String getNation() {
		return nation;
	}
	public void setNation(String nation) {
		this.nation = nation;
	}
	public int getSum() {
		return sum;
	}
	public void setSum(int sum) {
		this.sum = sum;
	}
}
