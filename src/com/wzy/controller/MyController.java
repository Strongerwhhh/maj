package com.wzy.controller;

import com.wzy.dao.UserDao;
import com.wzy.pojo.MajUser;
import com.wzy.pojo.Room;
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


    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("user");
        return "home";
    }


    @RequestMapping(value = "createRoom" , method = RequestMethod.POST)
    public String createRoom(@RequestParam("userId") String userId ,@RequestParam("roomPwd") String roomPwd, Model model){
        Room room = MyGoEasy.getInstance().createRoom(userId);
        room.setRoomPwd(roomPwd);
        model.addAttribute("roomId",room.getRoomId());
        return "games";
    }

    @RequestMapping(value = "roomIsLock" , method = RequestMethod.POST)
    @ResponseBody
    public String roomIsLock(@RequestParam("roomId")int roomId){
        String roomPwd = MyGoEasy.getInstance().getRoomPwd(roomId);
        if(roomPwd!=null && !roomPwd.equals("")) return "locked";
        else return "unlocked";
    }

    @RequestMapping(value = "joinRoom" , method = RequestMethod.POST)
    public String joinRoom(@RequestParam("userId")String userId , @RequestParam("roomId")int roomId , Model model){
        int i = MyGoEasy.getInstance().joinRoom(roomId, userId);
        if(i<0){
            String msg=(i==-1)?"房间不存在":"人数已满";
            model.addAttribute("msg",msg);
            return "home";
        }
        model.addAttribute("tableNum",i);
        return "room";
    }

}
