package com.model.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {

	int create(NoticeDTO dto);
	List<NoticeDTO> list(Map map);
	int total(Map map);
	NoticeDTO read(int noticeno);
	boolean delete(int noticeno);
	void upCnt(int noticeno);
	int update(NoticeDTO dto);
	
}
