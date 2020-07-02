package com.ricky.Dao;

import com.ricky.Bean.Contest_Problem;
import com.ricky.Bean.Problem;
import org.apache.ibatis.annotations.*;

import java.util.List;

public interface IProblemDao {
    /**
     * 查询所有公开问题的问题信息
     * @return
     */
    public List<Problem> getAllPublic();

    /**
     * 查询所有问题
     * @return
     */
    public List<Problem> getAll();

    /**
     * 插入题目信息
     * @param problem
     */
    public void InsertProblem(Problem problem);

    /**
     * 查找是否已经存在此问题
     * @param problem
     * @return
     */
    public Problem Exists(Problem problem);

    /**
     * 根据problem_id修改问题权限为全局可看
     * @param problem_id
     */
    public void DisplayProblem(Integer problem_id);

    /**
     * 根据problem_id修改问题权限为仅管理员可看
     * @param problem_id
     */
    public void HiddenProblem(Integer problem_id);

    /**
     * 根据problem_id删除问题
     * @param problem_id
     */
    public void DeleteProblem(Integer problem_id);

    /**
     * 根据问题编号查询问题的所有信息
     * @param problem_id
     * @return
     */
    public Problem getProblemById(Integer problem_id);

    /**
     * 根据问题ID查询所有问题
     * @param problems
     * @return
     */
    List<Problem> getProblemsByList(@Param("problems")List<Contest_Problem> problems);

    /**
     * 用户修改题面
     * @param problem
     */
    public void resetProblem(Problem problem);

    /**
     * 查询用户创建的题目
     * @param user_id
     * @return
     */
    public List<Problem> getProblemsByUser(String user_id);
}
