package com.wzy.util;

import java.util.LinkedList;
import java.util.Random;

public class MyUtil {
    
    public static LinkedList<Integer> getRandMaj(){
        LinkedList<Integer> maj=new LinkedList<Integer>();
        LinkedList<Integer> list = new LinkedList<Integer>();
        for(int i=0;i<136;i++) list.add(i);
        Random random = new Random();
        while(maj.size()<136){
            maj.add(list.remove(random.nextInt(list.size())));
        }
        return maj;
    }
}
