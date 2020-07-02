package com.ricky.Bean;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

@Repository
public class Contest implements Serializable {
	private int contest_id;
	private String title;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date start_time;
	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm")
	private Date end_time;
	private Date rg_time;
	private String description;
	private int _private;
	private int rg_count;
	private String user_id;
	private String password;
	private String status;
	private List<String> users;
	private List<Contest_Problem> problem_ids;
	private List<Problem> problems;
	private String edit;

	public String getEdit() {
		return edit;
	}

	public void setEdit(String edit) {
		this.edit = edit;
	}

	public Date getRg_time() {
		return rg_time;
	}

	public void setRg_time(Date rg_time) {
		this.rg_time = rg_time;
	}

	public int getRg_count() {
		return rg_count;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public void setRg_count(int rg_count) {
		this.rg_count = rg_count;
	}

	public List<Contest_Problem> getProblem_ids() {
		return problem_ids;
	}

	public void setProblem_ids(List<Contest_Problem> problem_ids) {
		this.problem_ids = problem_ids;
	}

	public List<Problem> getProblems() {
		return problems;
	}

	public void setProblems(List<Problem> problems) {
		this.problems = problems;
	}

	public List<String> getUsers() {
		return users;
	}

	public void setUsers(List<String> users) {
		this.users = users;
	}

	public Contest() {
	}

	public Contest(int contest_id, String title, Date start_time, Date end_time, String description, int _private, String user_id, String password) {
		this.contest_id = contest_id;
		this.title = title;
		this.start_time = start_time;
		this.end_time = end_time;
		this.description = description;
		this._private = _private;
		this.user_id = user_id;
		this.password = password;
	}

	@Override
	public String toString() {
		return "Contest{" +
				"contest_id=" + contest_id +
				", title='" + title + '\'' +
				", start_time=" + start_time +
				", end_time=" + end_time +
				", description='" + description + '\'' +
				", _private=" + _private +
				", rg_count=" + rg_count +
				", user_id='" + user_id + '\'' +
				", password='" + password + '\'' +
				", status='" + status + '\'' +
				", users=" + users +
				", problem_ids=" + problem_ids +
				", problems=" + problems +
				'}';
	}

	public int getContest_id() {
		return contest_id;
	}

	public void setContest_id(int contest_id) {
		this.contest_id = contest_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStart_time() {
		return start_time;
	}

	public void setStart_time(Date start_time) {
		this.start_time = start_time;
	}

	public Date getEnd_time() {
		return end_time;
	}

	public void setEnd_time(Date end_time) {
		this.end_time = end_time;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public int get_private() {
		return _private;
	}

	public void set_private(int _private) {
		this._private = _private;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
