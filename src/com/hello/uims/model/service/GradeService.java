package com.hello.uims.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.hello.common.UimsMapper;
import com.hello.uims.model.DTO.EnrollmentDTO;
import com.hello.uims.model.DTO.GradeDTO;
import com.hello.uims.model.DTO.LectureDTO;

import static com.hello.common.Template.getSqlSession;

public class GradeService {
	
	SqlSession sqlSession = null;
	
	public GradeService() { // 승재형 파트 

	}

	public ArrayList<GradeDTO> gradeCheck(int studentNo) {
		
		sqlSession = getSqlSession();
		UimsMapper mapper = sqlSession.getMapper(UimsMapper.class);
		ArrayList<GradeDTO> list = mapper.gradeCheck(studentNo);
		
		sqlSession.close();
		
		return list;
	}

	public ArrayList<LectureDTO> selectByProfNo(int profNo) {

		sqlSession = getSqlSession();
		UimsMapper mapper = sqlSession.getMapper(UimsMapper.class);
		ArrayList<LectureDTO> list = mapper.selectByProfNo(profNo);
		
		sqlSession.close();
		
		return list;
	}

	public ArrayList<EnrollmentDTO> selectStuGrade(Map<String, String> parameter) {
		
		sqlSession = getSqlSession();
		UimsMapper mapper = sqlSession.getMapper(UimsMapper.class);
		ArrayList<EnrollmentDTO> list = mapper.selectStuGrade(parameter);
		
		sqlSession.close();
		
		return list;
	}

	public boolean insertGrade(Map<String, String> parameter) {
		
		sqlSession = getSqlSession();
		UimsMapper mapper = sqlSession.getMapper(UimsMapper.class);
		int result = mapper.insertGrade(parameter);
		
		if(result > 0) {
			sqlSession.commit();
		} else {
			sqlSession.rollback();
		}
		return (result > 0)? true : false;
	}

	public ArrayList<GradeDTO> selectGrade(Map<String, String> parameter) {
		
		sqlSession = getSqlSession();
		UimsMapper mapper = sqlSession.getMapper(UimsMapper.class);
		
		ArrayList<GradeDTO> list = mapper.selectGrade(parameter);
		
		sqlSession.close();
		
		return list;
	}

}
