package com.ricky.Bean;

import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.Date;
@Repository
public class Solution implements Serializable {
	private int solution_id;
	private int problem_id;
	private String user_id;
	private String nick;
	private int time;
	private int memory;
	private Date in_date;
	private int result;
	private int language;
	private int contest_id;
	private int num;
	private int code_length;
	private Date judgetime;
	private float pass_rate;
	private String judger;
	private String error;
	private String source;
	private String html_status;
	private String html_language;
	private String html_score;
	private String html_memory;
	private String html_time;
	private String html_problem_id;
	private String html_solution_id;

	public Solution() {
	}

	public Solution(int solution_id, int problem_id, String user_id, String nick, int time, int memory, Date in_date, int result, int language, int contest_id, int num, int code_length, Date judgetime, float pass_rate, String judger, String error, String source) {
		this.solution_id = solution_id;
		this.problem_id = problem_id;
		this.user_id = user_id;
		this.nick = nick;
		this.time = time;
		this.memory = memory;
		this.in_date = in_date;
		this.result = result;
		this.language = language;
		this.contest_id = contest_id;
		this.num = num;
		this.code_length = code_length;
		this.judgetime = judgetime;
		this.pass_rate = pass_rate;
		this.judger = judger;
		this.error = error;
		this.source = source;
	}

	public String getHtml_solution_id() {
		return html_solution_id;
	}

	public void setHtml_solution_id(String html_solution_id) {
		this.html_solution_id = html_solution_id;
	}

	public int getSolution_id() {
		return solution_id;
	}

	public void setSolution_id(int solution_id) {
		this.solution_id = solution_id;
	}

	public int getProblem_id() {
		return problem_id;
	}

	public void setProblem_id(int problem_id) {
		this.problem_id = problem_id;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getNick() {
		return nick;
	}

	public void setNick(String nick) {
		this.nick = nick;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	public int getMemory() {
		return memory;
	}

	public void setMemory(int memory) {
		this.memory = memory;
	}

	public Date getIn_date() {
		return in_date;
	}

	public void setIn_date(Date in_date) {
		this.in_date = in_date;
	}

	public int getResult() {
		return result;
	}

	public void setResult(int result) {
		this.result = result;
	}

	public int getLanguage() {
		return language;
	}

	public void setLanguage(int language) {
		this.language = language;
	}

	public int getContest_id() {
		return contest_id;
	}

	public void setContest_id(int constest_id) {
		this.contest_id = constest_id;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getCode_length() {
		return code_length;
	}

	public void setCode_length(int code_length) {
		this.code_length = code_length;
	}

	public Date getJudgetime() {
		return judgetime;
	}

	public void setJudgetime(Date judgetime) {
		this.judgetime = judgetime;
	}

	public float getPass_rate() {
		return pass_rate;
	}

	public void setPass_rate(float pass_rate) {
		this.pass_rate = pass_rate;
	}

	public String getJudger() {
		return judger;
	}

	public void setJudger(String judger) {
		this.judger = judger;
	}

	public String getError() {
		return error;
	}

	public void setError(String error) {
		this.error = error;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public String getHtml_status() {
		return html_status;
	}

	public void setHtml_status(String html_status) {
		this.html_status = html_status;
	}

	public String getHtml_language() {
		return html_language;
	}

	public void setHtml_language(String html_language) {
		this.html_language = html_language;
	}

	public String getHtml_score() {
		return html_score;
	}

	public void setHtml_score(String html_score) {
		this.html_score = html_score;
	}

	public String getHtml_memory() {
		return html_memory;
	}

	public void setHtml_memory(String html_memory) {
		this.html_memory = html_memory;
	}

	public String getHtml_time() {
		return html_time;
	}

	public void setHtml_time(String html_time) {
		this.html_time = html_time;
	}

	public String getHtml_problem_id() {
		return html_problem_id;
	}

	public void setHtml_problem_id(String html_problem_id) {
		this.html_problem_id = html_problem_id;
	}

	@Override
	public String toString() {
		return "Solution{" +
				"solution_id=" + solution_id +
				", problem_id=" + problem_id +
				", user_id='" + user_id + '\'' +
				", nick='" + nick + '\'' +
				", time=" + time +
				", memory=" + memory +
				", in_date=" + in_date +
				", result=" + result +
				", language=" + language +
				", contest_id=" + contest_id +
				", num=" + num +
				", code_length=" + code_length +
				", judgetime=" + judgetime +
				", pass_rate=" + pass_rate +
				", judger='" + judger + '\'' +
				", error='" + error + '\'' +
				", source='" + source + '\'' +
				", html_status='" + html_status + '\'' +
				", html_language='" + html_language + '\'' +
				", html_score='" + html_score + '\'' +
				", html_memory='" + html_memory + '\'' +
				", html_time='" + html_time + '\'' +
				", html_problem_id='" + html_problem_id + '\'' +
				", html_solution_id='" + html_solution_id + '\'' +
				'}';
	}
}
