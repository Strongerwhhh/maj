package com.wzy.service;

import com.wzy.dao.UserDao;
import com.wzy.pojo.MajUser;

import java.util.*;

public class UserService {
    private UserDao userDao;

    private UserService() {
        userDao = new UserDao();
    }

    private static UserService instance;
    public static UserService getInstance(){
        if(instance==null){
            instance=new UserService();
        }
        return instance;
    }

//    public boolean login(MajUser user){
//        allUsers.contains(user)
//    }
    public boolean addUser(MajUser user) {
        if (!containsUser(user.getUserId()) && saveOrUpdateUser(user)){
            return true;
        }
        return false;
    }

    public boolean updateUser(MajUser user) {
        if (containsUser(user.getUserId()) && saveOrUpdateUser(user)){
//            allUsers.
            return true;
        }
        return false;
    }

    public boolean containsUser(MajUser majUser) {
        return userDao.selectUser(majUser.getUserId())!=null;//已存在为true 未存在为false
    }

    public boolean containsUser(String userId) {
        return userDao.selectUser(userId)!=null;
    }

    private boolean saveOrUpdateUser(MajUser user) {
        return userDao.saveOrUpdateUser(user);
    }
}
