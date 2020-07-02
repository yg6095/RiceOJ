package com.ricky.Util;

import com.ricky.Bean.User;

import java.util.List;

public class UserUtil {
    public static List<User> Manager_Update_User(List<User> users) {
        for(User user:users){
            String delete = "<button class='btn-info ' onclick='Delete(\""+user.getUser_id()+"\")'>删除</button>";
            user.setDelete(delete);
        }
        return users;
    }
}
