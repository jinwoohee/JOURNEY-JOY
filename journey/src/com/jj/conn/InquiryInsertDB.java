package com.jj.conn;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import com.jj.dao.SqlMapconfig;
import com.jj.dto.Inquiry;
import com.jj.dto.InqNotice;
import com.jj.inter.InquiryNotice;

public class InquiryInsertDB {
	static InquiryInsertDB qInsertDB = new InquiryInsertDB();
	
	public static InquiryInsertDB inquiryInsertDB() {
		return qInsertDB;
	}

	SqlSessionFactory sql = SqlMapconfig.getSqlSession();

	public int inquiryInsertDB(int p_no, String p_uid, String p_title, String u_id, String i_contents) {
		// TODO Auto-generated method stub
		SqlSession ss = sql.openSession();
		
		Inquiry dto = new Inquiry();
		dto.setP_no(p_no);
		dto.setP_uid(p_uid);
		dto.setP_title(p_title);
		dto.setU_id(u_id);
		dto.setI_contents(i_contents);
		//System.out.println("InquiryInsertDB----->"+dto.getP_no()+"/"+dto.getU_id()+"/"+dto.getI_contents());
		
		int row = ss.insert("inquiry_insert", dto);
		System.out.println("inquiry_insert------->"+row);
		
		ss.commit();		
		ss.close();
		
		return row;
	}
}
