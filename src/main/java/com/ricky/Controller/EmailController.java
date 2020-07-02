package com.ricky.Controller;

import com.ricky.Bean.ResultBean;
import com.ricky.Bean.User;
import com.ricky.Service.EmailService;
import com.ricky.Service.UserService;
import com.ricky.Util.EmailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;


@Controller
public class EmailController {
    @Autowired
    private EmailService emailService;
    @Autowired
    private UserService userService;
    @Autowired
    private EmailUtil emailUtil;
    @ResponseBody
    @RequestMapping("/sendVerify")
    public ResultBean SendEmail (
            @RequestParam(name = "email") String email, HttpSession session) throws Exception{
        if(emailUtil.isEmail(email)){
            session.removeAttribute("VerifyCode");
            session.setAttribute("VerifyCode", emailService.sendVerify(email));;
            return ResultBean.success();
        }else {
            return ResultBean.error(-4,"邮箱错误,请检查邮箱是否正确");
        }
    }
    @ResponseBody
    @RequestMapping("/sendResetVerify")
    public ResultBean resetPasswordVerify (String resetUser_id, String resetEmail, HttpSession session) throws Exception{
        System.out.println(resetEmail);
        if(emailUtil.isEmail(resetEmail)){
            User user = new User();
            user.setUser_id(resetUser_id);
            user.setEmail(resetEmail);
            if(!userService.checkUserEmail(user)){
                return ResultBean.error(-6,"用户名邮箱不匹配");
            }
            session.removeAttribute("VerifyCode");
            session.setAttribute("VerifyCode", emailService.sendVerify(resetEmail));;
            return ResultBean.success();
        }else {
            return ResultBean.error(-4,"邮箱错误,请检查邮箱是否正确");
        }
    }

    @ResponseBody
    @RequestMapping("/verifyCode")
    public ResultBean VerifyEmail(String verifyCode, String resetUser_id, String resetEmail, HttpSession session){
        User user = new User();
        user.setUser_id(resetUser_id);
        user.setEmail(resetEmail);
        String code = (String) session.getAttribute("VerifyCode");
        if(code != null && code.equalsIgnoreCase(verifyCode)){
            session.setAttribute("resetUser", user);
            return ResultBean.success();
        }else{
            session.removeAttribute("VerifyCode");
            return ResultBean.error(-5, "验证码错误,邮箱验证失败");
        }
    }

}
