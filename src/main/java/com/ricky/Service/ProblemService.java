package com.ricky.Service;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.ricky.Bean.ConfigBean;
import com.ricky.Bean.Problem;
import com.ricky.Bean.Solution;
import com.ricky.Dao.IProblemDao;
import com.ricky.Util.ConvertUtil;
import com.ricky.Util.FileUtil;
import com.ricky.Util.ProblemUtil;
import org.apache.commons.codec.binary.Base64;
import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;

@Service
public class ProblemService {

    @Autowired
    private  IProblemDao problemDao;
    @Autowired
    private ConfigBean configBean;
    @Autowired
    private SolutionService solutionService;

    public boolean Exists(Problem problem)  {
        problem = problemDao.Exists(problem);
        return problem != null;
    }
    public List<Problem> getAllPublic(){
        List<Problem> problems  = problemDao.getAllPublic();
        return problems;
    }

    public  List<Problem> getAll() {
        List<Problem> problems = problemDao.getAll();
        return ProblemUtil.Manager_Update_Problem(problems);
    }

    public String InsertProblem(Problem problem, MultipartFile[] files) throws IOException {
        if(this.Exists(problem)) {
            return "Problem "+ problem.getTitle() +" already exists!!";
        }
        problemDao.InsertProblem(problem);
        Integer problem_id = problem.getProblem_id();
        File problemdata = new File(configBean.getData_home() + "/" + problem_id + "/");
        problemdata.setWritable(true, false);
        if (!problemdata.exists()) {
            problemdata.mkdirs();
        }
        Collections.sort(Arrays.asList(files), new Comparator<MultipartFile>() {
            public int compare(MultipartFile u1, MultipartFile u2) {
                return u1.getOriginalFilename().compareTo(u2.getOriginalFilename());
            }
        }); // 按名称排序
        for (MultipartFile file:files){
            String filepath = problemdata + "/test" + file.getOriginalFilename();
            File dataFile = new File(filepath);
            file.transferTo(dataFile);
        }
        return "success";
    }
    public  void display(Integer problem_id) {
        problemDao.DisplayProblem(problem_id);
    }
    public  void hidden(Integer problem_id) {
        problemDao.HiddenProblem(problem_id);
    }
    public  void delete(Integer problem_id) {
        problemDao.DeleteProblem(problem_id);
        File file = new File(configBean.getData_home() + '/' + problem_id);
        FileUtil.delAllFile(file);
    }
    public List<String> importProblem(File fileItem, String user_id) throws Exception {
        List<String> result = new ArrayList<>();
        SAXReader sax=new SAXReader();
        Document document=sax.read(fileItem);//获取document对象,如果文档无节点，则会抛出Exception提前结束
        Element root=document.getRootElement();//获取根节
        List<Element> listElement=root.elements();//所有一级子节点的list
        for(Element e:listElement){//遍历所有一级子节点
            if(e.getName().equalsIgnoreCase("item")) {
                String str = this.getNodes(e, user_id);
                result.add(str);
            }
        }
        return result;
    }
    public String getNodes(Element node, String user_id) throws Exception {

        List<Element> listElement=node.elements();//所有一级子节点的list
        List<String>test_input = new ArrayList<>();
        List<String>test_output = new ArrayList<>();
        Map<String, String> imgs = new HashMap<>();
        Map<Integer, String> sols = new HashMap<>();
        String title = "", description = "", input = "", output = "", sample_input ="",
                sample_output="", hint = "", source="", code = "";
        Integer time_limit= 1, memory_limit = 256, language = -1;
        for(Element e:listElement) {//遍历所有一级子节点
            switch (e.getName()) {
                case "title":
                    title = e.getText();
                    break;
                case "description":
                    description = e.getText();
                    break;
                case "input":
                    input = e.getText();
                    break;
                case "output":
                    output = e.getText();
                    break;
                case "sample_input":
                    sample_input = e.getText();
                    break;
                case "sample_output":
                    sample_output = e.getText();
                    break;
                case "hint":
                    hint = e.getText();
                    break;
                case "source":
                    source = e.getText();
                    break;
                case "time_limit":
                    time_limit = Integer.valueOf(e.getText());
                    break;
                case "memory_limit":
                    memory_limit = Integer.valueOf(e.getText());
                    break;
                case "solution":
                    code = e.getText();
                    break;
                case "test_input":
                    test_input.add(e.getText());
                    break;
                case "test_output":
                    test_output.add(e.getText());
                    break;
                case "img":
                    List<Element> imgElement=e.elements();
                    String url = "", base64 = "";
                    for(Element p: imgElement){
                        switch (p.getName()){
                            case "src":
                                url = p.getText();
                                break;
                            case "base64":
                                base64 = p.getText();
                                imgs.put(url, base64);
                                break;
                        }
                    }
                    break;
            }
            List<Attribute> listAttr = e.attributes();//当前节点的所有属性的list
            for (Attribute attr : listAttr) {//遍历当前节点的所有属性
                String name = attr.getName();//属性名称
                if(name.equalsIgnoreCase("language")){
                    language = ConvertUtil.getLanguage(attr.getValue());
                    if(language != -1) sols.put(language, code);
                }
            }
        }
        Problem problem = new Problem(0,title,description,input,output,sample_input,
                sample_output,hint,source,time_limit,memory_limit,0,0,0,'Y',
                'N',new Date(),user_id);
        // 如果目录不存在则创建
        if(this.Exists(problem)) {
            return "<span class='text-danger'>"+ problem.getTitle() +": already exists.<span>";
        }
        problemDao.InsertProblem(problem);
        Integer problem_id = problem.getProblem_id();
        File problemdata = new File(configBean.getData_home() + "/" + problem_id + "/");
        problemdata.setWritable(true, false);
        if (!problemdata.exists()) {
            problemdata.mkdirs();
        }
        //修改description中的链接
        File imagedata = new File(configBean.getData_home() + "/img");
        if (!imagedata.exists()) {
            imagedata.mkdirs();
        }
        int cnt = 0;
        for (Map.Entry<String, String> entry : imgs.entrySet()) {
            File img = FileUtil.base64ToFile(entry.getValue(),""+problem.getProblem_id()+"_",imagedata.getPath());
            description = description.replaceFirst(entry.getKey(), img.getName());
        }
        problem.setDescription(description);
        problemDao.resetProblem(problem);

        for(int i = 1; i <= test_input.size(); i++){
            String in = test_input.get(i - 1);
            FileWriter test = new FileWriter(problemdata + "/test" + i + ".in");
            test.write(in);
            test.flush();
            test.close();
        }
        for(int i = 1; i <= test_output.size(); i++){
            String in = test_output.get(i - 1);
            FileWriter test = new FileWriter(problemdata + "/test" + i + ".out");
            test.write(in);
            test.flush();
            test.close();
        }
        for(Map.Entry<Integer, String> entry:sols.entrySet()){
            language = entry.getKey();
            code = entry.getValue();
            solutionService.submit(new Solution(0,problem_id,user_id,"",0,0,new Date(),0,language,
                    0,0,code.length(),null,0,"","",code));
        }
        return "<span class='text-success'>" + problem.getTitle() + ": Import Success.<span>";
    }

    public Problem getProblemById(Integer problem_id) {
        Problem problem = problemDao.getProblemById(problem_id);
        return  problem;
    }

    public void resetProblem(Problem problem) {
        problemDao.resetProblem(problem);
    }

    public List<Problem> getProblemsByUser(String user_id) {
        List<Problem> problems = problemDao.getProblemsByUser(user_id);
        return ProblemUtil.Manager_Update_Problem(problems);
    }
}
