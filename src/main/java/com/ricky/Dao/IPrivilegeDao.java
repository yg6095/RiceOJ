package com.ricky.Dao;

import com.ricky.Bean.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface IPrivilegeDao {

    /**
     * 查询所有拥有权限的用户
     * @return
     */
    public List<User> getAllPrivilege();

    /**
     * 删除用户权限
     * @param user_id
     */
    public void Delete(String user_id);

    /**
     * 添加用户权限
     * @param user_id
     */
    public void Insert(String user_id);

    /**
     * 根据用户名查询权限
     * @param user_id
     * @return
     */
    public String getPrivilegeById(String user_id);
}
