package com.wzy.controller;

import com.wzy.pojo.Room;
import com.wzy.websocket.MyGoEasy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;

@Controller
public class MyController {


    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        return "home";
    }








}
