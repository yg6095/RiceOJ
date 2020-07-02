package com.ricky.Dao;

import com.ricky.Bean.RankUser;
import com.ricky.Bean.User;
import org.apache.ibatis.annotations.*;
import org.apache.ibatis.mapping.FetchType;

import java.util.Date;
import java.util.List;

public interface IUserDao {
    /**
     * 用户login
     * @param user
     * @return 用户登录成功返回用户所有信息，否则返回null
     */
    public User UserLogin(User user);

    /**
     * 插入用户
     * @param user
     */
    public void UserInsert(User user);

    /**
     * 根据user_id查询用户信息
     * @param user_id
     * @return
     */
    public User getUserById(String user_id);

    /**
     * 更新用户登录时间
     * @param user_id
     */
    public void UpdateUserLogin(String user_id);

    /**
     * 查询用户rank表
     * @return
     */
    public List<RankUser> getAllUserRank();


    /**
     * 根据用户id查询用户rank
     * @return
     */
    public RankUser getUserRankById(String user_id);


    /**
     * 更新用户密码
     * @param user
     */
    public void resetPassword(User user);

    /**
     * 检查用户名邮箱是否匹配
     * @param user
     * @return
     */
    public User checkUserEmail(User user);

    /**
     * 修改用户信息
     * @param user
     */
    public void resetInfo(User user);
}
