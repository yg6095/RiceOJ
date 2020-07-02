package com.ricky.Controller;

import com.ricky.Bean.ResultBean;
import com.ricky.Bean.Solution;
import com.ricky.Bean.User;
import com.ricky.Service.SolutionService;
import com.ricky.Service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
public class SolutionController {
    @Autowired
    private SolutionService solutionService;
    @Autowired
    private UserService userService;

    @ResponseBody
    @RequestMapping(value = "/submit", method = RequestMethod.POST)
    public ResultBean submit(Solution solution, String code, HttpSession session){
        User user = (User) session.getAttribute("User");
        if(user == null) return ResultBean.error(-1,"用户尚未登录，请登录后再提交");
        solution.setUser_id(user.getUser_id());
        solution.setJudger(user.getUser_id());
        solution.setSource(code);
        solution.setCode_length(solution.getSource().length());
        solution.setIn_date(new Date());
        solutionService.submit(solution);
        return ResultBean.success();
    }

    @ResponseBody
    @RequestMapping("/searchAllSolutions")
    public ResultBean searchAll(HttpSession session){
        List<Solution> solutions = solutionService.getAll();
        User user = (User) session.getAttribute("User");
        if(user != null) {
            user = userService.update(user);
            session.setAttribute("User", user);
        }
        return ResultBean.success(solutions);
    }

}
