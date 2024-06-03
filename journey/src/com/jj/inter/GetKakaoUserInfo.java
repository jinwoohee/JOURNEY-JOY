package com.jj.inter;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jj.dto.KakaoToken;

public class GetKakaoUserInfo {
	
	public static KakaoToken getKakaoUserInfo(String result) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		KakaoToken kakaoToken = mapper.readValue(result, KakaoToken.class);
		//System.out.println(kakaoToken.getAccess_token());
		
		return kakaoToken;
	}

}
