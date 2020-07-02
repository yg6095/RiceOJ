package com.ricky.Bean;


public class ConfigBean {
    private String data_home;
    private String emailUrl;
    private String emailPass;
    private String emailHost;

    @Override
    public String toString() {
        return "OJConfigBean{" +
                "data_home='" + data_home + '\'' +
                ", emailUrl='" + emailUrl + '\'' +
                ", emailPass='" + emailPass + '\'' +
                ", emailHost='" + emailHost + '\'' +
                '}';
    }

    public String getEmailHost() {
        return emailHost;
    }

    public void setEmailHost(String emailHost) {
        this.emailHost = emailHost;
    }

    public String getData_home() {
        return data_home;
    }

    public void setData_home(String data_home) {
        this.data_home = data_home;
    }

    public String getEmailUrl() {
        return emailUrl;
    }

    public void setEmailUrl(String emailUrl) {
        this.emailUrl = emailUrl;
    }

    public String getEmailPass() {
        return emailPass;
    }

    public void setEmailPass(String emailPass) {
        this.emailPass = emailPass;
    }
}
