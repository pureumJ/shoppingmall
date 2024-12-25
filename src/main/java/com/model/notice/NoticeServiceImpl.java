package com.model.notice;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("com.model.notice.NoticeServiceImpl")
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	private NoticeMapper mapper;

	@Override
	public int create(NoticeDTO dto) {
		
		return mapper.create(dto);
	}

	@Override
	public List<NoticeDTO> list(Map map) {
		
		return mapper.list(map);
	}

	@Override
	public int total(Map map) {
		
		return mapper.total(map);
	}

	@Override
	public NoticeDTO read(int noticeno) {
		// TODO Auto-generated method stub
		return mapper.read(noticeno);
	}

	@Override
	public boolean delete(int noticeno) {
		// TODO Auto-generated method stub
		return mapper.delete(noticeno);
	}

	@Override
	public void upCnt(int noticeno) {
		mapper.upCnt(noticeno);
	}

	@Override
	public int update(NoticeDTO dto) {
		// TODO Auto-generated method stub
		return mapper.update(dto);
	}

}
