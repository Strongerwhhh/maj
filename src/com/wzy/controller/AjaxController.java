package com.wzy.controller;

import com.google.gson.Gson;
import com.wzy.bean.ActionBean;
import com.wzy.bean.AjaxActionBean;
import com.wzy.bean.PublishBean;
import com.wzy.bean.ShowMajBean;
import com.wzy.pojo.Room;
import com.wzy.websocket.MyGoEasy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/ajax")
public class AjaxController {
    private MyGoEasy myGoEasy=MyGoEasy.getInstance();
    @RequestMapping(value = "test", method = RequestMethod.GET)
    @ResponseBody
    public String ajaxTest() {
        ShowMajBean bean=new ShowMajBean();
        bean.setTableNum(1);
        bean.addMaj(1);
        bean.addMaj(4);
        bean.addMaj(111);
        Gson gson=new Gson();
        return gson.toJson(bean);
    }


    @RequestMapping(value = "showMaj" , method = RequestMethod.POST)
    @ResponseBody
    public boolean showMaj(ShowMajBean bean){
        int roomId = bean.getRoomId();
        Room room=myGoEasy.getRoom(roomId);
        room.showMaj(bean.getMajId(),bean.getTableNum());
        PublishBean publishBean=new PublishBean();
        publishBean.setType("showMaj");
        publishBean.setTableNum(bean.getTableNum());
        publishBean.setMajId(bean.getMajId());
        publishBean.setList(room.getHandMaj(bean.getTableNum()));
        myGoEasy.publishObject(roomId,publishBean);
        fun1(roomId);
        return true;
    }

    @RequestMapping(value = "action",method = RequestMethod.POST)
    @ResponseBody
    public boolean action(AjaxActionBean bean){
        int roomId = bean.getRoomId();
        Room room=myGoEasy.getRoom(roomId);
        PublishBean publishBean=new PublishBean();
        publishBean.setType(bean.getType());
        publishBean.setTableNum(bean.getTableNum());
        publishBean.setList(bean.getMajIdList());
        myGoEasy.publishObject(roomId,publishBean);
        return true;
    }

    @RequestMapping("guo")
    @ResponseBody
    public void guo(int roomId,int tableNum){
        fun1(roomId);
    }

    @RequestMapping("hu")
    @ResponseBody
    public void hu(int roomId,int tableNum){
        PublishBean bean=new PublishBean();
        bean.setType("hu");
        bean.setTableNum(tableNum);
        myGoEasy.publishObject(roomId,bean);
    }


    private void fun1(int roomId){
        Room room=myGoEasy.getRoom(roomId);
        ActionBean actionBean=room.popAction();
        PublishBean publishBean=new PublishBean();
        //如果有可执行操作
        if(actionBean.getTableNum()!=0){
            publishBean.setType("actions");
            publishBean.setList(actionBean.getActions());
            publishBean.setTableNum(room.getTableKey());
        }
        else {
            publishBean.setType("getMaj");
            publishBean.setMajId(room.popMaj());
            publishBean.setTableNum(room.getTableKey());
        }

        myGoEasy.publishObject(roomId,publishBean);
    }
//    private void

}
