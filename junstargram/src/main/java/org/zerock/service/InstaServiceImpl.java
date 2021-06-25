package org.zerock.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.zerock.mapper.InstaMapper;
import org.zerock.user.PostVO;
import org.zerock.user.UserVO;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public  class InstaServiceImpl implements InstaService {
	@Autowired
	private InstaMapper instaMapper;
	
	@Override
	public void register(UserVO user) {
		instaMapper.register(user);
	}

	@Override
	public int idCheck(String id) {
		int result = instaMapper.idCheck(id);
	    
		return result;
	}

	@Override
	public String login(UserVO login) {
		return instaMapper.login(login);
	}

	@Override
	public String insertPost(PostVO post) {
		String result = instaMapper.insertPost(post);		
		
		return result;
	}

	@Override
	public List<PostVO> selectPostList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PostVO getFile(int postNo) {
		// TODO Auto-generated method stub
		return null;
	}
}