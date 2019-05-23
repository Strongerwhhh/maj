package com.wzy.pojo;

import com.wzy.util.MyUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;

public class Room {
    private int roomId;
    private ArrayList<String> users;
    private LinkedList<Integer> majs;
    private HashSet<Integer>[] handMaj;
    private HashSet<Integer>[] historyMaj;
    public Room(){
        majs= MyUtil.getRandMaj();
        users=new ArrayList<String>();
        //初始化手牌和历史牌
        handMaj=new HashSet[4];
        historyMaj=new HashSet[4];
        for(int i=0;i<4;i++) handMaj[i]=new HashSet<Integer>();
        for(int i=0;i<4;i++) historyMaj[i]=new HashSet<Integer>();
    }

    public ArrayList<String> getUsers() {
        return users;
    }

    public int popMaj(){
        if(majs.size()==0) return 0;
        else return majs.pop();
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public boolean addUser(String userId){
        if(users.size()<4) {
            users.add(userId);
            return true;
        }
        return false;
    }

    public int getSize(){return users.size();}

}
