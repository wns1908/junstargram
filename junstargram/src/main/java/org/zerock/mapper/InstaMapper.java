package org.zerock.mapper;

import java.util.List;

import org.zerock.user.PostVO;
import org.zerock.user.UserVO;

public interface InstaMapper {
	// 회원가입
	public void register(UserVO user);
		
	// 아이디 중복 확인
	public int idCheck(String id);
	
	// 로그인 시 회원정보 조회
	String login(UserVO login);
	
	// 게시물 등록 기능(사진 첨부파일 포함)
	String insertPost(PostVO post);
	
	// 게시물 목록 조회
	List<PostVO> selectPostList();
	
	// 첨부파일을 db에서 불러오기
	PostVO getFile(int postNo);
}
