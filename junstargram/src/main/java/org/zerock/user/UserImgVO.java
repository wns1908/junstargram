package org.zerock.user;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class UserImgVO {
	private int userImgNo;
	private int userNo;
	private String profileName;
	private long profileSize;
	private String profileContentType;
	private byte[] profileData;
	
	private MultipartFile file;
}
