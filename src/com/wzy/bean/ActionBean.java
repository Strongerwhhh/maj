package com.wzy.bean;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;

public class ActionBean {
    private int tableNum;
    private LinkedList<String> actions;
//    private LinkedList<>
    public void addAction(String action){actions.add(action);}

    public LinkedList<String> getActions() {
        return actions;
    }

    public void setActions(LinkedList<String> actions) {
        this.actions = actions;
    }

    public int getTableNum() {
        return tableNum;
    }

    public void setTableNum(int tableNum) {
        this.tableNum = tableNum;
    }
}
