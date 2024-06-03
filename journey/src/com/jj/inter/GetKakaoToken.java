package com.jj.inter;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;

public class GetKakaoToken {
	
	public static String getKakaoToken(String code) throws Exception {
		String result = "";
				
		try {
			URL url = new URL("https://kauth.kakao.com/oauth/token");			
			
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
	        conn.setDoOutput(true);
			conn.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
			//System.out.println(conn.getResponseCode());
			
			StringBuilder builder = new StringBuilder();
			builder.append("grant_type=authorization_code");
			builder.append("&client_id=97d3d4fdd304333d14ac189994d057ea");
			builder.append("&redirect_uri=http://localhost:8091/journey/oauth.jj?page=kakaoLogin");
			builder.append("&code=" + code);

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
