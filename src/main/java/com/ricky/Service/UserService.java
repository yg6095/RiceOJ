package com.ricky.Service;

import com.ricky.Bean.RankUser;
import com.ricky.Bean.User;
import com.ricky.Dao.IUserDao;
import com.ricky.Util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
@Service
public class UserService {

    @Autowired
    private IUserDao userDao;


    public  List<RankUser> getAllUserRank(){
        List<RankUser> rankUsers = userDao.getAllUserRank();
        for(RankUser rankUser: rankUsers){
            if(rankUser.getSubmit() != 0) {
                rankUser.setPass_rate((float)rankUser.getSolve() / rankUser.getSubmit());
            }
        }
        return rankUsers;
    }
    public User update(User user){
        user = userDao.UserLogin(user);
        if(user != null){
            RankUser rankUser = user.getRankUser();
            if(rankUser.getSubmit() != 0) {
                rankUser.setPass_rate((float) rankUser.getSolve() / rankUser.getSubmit());
                user.setRankUser(rankUser);
            }
        }
        return user;
    }
    public  User login(String user_id, String password) {
        User user = new User();
        user.setUser_id(user_id);
        user.setPassword(PasswordUtil.getResult(password));
        user.setAccesstime(new Date());
        user = this.update(user);
        if (user != null) {
            userDao.UpdateUserLogin(user.getUser_id());
        }
        return user;
    }

    public void register(User user){
        user.setPassword(PasswordUtil.getResult(user.getPassword()));
        userDao.UserInsert(user);
    }
    public boolean isExists(String user_id){
        boolean ac = userDao.getUserById(user_id) != null;
        return ac;
    }
    public boolean checkUserEmail(User user){
        return userDao.checkUserEmail(user) != null;
    }

    public void resetPassword(User user) {
        user.setPassword(PasswordUtil.getResult(user.getPassword()));
        userDao.resetPassword(user);
    }

    public void resetInfo(User user) {
        user.setPassword(PasswordUtil.getResult(user.getPassword()));
        userDao.resetInfo(user);
    }
}
