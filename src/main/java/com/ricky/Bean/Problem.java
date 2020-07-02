package com.ricky.Bean;

import org.springframework.stereotype.Repository;

import java.io.Serializable;
import java.util.Date;
@Repository
public class Problem implements Serializable {
	private int problem_id;
	private String title;
	private String description;
	private String input;
	private String output;
	private String sample_input;
	private String sample_output;
	private String hint;
	private String source;
	private int time_limit;
	private int memory_limit;
	private int accepted;
	private int submit;
	private int solved;
	private char defunct;
	private char spj;
	private Date in_date;
	private String provider;
	private String user_status;
	private String edit;
	private String delete;
	private String status;

	public String getProvider() {
		return provider;
	}

	public void setProvider(String provider) {
		this.provider = provider;
	}

	public String getUser_status() {
		return user_status;
	}

	public void setUser_status(String user_status) {
		this.user_status = user_status;
	}

	public Problem() {
	}

	public String getEdit() {
		return edit;
	}

	public void setEdit(String edit) {
		this.edit = edit;
	}

	public String getDelete() {
		return delete;
	}

	public void setDelete(String delete) {
		this.delete = delete;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Problem(int problem_id, String title, String description, String input, String output, String sample_input, String sample_output, String hint, String source, int time_limit, int memory_limit, int accepted, int submit, int solved, char defunct, char spj, Date in_date, String provider) {
		this.problem_id = problem_id;
		this.title = title;
		this.description = description;
		this.input = input;
		this.output = output;
		this.sample_input = sample_input;
		this.sample_output = sample_output;
		this.hint = hint;
		this.source = source;
		this.time_limit = time_limit;
		this.memory_limit = memory_limit;
		this.accepted = accepted;
		this.submit = submit;
		this.solved = solved;
		this.defunct = defunct;
		this.spj = spj;
		this.in_date = in_date;
		this.provider = provider;
	}

	public int getProblem_id() {
		return problem_id;
	}

	public void setProblem_id(int problem_id) {
		this.problem_id = problem_id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getInput() {
		return input;
	}

	public void setInput(String input) {
		this.input = input;
	}

	public String getOutput() {
		return output;
	}

	public void setOutput(String output) {
		this.output = output;
	}

	public String getSample_input() {
		return sample_input;
	}

	public void setSample_input(String sample_input) {
		this.sample_input = sample_input;
	}

	public String getSample_output() {
		return sample_output;
	}

	public void setSample_output(String sample_output) {
		this.sample_output = sample_output;
	}

	public String getHint() {
		return hint;
	}

	public void setHint(String hint) {
		this.hint = hint;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public int getTime_limit() {
		return time_limit;
	}

	public void setTime_limit(int time_limit) {
		this.time_limit = time_limit;
	}

	public int getMemory_limit() {
		return memory_limit;
	}

	public void setMemory_limit(int memory_limit) {
		this.memory_limit = memory_limit;
	}

	public int getAccepted() {
		return accepted;
	}

	public void setAccepted(int accepted) {
		this.accepted = accepted;
	}

	public int getSubmit() {
		return submit;
	}

	public void setSubmit(int submit) {
		this.submit = submit;
	}

	public int getSolved() {
		return solved;
	}

	public void setSolved(int solved) {
		this.solved = solved;
	}

	public char getDefunct() {
		return defunct;
	}

	public void setDefunct(char defunct) {
		this.defunct = defunct;
	}

	public char getSpj() {
		return spj;
	}

	public void setSpj(char spj) {
		this.spj = spj;
	}

	public Date getIn_date() {
		return in_date;
	}

	public void setIn_date(Date in_date) {
		this.in_date = in_date;
	}

	@Override
	public String toString() {
		return "Problem{" +
				"problem_id=" + problem_id +
				", title='" + title + '\'' +
				", description='" + description + '\'' +
				", input='" + input + '\'' +
				", output='" + output + '\'' +
				", sample_input='" + sample_input + '\'' +
				", sample_output='" + sample_output + '\'' +
				", hint='" + hint + '\'' +
				", source='" + source + '\'' +
				", time_limit=" + time_limit +
				", memory_limit=" + memory_limit +
				", accepted=" + accepted +
				", submit=" + submit +
				", solved=" + solved +
				", defunct=" + defunct +
				", spj=" + spj +
				", in_date=" + in_date +
				", provider='" + provider + '\'' +
				", user_status='" + user_status + '\'' +
				'}';
	}
}
