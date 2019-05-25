package com.wzy.controller;

import com.wzy.bean.ShowMajBean;
import com.wzy.pojo.Room;
import com.wzy.websocket.MyGoEasy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.LinkedList;

@Controller
@RequestMapping("/game")
public class GameController {
    private MyGoEasy myGoEasy=MyGoEasy.getInstance();
    @RequestMapping(value = "start",method = RequestMethod.POST)
    @ResponseBody
    public ShowMajBean start(@RequestParam("roomId")int roomId){
        Room room=MyGoEasy.getInstance().getRoom(roomId);
        LinkedList[] handMaj= room.startGame();
        ShowMajBean bean=null;
        for(int i=0;i<4;i++) {
            bean=new ShowMajBean();
            bean.setType("initMaj");
            bean.setTableNum(i+1);
            bean.setMajIdList(handMaj[i]);
            myGoEasy.publishObject(roomId,bean);
        }
        return bean;
    }
}
