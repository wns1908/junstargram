package org.zerock.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Random;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
import org.springframework.web.servlet.ModelAndView;
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
	
	@Autowired
	private JavaMailSender mailSender;	// ?????? ???????????? ???????????? ?????? ???????????? ?????????.

	private final InstaService service;
	//////////////////////////////////////////////////////////////
	//????????? ?????? ??????
    private static final Logger logger=
    LoggerFactory.getLogger(instaController.class);
    private static final String String = null;
    
    
    // ????????? ??????
    @RequestMapping(value="/mailCheck", method=RequestMethod.GET)
    @ResponseBody
    public String mailCheckGET(String email) throws Exception {
    	/* ???(view)????????? ????????? ????????? ?????? */
    	logger.info("????????? ????????? ?????? ??????");
    	logger.info("???????????? : " + email);
    	
    	/* ???????????? (??????) ??????*/
    	Random random = new Random();
    	int checkNum = random.nextInt(888888) + 111111;
    	logger.info("???????????? " + checkNum);
    	
    	/* ????????? ????????? */
    	String setFrom = "SkyLifeKorea@gmail.com";
    	String toMail = email;
    	String title = "???????????? ?????? ????????? ?????????.";
    	String content =
    			"??????????????? ?????????????????? ???????????????." +
    				"<br><br>" + 
    				"?????? ????????? " + checkNum + "?????????." +
    				"<br>" +
    				"?????? ??????????????? ???????????? ???????????? ???????????? ?????????.";
    	try {
    		MimeMessage message = mailSender.createMimeMessage();
    		MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
    		helper.setFrom(setFrom);;
    		helper.setTo(toMail);
    		helper.setSubject(title);
    		helper.setText(content, true);
    		mailSender.send(message);
    	} catch(Exception e) {
    		e.printStackTrace();
    	}
    	
    	String num = Integer.toString(checkNum);
    	
    	return num;
    }
	///////////////////////////////////////////////////////////////
	@GetMapping("/join")
	public String home() throws Exception {
		return "/auth/joinForm";
	}

	// ????????? ?????? ??????
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
	// ?????? ??????
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

	// ?????????
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

	// ????????????
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {

		session.invalidate();

		return "redirect:/";
	}

	// ?????? ??????
	@GetMapping("/feed")
	/*
	 * @RequestMapping(value="/image/feed", method= {{RequestMethod.GET,
	 * RequestMethod.POST})
	 */
	public String feed() throws Exception {
		return "/image/feed";
	}
	@PostMapping("/feed")
	/*
	 * @RequestMapping(value="/image/feed", method= {{RequestMethod.GET,
	 * RequestMethod.POST})
	 */
	public String feed1() throws Exception {
		return "/image/feed";
	}

	// ?????? ??????
	@GetMapping("/explore")
	public String explore() throws Exception {
		return "/image/explore";
	}

	// ????????? ??????
	@GetMapping("/user")
	public String profile() throws Exception {
		return "/user/profile";
	}

	// ????????? ??????
	@PostMapping("/uploadAjax")
	public String writepost() throws Exception {
		return "image/uploadAjax";
	}

	// ????????? ?????? ?????? DB??? ??????

	@GetMapping("/uploadAjax")		// url : /uploadAjax
	public String uploadAjax() {
		log.info("uploadAjax");
		
		return "image/uploadAjax";
	}	
	

	@PostMapping("/uploadAjaxAction")
//			produces=MediaType.APPLICATION_JSON_UTF8_VALUE)	// JSON ????????? ??????(Content-Type)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("upload ajax post.....");
		List<AttachFileDTO> list = new ArrayList<AttachFileDTO>();	// ????????? ??????
		String uploadFolder = "C:\\wns\\upload";
		
		// ????????? ?????? ??????
		String uploadFolderPath = getFolder();	// yyyy/MM/dd
		File uploadPath = new File(uploadFolder, uploadFolderPath);
		log.info("upload path: " + uploadPath);
		if (uploadPath.exists() == false) {
			uploadPath.mkdirs();	// dd ??????????????? ?????? ???????????? ?????? ??????
		}	// make yyyy/MM/dd folder
				
		for(MultipartFile multipartFile : uploadFile) {
			AttachFileDTO attachDTO = new AttachFileDTO();
			log.info("-----------------------------------");
			
			log.info("Upload file name: " + multipartFile.getOriginalFilename());
			log.info("upload file size: " + multipartFile.getSize());
			
			
			String uploadFileName = multipartFile.getOriginalFilename();
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("only file name: " + uploadFileName);
			attachDTO.setFileName(uploadFileName);	// ?????????????????? ????????? ?????? ??????
			
			// ???????????? ?????? ??????
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
						
			// ?????? ??????
			File saveFile = new File(uploadPath, uploadFileName);
			try {
				multipartFile.transferTo(saveFile);	// ?????? ????????? ??????
				attachDTO.setUuid(uuid.toString());			// uuid
				attachDTO.setUploadPath(uploadFolderPath);	// yyyy/MM/dd ?????? ??????
				// ???????????? ??????
				// ????????? ?????? ???????????? ??????
				if(checkImageType(saveFile)) {
					attachDTO.setImage(true);	// ???????????? ?????? true??? ??????
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
		}	// url : /uploadAjaxAction.jsp ?????? -> 404 Not Found??? ??????
		return new ResponseEntity<List<AttachFileDTO>>(list, HttpStatus.OK);
	}
	
	// 2021/06/16 ????????? ???????????? ??????
	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String str = sdf.format(date);
		return str.replace("-", File.separator);
	}
	
	// ??????????????? ????????? ??????????????? ?????? : Content-Type??? "image/*" ????????? ??????
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