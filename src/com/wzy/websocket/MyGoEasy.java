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
    public static HashMap<Integer, Room> rooms;
    private Gson gson = new Gson();
    private MyGoEasy() {
        goEasy = new GoEasy("http://rest-hangzhou.goeasy.io","BC-6058f1b8923346efade7b8b3d7314b06");
        rooms = new HashMap<Integer, Room>();
    }

    public static MyGoEasy getInstance() {
        if(instance==null) instance=new MyGoEasy();
        return instance;
    }



    public Room createRoom(String userId) {
        Room room = new Room();
        room.setRoomId(getRandId());
        room.addUser(userId);
        rooms.put(room.getRoomId(), room);
        return room;
    }

    public void showTest(String msg){
        goEasy.publish("test",msg);
    }

    public String getRoomPwd(int roomId){
        if(rooms.get(roomId)==null) return null;
        return rooms.get(roomId).getRoomPwd();
    }

    public int joinRoom(int roomId,String userId){
        if(!rooms.containsKey(roomId)) return -1;//-1 为房间不存在
        Room room=rooms.get(roomId);
        if(room.addUser(userId)) return room.getSize();
        else return -2;//-2 为房间人满了
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
