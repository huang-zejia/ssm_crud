package com.hzj.test;


import com.github.pagehelper.PageInfo;
import com.hzj.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

/**
 * 使用spring测试模块提供的测试请求功能，测试crud请求的正确性
 *Spring4测试的时候，需要servlet3.0以上的支持
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:Spring.xml","classpath:Springmvc.xml"})
public class MVCTest {
    //虚拟的mvc请求，获取到处理结果
    MockMvc mockMvc;
    //引入SpringMvc 的ioc
    @Autowired
    WebApplicationContext context;

    @Before
    public void initMokcmvc(){
        mockMvc= MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testPage() throws Exception {
        //模拟请求拿到返回值
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "6")).andReturn();

        //取出请求域中的数据
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("empsInfo");
        System.out.println("当前页码"+pi.getPageNum());
        System.out.println("总页码"+pi.getPages());
        System.out.println("总记录数"+pi.getTotal());
        System.out.println("在页码中连续显示的页码");
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.print("  "+i);
        }

        //获取员工数据
        List<Employee> piList = pi.getList();
        for (Employee employee : piList) {
            System.out.println("id:"+employee.getEmpId()+"--name:"+employee.getEmpName());

        }
    }

}
