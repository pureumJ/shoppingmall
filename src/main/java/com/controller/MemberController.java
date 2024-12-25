package com.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.UploadCon;
import com.UploadMem;
import com.model.member.MemberDTO;
import com.model.member.MemberService;
import com.utility.Utility;

@Controller
public class MemberController {
	@Autowired
	@Qualifier("com.model.member.MemberServiceImpl") // 인터페이스이기 때문에 명확하게 명시 해줘야
	private MemberService service;

	@GetMapping("/")
	public String home() {

		return "/home";
	}

	@GetMapping(value = "/member/idcheck", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Map<String, String> idcheck(String id) {
		int cnt = service.duplicatedId(id);

		Map<String, String> map = new HashMap<String, String>();
		if (cnt > 0) {
			map.put("str", id + "는 중복, 사용할 수 없습니다.");
		} else {
			map.put("str", id + "는 중복아님, 사용가능합니다.");
		}

		return map;
	}

	@GetMapping(value = "/member/emailcheck", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Map<String, String> emailcheck(String email) {
		int cnt = service.duplicatedEmail(email);

		Map<String, String> map = new HashMap<String, String>();
		if (cnt > 0) {
			map.put("str", email + "는 중복, 사용할 수 없습니다.");
		} else {
			map.put("str", email + "는 사용가능한 아이디 입니다.");
		}

		return map;
	}

	/** 동의 페이지 **/
	@GetMapping("/member/agree")
	public String agree() {

		return "/member/agree";
	}

	/** 회원가입 페이지 **/
	
	@PostMapping("/member/createForm")
	public String create() {
		return "/member/create";
	}

	@PostMapping("/member/create")
	public String create(MemberDTO dto) {

		// 아이디, 이메일 중복 검사

		int checkId = service.duplicatedId(dto.getId());
		int checkEmail = service.duplicatedEmail(dto.getEmail());

		if (checkId > 0 || checkEmail > 0) {
			return "error2";
		}

		String fname = Utility.saveFileSpring(dto.getFnameMF(), UploadMem.getUploadDir());
		long fsize = dto.getFnameMF().getSize();

		if (fsize == 0)
			fname = "member.jpg";

		dto.setFname(fname);

		int cnt = service.create(dto);
		if (cnt > 0) {
			return "redirect:/";
		} else {
			return "error";
		}
	}

	@GetMapping("/member/login")
	public String login(HttpServletRequest request) {
		/*----쿠키설정 내용시작----------------------------*/
		String c_id = ""; // ID 저장 여부를 저장하는 변수, Y
		String c_id_val = ""; // ID 값

		Cookie[] cookies = request.getCookies();
		Cookie cookie = null;

		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				cookie = cookies[i];

				if (cookie.getName().equals("c_id")) {
					c_id = cookie.getValue(); // Y
				} else if (cookie.getName().equals("c_id_val")) {
					c_id_val = cookie.getValue(); // user1...
				}
			}
		}
		/*----쿠키설정 내용 끝----------------------------*/

		request.setAttribute("c_id", c_id);
		request.setAttribute("c_id_val", c_id_val);

		return "/member/login";
	}

	@PostMapping("/member/login")
	public String login(@RequestParam Map<String, String> map, HttpSession session, HttpServletResponse response,
			HttpServletRequest request, Model model) {

		System.out.println(map);

		int cnt = service.loginCheck(map);

		if (cnt > 0) {
			Map<String, String> gmap = service.getGrade(map.get("id"));
			session.setAttribute("id", map.get("id"));
			session.setAttribute("grade", gmap.get("grade"));
			session.setAttribute("mname", gmap.get("mname"));
			session.setAttribute("fname", gmap.get("fname"));

			
			// Cookie 저장,id저장 여부 및 id
			Cookie cookie = null;
			String c_id = request.getParameter("c_id");
			if (c_id != null) {
				cookie = new Cookie("c_id", c_id); // c_id=> Y
				cookie.setMaxAge(60 * 60 * 24 * 365);// 1년
				response.addCookie(cookie);// 요청지(client:브라우저 컴) 쿠키 저장

				cookie = new Cookie("c_id_val", map.get("id"));
				cookie.setMaxAge(60 * 60 * 24 * 365);// 1년
				response.addCookie(cookie);// 요청지(client:브라우저 컴) 쿠키 저장
			} else {
				cookie = new Cookie("c_id", ""); // 쿠키 삭제
				cookie.setMaxAge(0);
				response.addCookie(cookie);

				cookie = new Cookie("c_id_val", "");// 쿠키 삭제
				cookie.setMaxAge(0);
				response.addCookie(cookie);

			}

		} // ifcnt>0 end

		if (cnt > 0) {

			if (map.get("contentsno") != null && !map.get("contentsno").equals("")) {
				return "redirect:/contents/detail/" + map.get("contentsno");
			} else if (map.get("cateno") != null && !map.get("cateno").equals("")) {
				return "redirect:/contents/mainlist/" + map.get("cateno");
			} else {
				return "redirect:/";
			}

		} else {
			request.setAttribute("msg", "아이디 또는 비밀번호를 잘못 입력 했거나 <br>회원이 아닙니다. 회원가입 하세요");
			return "passwdError";
		}
	}

	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
//       session.removeAttribute("id");
//       session.removeAttribute("grade");
		session.invalidate();

		return "redirect:/";
	}

	@RequestMapping("/admin/member/list") // 요청은 admin
	public String list(HttpServletRequest request) {

		// 검색관련------------------------
		String col = Utility.checkNull(request.getParameter("col"));
		String word = Utility.checkNull(request.getParameter("word"));

		if (col.equals("total")) {
			word = "";
		}

		// 페이지관련-----------------------
		int nowPage = 1;// 현재 보고있는 페이지
		if (request.getParameter("nowPage") != null) {
			nowPage = Integer.parseInt(request.getParameter("nowPage"));
		}
		int recordPerPage = 3;// 한페이지당 보여줄 레코드갯수

		// DB에서 가져올 순번(mysql)-----------------
		int sno = (nowPage - 1) * recordPerPage;
		int eno = recordPerPage;

		Map map = new HashMap();
		map.put("col", col);
		map.put("word", word);
		map.put("sno", sno);
		map.put("eno", eno);

		int total = service.total(map);

		List<MemberDTO> list = service.list(map);

		String url = "list";

		String paging = Utility.paging(total, nowPage, recordPerPage, col, word, url);

		// request에 Model사용 결과 담는다
		request.setAttribute("list", list);
		request.setAttribute("nowPage", nowPage);
		request.setAttribute("col", col);
		request.setAttribute("word", word);
		request.setAttribute("paging", paging);

		return "/member/list"; // 응답은 member
	}

	// admin만 보는 페이지
	@GetMapping("/admin/member/read")
	public String read(String id, Model model) {

		MemberDTO dto = service.read(id);
		model.addAttribute("dto", dto);

		return "/member/read";
	}

	@GetMapping("/member/update")
	public String update(String id, HttpSession session, Model model) {

//		if (id == null) { // 본인이 정보수정 하는 경우
//			id = (String) session.getAttribute("id");
//		}

		MemberDTO dto = service.read(id);
		model.addAttribute("dto", dto);

		return "/member/update";
	}
	
	@GetMapping("/member/update/{id}")
	public String update_me(@PathVariable String id, HttpSession session, Model model) {

//		if (id == null) { // 본인이 정보수정 하는 경우
//			id = (String) session.getAttribute("id");
//		}

		MemberDTO dto = service.read(id);
		model.addAttribute("dto", dto);

		return "/member/update";
	}

	@PostMapping("/member/update")
	public String update(MemberDTO dto, HttpSession session) {

		int cnt = service.update(dto);

		String url = "redirect:/";
		if(session.getAttribute("grade").equals("A")) {
			url = "redirect:/admin/member/list";
		}
		if (cnt > 0) {
			return url;
		} else {
			return "error";
		}
	}

	@GetMapping("/member/delete/{id}/{oldfile}")
	public String delete(@PathVariable("id") String id, @PathVariable("oldfile") String oldfile) {
		
		
		boolean flag = false;
		
		try {
			flag = service.delete(id);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if (flag) {
//			if (!oldfile.equals("member.jpg")) {
//				Utility.deleteFile(UploadMem.getUploadDir(), oldfile);
//			}
			return "redirect:/admin/member/list";
		} else {
			return "error";
		}
	}

	@GetMapping("/member/mypage")
	public String mypage(HttpSession session, Model model) {
		String id = (String) session.getAttribute("id");

		if (id == null) {
			return "redirect: ./login/";
		} else {

			MemberDTO dto = service.mypage(id);

			model.addAttribute("dto", dto);

			return "/member/mypage";
		}
	}

	@GetMapping("/member/updateFile")
	public String updateFile() {

		return "/member/updateFile";
	}

	@PostMapping("/member/updateFile")
	public String updateFile(MultipartFile fname, String oldfile, String id, HttpSession session) {

		if(oldfile != null && !oldfile.equals("member.jpg")) {
			Utility.deleteFile(UploadMem.getUploadDir(), oldfile);
		}
		
		String filename = Utility.saveFileSpring(fname, UploadMem.getUploadDir());
		
		Map map = new HashMap();
		map.put("id", id);
		map.put("fname", filename);
		
		int cnt = service.updateFile(map);
		if(cnt > 0) {
			
			
			Map<String, String> gmap = service.getGrade(id);
//			session.setAttribute("id", map.get("id"));
//			session.setAttribute("grade", gmap.get("grade"));
//			session.setAttribute("mname", gmap.get("mname"));
			session.setAttribute("fname", gmap.get("fname"));
			
			return "redirect:/member/mypage";
		} else {
			return "error";
		}
	}
}
