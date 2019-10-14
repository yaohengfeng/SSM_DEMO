package com.yhf.test;

import com.yhf.bean.Department;
import com.yhf.bean.Employee;
import com.yhf.bean.EmployeeExample;
import com.yhf.dao.DepartmentMapper;
import com.yhf.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;
import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);


        /*departmentMapper.insertSelective(new Department(null,"开发部"));
        departmentMapper.insertSelective(new Department(null,"测试部"));*/

//        employeeMapper.insertSelective(new Employee(null,"张三","男","228359774@qq.com",1));

        // 批量插入员；使用可以执行的sqlSession
       /*EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<1000;i++){
            String uid = UUID.randomUUID().toString().substring(0, 5) + i;
            employeeMapper.insertSelective(new Employee(null,uid,"男",uid+"@qq.com",1));
        }
        System.out.println("批量完成");*/

/*        List<Employee> employees = employeeMapper.selectByExampleWithDept(new EmployeeExample());

        for (Employee employee:employees){
            System.out.println(employee);
        }*/

//        employeeMapper.deleteByPrimaryKey(1001);
//        employeeMapper.updateByPrimaryKeySelective(new Employee(2,"李四",null,null,null));
    }
}
