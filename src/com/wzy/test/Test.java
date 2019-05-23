package com.wzy.test;

import com.wzy.dao.UserDao;
import com.wzy.pojo.MajUser;
import com.wzy.service.UserService;
import com.wzy.websocket.MyGoEasy;
import io.goeasy.GoEasy;

import java.util.ArrayList;
import java.util.List;

public class Test {
    public static void main(String[] args) {
        MyGoEasy.getInstance().showTest("test test");
//        MajUser user=new MajUser();
//        user.setUserName("name");
//        user.setUserImg("img");
//        user.setUserId("id5");
//        user.setPassword("pwd");
//        user.setHappyBean("bean");
//        boolean b;
//        UserService instance = UserService.getInstance();
//        b=instance.containsUser(user);
//
//        List<String> list = new ArrayList<String>();
//        list.add("id1");
//        list.add("id3");
//        new UserDao().deleteUserById(list);
    }
}
