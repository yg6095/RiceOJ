package com.ricky.Service;

import com.ricky.Util.CaptchaUtils;
import com.ricky.Util.EmailUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

@Service
public class EmailService{
    @Autowired
    private EmailUtil emailUtil;
    public String  sendVerify(String email) throws  Exception{
        String code = CaptchaUtils.creatCaptcha();
        String txt = "您的验证码是：" + code;
        String title = "Online Judge验证码";
        emailUtil.sendMail(email, title,txt);
        return code;
    }
}
