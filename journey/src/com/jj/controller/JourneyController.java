package com.jj.controller;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jj.dao.JourneyInterface;
import com.jj.inter.ClassApply;
import com.jj.inter.ClassApplyDelete;
import com.jj.inter.ClassInsert;
import com.jj.inter.ClassListSelect;
import com.jj.inter.ClassSearch;
import com.jj.inter.ClassTabSelect;
import com.jj.inter.CommInsert;
import com.jj.inter.Currency;
import com.jj.inter.EaterySelect;
import com.jj.inter.EstimateInsert;
import com.jj.inter.EstimateSelect;
import com.jj.inter.InquiryUpdateFlag;
import com.jj.inter.KakaoLogin;
import com.jj.inter.InquiryFlag;
import com.jj.inter.InquiryInsert;
import com.jj.inter.InquiryNotice;
import com.jj.inter.LikeDelete;
import com.jj.inter.LikeInsert;
import com.jj.inter.MypageLikeSelect;
import com.jj.inter.MypagePackageSelect;
import com.jj.inter.MypagePlaceReviewSelect;
import com.jj.inter.MypagePlanReviewSelect;
import com.jj.inter.MypagePlannerSelect;
import com.jj.inter.MypagePurchaseSelect;
import com.jj.inter.MypageUserInfoSelect;
import com.jj.inter.NaverLogin;
import com.jj.inter.PackageDetail;
import com.jj.inter.PackageInsert;
import com.jj.inter.PackageSearch;
import com.jj.inter.PackageSelect;
import com.jj.inter.PageInfo;
import com.jj.inter.PlaceReviewSearch;
import com.jj.inter.PlaceSearch;
import com.jj.inter.PlanDelete;
import com.jj.inter.PlanInsert;
import com.jj.inter.PlanReviewSearch;
import com.jj.inter.PlanSelect;
import com.jj.inter.PlanUpdate;
import com.jj.inter.Plan_reviewTabSelect;
import com.jj.inter.PsInsert;
import com.jj.inter.PublicInfo1;
import com.jj.inter.PublicInfo2;
import com.jj.inter.PublicInfo3;
import com.jj.inter.PurchaseDelete;
import com.jj.inter.PurchaseInsert;
import com.jj.inter.RewardInsert;
import com.jj.inter.ScheduleInsert;
import com.jj.inter.ScheduleUpdate;
import com.jj.inter.SearchPlaceSelect;
import com.jj.inter.WhClear;
import com.jj.inter.WhSearch;
import com.jj.inter.WhSelect;
import com.jj.inter.WhlistSelect;

public class JourneyController extends HttpServlet {
	public void	service(HttpServletRequest request, HttpServletResponse response) {
		String page = request.getParameter("page");
		JourneyInterface ji;
		
		if (page.equals("wh")) { //워홀 전체 select
			ji = WhSelect.whselect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("whlist")) { //워홀 1개만 select
			ji = WhlistSelect.whlistselect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("whsearch")) { //워홀 검색창 조건에 따른 select
			ji = WhSearch.whsearch();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("whclear")) { //워홀 검색창 초기화
			ji = WhClear.whclear();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("mypagePackageMaking")) { //마이페이지-패키지 기획내역
			ji = MypagePackageSelect.mypagePackageSelect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("mypagePackageAttending")) { //마이페이지-패키지 참여내역
			ji = MypagePurchaseSelect.mypagePurchaseSelect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("mypagePackageLike")) { //마이페이지-찜한 패키지
			ji = MypageLikeSelect.mypageLikeSelect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("mypagePlanReview")) { //마이페이지-일정리뷰
			ji = MypagePlanReviewSelect.mypagePlanReviewSelect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("mypagePlaceReview")) { //마이페이지-장소리뷰
			ji = MypagePlaceReviewSelect.mypagePlaceReviewSelect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("mypageUserInfo")) { //마이페이지-회원정보수정
			ji = MypageUserInfoSelect.mypageUserInfoSelect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("mypagePlanner")) { //마이페이지-여행계획서
			ji = MypagePlannerSelect.mypagePlannerSelect();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("naverLogin")) { //네이버 로그인
			ji = NaverLogin.naverLogin();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}			
		} else if (page.equals("kakaoLogin")) { //카카오 로그인
			ji = KakaoLogin.kakaoLogin();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("publicInfo1")) { //워홀 sideBar(해외취업 통계정보)
			ji = PublicInfo1.publicInfo1();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("publicInfo2")) { //워홀 sideBar(해외취업 모집공고 정보)
			ji = PublicInfo2.publicInfo2();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("publicInfo3")) { //워홀 sideBar(해외취업 News 소식)
			ji = PublicInfo3.publicInfo3();
			try {
				String url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		
		
		
		
		//진수님 부분
		else if(page.equals("insert")) {
			ji = EstimateInsert.insertEstimate();
			try {
				System.out.println("0번");
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
			}
			
		}else if(page.equals("plan")) {
			ji = EaterySelect.select_eat();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}else if(page.equals("place_search")) {
			ji = SearchPlaceSelect.search_place();			
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response);
			} catch (Exception e) {
				// TODO: handle exception
			}
		}else if(page.equals("schedule_insert")) { 
			ji = ScheduleInsert.insertSchedule();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}else if(page.equals("select")) {
			ji = EstimateSelect.selectEstimate();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}else if(page.equals("save_plan")) {
			ji = PlanInsert.insertPlan();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }save_plan
			}
		}else if(page.equals("plan_select")) {
			ji = PlanSelect.selectPlan();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}else if(page.equals("plan_delete")) {
			ji = PlanDelete.deletePlan();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}else if(page.equals("plan_update")) { 
			ji = PlanUpdate.updatePlan();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}else if(page.equals("schedule_update")) {
			ji = ScheduleUpdate.updateSchedule();
			System.out.println("컨트롤러");
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}
		else if(page.equals("plan_reviewTab")) {
			ji = Plan_reviewTabSelect.plan_reviewTabSelect();
			try {
				String page_url = ji.journeyInterface(request, response);
				request.getRequestDispatcher(page_url).forward(request, response); 
			} catch(Exception e) { 
				// TODO: handle exception } }
			}
		}
		
		
		//윤영 부분
		else if(page.equals("packageInsert")) { //패키지 insert
			ji = PackageInsert.packageInsertinter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 패키지 insert ---" + e);
			}
		}else if(page.equals("packageSelect")) { //패키지 리스트 select
			ji = PackageSelect.packageSelectInter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 패키지 select ---" + e);
			}
			
		}else if(page.equals("packageSearch")) { //패키지 검색 select
			ji = PackageSearch.packageSearchInter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 패키지 검색 ---" + e);
			}
		}else if(page.equals("package_scheduleInsert")) { //일정 insert
			ji = PsInsert.scheduleInsertinter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				response.sendRedirect(result);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 일정 insert ---" + e);
			}
			
		}else if(page.equals("rewardInsert")) { //금액 insert
			ji = RewardInsert.rewardInsert();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 리워드 insert ---" + e);
			}
			
		}else if(page.equals("package_detail")) { //패키지 상세보기
			ji = PackageDetail.packageDetailInter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 패키지 상세보기 ---" + e);
			}
			
		}else if(page.equals("like_insert")) { //찜하기
			ji = LikeInsert.likeInsertinter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / like insert ---" + e);
			}
			
		}else if(page.equals("like_delete")) { //찜하기해제
			ji = LikeDelete.likeDeleteinter();
			String result; 
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / like delete ---" + e);
			}
			
		}else if(page.equals("purchase")) {//구매하기
			ji = PurchaseInsert.purchaseInsert();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 구매하기 ---" + e);
			}
			
		}else if(page.equals("purchase_delete")) { //구매취소
			ji = PurchaseDelete.pDeleteinter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 구매취소 ---" + e);
			}
		}else if(page.equals("commInsert")) { //패키지 댓글
			ji = CommInsert.commentInsert();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("--- Controller / 댓글 insert ---" + e);
			}
		} else if (page.equals("inquiryInsert")) {//패키지 문의하기
			ji = InquiryInsert.inquiryInsert();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("inquiry_notice")) { //문의하기 알림내용
			ji = InquiryNotice.inquiryNotice();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("inquiry_flag")) { //문의하기 구분자확인
			ji = InquiryFlag.inquiryFlag();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else if (page.equals("inquiry_updateFlag")) { //문의하기 구분자바꾸기
			ji = InquiryUpdateFlag.inquiryUpdateFlag();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("controller updatFlag 에러---------->"+e);
			}
		}else if(page.equals("placeReviewSearch")) {//장소리뷰 검색
			ji = PlaceReviewSearch.placeReviewSearchInter();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 장소리뷰검색 ---" + e);
			}
		}else if(page.equals("classInsert")) {//모임 등록하기
			ji = ClassInsert.classInsert();
			String result;
			try {
				result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 모임 insert ---" + e);
			}
		}else if (page.equals("clist")) { //모임 select
			ji = ClassListSelect.classlistselect();
			try {
				String result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 모임 select ---" + e);
			}
		}else if(page.equals("classTab")) { //모임 탭
			ji = ClassTabSelect.classTabSelect();
			try {
				String result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 모임 탭 select ---" + e);
			}
		}else if(page.equals("class_apply")) { //모임 참여하기
			ji = ClassApply.classApplyInsert();
			try {
				String result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 모임참여 insert ---" + e);
			}
		}else if(page.equals("class_applyDel")) { //모임 참여취소
			ji = ClassApplyDelete.classDelete();
			try {
				String result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 모임참여 delete ---" + e);
			}
		}else if(page.equals("classFilter")) { //모임 검색
			ji = ClassSearch.classSearchSelect();
			try {
				String result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 모임검색 select ---" + e);
			}
		}else if(page.equals("lr_place_search")) { //일정리뷰>장소검색
			ji = PlaceSearch.placeSearchInter();
			try {
				String result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 일정리뷰>장소검색 ---" + e);
				e.printStackTrace();
			}
		}else if(page.equals("planReviewSearch")) {
			ji = PlanReviewSearch.planReviewSearchInter();
			try {
				String result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 일정리뷰>검색 ---" + e);
				e.printStackTrace();
			}
		}else if(page.equals("selectPageInfo")) { //페이징
			ji = PageInfo.pageInfoSelect();
			try {
				String result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println("--- Controller / 페이징 ---" + e);
				e.printStackTrace();
			}
		}else if(page.equals("currency")) { //환율
			ji = Currency.currency();
			try {
				String result = ji.journeyInterface(request, response);
				request.getRequestDispatcher(result).forward(request, response);
			} catch (Exception e) {
				System.out.println(e);
				e.printStackTrace();
			}
		}
		else {
			System.out.println("--- controller else ---");
		}
	}
}
