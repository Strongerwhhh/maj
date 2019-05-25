package com.wzy.controller;

import com.wzy.pojo.MajUser;
import com.wzy.service.UserService;
import com.wzy.util.MyUtil;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/log")
public class LogController {
    private UserService userService=UserService.getInstance();
    @RequestMapping(value = "login" , method = RequestMethod.POST)
    public String login(@RequestParam("login_account")String account, @RequestParam("login_password")String pwd, Model model){
        if(userService.login(account,pwd)){
            model.addAttribute("login success",account+"--"+pwd);
            model.addAttribute("user",userService.getUser(account));
            return "home";
        }
        model.addAttribute("errormsg","账号或密码错误");
        return "welcome1";
    }

    @RequestMapping(value = "logup" , method = RequestMethod.POST)
    public String logup(@RequestParam("logup_account")String account, @RequestParam("logup_password")String pwd, Model model){
        MajUser user=new MajUser();
        user.setUserId(account);
        user.setPassword(pwd);
        user.setUserName("butters");
        user.setHappyBean("100");
        user.setUserImg("img");
        userService.addUser(user);
        return "home";
    }

    @RequestMapping(value = "checkAccount" , method = RequestMethod.POST)
    @ResponseBody
    public String checkAccount(@RequestParam("logup_account")String account){
        if(userService.containsUser(account)) return "true";
        else if(!MyUtil.matchingName(account)) return "fail";
        return "false";
    }
}
