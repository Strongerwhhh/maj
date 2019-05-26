package com.wzy.controller;

import com.wzy.bean.PublishBean;
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
    public boolean start(@RequestParam("roomId")int roomId){
        Room room=myGoEasy.getRoom(roomId);
        PublishBean bean=new PublishBean();
//        if(!room.canStart()) return false;
        LinkedList[] handMaj= room.startGame();
        for(int i=0;i<4;i++) {
            bean.setType("initMaj");
            bean.setTableNum(i+1);
            bean.setList(handMaj[i]);
            myGoEasy.publishObject(roomId,bean);
        }
        getMaj(roomId,1);
        return true;
    }

    protected void getMaj(int roomId,int tableNum){
        Room room = myGoEasy.getRoom(roomId);
        PublishBean bean=new PublishBean();
        bean.setType("getMaj");
        bean.setTableNum(tableNum);
        bean.setMajId(room.popMaj());
        myGoEasy.publishObject(roomId,bean);
    }
}
