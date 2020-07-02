package com.ricky.Controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.util.JSONPObject;
import com.ricky.Bean.RankUser;
import com.ricky.Bean.ResultBean;
import com.ricky.Bean.User;
import com.ricky.Service.PrivilegeService;
import com.ricky.Service.UserService;
import com.ricky.Util.IPUtil;
import com.ricky.Util.UserUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @Autowired
    private PrivilegeService privilegeService;

    @ResponseBody
    @RequestMapping("/login")
    public ResultBean Login(User loginuser, HttpSession session) {
        String user_id = loginuser.getUser_id();
        String password = loginuser.getPassword();
        User user = userService.login(user_id,password);
        if(user != null){
            session.setAttribute("User", user);
            return ResultBean.success();
        }else{
           return ResultBean.error(-1,"用户尚未注册或密码错误");
        }
    }
    @ResponseBody
    @RequestMapping("/register")
    public ResultBean Register(User user,
                           @RequestParam(name = "code") String code,
                           HttpSession session, HttpServletRequest request){
        Boolean exists = userService.isExists(user.getUser_id());
        String verifycode = (String) session.getAttribute("VerifyCode");
        user.setIp(IPUtil.getIP(request));
        user.setReg_time(new Date());
        user.setRankUser(new RankUser(0,0,0,0,0));
        if(exists) {
            return ResultBean.error(-9, "用户名已存在");
        }else if(!code.equalsIgnoreCase(verifycode)){
            return ResultBean.error(-2,"验证码错误");
        }else {
            userService.register(user);
            return ResultBean.success();
        }
    }
    @ResponseBody
    @RequestMapping("/resetUserInfo")
    public ResultBean resetInfo(User user, HttpSession session,
                                String code, String oldpassword){
        User user2 = (User) session.getAttribute("User");
        user.setUser_id(user2.getUser_id());
        String verifyCode = (String) session.getAttribute("VerifyCode");
        if(verifyCode.equalsIgnoreCase(code)){
            User user1 = userService.login(user.getUser_id(), oldpassword);
            if(user1 != null){
                String newPass = user.getPassword();
                userService.resetInfo(user);
                user = userService.login(user.getUser_id(), newPass);
                System.out.println(user);
                return ResultBean.success();
            }else{
                return ResultBean.error(-2,"密码错误");
            }
        }else{
            return ResultBean.error(-1,"验证码错误");
        }
    }
    @ResponseBody
    @RequestMapping("/searchAllPrivilege")
    public ResultBean SearchAllPrivilege(){
        ObjectMapper mapper = new ObjectMapper();
        List<User> users = privilegeService.getAllPrivilege();
        users = UserUtil.Manager_Update_User(users);
        return ResultBean.success(users);
    }
    @ResponseBody
    @RequestMapping("/insertPrivilege")
    public ResultBean Insert(String user_id){
        boolean exist = privilegeService.exists(user_id);
        if(exist){
            return ResultBean.error(-1,"用户已拥有管理员权限");
        }
        privilegeService.Insert(user_id);
        return ResultBean.success();
    }

    @ResponseBody
    @RequestMapping("/deletePrivilege")
    public ResultBean Delete(String user_id){
        privilegeService.Delete(user_id);
        return ResultBean.success();
    }

    @ResponseBody
    @RequestMapping("/searchAllRankUser")
    public ResultBean SearchAllRank(){
        List<RankUser> rankUsers = userService.getAllUserRank();
        return ResultBean.success(rankUsers);
    }

    @RequestMapping("/resetPassword")
    public String ResetPassword(String password, HttpSession session){
        User user = (User) session.getAttribute("resetUser");
        user.setPassword(password);
        userService.resetPassword(user);
        return "login";
    }
}
