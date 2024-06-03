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
import com.jj.dto.DtoPublicInfo1;

public class PublicInfo1 implements JourneyInterface {
	static PublicInfo1 pinfo = new PublicInfo1();
	
	public static PublicInfo1 publicInfo1() {
		return pinfo;
	}

	@Override
	public String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder = factory.newDocumentBuilder();
		Document document = builder.parse("http://www.worldjob.or.kr/openapi/overseasEmployment.do?gubun=A&item=N&year=2018");
		document.getDocumentElement().normalize(); //root tag
		//System.out.println("root elements: "+document.getDocumentElement().getNodeName());
		
		NodeList nlist = document.getDocumentElement().getElementsByTagName("ITEM");
		//System.out.println("파싱할 리스트 개수-----> "+nlist.getLength());
		
		ArrayList<DtoPublicInfo1> nodeList = new ArrayList<DtoPublicInfo1>();
		for (int temp = 0; temp < 15; temp++) {
			Node node = nlist.item(temp);
			if (node.getNodeType() == Node.ELEMENT_NODE) {
				Element element = (Element) node;				
				DtoPublicInfo1 info = new DtoPublicInfo1();
				info.setName(getTagValue("NAME", element));
				info.setCnt(getTagValue("CNT", element));
				info.setRanking(getTagValue("RANKING", element));
				info.setRate(getTagValue("RATE", element));
				
				nodeList.add(info);
			}
		}
		//System.out.println(nodeList.size());
		request.setAttribute("nodeList", nodeList);
		
		return "parseContents.jsp";
	}
	
	public static String getTagValue(String tag, Element element) {
		NodeList nlist = element.getElementsByTagName(tag).item(0).getChildNodes();
		Node node = (Node) nlist.item(0);
		if (node == null)
			return null;
		return node.getNodeValue();
	}
}
