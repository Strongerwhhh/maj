package com.wzy.controller;

import com.google.gson.Gson;
import com.wzy.pojo.Room;
import com.wzy.websocket.MyGoEasy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/ajax")
public class AjaxController {

    @RequestMapping(value = "test", method = RequestMethod.POST)
    public void ajaxTest(@RequestParam("msg") String msg) {
        MyGoEasy.getInstance().showTest("msg"+msg);
    }

    @RequestMapping(value = "start" , method = RequestMethod.POST)
    @ResponseBody
    public int ajaxStart(@RequestParam("userId")String userId){
        MyGoEasy instance = MyGoEasy.getInstance();
        Room room = instance.createRoom(userId);
        StringBuilder sb=new StringBuilder();
        sb.append("sendMaj--");
        sb.append("1");
        for(int i=0;i<14;i++){
            sb.append("--");
            sb.append(room.popMaj());
        }
        instance.showTest(sb.toString());
        return room.getRoomId();
    }
}
