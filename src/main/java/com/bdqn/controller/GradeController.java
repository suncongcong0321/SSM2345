package com.bdqn.controller;

import com.alibaba.fastjson.JSON;
import com.bdqn.entity.Grade;
import com.bdqn.service.GradeService2;
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
@RequestMapping("grade")
public class GradeController {
    @Resource
    private GradeService2 gradeService2;

    @RequestMapping("grade")
    public String grade(Integer pageNum, Integer pageSize, Model model) {
        PageInfo<Grade> pageInfo = gradeService2.queryAll(pageNum, pageSize);
        model.addAttribute("pageInfo", pageInfo);
        return "grade/grade";
    }

    @ResponseBody
    @RequestMapping(value = "queryGradeById",method = RequestMethod.GET,
                    produces = {"application/json;charset=UTF-8"})
    public String queryGradeById(Integer gradeId){
        Grade grade = gradeService2.queryGradeById(gradeId);
        return JSON.toJSONString(grade);
    }

    @ResponseBody
    @RequestMapping(value = "deleteGradeById",method = RequestMethod.POST,
                    produces = {"application/json;charset=UTF-8"})
    public String deleteGradeById(Integer gradeId){
        int count = gradeService2.deleteGradeById(gradeId);
        if (count>0){
            return JSON.toJSONString(Message.success());
        }
        return JSON.toJSONString(Message.error());
    }

    @ResponseBody
    @RequestMapping(value = "deleteGradeByIds", method = RequestMethod.POST,
            produces = {"application/json;charset=UTF-8"})
    public String deleteGradeByIds(String gradeIds) {
        String[] gradeArray = gradeIds.split(",");
        List<Integer> list = new ArrayList<Integer>();
        for (String s : gradeArray) {
            list.add(Integer.parseInt(s));
        }
        int count = gradeService2.deleteGradeByIds(list);
        if (count > 0) {
            return JSON.toJSONString(Message.success());
        }
        return JSON.toJSONString(Message.error());
    }

    @ResponseBody
    @RequestMapping(value = "addGrade", method = RequestMethod.POST,
            produces = {"application/json;charset=UTF-8"})
    public String addGrade(Grade grade) {
        int count = gradeService2.addGrade(grade);
        if (count > 0) {
            return JSON.toJSONString(Message.success());
        }
        return JSON.toJSONString(Message.error());
    }

    @ResponseBody
    @RequestMapping(value = "updateGrade", method = RequestMethod.POST,
            produces = {"application/json;charset=UTF-8"})
    public String updateGrade(Grade grade) {
        int count = gradeService2.updateGrade(grade);
        if (count > 0) {
            return JSON.toJSONString(Message.success());
        }
        return JSON.toJSONString(Message.error());
    }

}
