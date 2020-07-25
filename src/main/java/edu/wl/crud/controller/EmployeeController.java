package edu.wl.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.wl.crud.pojo.Employee;
import edu.wl.crud.service.EmployeeService;
import edu.wl.crud.utils.Msg;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 * User: 江斌
 * Date: 2020/7/21
 * Time: 11:13
 * To change this template use File /Settings/ File Templates
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeServce;

    /**
     * 删除员工
     * @param id
     * @return
     */
    @RequestMapping(value = "emp/{id}",method = RequestMethod.DELETE)
    @ResponseBody
    public  Msg deleteEmp(@PathVariable("id") Integer id){
        employeeServce.delteEmp(id);
        return Msg.success();
    }

    /**
     * 员工更新方法
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(Employee employee){
        System.out.println(employee);
        employeeServce.updateEmp(employee);
        return Msg.success();
    }

    /**
     * 根据id查询用户信息
     * @param id
     * @return
     */
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee emp = employeeServce.getEmp(id);
        return Msg.success().add("emp",emp);
    }

    @RequestMapping(value = "/checkuser", method = RequestMethod.POST)
    @ResponseBody
    public Msg checkUser(String empName) {
        //先校验用户名是否 是合法的表达式 在校验用户名是否可用
        String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if (!empName.matches(regName)) {
            return Msg.fail().add("va_msg", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
        }
        //数据库用户名重复校验
        boolean b = employeeServce.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    /**
     * 新增用户
     *
     * @param employee
     * @return
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名 "+fieldError.getField());
                System.out.println("错误信息 "+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        } else {
            employeeServce.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     * 用户查询
     *
     * @param pn
     * @return
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<Employee> emps = employeeServce.getAll();
        //PageInfo封装了详细的分页信息以及查询出来的结果. navigataPages：5 传入连续显示的页数为5
        PageInfo pageInfo = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", pageInfo);
    }

//    @RequestMapping("/emps")
//    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
//        //引入PageHelper分页插件,在查询之前只需要调用，传入页码，以及每页大小即可
//        PageHelper.startPage(pn, 5);
//        //startPage后面紧跟的这个查询就是一个分页查询
//        List<Employee> emps = employeeServce.getAll();
//        //PageInfo封装了详细的分页信息以及查询出来的结果. navigataPages：5 传入连续显示的页数为5
//        PageInfo page = new PageInfo(emps,5);
//        model.addAttribute("pageInfo",page);
//        return "list";
//    }


}
