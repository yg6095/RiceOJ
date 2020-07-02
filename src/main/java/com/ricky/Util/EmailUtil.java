package com.ricky.Util;


import com.ricky.Bean.ConfigBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

@Component
public class EmailUtil {
    private String mailFrom;// 指明邮件的发件人
    private String password_mailFrom;// 指明邮件的发件人登陆密码
    private String mail_host;    // 邮件的服务器域名
    private static final String ALIDM_SMTP_HOST = "smtp.riceoj.top";
    private static final String ALIDM_SMTP_PORT = "80";//或"80"
    @Autowired
    private ConfigBean configBean;

    public void sendMail(String mailTo, String mailTittle, String mailText) throws MessagingException {
        mailFrom = configBean.getEmailUrl();
        password_mailFrom = configBean.getEmailPass();
        mail_host = configBean.getEmailHost();
        Properties prop = new Properties();
        prop.put("mail.host", mail_host);
        prop.put("mail.transport.protocol", "smtp");
        prop.put("mail.smtp.auth", "true");
		prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		prop.put("mail.smtp.socketFactory.port", "465");
		prop.put("mail.smtp.port", "465");
        Session session = Session.getInstance(prop);
        session.setDebug(true);
        Transport ts = session.getTransport();
        ts.connect(mailFrom, password_mailFrom);
        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(mailFrom));
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(mailTo));
        message.setSubject(mailTittle);
        message.setContent(mailText, "text/html;charset=utf-8");
        ts.sendMessage(message, message.getAllRecipients());
    }

    public boolean isEmail(String string) {
        if (string == null)
            return false;
        String regEx1 = "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
        Pattern p;
        Matcher m;
        p = Pattern.compile(regEx1);
        m = p.matcher(string);
        if (m.matches())
            return true;
        else
            return false;
    }
}