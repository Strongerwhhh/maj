package com.wzy.service;

import com.wzy.dao.UserDao;
import com.wzy.pojo.MajUser;

import java.util.*;

public class UserService {
    private UserDao userDao;
    private static HashSet<String> idList;
    private UserService() {
        userDao = new UserDao();
        idList=new HashSet<String>();
    }

    private static UserService instance;
    public static UserService getInstance(){
        if(instance==null){
            instance=new UserService();
        }
        return instance;
    }
    public MajUser getUser(String userId){
        return userDao.selectUser(userId);
    }
    public boolean login(String userId,String pwd){
        MajUser user = userDao.selectUser(userId);
        if(user==null || !user.getPassword().equals(pwd)) return false;
        return true;
    }
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
        if(idList.contains(userId)) return true;
        if(userDao.selectUser(userId)==null) return false;
        idList.add(userId);
        return true;
    }

    private boolean saveOrUpdateUser(MajUser user) {
        return userDao.saveOrUpdateUser(user);
    }
}
