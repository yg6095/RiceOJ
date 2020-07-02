package com.ricky.Service;

import com.ricky.Bean.Solution;
import com.ricky.Dao.ISolutionDao;
import com.ricky.Util.HtmlUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.*;

@Service
public class SolutionService {
    @Autowired
    private  ISolutionDao solutionDao;

    public  List<Solution> getAll() {
        List<Solution> solutions = solutionDao.getAll();
        for(Solution sol : solutions) {
            sol.setHtml_solution_id("<a onclick=\"show("+sol.getSolution_id()+")\">"+sol.getSolution_id()+"</a>");
            sol.setHtml_time(sol.getTime() + " ms");
            sol.setHtml_memory(sol.getMemory() + " KB");
            sol.setHtml_problem_id("<a href=\"/problem?problem_id=" +sol.getProblem_id()+"\">"+sol.getProblem_id()+"</a>");
            sol.setHtml_language(HtmlUtil.language_to_html(sol.getLanguage()));
            sol.setHtml_status(HtmlUtil.status_to_html(sol.getResult()));
            sol.setHtml_score(HtmlUtil.score_to_html(sol.getResult(),sol.getPass_rate()));
            sol.setSource(HtmlUtil.readStr(sol.getSource()));
        }
        Collections.sort(solutions, new Comparator<Solution>() {
            @Override
            public int compare(Solution o1, Solution o2) {
                return o2.getSolution_id() - o1.getSolution_id();
            }
        });
        return solutions;
    }

    public  void submit(Solution solution) {
        solutionDao.InsertSolution(solution);
        solutionDao.InsertSource(solution);
    }

    public List<Solution> getContestStatusById(Integer contest_id) {
        List<Solution> solutions = solutionDao.getContestStatusById(contest_id);
        for(Solution sol : solutions) {
            sol.setHtml_time(sol.getTime() + " ms");
            sol.setHtml_memory(sol.getMemory() + " KB");
            sol.setHtml_problem_id(sol.getProblem_id()+"");
            sol.setHtml_language(HtmlUtil.language_to_html(sol.getLanguage()));
            sol.setHtml_status(HtmlUtil.status_to_html(sol.getResult()));
            sol.setHtml_score(HtmlUtil.score_to_html(sol.getResult(),sol.getPass_rate()));
            sol.setSource(HtmlUtil.readStr(sol.getSource()));
        }
        return solutions;
    }
}
