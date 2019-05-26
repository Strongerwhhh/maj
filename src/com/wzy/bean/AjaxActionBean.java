package com.wzy.bean;

import java.util.List;

public class AjaxActionBean {
    private String type;
    private int roomId;
    private int tableNum;
    private List majIdList;

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public int getTableNum() {
        return tableNum;
    }

    public void setTableNum(int tableNum) {
        this.tableNum = tableNum;
    }

    public List getMajIdList() {
        return majIdList;
    }

    public void setMajIdList(List majIdList) {
        this.majIdList = majIdList;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
