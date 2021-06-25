package org.zerock.service;

import java.util.List;

import org.zerock.user.PostVO;
import org.zerock.user.UserVO;

// 기능에 대한 처리 : 서비스 로직
// Mapper와 1:1로 대응되는 편이지만 꼭 그런 것만은 아니다.

public interface InstaService {
	// 회원가입
	public void register(UserVO user);
	
	// 아이디 중복 체크
	public int idCheck(String id);
	
	// 로그인
	public String login(UserVO login);
	
	// 게시물 등록 기능(사진 첨부파일 포함)
	public String insertPost(PostVO post);
		
	// 게시물 목록 조회
	public List<PostVO> selectPostList();
		
	// 첨부파일을 db에서 불러오기
	public PostVO getFile(int postNo);
}
