package com.bdqn.service;

import com.bdqn.entity.Grade;
import com.bdqn.entity.Student;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * Created by 大聪 on 2017/12/9.
 */
public interface GradeService2 {

    PageInfo<Grade> queryAll(Integer pageNum,Integer pageSize);

    Grade queryGradeById(Integer id);

    Integer deleteGradeById(Integer id);

    Integer deleteGradeByIds(List<Integer> list);

    Integer addGrade(Grade grade);

    Integer updateGrade(Grade grade);

    List<Grade> queryAll();


}
