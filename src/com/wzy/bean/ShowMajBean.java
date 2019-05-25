package com.wzy.bean;

import java.util.ArrayList;
import java.util.LinkedList;

public class ShowMajBean {
    private String type = "showMaj";
    private int tableNum;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
}
