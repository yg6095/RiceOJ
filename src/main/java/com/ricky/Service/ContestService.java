package com.ricky.Service;

import com.ricky.Bean.*;
import com.ricky.Dao.IContestDao;
import com.ricky.Dao.IProblemDao;
import com.ricky.Dao.ISolutionDao;
import com.ricky.Dao.IUserDao;
import com.ricky.Util.ContestUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ContestService {
    @Autowired
    private IContestDao contestDao;
    @Autowired
    private IProblemDao problemDao;
    @Autowired
    private ISolutionDao solutionDao;
    @Autowired
    private IUserDao userDao;

    public Integer InsertContest(Contest contest){
        contestDao.InsertContest(contest);
        List<Contest_Problem> problems = contest.getProblem_ids();
        for(Contest_Problem contest_problem: problems){
            contest_problem.setContest_id(contest.getContest_id());
            contestDao.InsertContestProblem(contest_problem);
        }
        contestDao.InsertContestUser(new Contest_User(contest.getContest_id(),contest.getUser_id(),new Date()));
        return contest.getContest_id();
    }
    public void RegisterContest(Contest_User contest_user){
        contestDao.InsertContestUser(contest_user);
    }

    public Contest getContestById(Integer contest_id, User user){
        Contest contest = contestDao.getContestById(contest_id);
        contest.setProblems(problemDao.getProblemsByList(contest.getProblem_ids()));
        List<Integer> acProblems = new ArrayList<>();
        List<Integer> subProblems = new ArrayList<>();
        if(user != null) {
            Contest_User contest_user = new Contest_User(contest_id,user.getUser_id(),new Date());
            acProblems = solutionDao.getContestACByUserId(contest_user);
            subProblems = solutionDao.getContestSubByUserId(contest_user);
        }
        for(Contest_Problem contest_problem:contest.getProblem_ids()){
            Integer num = contest_problem.getNum();
            contest_problem.setNumber((char)((byte)'A' + num - 1));
            if(subProblems.contains(num)){
                if(acProblems.contains(num)){
                    contest_problem.setStatus("<span class='label label-badge label-success'>Solved</span>");
                }else{
                    contest_problem.setStatus("<span class='label label-badge label-danger'>Unsolved</span>");
                }
            }
        }


        return contest;
    }

    public List getFutureContest() {
        List<Contest> contests = contestDao.getFutureContest();
        return ContestUtil.ContestsToHtml(contests);
    }

    public List<Contest> getEndContests() {
        List<Contest> contests = contestDao.getEndContest();
        return ContestUtil.ContestsToHtml(contests);
    }

    public List<Contest_User> getContestRankById(Integer contest_id) {
        List<Contest_User> ranks = new ArrayList<>();
        Contest contest = contestDao.getContestById(contest_id);
        List<String> users = contest.getUsers();
        List<Contest_Problem> problems = contest.getProblem_ids();
        for(String s : users){
            Contest_User user = new Contest_User();
            User user1 = userDao.getUserById(s);
            String nick = user1.getNick();
            user.setUser_id(s);
            user.setContest_id(contest_id);
            user.setAc_count(solutionDao.getContestACByUserId(user).size());
            user.setSub_count(solutionDao.getContestSubByUserId(user).size());
            user.setTeam(s + (nick == null ?"":"<span class=\"text-muted\">("+nick+")</span>"));
            long sum = 0;
            int i = 0;
            for(Contest_Problem contest_problem:problems){
                String q = "";
                List<Solution> acSolution = solutionDao.checkACByUser(contest_problem, s, contest.getStart_time(),contest.getEnd_time());
                List<Solution> subSolutions = solutionDao.getSubByUser(contest_problem, s, contest.getStart_time(),contest.getEnd_time());
                contest_problem.setC_accepted(Math.min(1,acSolution.size()));
                contest_problem.setC_submit(subSolutions.size());
                Integer num = contest_problem.getNum();
                contest_problem.setNumber((char)((byte)'A' + num - 1));
                int error = (contest_problem.getC_submit() - contest_problem.getC_accepted());
                if(contest_problem.getC_accepted() == 1) {
                    contest_problem.setAc_Date(solutionDao.getLastACDate(contest_problem, s, contest.getStart_time(),contest.getEnd_time()));
                    long ac_time =contest_problem.getAc_Date().getTime() - contest.getStart_time().getTime();
                    sum +=  error * 20 * 60 * 1000;
                    sum += ac_time;
                    List<Solution> firstSolutions = solutionDao.getFirstByUser(contest_problem, contest.getStart_time(),contest.getEnd_time());
                    if(firstSolutions.size() == 0){
                        if(error != 0) q = "<div class=\"container-fluid with-padding first\"><p>"+ac_time / 1000 / 60+"<span class=\"text-muted\">( -"+error+" )</span></p><div>";
                        else q = "<div class=\"container-fluid with-padding first\"><p>"+ac_time / 1000 / 60+"</p><div>";
                    }
                    else{
                        if(error != 0) q = "<div class=\"container-fluid with-padding success\"><p>"+ac_time / 1000 / 60+"<span class=\"text-muted\">( -"+error+" )</span></p><div>";
                        else q = "<div class=\"container-fluid with-padding success\"><p>"+ac_time / 1000 / 60+"</p><div>";
                    }
                }else{
                    if(error != 0) q = "<div class=\"container-fluid with-padding error1\"><p class=\"text-muted\">( -"+error+" )</p><div>";
                }
                user.setString(++i, q);
            }
            user.setProblem_ids(problems);
            user.setPenalty(sum);
            user.setSumTime((int)(user.getPenalty() / 1000 / 60));
            ranks.add(user);
        }
        Collections.sort(ranks, new Comparator<Contest_User>() {
            @Override
            public int compare(Contest_User o1, Contest_User o2) {
                if(o1.getAc_count() > o2.getAc_count())
                    return -1;
                else if(o1.getAc_count() == o2.getAc_count() && o1.getPenalty() < o2.getPenalty())
                    return -1;
                else if(o1.getAc_count() == o2.getAc_count() && o1.getPenalty() == o2.getPenalty()){
                    return 1;
                }
                else return 1;
            }
        });
        for(Contest_User contest_user:ranks){
            contest_user.setRank(ranks.indexOf(contest_user) + 1);
        }
        return ranks;
    }

    public List<Contest> getAllContests() {
        List<Contest> contests = contestDao.getAllContests();
        return ContestUtil.ContestsToHtml(contests);
    }

    public Contest getResetContestById(Integer contest_id) {
        Contest contest = contestDao.getContestById(contest_id);
        return contest;
    }

    public void delete(Integer contest_id) {
        contestDao.deleteContest(contest_id);
        solutionDao.deleteContestSubmit(contest_id);
    }

    public void resetContest(Contest contest) {
        contestDao.resetContest(contest);
        List<Contest_Problem> contest_problems = contestDao.getAllProblemIdsByContestId(contest.getContest_id());
        List<Contest_Problem> problems = contest.getProblem_ids();
        contestDao.deleteContestProblem(contest.getContest_id());
        for(Contest_Problem problem: problems){
            for(Contest_Problem contest_problem: contest_problems){
                if(contest_problem.getProblem_id() == problem.getProblem_id()){
                    problem.setC_submit(contest_problem.getC_submit());
                    problem.setC_accepted(contest_problem.getC_accepted());
                }
            }
            problem.setContest_id(contest.getContest_id());
            contestDao.InsertContestProblem(problem);
        }
    }

    public List<Contest> getContestsByUser(String user_id) {
        List<Contest> contests = contestDao.getContestsByUser(user_id);
        return ContestUtil.ContestsToHtml(contests);
    }
}
