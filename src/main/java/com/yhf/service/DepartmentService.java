package com.yhf.service;

import com.yhf.bean.Department;
import com.yhf.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> deptInfo(){
        List<Department> departments = departmentMapper.selectByExample(null);
        return departments;
    }
}
