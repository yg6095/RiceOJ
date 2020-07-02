package com.ricky.Bean;

import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
@Repository
public class User implements Serializable {
	private String user_id;
	private String email;
	private char defunct;
	private String password;
	private String nick;
	private String school;
	private String ip;
	private Date reg_time;
	private Date accesstime;
	private String rightstr;
	private List<Integer> ac_problems;
	private List<Integer> sub_problems;
	private RankUser rankUser;
	private String delete;
	private List<Contest> rg_contests;

	public List<Contest> getRg_contests() {
		return rg_contests;
	}

	public void setRg_contests(List<Contest> rg_contests) {
		this.rg_contests = rg_contests;
	}

	public String getDelete() {
		return delete;
	}

	public void setDelete(String delete) {
		this.delete = delete;
	}

	public RankUser getRankUser() {
		return rankUser;
	}

	public void setRankUser(RankUser rankUser) {
		this.rankUser = rankUser;
	}

	public List<Integer> getAc_problems() {
		return ac_problems;
	}

	public void setAc_problems(List<Integer> ac_problems) {
		this.ac_problems = ac_problems;
	}

	public List<Integer> getSub_problems() {
		return sub_problems;
	}

	public void setSub_problems(List<Integer> sub_problems) {
		this.sub_problems = sub_problems;
	}

	public User() {
	}

	public User(String user_id, String email, char defunct, String password, String nick, String school, String ip, Date reg_time, Date accesstime, String rightstr, RankUser rankUser) {
		this.user_id = user_id;
		this.email = email;
		this.defunct = defunct;
		this.password = password;
		this.nick = nick;
		this.school = school;
		this.ip = ip;
		this.reg_time = reg_time;
		this.accesstime = accesstime;
		this.rightstr = rightstr;
		this.rankUser = rankUser;
	}

	public String getRightstr() {
		return rightstr;
	}

	public void setRightstr(String rightstr) {
		this.rightstr = rightstr;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public char getDefunct() {
		return defunct;
	}

	public void setDefunct(char defunct) {
		this.defunct = defunct;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public String getSchool() {
		return school;
	}

	public void setSchool(String school) {
		this.school = school;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Date getReg_time() {
		return reg_time;
	}

	public void setReg_time(Date reg_time) {
		this.reg_time = reg_time;
	}

	public Date getAccesstime() {
		return accesstime;
	}

	public void setAccesstime(Date accesstime) {
		this.accesstime = accesstime;
	}

	@Override
	public String toString() {
		return "User{" +
				"user_id='" + user_id + '\'' +
				", email='" + email + '\'' +
				", defunct=" + defunct +
				", password='" + password + '\'' +
				", nick='" + nick + '\'' +
				", school='" + school + '\'' +
				", ip='" + ip + '\'' +
				", reg_time=" + reg_time +
				", accesstime=" + accesstime +
				", rightstr='" + rightstr + '\'' +
				", ac_problems=" + ac_problems +
				", sub_problems=" + sub_problems +
				", rankUser=" + rankUser +
				", delete='" + delete + '\'' +
				'}';
	}
}
