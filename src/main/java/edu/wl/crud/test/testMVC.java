package edu.wl.crud.test;

import com.github.pagehelper.PageInfo;
import edu.wl.crud.pojo.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: 江斌
 * Date: 2020/7/21
 * Time: 14:13
 *
 * @ContextConfiguration 指定Spring配置文件的位置
 * @WebAppConfiguration 自动装配SpringMVC容器，若没有，则只能装配SpringMvc里面的东西
 * @RunWith 运行单元测试时使用哪个单元测试
 */

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class testMVC {
    //传入SpringMvc的ioc
    @Autowired
    WebApplicationContext context;
    //虚拟mvc请求，获取到处理结果
    MockMvc mockMvc;

    @Before
    public void initMockMvc() {
        mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "1"))
                .andReturn();
        //请求成功以后，请求域中会有pageInfo，我们可以取出pageInfo进行验证
        MockHttpServletRequest request = result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码" + pageInfo.getPageNum());
        System.out.println("总页码" + pageInfo.getPages());
        System.out.println("总记录数" + pageInfo.getTotal());

        System.out.println("在页面需要连续显示的页码");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i : nums) {
            System.out.println(" " + i);
        }

        List<Employee> list = pageInfo.getList();
        for (Employee employee : list) {
            System.out.println("Id " + employee.getEmpId() + "====>Name " + employee.getEmpName());
        }
    }

}
