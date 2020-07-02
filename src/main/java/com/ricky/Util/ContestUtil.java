package com.ricky.Util;

import com.ricky.Bean.Contest;

import java.util.Date;
import java.util.List;

public class ContestUtil {
    public static List<Contest> ContestsToHtml(List<Contest> contests){
        for(Contest contest: contests){
            contest.setTitle("<a href=\"contest?contest_id="+contest.getContest_id()+"\">"+contest.getTitle()+"</a>");
            contest.setRg_count(contest.getUsers().size());
            long endDate = contest.getEnd_time().getTime();
            long startDate = contest.getStart_time().getTime();
            long date = new Date().getTime();
            int _private = contest.get_private();
            if(startDate > date){
                contest.setStatus("<span class=\"text-info\")\">尚未开始</span>");
            }else if(endDate < date){
                contest.setStatus("<span class=\"text-danger\">已结束</span>");
            }else if(startDate <= date && date <= endDate){
                contest.setStatus("<span class=\"text-success\">正在进行</span>");
            }else{
                contest.setStatus("<span class=\"text-danger\">错误比赛</span>");
            }
            contest.setEdit("<button class='btn-warning' onclick=\"window.location.href='/getResetContest?contest_id="+contest.getContest_id()+"'\">修改</button>");
        }
        return contests;
    }
}
