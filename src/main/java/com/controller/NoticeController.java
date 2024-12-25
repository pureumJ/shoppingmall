package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.UploadNotice;
import com.model.notice.NoticeDTO;
import com.model.notice.NoticeService;
import com.utility.Utility;

@Controller
public class NoticeController {

	@Autowired
	@Qualifier("com.model.notice.NoticeServiceImpl")
	private NoticeService service;

	@GetMapping("/admin/notice/create")
	public String create() {

		return "/notice/create";
	}

	@PostMapping("/notice/create")
	public String create(NoticeDTO dto) {

		// 1.DTO Multipartfile, storage 경로에 순수 파일로, rename 해서 저장
		long size = dto.getFnameMF().getSize();
		if (size > 0) {

			String filename = Utility.saveFileSpring(dto.getFnameMF(), UploadNotice.getUploadDir());
			dto.setFile(filename);
		}

		int cnt = service.create(dto);
		if (cnt > 0) {

			return "redirect:/notice/list";
		} else {

			return "error";
		}
	}

	@RequestMapping("/notice/list")
	public String list(HttpServletRequest request) {
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));

		if (col.equals("total")) {
			word = "";
		}

		int nowPage = 1;// 현재 보고있는 페이지
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		int recordPerPage = 3;// 한페이지당 보여줄 레코드갯수

		int sno = ((nowPage - 1) * recordPerPage);

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("cnt", recordPerPage);

		int total = service.total(map);

		List<NoticeDTO> list = service.list(map);

		String url = "/notice/list";

		String paging = Utility.paging(total, nowPage, recordPerPage, col, word, url);

		request.setAttribute("list", list);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("paging", paging);

		return "/notice/list";
	}

	@GetMapping("/notice/read")
	public String read(int noticeno, Model model) {
		service.upCnt(noticeno);

		NoticeDTO dto = service.read(noticeno);
		String content = dto.getContent().replaceAll("\r\n", "<br>");

		model.addAttribute("dto", dto);

//		model.addAttribute("dto", service.read(noticeno));

		return "/notice/read";
	}

	@GetMapping("admin/notice/update/{noticeno}")
	public String update(@PathVariable int noticeno, Model model) {

		model.addAttribute("dto", service.read(noticeno));
		model.addAttribute("oldfile", model.getAttribute("file"));
		return "/notice/update";
	}

	@PostMapping("/notice/update")
	public String update(NoticeDTO dto) {

//		int cnt = service.update(dto);
//
//		if (cnt > 0) {
//			return "redirect:/notice/list";
//		} else {
//			return "error";
//		}
		
		
		if (dto.getFnameMF().getSize() > 0) {
			if (dto.getFile() != null)
				Utility.deleteFile(UploadNotice.getUploadDir(), dto.getFile());
			dto.setFile(Utility.saveFileSpring(dto.getFnameMF(), UploadNotice.getUploadDir()));
			
		} else {
			dto.setFile(dto.getFile());
		}
		int cnt = service.update(dto);

		if (cnt > 0) {
			return "redirect:/notice/list";
		} else {
			return "error";
		}
			
		
	}

	@GetMapping({ "/admin/notice/delete/{noticeno}/{oldfile}", "admin/notice/delete/{noticeno}" })
	public String delete(@PathVariable("noticeno") int noticeno,
			@PathVariable(required = false) String oldfile) {
		boolean flag = false;

		try {

			flag = service.delete(noticeno);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (flag) {
			if (oldfile != null) {
				Utility.deleteFile(UploadNotice.getUploadDir(), oldfile);
			}
			return "redirect:/notice/list";
		} else {
			return "error";
		}
	}

}
