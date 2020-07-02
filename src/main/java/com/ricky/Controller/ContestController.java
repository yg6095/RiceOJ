package com.ricky.Controller;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.ricky.Bean.*;
import com.ricky.Service.ContestService;
import com.ricky.Service.SolutionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class ContestController {
    @Autowired
    private ContestService contestService;
    @Autowired
    private SolutionService solutionService;

    @ResponseBody
    @RequestMapping("/searchFutureContests")
    public ResultBean getFuture(){
        return ResultBean.success(contestService.getFutureContest());
    }
    @ResponseBody
    @RequestMapping("/searchEndContests")
    public ResultBean getEnd(){
        return ResultBean.success(contestService.getEndContests());
    }

    @ResponseBody
    @RequestMapping("/searchAllContests")
    public ResultBean getAll(){
        return ResultBean.success(contestService.getAllContests());
    }
    @ResponseBody
    @RequestMapping("/searchContestsByUser")
    public ResultBean getContestsByUser(String user_id){
        return ResultBean.success(contestService.getContestsByUser(user_id));
    }

    @RequestMapping("/getResetContest")
    public String getResetContest(Integer contest_id, Model model){
        Contest contest = contestService.getResetContestById(contest_id);
        model.addAttribute("Contest", contest);
        return "contest_reset";
    }
    @ResponseBody
    @RequestMapping("/resetContest")
    public ResultBean resetContest(@RequestBody String str, HttpSession session) throws ParseException {
        User user = (User)session.getAttribute("User");
        if(user == null){
            return ResultBean.error(-1, "用户尚未登录");
        }
        JSONObject jsonObject = JSONObject.parseObject(str);
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm" );
        Contest contest = new Contest();
        contest.setContest_id((Integer) jsonObject.get("contest_id"));
        contest.setTitle((String) jsonObject.get("title"));
        contest.setPassword((String) jsonObject.get("password"));
        contest.setEnd_time(sdf.parse((String) jsonObject.get("end_time")) );
        contest.setStart_time(sdf.parse((String) jsonObject.get("start_time")) );
        contest.set_private(Integer.valueOf((String)jsonObject.get("_private")) );
        contest.setDescription((String) jsonObject.get("description"));
        List<String> problems = (List<String>) jsonObject.get("problemids");
        List<String> titles = (List<String>) jsonObject.get("titles");
        List<Contest_Problem> contest_problems = new ArrayList<>();
        for(int i = 0; i < problems.size(); i++){
            contest_problems.add(new Contest_Problem(Integer.valueOf(problems.get(i)),0,titles.get(i),i + 1, 0, 0));
        }
        contest.setProblem_ids(contest_problems);
        contestService.resetContest(contest);
        return ResultBean.success();
    }

    @RequestMapping("/contest")
    public String getContestById(String contest_id, Model model, HttpSession session){
        User user = (User)session.getAttribute("User");
        Contest contest = contestService.getContestById(Integer.valueOf(contest_id), user);
        model.addAttribute("Contest", contest);
        return "contest";
    }

    @ResponseBody
    @RequestMapping("/registerContest")
    public ResultBean RegisterContest( Integer contest_id, String password, HttpSession session){
        User user = (User) session.getAttribute("User");
        if(user == null){
            return ResultBean.error(-1,"用户尚未登录");
        }
        Contest contest = contestService.getContestById(contest_id, user);
        String verifyCode = contest.getPassword();
        if(verifyCode.equalsIgnoreCase(password)){
            Contest_User contest_user = new Contest_User(contest_id,user.getUser_id(),new Date());
            contestService.RegisterContest(contest_user);
            return ResultBean.success();
        }else{
            return ResultBean.error(-1,"密码错误");
        }
    }

    @ResponseBody
    @RequestMapping("/contestSubmit")
    public ResultBean submit(Solution solution, String code, HttpSession session){
        User user = (User) session.getAttribute("User");
        if (user == null){
            return ResultBean.error(-1,"用户尚未登录");
        }
        solution.setUser_id(user.getUser_id());
        solution.setJudger(user.getUser_id());
        solution.setSource(code);
        solution.setCode_length(solution.getSource().length());
        solution.setIn_date(new Date());
        Contest contest = contestService.getContestById(solution.getContest_id(),user);
        List<String> users = contest.getUsers();
        if(!users.contains(user.getUser_id())){
            contestService.RegisterContest(new Contest_User(contest.getContest_id(),user.getUser_id(),new Date()));
        }
        List<Contest_Problem> problems = contest.getProblem_ids();
        for(Contest_Problem contest_problem:problems){
            if(contest_problem.getNum() == solution.getNum()){
                solution.setProblem_id(contest_problem.getProblem_id());
                break;
            }
        }
        solutionService.submit(solution);
        return ResultBean.success();
    }

    @ResponseBody
    @RequestMapping("/getContestStatus")
    public ResultBean getContestStatus(Integer contest_id){
        List<Solution> solutions = solutionService.getContestStatusById(contest_id);
        return ResultBean.success(solutions);
    }

    @ResponseBody
    @RequestMapping("/getContestRank")
    public ResultBean getContestRank(Integer contest_id){
        List<Contest_User> ranks = contestService.getContestRankById(contest_id);
        return ResultBean.success(ranks);
    }

    @ResponseBody
    @RequestMapping("/createContest")
    public ResultBean createContest(@RequestBody String str, HttpSession session) throws ParseException {
        User user = (User)session.getAttribute("User");
        if(user == null){
            return ResultBean.error(-1, "用户尚未登录");
        }
        JSONObject jsonObject = JSONObject.parseObject(str);
        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm" );
        Contest contest = new Contest();
        contest.setTitle((String) jsonObject.get("title"));
        contest.setPassword((String) jsonObject.get("password"));
        contest.setEnd_time(sdf.parse((String) jsonObject.get("end_time")) );
        contest.setStart_time(sdf.parse((String) jsonObject.get("start_time")) );
        contest.set_private(Integer.valueOf((String)jsonObject.get("_private")) );
        contest.setDescription((String) jsonObject.get("description"));
        List<String> problems = (List<String>) jsonObject.get("problemids");
        List<String> titles = (List<String>) jsonObject.get("titles");
        List<Contest_Problem> contest_problems = new ArrayList<>();
        for(int i = 0; i < problems.size(); i++){
            contest_problems.add(new Contest_Problem(Integer.valueOf(problems.get(i)),0,titles.get(i),i + 1, 0, 0));
        }
        contest.setProblem_ids(contest_problems);
        contest.setRg_time(new Date());
        contest.setUser_id(user.getUser_id());
        Integer contest_id = contestService.InsertContest(contest);
        List<Integer> result = new ArrayList<>();
        result.add(contest_id);
        return ResultBean.success(result);
    }

    @ResponseBody
    @RequestMapping("/deleteContest")
    public ResultBean deleteContest(@RequestBody String contestStr){
        JSONArray jsonArr = JSONArray.parseArray(contestStr);
        List<String> contests = jsonArr.toJavaList(String.class);
        for(String str : contests){
            contestService.delete(Integer.valueOf(str));
        }
        return ResultBean.success();
    }
}
