package com.bdqn.service;

import com.bdqn.dao.StudentMapper2;
import com.bdqn.dao.StudentNumMapper2;
import com.bdqn.entity.Student;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by 大聪 on 2017/12/14.
 */
@Service
public class StudentService1Impl implements StudentService2 {
    @Resource
    private StudentMapper2 studentMapper2;

    @Resource
    private StudentNumMapper2 studentNumMapper2;
    @Override
    public PageInfo<Student> queryAll(Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Student> list=studentMapper2.queryAll();
        PageInfo<Student> pageInfo = new PageInfo<>(list);
        return pageInfo;
    }

    @Override
    public Integer deleteStudentByList(List<Integer> list) {
        return studentMapper2.deleteStudentByList(list);
    }

    @Override
    public Integer addStudent(Student student) {
        //1.student_num的对应班级的max_num加一
        Integer gradeId = student.getGrade().getId();
        studentNumMapper2.updateStudentMaxNumByGradeId(gradeId);
        //2.取student_num对应班级的max_num
        Integer maxNum = studentNumMapper2.queryStudentMaxNumByGradeId(gradeId);
        //3.组装studentNum
        String gradeName=student.getGrade().getGradeName();
        String studentNum = gradeName + maxNum;
        int n = 15 - (studentNum.length());
        if (n > 0) {
            for (int i=0;i<n;i++) {
                gradeName += 0;
            }
        }
        studentNum = gradeName + maxNum;
        student.setStudentNum(studentNum);
        return studentMapper2.addStudent(student);
    }

    @Override
    public Student queryStudentById(Integer id) {
        return studentMapper2.queryStudentById(id);
    }

    @Override
    public Integer updateStudent(Student student) {
        return studentMapper2.updateStudent(student);
    }
}
