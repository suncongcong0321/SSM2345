package com.bdqn.controller;

import com.alibaba.fastjson.JSON;
import com.bdqn.entity.Grade;
import com.bdqn.entity.Student;
import com.bdqn.service.GradeService2;
import com.bdqn.service.StudentService2;
import com.bdqn.util.Message;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 大聪 on 2017/12/9.
 */
@Controller
@RequestMapping("student")
public class StudentController {

    @Resource
    private StudentService2 studentService2;

    @Resource
    private GradeService2 gradeService2;

    @RequestMapping(value = "queryAllStudent",method = RequestMethod.GET)
    public String student(Integer pageNum, Integer pageSize, Model model){
        PageInfo<Student> pageInfo = studentService2.queryAll(pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return "student/student";
    }

    @ResponseBody
    @RequestMapping(value = "deleteStudentByIds", method = RequestMethod.POST,
            produces = "application/json;charset=UTF-8")
    public String deleteStudentByIds(String idStr) {
        String[] idArray = idStr.split(",");
        List<Integer> students = new ArrayList<Integer>();
        for (String s : idArray) {
            students.add(Integer.parseInt(s));
        }
        int n = studentService2.deleteStudentByList(students);
        if (n > 0) {
            return JSON.toJSONString(Message.success());
        }
        return JSON.toJSONString(Message.error());
    }

    @ResponseBody
    @RequestMapping(value = "queryAll",method = RequestMethod.GET,
    produces = "application/json;charset=UTF-8")
    public String queryAll(){
        List<Grade> list = gradeService2.queryAll();
        return JSON.toJSONString(list);
    }

    @ResponseBody
    @RequestMapping(value = "addStudent",method = RequestMethod.POST,
            produces = {"application/json;charset=UTF-8"})
    public String addStudent(Student student){
        int count = studentService2.addStudent(student);
        if (count > 0) {
            return JSON.toJSONString(Message.success());
        }
        return JSON.toJSONString(Message.error());
    }

    @ResponseBody
    @RequestMapping(value = "queryStudentById", method = RequestMethod.GET,
            produces = {"application/json;charset=UTF-8"})
    public String queryStudentById(Integer studentId) {
        Student student = studentService2.queryStudentById(studentId);
        return JSON.toJSONString(student);
    }

    @ResponseBody
    @RequestMapping(value = "updateStudent", method = RequestMethod.POST,
            produces = {"application/json;charset=UTF-8"})
    public String updateStudent(Student student) {
        int count = studentService2.updateStudent(student);
        if (count > 0) {
            return JSON.toJSONString(Message.success());
        }
        return JSON.toJSONString(Message.error());
    }
}
