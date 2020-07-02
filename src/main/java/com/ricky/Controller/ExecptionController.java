package com.ricky.Controller;


import com.ricky.Bean.ResultBean;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
@ControllerAdvice
public class ExecptionController {

    static Logger logger = LogManager.getLogger(LogManager.ROOT_LOGGER_NAME);

    @ResponseBody
    @ExceptionHandler(value = {Exception.class})
    public ResultBean CatchExecption(Exception e){
        e.printStackTrace();
        logger.error("Execption", e);
        return ResultBean.error(-1,"系统错误，请联系管理员");
    }
}
