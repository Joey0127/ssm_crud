package edu.wl.crud.dao;

import edu.wl.crud.pojo.Dept;
import edu.wl.crud.pojo.DeptExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface DeptMapper {
    long countByExample(DeptExample example);

    int deleteByExample(DeptExample example);

    int insert(Dept record);

    int insertSelective(Dept record);

    List<Dept> selectByExample(Dept example);

    int updateByExampleSelective(@Param("record") Dept record, @Param("example") DeptExample example);

    int updateByExample(@Param("record") Dept record, @Param("example") DeptExample example);
}