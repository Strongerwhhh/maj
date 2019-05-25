package com.wzy.bean;

import java.util.ArrayList;

public class AjaxBean {
    private String type;
    private int roomId;
    private int tableNum;
    private ArrayList<Integer> majIdList;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public ArrayList<Integer> getMajIdList() {
        return majIdList;
    }

    public void setMajIdList(ArrayList<Integer> majIdList) {
        this.majIdList = majIdList;
    }

    public int getTableNum() {
        return tableNum;
    }

    public void setTableNum(int tableNum) {
        this.tableNum = tableNum;
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }
}
