package com.wzy.pojo;

import com.wzy.bean.ActionBean;
import com.wzy.util.MyUtil;

import java.util.*;

public class Room {
    //majId 0 - 135
    private int tableKey;

    private int roomId;
    private String roomPwd;
    private ArrayList<String> users;
    private LinkedList<Integer> majs;
    private LinkedList<Integer>[] handMaj;
    private LinkedList<Integer>[] tableMaj;
    private HashSet<Integer>[] historyMaj;
    private HashMap<String, LinkedList<Integer>> actions;


    public Room() {
        roomPwd = "";
        users = new ArrayList<String>();
        actions = new HashMap<String, LinkedList<Integer>>();
        //初始化手牌和历史牌
        handMaj = new LinkedList[4];
        tableMaj=new LinkedList[4];
        historyMaj = new HashSet[4];
        for (int i = 0; i < 4; i++) handMaj[i] = new LinkedList<Integer>();
        for (int i = 0; i < 4; i++) tableMaj[i] = new LinkedList<Integer>();
        for (int i = 0; i < 4; i++) historyMaj[i] = new HashSet<Integer>();
    }

    public LinkedList<Integer>[] getTableMaj() {
        return tableMaj;
    }

    public void setTableMaj(LinkedList<Integer>[] tableMaj) {
        this.tableMaj = tableMaj;
    }

    public boolean canStart() {
        return users.size() == 4;
    }

    public int getTableNum(String userId) {
        for (int i = 0; i < users.size(); i++) if (users.get(i).equals(userId)) return i;
        return 0;
    }

    public LinkedList<Integer> getHandMaj(int tableNum){
        return handMaj[tableNum-1];
    }

    public LinkedList<Integer>[] startGame() {
        tableKey=1;
        majs = MyUtil.getRandMaj();
        for (int i = 0; i < 4; i++)
            for (int j = 0; j < 13; j++)
                handMaj[i].add(majs.pop());
        return handMaj;
    }

    public int getTableKey(){return tableKey;}

    public void showMaj(int majId,int tableNum){
        handMaj[tableNum-1].remove((Integer)majId);
        //从手牌区移除
        tableMaj[tableNum-1].add(majId);
        //加入出牌区
        initActions(majId,tableNum);
        //初始化动作列表
        tableKey=(tableKey%4)+1;
        //出牌人轮转
    }

    public void doAction(int tableNum,LinkedList<Integer> majIdList){
        for(int i=0;i<majIdList.size();i++){
            handMaj[tableNum-1].remove((Integer)majIdList.get(i));
            tableMaj[tableNum-1].add((Integer)majIdList.get(i));
        }
        tableKey=(tableNum%4)+1;
    }

    public String getRoomPwd() {
        return roomPwd;
    }

    public void quitRoom(int tableNum) {if (users.contains(tableNum)) users.remove(tableNum);
    }


    public void setRoomPwd(String roomPwd) {
        this.roomPwd = roomPwd;
    }

    public ArrayList<String> getUsers() {
        return users;
    }

    public int popMaj() {
        if (majs.size() == 0) return 0;
        else return majs.pop();
    }

    public int getRoomId() {
        return roomId;
    }

    public void setRoomId(int roomId) {
        this.roomId = roomId;
    }

    public boolean addUser(String userId) {
        if (users.size() < 4) {
            users.add(userId);
            return true;
        }
        return false;
    }

    public int getSize() {
        return users.size();
    }

    public ActionBean popAction() {
        ActionBean bean = new ActionBean();
        if (!actions.get("hu").isEmpty()) {
            bean.setTableNum(actions.get("hu").pop());
            bean.addAction("hu");
            return bean;
        }

        if (!actions.get("gang").isEmpty()){
            bean.setTableNum(actions.get("gang").pop());
            bean.addAction("gang");
        }

        if (!actions.get("peng").isEmpty()){
            bean.setTableNum(actions.get("peng").pop());
            bean.addAction("peng");
        }
        if(!actions.get("chi").isEmpty()){
            if(bean.getTableNum()==0 || bean.getTableNum()==actions.get("chi").get(0)){
                bean.setTableNum(actions.get("chi").pop());
                bean.addAction("chi");
            }
        }
        return bean;
    }

    public void initActions(int majId, int tableNum) {
        actions.put("peng", new LinkedList<Integer>());
        actions.put("gang", new LinkedList<Integer>());
        actions.put("chi", new LinkedList<Integer>());

        actions.put("hu", hu(majId, tableNum));
        int i = peng(majId, tableNum);
        if (i > 0) actions.get("peng").push(i);
        if (gang(majId, i)) actions.get("gang").push(i);
        if (chi(majId, tableNum)) actions.get("chi").push((tableNum % 4) + 1);
    }

    private int peng(int majId, int tableNum) {
        for (int i = 0; i < 4; i++) {
            if (i != tableNum - 1) {
                int count = 0;
                for (int j : handMaj[i]) if ((j % 34) == (majId % 34)) count++;
                if (count == 2) return i + 1;
            }
        }
        return 0;//无人可碰
    }

    private boolean gang(int majId, int tableNum) {
        int count = 0;
        for (int j : handMaj[tableNum]) if ((j % 34) == (majId % 34)) count++;
        if (count == 3) return true;
        return false;
    }

    private boolean chi(int majId, int tableNum) {
        if (majId % 34 >= 27) return false;
        int num = tableNum % 4;
        boolean[] flags = new boolean[4];
        for (int i : handMaj[num]) {
            if (i % 34 < 27) {
                int x = (majId % 34) % 9;
                int y = (i % 34) % 9;
                if (y == (x - 2)) flags[0] = true;
                if (y == (x - 1)) flags[1] = true;
                if (y == (x + 1)) flags[2] = true;
                if (y == (x + 2)) flags[3] = true;
            }
        }
        if (flags[0] & flags[1]) return true;
        if (flags[1] & flags[2]) return true;
        if (flags[2] & flags[3]) return true;
        return false;
    }

    private LinkedList<Integer> hu(int majId, int tableNum) {
        LinkedList<Integer> list = new LinkedList<Integer>();
        for (int i = 0; i < 4; i++) {
            if (i != tableNum) {
                handMaj[i].add(majId);
                if (MyUtil.canHu(handMaj[i])) list.push(i);
                handMaj[i].remove((Integer) majId);
            }
        }
        return list;
    }
}
