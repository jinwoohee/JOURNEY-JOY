package com.jj.inter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.jj.dao.JourneyInterface;
import com.jj.dto.Exchange;

public class Currency implements JourneyInterface{
	static Currency currency = new Currency();
	
	public static Currency currency() {
		return currency;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		BufferedReader br;
		String line = "";
		JSONParser parser = new JSONParser();
		
		String authKey = "NIUAIe1G1zGmy4coQQYvPT3antBv1Y6x"; //인증키
		String searchDate = new SimpleDateFormat("yyyyMMdd").format(new Date()); //요청날짜
		String dataType = "AP01"; //환율
		
		try {
			//Request URL
			URL url = new URL("https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey="+authKey+"&searchdate=" + searchDate + "&data=" + dataType);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			int status = conn.getResponseCode();
			
			//API호출
			if(status > 299) { //호출 실패 > conn close
				br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
			}else { //호출 성공 > 환율 정보 추출
				br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			}
			
			line = br.readLine();
			
			if(br != null) br.close();
			
		} catch (Exception e) {
	       System.out.println("환율 error ------------ " + e);
	    } 
		
		JSONArray arr = (JSONArray) new JSONParser().parse(line); 
		
		ArrayList<Exchange> exchangeList = new ArrayList<Exchange>();
		
		for(int i=0; i<arr.size(); i++) {
			 JSONObject row = (JSONObject) arr.get(i);
				 Exchange ex = new Exchange();
				 String curr = (String) row.get("cur_unit");
				 if(curr.equals("AUD") || curr.equals("CAD") || curr.equals("CNH") || curr.equals("EUR") || curr.equals("GBP") || curr.equals("HKD") || curr.equals("JPY") || curr.equals("SGD") || curr.equals("USD") || curr.equals("THB")) {
					 ex.setCur_nm((String) row.get("cur_nm"));
					 ex.setCur_unit((String) row.get("cur_unit"));
					 ex.setTts((String) row.get("tts"));
					 
					 exchangeList.add(ex);
				 }
		}

		request.setAttribute("exchangeList", exchangeList);
		return "exchangeList.jsp";
	}

}
