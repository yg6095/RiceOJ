package com.ricky.Controller;

import com.alibaba.fastjson.JSONArray;
import com.ricky.Bean.ConfigBean;
import com.ricky.Bean.Problem;
import com.ricky.Bean.ResultBean;
import com.ricky.Bean.User;
import com.ricky.Service.ProblemService;
import com.ricky.Service.UserService;
import com.ricky.Util.ProblemUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.*;


@Controller
public class ProblemController {
    @Autowired
    private ProblemService problemService;
    @Autowired
    private ConfigBean ConfigBean;
    @ResponseBody
    @RequestMapping("/insertProblem")
    public ResultBean InsertProblem(Problem problem,
                              @RequestParam(name = "file") MultipartFile[] files,
                              HttpSession session, Model model) throws IOException {
        User user = (User)session.getAttribute("User");
        if(user == null){
            return ResultBean.error(-1,"用户尚未登录");
        }
        problem.setIn_date(new Date());
        problem.setAccepted(0);
        problem.setSubmit(0);
        problem.setSolved(0);
        problem.setDefunct('Y');
        problem.setProvider(user.getUser_id());
        problem.setSpj('N');
        problem.setSource("自创题目");
        String result = problemService.InsertProblem(problem, files);
        if(result.equalsIgnoreCase("success"))  return ResultBean.success();
        else return ResultBean.error(-3, result);
    }
    @ResponseBody
    @RequestMapping("/importProblem")
    public ResultBean ImportProblemXml(MultipartFile file, HttpSession session) throws Exception{
        User user = (User)session.getAttribute("User");
        if(user == null){
            return ResultBean.error(-1,"用户尚未登录");
        }
        File file1 = new File(ConfigBean.getData_home() + File.separator + "problem.xml");
        file.transferTo(file1);
        List<String> result = problemService.importProblem(file1,user.getUser_id());
        file1.delete();
        return ResultBean.success(result);
    }
    @ResponseBody
    @RequestMapping("/searchAllPublicProblems")
    public ResultBean SearchAllPublicProblem(HttpSession session){
        List<Problem> problems = problemService.getAllPublic();
        User user = (User)session.getAttribute("User");
        if(user != null){
            problems = ProblemUtil.User_Update_Problem(user, problems);
        }

        if(problems == null) problems = new ArrayList<>();
        return ResultBean.success(problems);

    }

    @RequestMapping("/problem")
    public String SearchProblemById(@RequestParam(name = "problem_id") String problem_id,Model model){
        Problem problem = problemService.getProblemById(Integer.valueOf(problem_id));
        model.addAttribute("Problem",problem);
        return "problem";
    }

    @ResponseBody
    @RequestMapping("/getProblemTitleById")
    public ResultBean getProblemTitleById(Integer problem_id) {
        Problem problem = problemService.getProblemById(problem_id);
        if(problem != null) {
            List<String> result = new ArrayList<>();
            result.add(problem.getTitle());
            return ResultBean.success((Collection) result);
        }
        else return ResultBean.error(-2,"题目不存在题库中");
    }
    @ResponseBody
    @RequestMapping("/searchAllProblems")
    public ResultBean SearchAllProblem(){
        List<Problem> problems = problemService.getAll();
        if(problems == null)  problems = new ArrayList<>();
        return ResultBean.success(problems);

    }
    @ResponseBody
    @RequestMapping("/searchProblemsByUser")
    public ResultBean searchProblemsByUser(String user_id){
        List<Problem> problems = problemService.getProblemsByUser(user_id);
        if(problems == null) problems = new ArrayList<>();
        return ResultBean.success(problems);
    }

    @ResponseBody
    @RequestMapping("/displayProblem")
    public ResultBean displayProblem(@RequestBody String problemStr){
        JSONArray jsonArr = JSONArray.parseArray(problemStr);
        List<String> problems = jsonArr.toJavaList(String.class);
        for(String str : problems){
            problemService.display(Integer.valueOf(str));
        }
        return ResultBean.success();
    }
    @ResponseBody
    @RequestMapping("/hiddenProblem")
    public ResultBean hiddenProblem(@RequestBody String problemStr){
        JSONArray jsonArr = JSONArray.parseArray(problemStr);
        List<String> problems = jsonArr.toJavaList(String.class);
        for(String str : problems){
            problemService.hidden(Integer.valueOf(str));
        }
        return ResultBean.success();
    }
    @ResponseBody
    @RequestMapping("/deleteProblem")
    public ResultBean deleteProblem(@RequestBody String problemStr){
        JSONArray jsonArr = JSONArray.parseArray(problemStr);
        List<String> problems = jsonArr.toJavaList(String.class);
        for(String str : problems){
            problemService.delete(Integer.valueOf(str));
        }
        return ResultBean.success();
    }
    @RequestMapping("/getResetProblem")
    public String getResetProblem(String problem_id, Model model){
        Problem problem = problemService.getProblemById(Integer.valueOf(problem_id));
        model.addAttribute("Problem", problem);
        return "problem_reset";
    }

    @ResponseBody
    @RequestMapping("/resetProblem")
    public ResultBean resetProblem(Problem problem, HttpSession session){
        User user = (User)session.getAttribute("User");
        if(user == null){
            return ResultBean.error(-1,"用户尚未登录");
        }
        Problem problem1 = problemService.getProblemById(problem.getProblem_id());
        problem.setIn_date(problem1.getIn_date());
        problem.setAccepted(problem1.getAccepted());
        problem.setSubmit(problem1.getSubmit());
        problem.setSolved(problem1.getSolved());
        problem.setDefunct(problem1.getDefunct());
        problem.setProvider(problem1.getProvider());
        problem.setSpj(problem1.getSpj());
        problem.setSource(problem1.getSource());
        problemService.resetProblem(problem);
        return ResultBean.success();
    }
}
