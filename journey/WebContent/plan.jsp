<%@page import="com.jj.dto.Product"%>
<%@page import="com.jj.dto.Ticket"%>
<%@page import="com.jj.dto.Place"%>
<%@page import="com.jj.dto.Eatery"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.jj.dto.Estimate"%>
<%@page import="com.jj.dto.Schedule"%>
<%@page import="com.jj.dto.Account"%>
<%@page import="com.jj.dto.Plan"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.DecimalFormat"%>

<%
request.setCharacterEncoding("utf-8");
	Cookie[] cookies = request.getCookies(); 
%>
<%!
	private String getCookieValue(Cookie[] cookies, String name){
		String value = null;
		if(cookies == null)
			return null;
		for(Cookie cookie : cookies){
			if(cookie.getName().equals(name))
				return cookie.getValue();
		}
		return null;
	}
%>
<% 
DecimalFormat f = new DecimalFormat("###,###,###");
List<Estimate> esti = (List<Estimate>) request.getAttribute("estimate");
List<Schedule> sche = (List<Schedule>) request.getAttribute("schedule");
List<Ticket> tick = (List<Ticket>) request.getAttribute("ticket");
List<Product> prod = (List<Product>) request.getAttribute("product");
List<Place> plac = (List<Place>) request.getAttribute("plaList");
List<Eatery> eate = (List<Eatery>) request.getAttribute("eatList");

String paging = (String) request.getAttribute("paging");

int items = (int) Math.ceil((double) (tick.size()+prod.size())/4);

String e_destination = esti.get(0).gete_destination();
String e_start_date = esti.get(0).gete_start_date();
String e_end_date = esti.get(0).gete_end_date();
String thema = esti.get(0).gete_thema();
String d_thema = esti.get(0).gete_detail_thema();
String volume = esti.get(0).gete_volume();
String food_st = esti.get(0).gete_food_taste();

String [] e_detail_thema = d_thema.split(",");
String [] e_food_taste = food_st.split(",");

String sdt = e_start_date.replaceAll("-", ".");
String edt = e_end_date.replaceAll("-", ".");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
Date sdate = sdf.parse(e_start_date);
Date edate = sdf.parse(e_end_date);
long datecnt = 1+(edate.getTime() - sdate.getTime()) /(1000*60*60*24);
String aaaa = datecnt+"";
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>JourneyJoy_main</title>

	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="css\plan.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>	
	<script type="text/javascript" src="js\plan.js"></script>

	<script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAN8pqDt8WwrtCF3kkPS7Snko0A-RTUns0&callback=initMap&libraries=places&v=weekly"
      defer
    ></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

</head>

<body>
	<!-- menu bar -->
	<jsp:include page="main_header.jsp"></jsp:include>
	<!-- 페이지 섹션 -->
	<section>
	<form action="planner.jj?page=save_plan" method="post"> 
	<div id="content">
	<%
	if(paging != null){
		System.out.println("saas");
		List<Plan> plan = (List<Plan>) request.getAttribute("plan");
		List<Plan> planList = (List<Plan>)request.getAttribute("plan");
		String my_prod = planList.get(0).getPlan_product();

		String [] mp = my_prod.split(",");
		List<Account> accList = (List<Account>)request.getAttribute("account");
		%>
		<input type="hidden" name="day" id="day_count" value="<%=aaaa %>">
		<input type="hidden" id="item" value="<%= items%>">
			<div id="list_text">
				<p id="list_text"></p>
			</div>
			<div id="radio_div">
				<label for="plan_btn" id="plan_radio_1" onclick="change_main('1')">여행계획서</label>			
				<label for="gagyebu_btn" id="plan_radio_2" onclick="change_main('2')">가계부</label>
				<!-- <label for="checklist_btn" id="plan_ra_empty" onclick="change_main('3')"></label> -->
			</div>
			<input type="hidden" name="selected_prod" id="selected_prod" value="<%=my_prod%>">
			<input type="hidden" name="e_no" value="<%=esti.get(0).gete_no()%>">
			<div id="plandiv_1">
				<input type="text" name="plan_subject" placeholder="계획서 제목(최대50자)" maxlength="50" value="<%=plan.get(0).getPlan_title()%>" readonly="true"/>
				<div id="plan_info">
					<p id="city"><%=e_destination %></p>
					<p id="plan_date"><%=sdt %>&nbsp;~&nbsp;<%=edt %></p>
					<p class="list_thema"><%=thema %></p>	
					<%
						for(String st : e_detail_thema){
							
							out.println("<p class='list_thema'>"+st+"</p>");
						}
						for(String ft : e_food_taste){
							out.println("<p class='list_thema'>"+ft+"</p>");
						}
					%>
				</div>
				<div id="plan_div">
					<p class="plan_sub">※여행일정</p>
					<% 
					for(int a = 1 ; a <= datecnt ; a++){
						
					%>
					
					<div class="plan_day">
						<div class="plan_date">
							<p class="day">Day<%=a %></p>
							<p class="date"> </p>
						</div>
						<div class="plan_detail">
						<div class="place_name_div">
							<% 
							int num = a-1;
							String places = sche.get(num).getPlace();
							String [] place_arr = places.split(",");
							out.println("<p class='place_name'>");
							String empty_pl = "";
							String empty_ea = "";
							for(String st : place_arr){
								
								for(Place pl : plac){
									if(pl.getPlac_id().equals(st)){
										out.println("#"+pl.getPlac_name()+" ");
										empty_pl = "1";
									}
								}
								for(Eatery ea : eate){
									if(ea.getEat_id().equals(st)){
										out.println("#"+ea.getEat_name()+" ");
										empty_ea = "2";
									}
								}
							}if(empty_pl.equals("") && empty_ea.equals("")){
								out.println("일정이 없습니다.");
							}
							out.println("</p>");
							%>
							</div>
							<img src="img/icon/arrow_up.png" onclick="close_div(<%=a%>)" id="close<%=a%>"/>
							<img src="img/icon/arrow_down.png" onclick="open_div(<%=a%>)" id="open<%=a%>"/>
						</div>
					</div>
					
					<div id="detail_info<%=a%>">
						<div class="map_info">
							<div id="map<%=a%>">				
							</div>
						</div>
						
						<div class="pl_eat_div">
						<%int i = 0;
							int number;
							for(String st : place_arr){
								for(Place pl : plac){
									if(pl.getPlac_id().equals(st)){
										i++;
										number = a*100+i;
										out.println("<div class='places_"+a+"'><div class='no'>"+i+"</div><div id='plac_name"+number+"'>"+pl.getPlac_name()+"</div></div>");
										out.println("<input type='hidden' name = 'change_value"+a+"' id='change_name"+number+"' value='"+st+"'>");
										out.println("<input type='hidden' name = 'before_value"+a+"' id='before_name"+number+"' value='"+st+"'>");
										
									}
								}
								for(Eatery ea : eate){
									if(ea.getEat_id().equals(st)){
										i++;
										number = a*100+i;
										out.println("<div class='places_"+a+"'><div class='no'>"+i+"</div><div id='plac_name"+number+"'>"+ea.getEat_name()+"</div></div>");
										out.println("<input type='hidden' name = 'change_value"+a+"' id='change_name"+number+"' value='"+st+"'>");
										out.println("<input type='hidden' name = 'before_value"+a+"' id='before_name"+number+"' value='"+st+"'>");
									}
								}
							}
						
						%>
						</div>
					</div>
				
					<%
					}
					%>	
				</div>
				<div id="product">
					<div class="product_add">
						<p class="product_sub">※추가상품</p>
						<table id="product_table">
							<tr>
								<td id="product_sub_name">이름</td>
								<td id="product_sub_sort">종류</td>
								<td id="product_sub_price">가격</td>
							</tr>
							<%
							if(my_prod.equals("")) {%>
								<tr>
									<td id="product_add_name">추가한 상품이 없습니다.</td>
									<td></td>
									<td></td>
								</tr>
							<%} %>
							<% String [] pr_arr = plan.get(0).getPlan_product().split(",");
								for(Product pr : prod){
									String pr_no = pr.getProd_no()+"";
									for(String my_pr : pr_arr){
										if(pr_no.equals(my_pr)){
											%>
											<tr>
												<td id="product_add_name<%=pr_no%>"><%=pr.getProd_name() %></td>
												<td id="product_add_sort<%=pr_no%>"><%=pr.getProd_sort() %></td>
												<td id="product_add_price<%=pr_no%>"><%="￦"+f.format(pr.getProd_price()) %></td>
											</tr>							
											<% 
										}
									}
								}
							%>
							<% 	for(Ticket ti : tick){
									String ti_no = ti.getTick_no()+"";
									for(String my_pr : pr_arr){
										if(ti_no.equals(my_pr)){
											%>
											<tr>
												<td id="product_add_name<%=ti_no%>"><%=ti.getTick_name()%></td>
												<td id="product_add_sort<%=ti_no%>"><%=ti.getTick_sort() %></td>
												<td id="product_add_price<%=ti_no%>"><%="￦"+f.format(ti.getTick_price())%></td>
											</tr>							
											<% 
										}
									}
								}
							%>
						</table>
					</div>
				</div>
					<div id="save_btn_div">
						<a href = "plan_page.jsp?paging=edit_my&e_no=<%=esti.get(0).gete_no()%>"><input type="button" name="edit_plan" value="수정"></a>
					</div>	
					</div>
				<div id="plandiv_2">
					<div id="acc_div0">
					<p class="acc_sub">여행 준비  <input type="button" name="add_acc0" value="비용 추가" onclick="open_acc_div('0')"></p>
					<table id="acc_table0">
						<tr>
							<td><input type="text" readOnly="true" value="카테고리" name="sort"><input type="hidden" name="sort0" value="0"></td>
							<td><input type="text" readOnly="true" value="내용" name="content"><input type="hidden" name="content0" value="0"></td>
							<td><input type="text" readOnly="true" value="결제수단" name="pay_with"><input type="hidden" name="pay_with0" value="0"></td>
							<td><input type="text" readOnly="true" value="금액" name="prices"><input type="hidden" name="prices0" value="0"></td>	
							<input type="hidden" name="curr0" value="a">			
							<td></td>
						</tr>
					<% int rs_z = 0;
					String m_sort = "";
					int m_x = 0;
						for(Account acc : accList){
						if(acc.getAcc_day() == 0){
							if(acc.getAcc_currency().equals("k")){
								m_sort = "￦";
								m_x = 1;
							}else if (acc.getAcc_currency().equals("u")){
								m_sort = " $";
								m_x = 1360;
							}else if (acc.getAcc_currency().equals("j")){
								m_sort = "￥";
								m_x = 9;
							}
						%>
						 <tr>
							<td><input type="text" name="sort0" readOnly="true" value="<%=acc.getAcc_category() %>"></td>
							<td><input type="text" name="content0" readOnly="true" value="<%=acc.getAcc_contents() %>"></td>
							<td><input type="hidden" name="curr0" value="<%=acc.getAcc_currency()%>"><input type="text" name="pay_with0" readOnly="true" value="<%=acc.getAcc_payment() %>"></td>
							<td><input type="text" name="m_emot0" value="<%=m_sort %>"><input type="text" name="prices0" readOnly="true" value="<%=f.format(acc.getAcc_amount()) %>"></td>
							<td><input type="button" name="del_place" value="삭제" onclick="del_pl(this,<%=acc.getAcc_amount()*m_x%>)"></td>
						</tr> 
						<%rs_z += (acc.getAcc_amount()*m_x);}} %>
				</table>
				
				<div id="pay_one_div0">
					<div class="price_div">
						<input type="text" name="acc_price0" id = "acc_price0"placeholder="금액입력" maxlength="15" value="">
						<select name="price_sort0" id ="price_sort0">
                      <option value="k">KRW(원)</option>
                      <option value="u">USD(달러)</option>
                      <option value="j">JPY(엔)</option>                 
                  </select>

					</div>
						<div class="pay_with_div">
						<p class="pay_with_text">결제수단</p>
					 	<select name="pay_with0" id= "pay_with0" >
				 			<option>현금</option>
                     <option>카드</option>
                     <option>기타</option>
                  </select>
                  </div>

                     <input type="text" name="acc_content0" maxlength="25" id= "acc_content0" placeholder="내용을 입력해주세요.">
                
                     <p class="sort_text">카테고리</p>
                      <input type="checkbox" name="acc_sort0" id="acc_sort0" value="숙소" onclick="checking(this.id,0)">
                      <label for="acc_sort0" id="sort_img0"><img src="img/icon/acc_hotel.png" id="sort_img0" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort1" value="항공" onclick="checking(this.id,0)">
                      <label for="acc_sort1" id="sort_img1"><img src="img/icon/acc_airplane.png" id="sort_img1" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort2" value="교통" onclick="checking(this.id,0)">
                      <label for="acc_sort2" id="sort_img2"><img src="img/icon/acc_car.png" id="sort_img2" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort3" value="관광" onclick="checking(this.id,0)">
                      <label for="acc_sort3" id="sort_img3"><img src="img/icon/acc_trip.png" id="sort_img3" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort4" value="식비" onclick="checking(this.id,0)">
                      <label for="acc_sort4" id="sort_img4"><img src="img/icon/acc_food.png" id="sort_img4" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort5" value="쇼핑" onclick="checking(this.id,0)"> 
                      <label for="acc_sort5" id="sort_img5"><img src="img/icon/acc_shopping.png" id="sort_img5" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort6" value="기타" onclick="checking(this.id,0)">
                      <label for="acc_sort6" id="sort_img6"><img src="img/icon/acc_etc.png" id="sort_img6" name="acc0"/></label>
					  
					  <p class="ctg_t">숙소 항공 교통 관광 식비 쇼핑 기타</p>
         			<input type="button" name="close_acc_one0" value="닫기" onclick="close_acc_one('0')">
  					<input type="button" name="add_acc_one0" value="추가하기" onclick="add_acc('0')">
				</div>
				</div> 
				
				<% int rs=0;
					for(int a = 1 ; a <= datecnt ; a++){
					%>	
					<div id="acc_div<%=a%>">
						<p class="acc_sub">Day <%=a%><input type="button" name="add_acc<%=a%>" value="비용 추가" onclick="open_acc_div(<%=a%>)"></p>
						<table id="acc_table<%=a%>">
							<tr>
								<td><input type="text" readOnly="true" value="카테고리" name="sort"><input type="hidden" name="sort<%=a%>" value="0"></td>
								<td><input type="text" readOnly="true" value="내용" name="content"><input type="hidden" name="content<%=a%>" value="0"></td>
								<td><input type="text" readOnly="true" value="결제수단" name="pay_with"><input type="hidden" name="pay_with<%=a%>" value="0"></td>
								<td><input type="text" readOnly="true" value="금액" name="prices"><input type="hidden" name="prices<%=a%>" value="0"></td>
								<input type="hidden" name="curr<%=a %>" value="a">					
								<td></td>
							</tr>
					<%	
						
						for(Account acc : accList){
							if(acc.getAcc_day() == a){
								if(acc.getAcc_currency().equals("k")){
									m_sort = "￦";
									m_x = 1;
								}else if (acc.getAcc_currency().equals("u")){
									m_sort = " $";
									m_x = 1360;
								}else if (acc.getAcc_currency().equals("j")){
									m_sort = "￥";
									m_x = 9;
								}
								
				%>	 
							<tr>
								<td><input type="text" name="sort<%=a%>" readOnly="true" value="<%=acc.getAcc_category() %>"></td>
								<td><input type="text" name="content<%=a%>" readOnly="true" value="<%=acc.getAcc_contents() %>"></td>
								<td><input type="hidden" name="curr<%=a %>" value="<%=acc.getAcc_currency()%>"><input type="text" name="pay_with<%=a%>" readOnly="true" value="<%=acc.getAcc_payment() %>"></td>
								<td><input type="text" name="m_emot<%=a%>" value="<%=m_sort %>"><input type="text" name="prices<%=a%>" readOnly="true" value="<%=f.format(acc.getAcc_amount()) %>"></td>
								<td><input type="button" name="del_place" value="삭제" onclick="del_pl(this,<%=acc.getAcc_amount()*m_x%>)"></td>
							</tr>
				<%rs += (acc.getAcc_amount()*m_x);}} %>
				</table>
				<div id="pay_one_div<%=a%>">
					<div class="price_div">
						<input type="text" name="acc_price<%=a%>" id = "acc_price<%=a%>"placeholder="금액입력" maxlength="15" value="">
						<select name="price_sort<%=a%>" id ="price_sort<%=a%>">
                      <option value="k">KRW(원)</option>
                      <option value="u">USD(달러)</option>
                      <option value="j">JPY(엔)</option>                 
                  </select>

					</div>
						<div class="pay_with_div">
						<p class="pay_with_text">결제수단</p>
					 	<select name="pay_with<%=a%>" id= "pay_with<%=a%>" >
				 			<option>현금</option>
                     <option>카드</option>
                     <option>기타</option>
                  </select>
                  </div>

                     <input type="text" name="acc_content<%=a%>" maxlength="25" id= "acc_content<%=a%>" placeholder="내용을 입력해주세요.">
                
                     <p class="sort_text">카테고리</p>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts1_<%=a %>" value="숙소" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts1_<%=a %>" id="sort_img0_<%=a%>"><img src="img/icon/acc_hotel.png" id="sort_img0_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts2_<%=a %>" value="항공" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts2_<%=a %>" id="sort_img1_<%=a%>"><img src="img/icon/acc_airplane.png" id="sort_img1_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts3_<%=a %>" value="교통" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts3_<%=a %>" id="sort_img2_<%=a%>"><img src="img/icon/acc_car.png" id="sort_img2_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts4_<%=a %>" value="관광" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts4_<%=a %>" id="sort_img3_<%=a%>"><img src="img/icon/acc_trip.png" id="sort_img3_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts5_<%=a %>" value="식비" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts5_<%=a %>" id="sort_img4_<%=a%>"><img src="img/icon/acc_food.png" id="sort_img4_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts6_<%=a %>" value="쇼핑" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts6_<%=a %>" id="sort_img5_<%=a%>"><img src="img/icon/acc_shopping.png" id="sort_img5_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts7_<%=a %>" value="기타" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts7_<%=a %>" id="sort_img6_<%=a%>"><img src="img/icon/acc_etc.png"  id="sort_img6_<%=a%>" name="acc<%=a%>" /></label>
						
					  <p class="ctg_t">숙소 항공 교통 관광 식비 쇼핑 기타</p>
         			<input type="button" name="close_acc_one<%=a %>" value="닫기" onclick="close_acc_one(<%=a%>)">
  					<input type="button" name="add_acc_one<%=a%>" value="추가하기" onclick="add_acc(<%=a%>)">
				</div>
				</div>
				<%} %>
				<input type="hidden" id="result_price" value="<%=rs_z+rs %>">
				
				<div id="acc_result_div">
				<span id= "result_price_text"><%=f.format(rs_z+rs) %></span>원
				</div>
  
				<input type="submit" name="save_acc" value="저장">
			</div>
		
			<%}else{ %>
	<input type="hidden" id="item" value="<%= items%>">
	<input type="hidden" name="day" value="<%=aaaa %>">
			<div id="list_text">
				<p id="list_text"></p>
			</div>
			<div id="radio_div">
				<label for="plan_btn" id="plan_radio_1" onclick="change_main('1')">여행계획서</label>			
				<label for="gagyebu_btn" id="plan_radio_2" onclick="change_main('2')">가계부</label>
				<!-- <label for="checklist_btn" id="plan_radio_3" onclick="change_main('3')">체크리스트</label> -->
			</div>
			<input type="hidden" name="selected_prod" id="selected_prod" value="">
			<input type="hidden" name="e_no" value="<%=esti.get(0).gete_no()%>">
			<div id="plandiv_1">
				<input type="text" name="plan_subject" placeholder="계획서 제목(최대50자)" maxlength="50" value="<%=esti.get(0).getu_id()%>의 <%=esti.get(0).gete_destination() %>여행계획서"/>
				<div id="plan_info">
					<p id="city"><%=e_destination %></p>
					<p id="plan_date"><%=sdt %>&nbsp;~&nbsp;<%=edt %></p>
					<p class="list_thema"><%=thema %></p>	
					<%
						for(String st : e_detail_thema){
							out.println("<p class='list_thema'>"+st+"</p>");
						}
						for(String ft : e_food_taste){
							out.println("<p class='list_thema'>"+ft+"</p>");
						}
					%>
				</div>
				<div id="plan_div">
					<p class="plan_sub">※여행일정</p>
					<% 
					for(int a = 1 ; a <= datecnt ; a++){
						
					%>
					
					<div class="plan_day">
						<div class="plan_date">
							<p class="day"><%=a %>일차</p>
							<p class="date"> </p>
						</div>
						<div class="plan_detail">
						<div class="place_name_div">
							<% 
							int num = a-1;
							String places = sche.get(num).getPlace();
							String [] place_arr = places.split(",");
							out.println("<p class='place_name'>");
							String empty_pl = "";
							String empty_ea = "";
							for(String st : place_arr){
								System.out.println("hh"+st);
								for(Place pl : plac){
									if(pl.getPlac_id().equals(st)){
										System.out.println(pl.getPlac_name());
										out.println("#"+pl.getPlac_name()+" ");
										empty_pl = "1";
									}
								}
								for(Eatery ea : eate){
									if(ea.getEat_id().equals(st)){
										out.println("#"+ea.getEat_name()+" ");
										empty_ea = "2";
									}
								}
							}if(empty_pl.equals("") && empty_ea.equals("")){
								out.println("일정이 없습니다.");
							}
							out.println("</p>");
							%>
							</div>
							<img src="img/icon/arrow_up.png" onclick="close_div(<%=a%>)" id="close<%=a%>"/>
							<img src="img/icon/arrow_down.png" onclick="open_div(<%=a%>)" id="open<%=a%>"/>
						</div>
					</div>
					
					<div id="detail_info<%=a%>">
							<div id="map<%=a%>" name = "maps">
							</div>
						
						<div class="pl_eat_div">
						<%int i = 0;
							int number;
							for(String st : place_arr){
								for(Place pl : plac){
									if(pl.getPlac_id().equals(st)){
										i++;
										number = a*100+i;
										out.println("<div class='places_"+a+"'><div class='no'>"+i+"</div><div id='plac_name"+number+"'>"+pl.getPlac_name()+"</div><div class='up_down_btn'><img src='img/icon/arrow_up.png' class='up' onclick='up_pla("+number+")'><img src='img/icon/arrow_down.png' class='down' onclick='down_pla("+number+")'></div></div>");
										out.println("<input type='hidden' name = 'change_value"+a+"' id='change_name"+number+"' value='"+st+"'>");
										out.println("<input type='hidden' name = 'before_value"+a+"' id='before_name"+number+"' value='"+st+"'>");
										
									}
								}
								for(Eatery ea : eate){
									if(ea.getEat_id().equals(st)){
										i++;
										number = a*100+i;
										out.println("<div class='places_"+a+"'><div class='no'>"+i+"</div><div id='plac_name"+number+"'>"+ea.getEat_name()+"</div><div class='up_down_btn'><img src='img/icon/arrow_up.png' class='up' onclick='up_pla("+number+")'><img src='img/icon/arrow_down.png' class='down' onclick='down_pla("+number+")'></div></div>");
										out.println("<input type='hidden' name = 'change_value"+a+"' id='change_name"+number+"' value='"+st+"'>");
										out.println("<input type='hidden' name = 'before_value"+a+"' id='before_name"+number+"' value='"+st+"'>");
									}
								}
							}
						
						%>
						</div>
					</div>
				
					<%
					}
					%>	
				</div>
				<div id="product">
					<div class="product_add">
						<p class="product_sub">※추가상품</p>
						<table id="product_table">
							<tr>
								<td id="product_sub_name">이름</td>
								<td id="product_sub_sort">종류</td>
								<td id="product_sub_price">가격</td>
								<td id="del">삭제</td>
							</tr>
							<tr id="sel_prod_plz">
								<td><p id="product_add_name">추가한 상품이 없습니다.</p></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</div>
					<div class="product_add">
						<p class="product_add_sub">※이런 상품은 어떠세요?</p>				
						<div id="item_div">
						<div id = "slide_div">
						<div class = "kind_slider">
						<ul class="slider">
						<li id="plan_li">							
							<div class="product_adv">
						<%
							for(Ticket ti : tick){	
						%>
							<div id="product_item<%=ti.getTick_no()%>">
								<img src="img/tick_prod/<%=ti.getTick_file() %>"  class="tick_prod" />
								<table id="product_tb<%=ti.getTick_no()%>">
									<tr>
										<td colspan='2' name="prod_name" id="product_name<%=ti.getTick_no()%>"><%=ti.getTick_name() %></td>
									</tr>
									<tr>
										<td name="prod_price" id="product_price<%=ti.getTick_no()%>" ><%="￦"+f.format(ti.getTick_price()) %>
										<img src="img/icon/plus.png" onclick="add_prod(<%=ti.getTick_no()%>)"/>
										</td>
									</tr>
								</table>
								<input type="hidden" id="product_sort<%=ti.getTick_no()%>" value="<%=ti.getTick_sort()%>">
								<input type="hidden" id="product_no<%=ti.getTick_no()%>" value="<%=ti.getTick_no()%>">	
							</div>
						<%}
						
						for(Product pro : prod){

						%>
							<div id="product_item<%=pro.getProd_no()%>">
								<img src="img/tick_prod/<%=pro.getProd_file() %>" class="tick_prod"/>
								<table id="product_tb<%=pro.getProd_no()%>">
									<tr>
										<td colspan='2' name="prod_name" id="product_name<%=pro.getProd_no()%>"><%=pro.getProd_name() %></td>
									</tr>

									<tr>
										<td name="prod_price" id="product_price<%=pro.getProd_no()%>" ><%="￦"+f.format(pro.getProd_price()) %>
											<img src="img/icon/plus.png" onclick="add_prod(<%=pro.getProd_no()%>)"/>											
										</td>
									</tr>
								</table>
								<input type="hidden" id="product_sort<%=pro.getProd_no()%>" value="<%=pro.getProd_sort()%>">
								<input type="hidden" id="product_no<%=pro.getProd_no()%>" value="<%=pro.getProd_no()%>">	
							</div>
						<%} %> 
							</div>

						</li>
						</ul>
						</div>
						</div>
							<img src="img/icon/arrows_right_black.png" id="right">
							<img src="img/icon/arrows_left_black.png" id="left">
						</div>	
					</div>
				</div>
			<div id="save_btn_div">
					<input type="submit" name="save_plan" value="저장">
					</div>
		</div>
		<div id="plandiv_2">
					<div id="acc_div0">
					<p class="acc_sub">여행 준비  <input type="button" name="add_acc0" value="비용 추가" onclick="open_acc_div('0')"></p>
					<table id="acc_table0">
						<tr>
							<td><input type="text" readOnly="true" value="카테고리" name="sort"><input type="hidden" name="sort0" value="0"></td>
							<td><input type="text" readOnly="true" value="내용" name="content"><input type="hidden" name="content0" value="0"></td>
							<td><input type="text" readOnly="true" value="결제수단" name="pay_with"><input type="hidden" name="pay_with0" value="0"></td>
							<td><input type="text" readOnly="true" value="금액" name="prices"><input type="hidden" name="prices0" value="0"></td>		
							<input type="hidden" name="curr0" value="a">			
							<td></td>
						</tr>
					</table>	
				<div id="pay_one_div0">
					<div class="price_div">
						<input type="text" name="acc_price0" id = "acc_price0"placeholder="금액입력" maxlength="15" value="">
						<select name="price_sort0" id ="price_sort0">
                      <option value="k">KRW(원)</option>
                      <option value="u">USD(달러)</option>
                      <option value="j">JPY(엔)</option>                   
                  </select>

					</div>
						<div class="pay_with_div">
						<p class="pay_with_text">결제수단</p>
					 	<select name="pay_with0" id= "pay_with0" >
				 			<option>현금</option>
                     <option>카드</option>
                     <option>기타</option>
                  </select>
                  </div>

                     <input type="text" name="acc_content0" maxlength="25" id= "acc_content0" placeholder="내용을 입력해주세요.">
                
                     <p class="sort_text">카테고리</p>
                      <input type="checkbox" name="acc_sort0" id="acc_sort0" value="숙소" onclick="checking(this.id,0)">
                      <label for="acc_sort0" id="sort_img0"><img src="img/icon/acc_hotel.png" id="sort_img0" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort1" value="항공" onclick="checking(this.id,0)">
                      <label for="acc_sort1" id="sort_img1"><img src="img/icon/acc_airplane.png" id="sort_img1" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort2" value="교통" onclick="checking(this.id,0)">
                      <label for="acc_sort2" id="sort_img2"><img src="img/icon/acc_car.png" id="sort_img2" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort3" value="관광" onclick="checking(this.id,0)">
                      <label for="acc_sort3" id="sort_img3"><img src="img/icon/acc_trip.png" id="sort_img3" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort4" value="식비" onclick="checking(this.id,0)">
                      <label for="acc_sort4" id="sort_img4"><img src="img/icon/acc_food.png" id="sort_img4" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort5" value="쇼핑" onclick="checking(this.id,0)"> 
                      <label for="acc_sort5" id="sort_img5"><img src="img/icon/acc_shopping.png" id="sort_img5" name="acc0"/></label>
                      <input type="checkbox" name="acc_sort0" id="acc_sort6" value="기타" onclick="checking(this.id,0)">
                      <label for="acc_sort6" id="sort_img6"><img src="img/icon/acc_etc.png" id="sort_img6" name="acc0"/></label>
					  
					  <p class="ctg_t">숙소 항공 교통 관광 식비 쇼핑 기타</p>
         			<input type="button" name="close_acc_one0" value="닫기" onclick="close_acc_one('0')">
  					<input type="button" name="add_acc_one0" value="추가하기" onclick="add_acc('0')">
				</div>
				</div>
				
				<% int rs=0;
					for(int a = 1 ; a <= datecnt ; a++){
					%>	
					<div id="acc_div<%=a%>">
						<p class="acc_sub">Day <%=a%><input type="button" name="add_acc<%=a%>" value="비용 추가" onclick="open_acc_div(<%=a%>)"></p>
						<table id="acc_table<%=a%>">
							<tr>
								<td><input type="text" readOnly="true" value="카테고리" name="sort"><input type="hidden" name="sort<%=a%>" value="0"></td>
								<td><input type="text" readOnly="true" value="내용" name="content"><input type="hidden" name="content<%=a%>" value="0"></td>
								<td><input type="text" readOnly="true" value="결제수단" name="pay_with"><input type="hidden" name="pay_with<%=a%>" value="0"></td>
								<td><input type="text" readOnly="true" value="금액" name="prices"><input type="hidden" name="prices<%=a%>" value="0"></td>
								<input type="hidden" name="curr<%=a %>" value="a">						
								<td></td>
							</tr>

				</table>
				<div id="pay_one_div<%=a%>">
					<div class="price_div">
						<input type="text" name="acc_price<%=a%>" id = "acc_price<%=a%>"placeholder="금액입력" maxlength="15" value="">
						<select name="price_sort<%=a%>" id ="price_sort<%=a%>">
                      <option value="k">KRW(원)</option>
                      <option value="u">USD(달러)</option>
                      <option value="j">JPY(엔)</option>                   
                  </select>

					</div>
						<div class="pay_with_div">
						<p class="pay_with_text">결제수단</p>
					 	<select name="pay_with<%=a%>" id= "pay_with<%=a%>" >
				 			<option>현금</option>
                     <option>카드</option>
                     <option>기타</option>
                  </select>
                  </div>

                     <input type="text" name="acc_content<%=a%>" maxlength="25" id= "acc_content<%=a%>" placeholder="내용을 입력해주세요.">
                
                     <p class="sort_text">카테고리</p>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts1_<%=a %>" value="숙소" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts1_<%=a %>" id="sort_img0_<%=a%>"><img src="img/icon/acc_hotel.png" id="sort_img0_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts2_<%=a %>" value="항공" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts2_<%=a %>" id="sort_img1_<%=a%>"><img src="img/icon/acc_airplane.png" id="sort_img1_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts3_<%=a %>" value="교통" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts3_<%=a %>" id="sort_img2_<%=a%>"><img src="img/icon/acc_car.png" id="sort_img2_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts4_<%=a %>" value="관광" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts4_<%=a %>" id="sort_img3_<%=a%>"><img src="img/icon/acc_trip.png" id="sort_img3_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts5_<%=a %>" value="식비" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts5_<%=a %>" id="sort_img4_<%=a%>"><img src="img/icon/acc_food.png" id="sort_img4_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts6_<%=a %>" value="쇼핑" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts6_<%=a %>" id="sort_img5_<%=a%>"><img src="img/icon/acc_shopping.png" id="sort_img5_<%=a%>" name="acc<%=a%>"/></label>
                      <input type="checkbox" name="acc_sort<%=a%>" id="acc_sorts7_<%=a %>" value="기타" onclick="checking(this.id,<%=a%>)">
                      <label for="acc_sorts7_<%=a %>" id="sort_img6_<%=a%>"><img src="img/icon/acc_etc.png" id="sort_img6_<%=a%>"name="acc<%=a%>"/></label>

					  <p class="ctg_t">숙소 항공 교통 관광 식비 쇼핑 기타</p>
         			<input type="button" name="close_acc_one<%=a %>" value="닫기" onclick="close_acc_one(<%=a%>)">
  					<input type="button" name="add_acc_one<%=a%>" value="추가하기" onclick="add_acc(<%=a%>)">
				</div>
				</div>
				<%} %>
				<input type="hidden" id="result_price" value="<%=rs %>">
				<div id="acc_result_div">
				<span id= "result_price_text"><%=f.format(rs) %></span>원
				</div>
				<input type="submit" name="save_acc" value="저장">
			
		<%} %>
		
		</div>
	
		</div>
		</form>
	</section>

	<footer>
		<jsp:include page="main_footer.jsp" />	
	</footer>
</body>
</html>