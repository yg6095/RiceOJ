package com.ricky.Util;

import com.ricky.Bean.Problem;
import com.ricky.Bean.User;

import java.util.List;

public class ProblemUtil {
    public static List<Problem> User_Update_Problem(User user, List<Problem> problems){
        String ac = "<span class='label label-badge label-success'>Solved</span>";
        String sub = "<span class='label label-badge label-danger'>Unsolved</span>";
        for(Problem problem : problems){
            if(user.getSub_problems().contains(problem.getProblem_id())){
                if(user.getAc_problems().contains(problem.getProblem_id())){
                    problem.setUser_status(ac);
                }
                else{
                    problem.setUser_status(sub);
                }
            }
        }
        return problems;
    }
    public static List<Problem> Manager_Update_Problem(List<Problem> problems){
        for(Problem problem:problems){
            String delete = "<button class='btn-info ' onclick='Do(\"delete\","+problem.getProblem_id()+")'>删除</button>";
            String edit = "<button class='btn-warning' onclick=\"window.location.href='/getResetProblem?problem_id="+problem.getProblem_id()+"'\">修改</button>";
            String Public = "<button class='btn-success ' onclick='Do(\"hidden\","+problem.getProblem_id()+")'>公开</button>";
            String Private = "<button class='btn-danger ' onclick='Do(\"display\","+problem.getProblem_id()+")'>私有</button>";
            String Title = "<a href = '/problem?problem_id="+problem.getProblem_id()+"'>"+problem.getTitle()+"</a>";
            switch (problem.getDefunct()) {
                case 'N':
                    problem.setStatus(Public);
                    break;
                default:
                    problem.setStatus(Private);
            }
            problem.setDelete(delete);
            problem.setTitle(Title);
            problem.setEdit(edit);
        }
        return problems;
    }
}
