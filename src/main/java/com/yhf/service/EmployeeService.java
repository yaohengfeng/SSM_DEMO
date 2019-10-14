package com.yhf.service;

import com.yhf.bean.Employee;
import com.yhf.bean.EmployeeExample;
import com.yhf.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所有员工
     * @return
     */
    public List<Employee> getAll() {
    EmployeeExample example=new EmployeeExample();
    example.setOrderByClause("id");
    return employeeMapper.selectByExampleWithDept(null);
    }

    public void saveEmp(Employee employee){
        employeeMapper.insertSelective(employee);
    }

    public boolean slecteEmpByName(String name) {

        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria=example.createCriteria();
        criteria.andEmpNameEqualTo(name);
        long count = employeeMapper.countByExample(example);
        return count==0;
    }

    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    public void delete(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }
    //批量删除
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria=example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
