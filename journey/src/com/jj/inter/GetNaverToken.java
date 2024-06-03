package com.jj.inter;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

public class GetNaverToken {
	
	public static String getNaverToken(String code, String state) {
		String result = "";
		String clientId = "lEYwWdovBT_X9ayS_3P9";
	    String clientSecret = "nPnw91uySk";
		
		try {
			URL url = new URL("https://nid.naver.com/oauth2.0/token");
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
	        conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
	        
	        StringBuilder builder = new StringBuilder();
	        builder.append("grant_type=authorization_code");
	        builder.append("&client_id=" + clientId);
			builder.append("&client_secret=" + clientSecret);
			builder.append("&code=" + code);
			builder.append("&state=" + state);
			
			try {
				BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
				bw.write(builder.toString());
				bw.flush();	
			} catch (Exception e) {
				System.out.println("bufferedwriter------>"+e);
			}
			
			String line = "";
			try {
				BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				while ((line = br.readLine()) != null) {
					result += line;
				}
				
				if (br != null)
					br.close();
			} catch (Exception e) {
				System.out.println("bufferedreader------>"+e);
			}
			
			//System.out.println("result: " + result);			
		} catch (Exception e) {
			System.out.println("tokenError------>"+e);
		}
		return result;
	}
}
