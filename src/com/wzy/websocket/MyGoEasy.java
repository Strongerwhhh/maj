package com.wzy.websocket;

import com.google.gson.Gson;
import com.wzy.bean.ShowMajBean;
import com.wzy.pojo.Room;
import io.goeasy.GoEasy;

import java.util.HashMap;
import java.util.Random;
import java.util.Set;

public class MyGoEasy {
    private static GoEasy goEasy;
    private static MyGoEasy instance;
    private static HashMap<Integer, Room> rooms;
    private static HashMap<String , Integer> players;
    private Gson gson = new Gson();
    private MyGoEasy() {
        goEasy = new GoEasy("http://rest-hangzhou.goeasy.io","BC-6058f1b8923346efade7b8b3d7314b06");
        rooms = new HashMap<Integer, Room>();
        players=new HashMap<String,Integer>();
    }

    public static MyGoEasy getInstance() {
        if(instance==null) instance=new MyGoEasy();
        return instance;
    }

    public int getTableNum(String userId){
        if(!players.containsKey(userId)) return 0;//不存在
        Room room = rooms.get(players.get(userId));
        return room.getTableNum(userId);
    }

    public static Room getRoom(int roomId){return rooms.get(roomId);}

    public Room createRoom() {
        Room room = new Room();
        room.setRoomId(getRandId());
        rooms.put(room.getRoomId(), room);
        return room;
    }

    public int joinRoom(int roomId,String roomPwd,String userId){
        if(!rooms.containsKey(roomId)) return 0;//0 为房间不存在
        if(getRoomByUserId(userId)>0) return -3;//-3为该用户已加入某房间
        Room room=rooms.get(roomId);
        if(!room.getRoomPwd().equals(roomPwd)) return -1;//-1为密码错误
        if(room.addUser(userId)) {
            players.put(userId,roomId);
            return room.getSize();
        }
        else return -2;//-2 为房间人满了
    }

    public void showTest(String msg){
        goEasy.publish("test",msg);
    }

    public String getRoomPwd(int roomId){
        if(rooms.get(roomId)==null) return null;
        return rooms.get(roomId).getRoomPwd();
    }

    public static int getRoomByUserId(String userId){
        if(players.isEmpty()) return 0;
        if(!players.containsKey(userId)) return 0;//0为无该用户
        return players.get(userId);
    }

    public void quitRoom(int roomId,int tableNum){
        if(rooms.containsKey(roomId)){
            rooms.get(roomId).quitRoom(tableNum);
        }
    }

    public void publishObject(int roomId,Object o){ goEasy.publish(Integer.toString(roomId),gson.toJson(o)); }

    private  int getRandId() {
        Random random = new Random();
        Set<Integer> ids = rooms.keySet();
        while (true) {
            int id = random.nextInt(90000) + 10000;
            if (!ids.contains(id)) return id;
        }
    }

}
