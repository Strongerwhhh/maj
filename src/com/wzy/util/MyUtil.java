package com.wzy.util;

import java.util.LinkedList;
import java.util.Random;
import java.util.regex.Pattern;

public class MyUtil {
    public static boolean matchingName(String str) {
        Pattern pattern = Pattern.compile("[a-zA-Z0-9]{6,15}$");
        if (pattern.matcher(str).matches() && str.indexOf(" ") == -1) {
            return true;
        }
        return false;
    }

    public static String matchingPaw(String str) {
        Pattern pattern = Pattern.compile("[a-zA-Z0-9]{6,20}$");
        if (pattern.matcher(str).matches() && str.indexOf(" ") == -1) {
            return "success";
        } else {
            return "fail";
        }
    }
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
