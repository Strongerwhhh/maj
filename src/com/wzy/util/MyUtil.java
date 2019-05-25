package com.wzy.util;

import java.util.*;
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

    public static LinkedList<Integer> getRandMaj() {
        LinkedList<Integer> maj = new LinkedList<Integer>();
        LinkedList<Integer> list = new LinkedList<Integer>();
        for (int i = 0; i < 136; i++) list.add(i);
        Random random = new Random();
        while (maj.size() < 136) {
            maj.add(list.remove(random.nextInt(list.size())));
        }
        return maj;
    }

    private static HashMap<Integer, LinkedList<Integer>> getMap(ArrayList<Integer> majIdList) {
        HashMap<Integer, LinkedList<Integer>> map = new HashMap<Integer, LinkedList<Integer>>();
        for (int i : majIdList) {
            if (map.containsKey(i % 34)) map.get(i % 34).add(i);
            else {
                LinkedList<Integer> list = new LinkedList<Integer>();
                list.add(i);
                map.put(i % 34, list);
            }
        }
        return map;
    }

    private static int count=0;
    private static void dfs(ArrayList<Integer> majIdList) {
        HashMap<Integer, LinkedList<Integer>> myMap = getMap(majIdList);
        //只有两张牌时判断是否对子
        if (majIdList.size() == 2) {
            if (majIdList.get(0) % 34 == majIdList.get(1) % 34) count++;
            return;
        }
        Set<Integer> set = myMap.keySet();
        for (Integer i : set) {
            //如果有克子则remove掉后继续调用
            if (myMap.get(i).size() >= 3) {
                for (int j = 0; j < 3; j++) majIdList.remove(myMap.get(i).pop());
                dfs(majIdList);
            }
            //如果大于27则是字 没有顺子
            if(i<27){
                //只算0-6的牌
                if(i%9<7){
                    if(set.contains(i+1) & set.contains(i+2)) {
                        int n0=myMap.get(i).pop();
                        int n1=myMap.get(i+1).pop();
                        int n2=myMap.get(i+2).pop();
                        majIdList.remove((Integer)n0);
                        majIdList.remove((Integer)n1);
                        majIdList.remove((Integer)n2);
                        dfs(majIdList);
                        majIdList.add(n0);
                        majIdList.add(n1);
                        majIdList.add(n2);
                        myMap.get(i).push(n0);
                        myMap.get(i+1).push(n1);
                        myMap.get(i+2).push(n2);
                    }
                }
            }
        }
    }

    public static int canHu(ArrayList<Integer> majIdList){
        //牌数不对
        if(majIdList.size()%3 != 2) return -1;
        dfs(majIdList);
        return count;
    }

    public static void main(String[] args) {
        ArrayList<Integer> list=new ArrayList<Integer>();
        list.add(1);
        list.add(2);
        list.add(3);
        list.add(4);
        list.add(35);
        list.add(40);
        list.add(74);
        list.add(108);
        int i=0;
        i=canHu(list);
        System.out.println("i="+i);
    }
}
