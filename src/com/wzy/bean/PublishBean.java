package com.wzy.bean;

import java.util.ArrayList;
import java.util.List;

public class PublishBean {
    private String type;
    private int tableNum;
    private int majId;
    private List majIdList;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List getList() {
        return majIdList;
    }

    public void setList(List list) {
        this.majIdList = list;
    }

    public int getTableNum() {
        return tableNum;
    }

    public void setTableNum(int tableNum) {
        this.tableNum = tableNum;
    }

    public int getMajId() {
        return majId;
    }

    public void setMajId(int majId) {
        this.majId = majId;
    }
}
