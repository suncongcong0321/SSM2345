package com.bdqn.service;

import com.bdqn.dao.GradeMapper2;
import com.bdqn.dao.StudentNumMapper2;
import com.bdqn.entity.Grade;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 大聪 on 2017/12/9.
 */
@Service
public class GradeService2Impl implements GradeService2 {
    @Resource
    private GradeMapper2 gradeMapper2;

    @Resource
    private StudentNumMapper2 studentNumMapper2;
    @Override
    public PageInfo<Grade> queryAll(Integer pageNum,Integer pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Grade> grades = gradeMapper2.queryAll();
        PageInfo<Grade> pageInfo = new PageInfo<>(grades);
        return pageInfo;
    }

    @Override
    public Grade queryGradeById(Integer id) {
        return gradeMapper2.queryGradeById(id);
    }

    @Override
    public Integer deleteGradeById(Integer id) {
        return gradeMapper2.deleteGradeById(id);
    }

    @Override
    public Integer deleteGradeByIds(List<Integer> list) {
        return gradeMapper2.deleteGradeByIds(list);
    }

    @Override
    public Integer addGrade(Grade grade) {
        gradeMapper2.addGrade(grade);
        Integer gradeId = grade.getId();
        return studentNumMapper2.addStudentNum(gradeId);
    }

    @Override
    public Integer updateGrade(Grade grade) {
        return gradeMapper2.updateGrade(grade);
    }

    @Override
    public List<Grade> queryAll() {
        return gradeMapper2.queryAll();
    }
}
