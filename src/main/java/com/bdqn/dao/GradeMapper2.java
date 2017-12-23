package com.bdqn.dao;

import com.bdqn.entity.Grade;

import java.util.List;

/**
 * Created by 大聪 on 2017/12/9.
 */
public interface GradeMapper2 {

    List<Grade> queryAl2();
    List<Grade> queryAll();

    Grade queryGradeById(Integer id);

    Integer deleteGradeById(Integer id);

    Integer deleteGradeByIds(List<Integer> list);

    Integer addGrade(Grade grade);

    Integer updateGrade(Grade grade);



}
