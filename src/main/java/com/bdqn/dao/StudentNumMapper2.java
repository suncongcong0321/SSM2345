package com.bdqn.dao;

/**
 * Created by 大聪 on 2017/12/16.
 */
public interface StudentNumMapper2 {

    Integer addStudentNum(Integer gradeId);

    Integer updateStudentMaxNumByGradeId(Integer gradeId);

    Integer queryStudentMaxNumByGradeId(Integer gradeId);
}
