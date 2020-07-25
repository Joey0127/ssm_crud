package edu.wl.crud.service;

import edu.wl.crud.dao.DeptMapper;
import edu.wl.crud.pojo.Dept;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: 江斌
 * Date: 2020/7/22
 * Time: 17:22
 * To change this template use File /Settings/ File Templates
 */
@Service
public class DepteService {

    @Autowired
    DeptMapper deptMapper;

    public List<Dept> getAll() {
        return deptMapper.selectByExample(null);
    }
}
