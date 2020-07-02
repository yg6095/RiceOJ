package com.ricky.Dao;

import com.ricky.Bean.Contest;
import com.ricky.Bean.Contest_User;
import com.ricky.Bean.Contest_Problem;

import java.util.List;

public interface IContestDao {

    /**
     * 根据比赛ID查询比赛的所有信息
     * @param contest_id
     * @return
     */
    public Contest getContestById(Integer contest_id);
    /**
     * 根据比赛ID查询所有题目
     * @return
     */
    public List<Contest_Problem> getAllProblemIdsByContestId(Integer contest_id);

    /**
     * 插入比赛题目
     * @param contest_problem
     */
    public void InsertContestProblem(Contest_Problem contest_problem);

    /**
     * 创建比赛
     * @param contest
     */
    public void InsertContest(Contest contest);

    /**
     * 根据比赛ID查询注册的用户ID
     * @param contest_id
     */
    public List<Contest_User> getAllUserByContestId(Integer contest_id);

    /**
     * 插入用户注册信息
     * @param contest_user
     */
    public void InsertContestUser(Contest_User contest_user);

    /**
     * 查询尚未开始的比赛
     * @return
     */
    public List<Contest> getFutureContest();

    /**
     * 查询已经结束的比赛
     * @return
     */
    public List<Contest> getEndContest();

    /**
     * 根据比赛ID查询注册密码
     * @param contest_id
     * @return
     */
    public String getContestPasswordById(Integer contest_id);

    /**
     * 根据用户ID查询用户注册的比赛
     * @param user_id
     * @return
     */
    public List<Contest> getContestsByUserId(String user_id);

    /**
     * 查询所有比赛信息
     * @return
     */
    public List<Contest> getAllContests();

    /**
     * 删除比赛
     * @param contest_id
     */
    public void deleteContest(Integer contest_id);

    /**
     * 删除比赛题目
     * @param contest_id
     */
    public void deleteContestProblem(Integer contest_id);

    /**
     * 删除比赛用户
     * @param contest_id
     */
    public void deleteContestUser(Integer contest_id);

    /**
     * 修改比赛信息
     * @param contest
     */
    public void resetContest(Contest contest);

    /**
     * 根据用户查询用户创建的比赛
     * @param user_id
     * @return
     */
    public List<Contest> getContestsByUser(String user_id);
}
