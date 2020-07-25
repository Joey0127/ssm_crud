package edu.wl.crud.controller;

import edu.wl.crud.pojo.Dept;
import edu.wl.crud.service.DepteService;
import edu.wl.crud.utils.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: 江斌
 * Date: 2020/7/22
 * Time: 17:20
 * To change this template use File /Settings/ File Templates
 */
@Controller
public class DeptController {

    @Autowired
    DepteService deptService;

    /**
     * 返回所有的部门信息
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Dept> deptList = deptService.getAll();
        return Msg.success().add("deptList",deptList);
    }
}
