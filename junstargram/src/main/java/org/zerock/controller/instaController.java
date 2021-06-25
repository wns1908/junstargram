package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.service.InstaService;
import org.zerock.user.AttachFileDTO;
import org.zerock.user.PostVO;
import org.zerock.user.UserVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@RequestMapping("/insta/*")
@Controller
@AllArgsConstructor
@Log4j
public class instaController {

	@Inject
	BCryptPasswordEncoder pwdEncoder;

	private final InstaService service;

	@GetMapping("/join")
	public String home() throws Exception {
		return "/auth/joinForm";
	}

	// 아이디 중복 체크
	@RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	@ResponseBody
	public String idCheck(HttpServletRequest req) {

		String id = req.getParameter("id");
		int result = service.idCheck(id);
		return Integer.toString(result);
	}

	/*
	 * @RequestMapping(value = "/idCheck", method = RequestMethod.GET)
	 * 
	 * @ResponseBody public int idCheck(@RequestParam("id") String id) {
	 * 
	 * return service.idCheck(id); }
	 */
	// 회원 등록
	@PostMapping("/join")
	public String register(UserVO user, String id) throws Exception {

		log.info("user: " + user);

		int result = service.idCheck(id);

		try {
			if (result == 1) {
				return "/auth/joinForm";
			} else if (result == 0) {
				String inputPass = user.getPw();
				user.setPw(inputPass);
				String pwd = pwdEncoder.encode(inputPass);
				user.setPw(pwd);

				service.register(user);
			}
		} catch (Exception e) {
			throw new RuntimeException();
		}
		return "/loginForm";
	}

	// 로그인
	@SuppressWarnings("unused")
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(UserVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
		log.info("post login");

		HttpSession session = req.getSession();
		String pw = service.login(vo);
		boolean pwdMatch = pwdEncoder.matches(vo.getPw(), pw);

		if (pw != null && pwdMatch == true) {
			session.setAttribute("login", vo);
			
			return "redirect:/insta/feed";
		} else {
			session.setAttribute("login", null);
			rttr.addFlashAttribute("msg", false);
			
			return "redirect:/loginForm";
		}

		
	}

	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {

		session.invalidate();

		return "redirect:/";
	}

	// 피드 화면
	@GetMapping("/feed")
	/*
	 * @RequestMapping(value="/image/feed", method= {{RequestMethod.GET,
	 * RequestMethod.POST})
	 */
	public String feed() throws Exception {
		return "/image/feed";
	}

	// 검색 화면
	@GetMapping("/explore")
	public String explore() throws Exception {
		return "/image/explore";
	}

	// 프로필 화면
	@GetMapping("/user")
	public String profile() throws Exception {
		return "/user/profile";
	}

	// 게시글 쓰기
	@GetMapping("/post")
	public String writepost() throws Exception {
		return "image/upload";
	}

	// 업로드 사진 파일 DB에 입력

	@GetMapping("/uploadAjax")		// url : /uploadAjax
	public String uploadAjax() {
		log.info("uploadAjax");
		
		return "/uploadAjax";
	}	
	

	@PostMapping("/uploadAjaxAction")
//			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)	// JSON 형태로 응답(Content-Type)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("upload ajax post.....");
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();	// 반환될 목록
		String uploadFolder = "C:\\wns\\upload";
		
		// 업로드 폴더 생성
		String uploadFolderPath = getFolder();	// yyyy/MM/dd
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path: " + uploadPath);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();	// dd 경로까지의 중간 폴더들을 모두 생성
		}	// make yyyy/MM/dd folder
				
		for(MultipartFile multipartFile : uploadFile) {
			AttachFileDTO attachDTO = new AttachFileDTO();
			log.info("-----------------------------------");
			
			log.info("Upload file name: " + multipartFile.getOriginalFilename());
			log.info("upload file size: " + multipartFile.getSize());
			
			
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName);	// 브라우저에서 첨부한 파일 이름
			
			// 파일이름 중복 방지
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
						
			// 파일 저장
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);	// 원본 파일을 저장
				attachDTO.setUuid(uuid.toString());			// uuid
				attachDTO.setUploadPath(uploadFolderPath);	// yyyy/MM/dd 폴더 구조
				// 섬네일을 저장
				// 이미지 파일 유형인지 검사
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);	// 이미지인 경우 true로 저장
					FileOutputStream thumbnail = new FileOutputStream(
							new File(uploadPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(
							multipartFile.getInputStream(), thumbnail, 100, 100);
					thumbnail.close();
				}
				list.add(attachDTO);
			} catch(Exception e) {
				log.error(e.getMessage());
			}
		}	// url : /uploadAjaxAction.jsp 응답 -> 404 Not Found가 발생
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}
	
	// 2021/06/16 형태의 문자열을 생성
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	// 첨부파일이 이미지 타입인지를 검사 : Content-Type이 "image/*" 인지를 검사
	private boolean checkImageType(File file) {
		try {
			String contentType = Files.probeContentType(file.toPath());
			if(contentType != null)	
				return contentType.startsWith("image"); // image/jpg, image/png, image/gif
			else
				return false;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return false;
	}
}