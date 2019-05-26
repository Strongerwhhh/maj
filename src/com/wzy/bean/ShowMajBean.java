package com.wzy.bean;

import java.util.ArrayList;
import java.util.LinkedList;

public class ShowMajBean {
    private int roomId;
    private int tableNum;
    private int majId;
    private LinkedList<Integer> majIdList = new LinkedList<Integer>();


    public int getTableNum() {
        return tableNum;
    }

    public void setTableNum(int tableNum) {
        this.tableNum = tableNum;
    }

    public void addMaj(int majId){
        majIdList.add(majId);
    }

    public LinkedList<Integer> getMajIdList() {
        return majIdList;
    }

    public void setMajIdList(LinkedList<Integer> majIdList) {
        this.majIdList = majIdList;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getMajId() {
        return majId;
    }

    public void setMajId(int majId) {
        this.majId = majId;
    }
}
