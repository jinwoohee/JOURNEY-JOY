package com.jj.inter;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.jj.dao.JourneyInterface;
import com.jj.dto.DtoPublicInfo2;

public class PublicInfo2 implements JourneyInterface {
	static PublicInfo2 pInfo = new PublicInfo2();
	
	public static PublicInfo2 publicInfo2() {
		return pInfo;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document document = builder.parse("https://www.worldjob.or.kr/openapi/openapi.do?dobType=1&dsptcKsco=01&continent=1&epmt61=N&pageIndex=2&showItemListCount=10");
		document.getDocumentElement().normalize(); //root tag
		//System.out.println("root elements: "+document.getDocumentElement().getNodeName());
		
		NodeList nlist = document.getDocumentElement().getElementsByTagName("ITEM");
		//System.out.println("파싱할 리스트 개수-----> "+nlist.getLength());
		
		ArrayList<DtoPublicInfo2> nodeList = new ArrayList<DtoPublicInfo2>();
		for (int temp = 0; temp < nlist.getLength(); temp++) {
			Node node = nlist.item(temp);
			if (node.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) node;
				DtoPublicInfo2 info = new DtoPublicInfo2();
				info.setRctntcSj(getTagValue("rctntcSj", element));
				info.setRctntcSprtQualfCn(getTagValue("rctntcSprtQualfCn", element));
				info.setDsptcNationScd(getTagValue("dsptcNationScd", element));
				info.setDsptcKsco(getTagValue("dsptcKsco", element));
				info.setRctntcEndDe(getTagValue("rctntcEndDe", element));
				
				/*System.out.println("===============");
				System.out.println("공고명 : "+getTagValue("rctntcSj", element));
				System.out.println("업무내용 : "+getTagValue("rctntcSprtQualfCn", element));
				System.out.println("국가 : "+getTagValue("dsptcNationScd", element));
				System.out.println("직종 : "+getTagValue("dsptcKsco", element));
				System.out.println("모집종료기간 : "+getTagValue("rctntcEndDe", element));*/
				
				nodeList.add(info);
			}
		}
		
		request.setAttribute("nodeList", nodeList);
		return "parseContents2.jsp";
	}
	
	public static String getTagValue(String tag, Element element) {
		NodeList nlist = element.getElementsByTagName(tag).item(0).getChildNodes();
		Node node = (Node) nlist.item(0);
		if (node == null)
			return null;
		return node.getNodeValue();
	}
}
