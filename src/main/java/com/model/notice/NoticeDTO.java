package com.model.notice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.model.member.MemberDTO;
import com.model.orders.OrdersDTO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class NoticeDTO {
	private int noticeno;
	private String title;
	private String content;
	private String rdate;
	private String file;
	private int cnt;
	private MultipartFile fnameMF;
	private int filesize;
}
