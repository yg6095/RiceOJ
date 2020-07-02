package com.ricky.Dao;

import com.ricky.Bean.Contest_Problem;
import com.ricky.Bean.Contest_User;
import com.ricky.Bean.RankUser;
import com.ricky.Bean.Solution;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectKey;

import java.util.Date;
import java.util.List;

public interface ISolutionDao {
    /**
     * 查询所有提交记录
     * @return
     */
    public List<Solution> getAll();

    /**
     * 插入一个提交记录
     * @param solution
     */
    public void InsertSolution(Solution solution);

    /**
     * 插入用户提交的代码
     * @param solution
     */
    public void InsertSource(Solution solution);

    /**
     * 根据用户id查询用户通过的题号
     * @param user_id
     * @return
     */
    public List<Integer> getACProblemById(String user_id);

    /**
     * 根据用户id查询用户的提交通过数量
     * @param user_id
     * @return
     */
    public Integer getACCount(String user_id);
    /**
     * 根据用户id查询用户提交的题号
     * @param user_id
     * @return
     */
    public List<Integer> getAllSubmitById(String user_id);


    /**
     * 根据比赛ID查询所有比赛提交的solutions
     * @param contest_id
     * @return
     */
    List<Solution> getContestStatusById(Integer contest_id);

    /**
     * 根据用户ID  比赛ID查询用户通过的题号
     * @param contest_user
     * @return
     */
    List<Integer> getContestACByUserId(Contest_User contest_user);

    /**
     * 根据用户ID  比赛ID查询用户提交过的题号
     * @param contest_user
     * @return
     */
    List<Integer> getContestSubByUserId(Contest_User contest_user);

    /**
     * 根据比赛ID查询比赛的相关Rank信息
     * @return
     */
    List<Solution> getContestRank(Contest_Problem contest_problem);

    /**
     * 根据题号和用户名查询是否已经AC
     * @param contest_problem
     * @param s
     * @return
     */
    List<Solution> checkACByUser(@Param("contest_problem")Contest_Problem contest_problem, @Param("user_id") String s,
                      @Param("start_time") Date start_time, @Param("end_time") Date end_time);

    /**
     * 根据题号和用户名查询题目提交次数
     * @param contest_problem
     * @param s
     * @return
     */
    List<Solution> getSubByUser(@Param("contest_problem")Contest_Problem contest_problem, @Param("user_id")String s,
                     @Param("start_time") Date start_time, @Param("end_time") Date end_time);

    /**
     * 查询用户最后一次通过的时间
     * @param contest_problem
     * @param s
     * @param start_time
     * @param end_time
     * @return
     */
    Date getLastACDate(@Param("contest_problem")Contest_Problem contest_problem, @Param("user_id")String s,
                       @Param("start_time") Date start_time, @Param("end_time") Date end_time);

    /**
     * 查询在当前时间之前是否已经有人通过
     * @param contest_problem
     * @param start_time
     * @param end_time
     * @return
     */
    List<Solution> getFirstByUser(@Param("contest_problem")Contest_Problem contest_problem,
                                  @Param("start_time") Date start_time, @Param("end_time") Date end_time);

    /**
     * 删除比赛的提交信息
     * @param contest_id
     */
    public void deleteContestSubmit(Integer contest_id);
}
