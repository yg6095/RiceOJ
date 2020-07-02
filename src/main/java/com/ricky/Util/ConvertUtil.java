package com.ricky.Util;

public class ConvertUtil {
    public static Integer getLanguage(String str){
        switch (str){
            case "C++":
                return 1;
            case "java":
                return 3;
            case "C":
                return 0;
            case "python":
                return 6;
            default:
                return -1;
        }
    }
}
