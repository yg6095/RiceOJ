package com.ricky.Bean;

import org.springframework.stereotype.Repository;

import java.io.Serializable;
@Repository
public class RankUser implements Serializable {
    private String user_id;
    private int submit;
    private int solved;
    private int solve;
    private int rank;
    private float pass_rate;

    public RankUser() {
    }

    public float getPass_rate() {
        return pass_rate;
    }

    public void setPass_rate(float pass_rate) {
        this.pass_rate = pass_rate;
    }

    public RankUser(int submit, int solved, int solve, int rank, float pass_rate) {
        this.submit = submit;
        this.solved = solved;
        this.solve = solve;
        this.rank = rank;
        this.pass_rate = pass_rate;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
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

    public int getSolve() {
        return solve;
    }

    public void setSolve(int solve) {
        this.solve = solve;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }


    @Override
    public String toString() {
        return "RankUser{" +
                "user_id='" + user_id + '\'' +
                ", submit=" + submit +
                ", solved=" + solved +
                ", solve=" + solve +
                ", rank=" + rank +
                ", pass_rate=" + pass_rate +
                '}';
    }
}
