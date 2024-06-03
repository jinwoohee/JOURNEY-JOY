package com.jj.dao;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface JourneyInterface {
	String journeyInterface(HttpServletRequest request, HttpServletResponse response) throws Exception;
}
