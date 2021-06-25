package org.zerock.user;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Data
public class UserVO {
	private int userNo; 	// 회원 번호
	private String email;	// 회원 이메일
	private String id; 		// 회원 아이디
	private String pw;		// 회원 비밀번호
	private String name;	// 회원 이름
	private String intro;	// 회원 소개
	private String phone;	// 회원 전화번호
	private Date regDate;	// 등록 날짜
	
	// 클라이언트 측에서 넘어온 파일 데이터를 저장하기 위한 파라미터 읽기용
	private MultipartFile file;
	
	// 프로필 파일을 위한 필드
	private int userImgNo;
	private String profileName;		// 파일 이름
	private long profileSize;		// 파일 크기
	private String profileContentType; // 파일 타입
	
}
