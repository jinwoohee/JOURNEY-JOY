package com.jj.inter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jj.dto.NaverToken;

public class GetNaverUserInfo {
	
	public static NaverToken getNaverUserInfo(String result) throws Exception {
		ObjectMapper mapper = new ObjectMapper();
		NaverToken naverToken = mapper.readValue(result, NaverToken.class);
		
		return naverToken;
	}
}
