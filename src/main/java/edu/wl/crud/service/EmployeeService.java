package edu.wl.crud.service;

import edu.wl.crud.dao.EmployeeMapper;
import edu.wl.crud.pojo.Employee;
import edu.wl.crud.pojo.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: 江斌
 * Date: 2020/7/21
 * Time: 11:18
 * To change this template use File /Settings/ File Templates
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;


    /**
     * 删除员工
     * @param id
     * @return
     */
    public int delteEmp(Integer id) {
       return employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 员工更新
     * @param employee
     * @return
     */
    public int updateEmp(Employee employee) {
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }


    /**
     * 根据id查询用户信息
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
       return  employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * 校验用户名是否可用
     *
     * @param empName
     */
    public boolean checkUser(String empName) {
        EmployeeExample employeeExample =new EmployeeExample();
        EmployeeExample.Criteria criteria =employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    /**
     * 保存员工信息
     *
     * @param employee
     * @return
     */
    public int saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    /**
     * 查询所有员工信息
     *
     * @return
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

}
