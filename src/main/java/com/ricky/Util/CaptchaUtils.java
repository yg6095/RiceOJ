// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   CaptchaUtils.java

package com.ricky.Util;

import org.springframework.stereotype.Component;

import java.util.Random;
@Component
public class CaptchaUtils{
    public static String creatCaptcha(){
        String captcha = captcha(6);
        return captcha;
    }

    public static String captcha(int charCount) {
        String charValue = "";
        for(int i = 0; i < charCount; i++) {
            char c = (char)(randomInt(0, 10) + 48);
            charValue = (new StringBuilder(String.valueOf(charValue))).append(String.valueOf(c)).toString();
        }

        return charValue;
    }

    public static int randomInt(int from, int to){
        Random r = new Random();
        return from + r.nextInt(to - from);
    }
}
