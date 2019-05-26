package com.wzy.controller;

import com.wzy.pojo.MajUser;
import com.wzy.pojo.Room;
import com.wzy.websocket.MyGoEasy;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class RoomController {


    @RequestMapping(value = "createRoom" , method = RequestMethod.POST)
    public String createRoom(RedirectAttributes attr,@RequestParam(name="roomPwd",required = false,defaultValue = "")String roomPwd){
        Room room = MyGoEasy.getInstance().createRoom();
        room.setRoomPwd(roomPwd);
        attr.addAttribute("roomId",room.getRoomId());
        attr.addAttribute("roomPwd",roomPwd);
        return "redirect: joinRoom";
    }

    @RequestMapping(value = "joinRoom" , method = RequestMethod.GET)
    public String joinRoom(@RequestParam("roomId")int roomId , HttpSession session, RedirectAttributes attr,Model model,
                           @RequestParam(name="roomPwd",required = false,defaultValue = "")String roomPwd){
        MajUser user = (MajUser) session.getAttribute("user");
        int i = MyGoEasy.getInstance().joinRoom(roomId, roomPwd,user.getUserId());
        if(i<=0) {
            String errorMsg = null;
            if (i == 0) errorMsg = "房间不存在";
            if (i == -1) errorMsg = "密码错误";
            if (i == -2) errorMsg = "房间已满";
            if (i == -3) errorMsg = "不可重复加入房间";
            model.addAttribute("errorMsg", errorMsg);
            return "home";
        }
        else{
            attr.addAttribute("tableNum",i);
            attr.addAttribute("roomId",roomId);
        }
        return "redirect: room";
    }

    @RequestMapping("room")
    public String joinRoom(Model model,int tableNum,int roomId,HttpSession session){
        model.addAttribute("roomId",roomId);
        model.addAttribute("tableNum",tableNum);
        return "games";
    }

    @RequestMapping(value = "roomIsLock" , method = RequestMethod.POST)
    @ResponseBody
    public boolean roomIsLock(@RequestParam("roomId")int roomId){
        String roomPwd = MyGoEasy.getInstance().getRoomPwd(roomId);
        if(roomPwd!=null && !roomPwd.equals("")) return true;
        else return false;
    }

    @RequestMapping("/quitRoom")
    @ResponseBody
    public void quitRoom(int roomId,int tableNum){
        MyGoEasy.getInstance().quitRoom(roomId,tableNum);
        return;
    }
}
