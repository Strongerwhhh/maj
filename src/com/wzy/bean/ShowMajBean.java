package com.wzy.bean;

import java.util.ArrayList;

public class ShowMajBean {
    private String type = "showMaj";
    private int tableNum;
    private ArrayList<Integer> majIdList = new ArrayList<Integer>();

    public int getTableNum() {
        return tableNum;
    }

    public void setTableNum(int tableNum) {
        this.tableNum = tableNum;
    }

    public void addMaj(int majId){
        majIdList.add(majId);
    }

    public ArrayList<Integer> getMajIdList() {
        return majIdList;
    }

    public void setMajIdList(ArrayList<Integer> majIdList) {
        this.majIdList = majIdList;
    }
}
