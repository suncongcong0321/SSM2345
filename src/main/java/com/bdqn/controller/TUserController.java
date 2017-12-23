package com.bdqn.controller;

import com.bdqn.entity.TUser;
import com.bdqn.service.TUserService2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

/**
 * Created by 大聪 on 2017/12/7.
 */
@Controller
@RequestMapping("user")
public class TUserController {
    @Resource
    private TUserService2 tUserService2;

    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(TUser tUser, HttpSession session, Model model) {
        TUser loginUser = tUserService2.login(tUser);
        if (loginUser != null) {
            session.setAttribute("loginUser",loginUser);
            return "welcome";
        }
        model.addAttribute("message", "用户名错误");
        return "index";
    }

    @RequestMapping("logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loginUser");
        return "index";
    }
}
