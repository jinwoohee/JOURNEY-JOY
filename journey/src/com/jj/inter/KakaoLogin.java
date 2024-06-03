package com.jj.inter;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.ws.spi.http.HttpHandler;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jj.dao.JourneyInterface;
import com.jj.dto.KakaoToken;
import com.jj.dto.KakaoUser;
import com.mysql.cj.xdevapi.JsonParser;

public class KakaoLogin implements JourneyInterface {
	static KakaoLogin kLogin = new KakaoLogin();
	
	public static KakaoLogin kakaoLogin() {
		return kLogin;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String code = request.getParameter("code");
		//System.out.println(code);
		String result = GetKakaoToken.getKakaoToken(code);
		KakaoToken kakaoToken = GetKakaoUserInfo.getKakaoUserInfo(result);
		String access_token =  kakaoToken.getAccess_token();
		String user = "", line = "";
		
		try {
			URL url = new URL("https://kapi.kakao.com/v2/user/me");
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	        conn.setRequestProperty("Authorization", "Bearer "+access_token);
	        
	        try {
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				while ((line = br.readLine()) != null) {
					user += line;
				}
				
				if (br != null)
					br.close();
			} catch (Exception e) {
				System.out.println("bufferedreader2----->"+e);
			}
	        
	        System.out.println("user: "+user);
		} catch (Exception e) {
			System.out.println("userInfoError----->"+e);
		}
		
		ObjectMapper mapper = new ObjectMapper();
		KakaoUser ku = mapper.readValue(user, KakaoUser.class);
		
		String[] str = ku.getProperties().toString().split("=");
		ku.setNickname(str[1].replaceAll("}", ""));
		//System.out.println(ku.getNickname());
		
		HttpSession session = request.getSession();
		session.setAttribute("u_id", String.valueOf(ku.getId()));
		
		
		return "index.jsp";
	}
	
	
}
