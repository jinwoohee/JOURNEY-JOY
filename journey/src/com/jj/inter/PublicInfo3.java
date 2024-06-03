package com.jj.inter;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.jj.dao.JourneyInterface;
import com.jj.dto.DtoPublicInfo3;

public class PublicInfo3 implements JourneyInterface {
	static PublicInfo3 pInfo = new PublicInfo3();
	
	public static PublicInfo3 publicInfo3() {
		return pInfo;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String result = "";
		
		try {
			String apiUrl = "https://apis.data.go.kr/B410001/kotra_overseasMarketNews/ovseaMrktNews/ovseaMrktNews";
			apiUrl += "?serviceKey=BcOuiLozBFvAa1JfaDYPcaprIZrtOjwBNIZBTzNRvUJ8odWwgzDUsuFyPHQTUwBdBIx03uYH5CjVQY4Qlp4VlA%3D%3D"; //serviceKey
			apiUrl += "&type=json&numOfRows=10&pageNo=1&search5=I001205&search6=JOB.A"; //serch5-산업분류(IT), search6-일자리동향(취업)
			
			URL url = new URL(apiUrl);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			int responseCode = conn.getResponseCode(); //응답코드
			
			try {
				BufferedReader br;
				
				if(responseCode == 200) { //정상 호출
					br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
				} else { //에러 발생
					br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
				}
				
				result = br.readLine();
				
				if (br != null)
					br.close();
			} catch (Exception e) {
				System.out.println("bufferedreader Error----->"+e);
			}
			
			//System.out.println("result: "+result);
		} catch (Exception e) {
			System.out.println("PublicInfo3 Error----->"+e);
		}
		
		JSONObject jsonObject = (JSONObject) new JSONParser().parse(result);
		JSONObject rp = (JSONObject) jsonObject.get("response");
		JSONObject body = (JSONObject) rp.get("body");
		JSONObject itemList = (JSONObject) body.get("itemList");
		JSONArray item = (JSONArray) itemList.get("item");
		
		ArrayList<DtoPublicInfo3> plist = new ArrayList<DtoPublicInfo3>();
		for (int i = 0; i < item.size(); i++) {
			JSONObject row = (JSONObject) item.get(i);
			String line = "";
			line += row.get("newsTitl") + "@"; //뉴스제목
			line += row.get("cntntSumar") + "@"; //내용요약
			line += row.get("natn") + "@"; //국가
			line += row.get("regn") + "@"; //지역
			line += row.get("kotraNewsUrl") + "@"; //뉴스url
			line = line.substring(0, line.length() - 1);
			
			String[] arr = line.split("@");
			DtoPublicInfo3 info = new DtoPublicInfo3();
			info.setNewsTitl(arr[0]);
			info.setCntntSumar(arr[1]);
			info.setNatn(arr[2]);
			info.setRegn(arr[3]);
			info.setKotraNewsUrl(arr[4]);
			
			plist.add(info);
		}
		//System.out.println(plist.size());
		
		request.setAttribute("plist", plist);
		return "parseContents3.jsp";
	}
}
