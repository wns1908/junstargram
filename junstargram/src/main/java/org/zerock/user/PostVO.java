package org.zerock.user;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PostVO {
	private int postNo;  	// 게시글
	private String caption;	// 내용
	private Date regDate;	// 등록일
	
	private int userNo;		// 유저 번호
	private String id;		// 아이디
	
	private MultipartFile file;	// 파라미터 읽기용
	
	private String profileName;	// 파일 이름
	private long profileSize;	// 파일 크기	
	private String profileContentType;	// 파일 타입
	private byte[] profileData;		// 실제 데이터
	
	
}
