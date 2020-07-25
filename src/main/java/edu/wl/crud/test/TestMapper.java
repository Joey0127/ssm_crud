package edu.wl.crud.test;

import edu.wl.crud.dao.DeptMapper;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 测试DAO层工作
 * User: 江斌
 * Date: 2020/7/20
 * Time: 17:19
 * 推荐Spring的项目使用Spring单元测试，可以自动注入我们需要的组件
 *1.导入SpringTest模块
 *2.@ContextConfiguration 指定Spring配置文件的位置,@ExtendWith运行单元测试时使用哪个单元测试
 *3.直接AutoWired即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class TestMapper {

    @Autowired
    DeptMapper deptMapper;

    /**
     * 测试DepartMentMapper
     */

   public void testCRUD(){
        System.out.println(deptMapper);

    }
}
