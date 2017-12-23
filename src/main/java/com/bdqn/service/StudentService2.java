package com.bdqn.service;

import com.bdqn.entity.Student;
import com.github.pagehelper.PageInfo;

import java.util.List;

/**
 * Created by 大聪 on 2017/12/14.
 */
public interface StudentService2 {

    PageInfo<Student> queryAll(Integer pageNum, Integer pageSize);

    Integer deleteStudentByList(List<Integer> list);

    Integer addStudent(Student student);

    Student queryStudentById(Integer id);

    Integer updateStudent(Student student);


}
