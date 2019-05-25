package com.wzy.pojo;

import com.wzy.bean.ActionBean;
import com.wzy.util.MyUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;

public class Room {
    //majId 0 - 135
    private int roomId;
    private String roomPwd;
    private ArrayList<String> users;
    private LinkedList<Integer> majs;
    private LinkedList<Integer>[] handMaj;
    private HashSet<Integer>[] tableMaj;
    private HashSet<Integer>[] historyMaj;
    private LinkedList<String> actions;

    public HashSet<Integer>[] getTableMaj() {
        return tableMaj;
    }

    public void setTableMaj(HashSet<Integer>[] tableMaj) {
        this.tableMaj = tableMaj;
    }

    public Room(){
        users=new ArrayList<String>();
        //初始化手牌和历史牌
        handMaj=new LinkedList[4];
        historyMaj=new HashSet[4];
        for(int i=0;i<4;i++) handMaj[i]=new LinkedList<Integer>();
        for(int i=0;i<4;i++) historyMaj[i]=new HashSet<Integer>();
//        for(int i=0;i<4;i++) tableMaj[i]=new HashSet<Integer>();
    }

    public LinkedList<Integer>[] startGame(){
        majs= MyUtil.getRandMaj();
        for(int i=0;i<4;i++)
            for(int j=0;j<13;j++)
                handMaj[i].add(majs.pop());
            return handMaj;
    }


    public String getRoomPwd() {
        return roomPwd;
    }

    public void setRoomPwd(String roomPwd) {
        this.roomPwd = roomPwd;
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

    public void addAction(){}

    public LinkedList<String> getActions() {
        return actions;
    }

    public void setActions(LinkedList<String> actions) {
        this.actions = actions;
    }

    public int peng(int majId, int tableNum){
        for(int i=0;i<4;i++){
            if( i != tableNum-1 ){
                int count=0;
                for(int j:handMaj[i]) if( (j%34) == (majId%34) ) count ++;
                if(count==2) return i+1;
            }
        }
        return -1;//无人可碰
    }

    public boolean gang(int majId,int tableNum){
        int count=0;
        for(int j:handMaj[tableNum]) if( (j%34) == (majId%34) ) count ++;
        if(count==3) return true;
        return false;
    }

    public boolean chi(int majId,int tableNum){
        if(majId%34 >= 27) return false;
        int num=tableNum%4;
        boolean[] flags=new boolean[4];
        for(int i:handMaj[num]){
            if(i%34 < 27){
                int x=(majId%34)%9;
                int y=(i%34)%9;
                if(y==(x-2)) flags[0]=true;
                if(y==(x-1)) flags[1]=true;
                if(y==(x+1)) flags[2]=true;
                if(y==(x+2)) flags[3]=true;
            }
        }
        if(flags[0] & flags[1]) return true;
        if(flags[1] & flags[2]) return true;
        if(flags[2] & flags[3]) return true;
        return false;
    }

    public int hu(int majId,int tableNum){
        return 0;
    }
}
