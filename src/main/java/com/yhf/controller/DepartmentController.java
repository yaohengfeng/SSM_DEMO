package com.yhf.controller;

import com.yhf.bean.Department;
import com.yhf.bean.Msg;
import com.yhf.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    public DepartmentService departmentService;


    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> departments = departmentService.deptInfo();
        return Msg.success().add("dept",departments);
    }
}
