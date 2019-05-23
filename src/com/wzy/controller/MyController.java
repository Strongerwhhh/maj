package com.wzy.controller;

import com.wzy.dao.UserDao;
import com.wzy.pojo.MajUser;
import com.wzy.pojo.ShowMajBean;
import com.wzy.pojo.User;
import com.wzy.websocket.MyGoEasy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class MyController {
    @RequestMapping("/hello")
    public String hello(ModelMap map) {
        map.put("msg", "hello mvc");
        return "hello";
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String toLogin() {
        return "login";
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(User user, Model model, HttpSession session) {
        String username = user.getUsername();
        String password = user.getPassword();
        if (username != null && username.equals("admin") && password != null && password.equals("admin")) {
            //将用户对象添加到Session中
            session.setAttribute("user", user);
            //重定向到主页面的跳转方法
            return "redirect:hello";
        }
        model.addAttribute("msg", "登录失败");
        return "hello";
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        return "home";
    }

}
