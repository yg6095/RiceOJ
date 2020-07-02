package com.ricky.Bean;

import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.Date;

@Repository
public class Contest_Problem implements Serializable {
	private int problem_id;
	private int contest_id;
	private String title;
	private int num;
	private int c_accepted;
	private int c_submit;
	private char number;
	private String status;
	private Date ac_Date;

	public Date getAc_Date() {
		return ac_Date;
	}

	public void setAc_Date(Date ac_Date) {
		this.ac_Date = ac_Date;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public char getNumber() {
		return number;
	}

	public void setNumber(char number) {
		this.number = number;
	}

	public Contest_Problem() {
	}

	public Contest_Problem(int problem_id, int contest_id, String title, int num, int c_accepted, int c_submit) {
		this.problem_id = problem_id;
		this.contest_id = contest_id;
		this.title = title;
		this.num = num;
		this.c_accepted = c_accepted;
		this.c_submit = c_submit;
	}

	@Override
	public String toString() {
		return "Contest_problem{" +
				"problem_id=" + problem_id +
				", contest_id=" + contest_id +
				", title='" + title + '\'' +
				", num=" + num +
				", c_accepted=" + c_accepted +
				", c_submit=" + c_submit +
				", number=" + number +
				", status='" + status + '\'' +
				'}';
	}

	public int getProblem_id() {
		return problem_id;
	}

	public void setProblem_id(int problem_id) {
		this.problem_id = problem_id;
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

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public int getC_accepted() {
		return c_accepted;
	}

	public void setC_accepted(int c_accepted) {
		this.c_accepted = c_accepted;
	}

	public int getC_submit() {
		return c_submit;
	}

	public void setC_submit(int c_submit) {
		this.c_submit = c_submit;
	}
}
