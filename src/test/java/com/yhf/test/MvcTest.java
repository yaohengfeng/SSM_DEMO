package com.yhf.test;

import com.github.pagehelper.PageInfo;
import com.yhf.bean.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockHttpServletRequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class MvcTest {

    @Autowired
    WebApplicationContext context;
    //模拟mvc请求，获取到处理结果
    MockMvc mockMvc;
    @Before
    public void initMockMvc(){
        mockMvc=MockMvcBuilders.webAppContextSetup(context).build();
    }
    @Test
    public void testPages() throws Exception {
        MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emp/getemps")
                .param("pn", "1")).andReturn();
        MockHttpServletRequest request=result.getRequest();
        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码"+pageInfo.getPageNum());
        System.out.println("总页码"+pageInfo.getPages());
        System.out.println("总记录数"+pageInfo.getTotal());
        System.out.println("在页面需要连续展示的页码");
        int[] nums = pageInfo.getNavigatepageNums();
        for (int i:nums){
            System.out.println(" "+i);
        }

        //获取员工数据
        List<Employee> list = pageInfo.getList();

        for (Employee employee:list){
            System.out.println(employee);
        }
    }
}
