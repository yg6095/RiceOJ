package com.ricky.Service;

import com.ricky.Bean.User;
import com.ricky.Dao.IPrivilegeDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PrivilegeService {
    @Autowired
    private IPrivilegeDao privilegeDao;

    public  List<User> getAllPrivilege(){
        List<User> users = new ArrayList<>();
        users = privilegeDao.getAllPrivilege();
        return users;
    }

    public  void Delete(String user_id){
        privilegeDao.Delete(user_id);
    }

    public  void Insert(String user_id){

        privilegeDao.Insert(user_id);
    }

    public boolean exists(String user_id) {
        return privilegeDao.getPrivilegeById(user_id) != null;
    }
}
