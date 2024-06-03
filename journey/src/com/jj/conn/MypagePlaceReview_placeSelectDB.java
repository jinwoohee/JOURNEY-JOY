package com.jj.conn;

import static com.jj.db.JdbcUtil.close;
import static com.jj.db.JdbcUtil.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import com.jj.dao.JourneySql;
import com.jj.dto.Place;

public class MypagePlaceReview_placeSelectDB {

	public ArrayList<Place> mypagePlaceSelectDB(String pl_eat_no) {
		Connection con = getConnection();
		JourneySql sql = JourneySql.getInstance();
		sql.setConnection(con);
		ArrayList<Place> pclist = sql.mypagePlaceSelect(pl_eat_no);
		
		close(con);
		return pclist;
	}
}
