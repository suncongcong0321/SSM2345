package com.bdqn.dao;

import com.bdqn.entity.Student;

import java.util.List;

/**
 * Created by 大聪 on 2017/12/14.
 */
public interface StudentMapper2 {

    List<Student> queryAll();

    Integer deleteStudentByList(List<Integer> list);

    Integer addStudent(Student student);

    Student queryStudentById(Integer id);

    Integer updateStudent(Student student);

}
