package com.yhf.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yhf.bean.Employee;
import com.yhf.bean.Msg;
import com.yhf.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工的CRUD请求
 */
@Controller
@CrossOrigin(origins = "*",maxAge = 3600)
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    @ResponseBody
    @RequestMapping("/checkName")
    public Msg checkEmpName(@RequestParam("empName")String empName){
        String reg="(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u4e00-\\u9fa5]{2,5})";
        if(!empName.matches(reg)){
            return Msg.fail().add("va_msg","用户名必须是6-16位字母和数字或者2-5位汉字");
        }
        //数据库校验
        boolean b= employeeService.slecteEmpByName(empName);

        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }
    /**
     * 查询所有员工数据
     * @return
     */
 /*    @RequestMapping("/emps")
   public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //分页查询
        PageHelper.startPage(pn,5);
        List<Employee> employees = employeeService.getAll();
        PageInfo pageInfo=new PageInfo(employees,5);
        model.addAttribute("pageInfo",pageInfo);

        return "list";
    }*/
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //分页查询
        PageHelper.startPage(pn,5);
        List<Employee> employees = employeeService.getAll();
        PageInfo pageInfo=new PageInfo(employees,5);

        return  Msg.success().add("pageInfo",pageInfo);
    }

    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmpWithJson(@Valid Employee employee, BindingResult result) {

        Map<String,Object> map=new HashMap<>();
        if (result.hasErrors()){
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError:fieldErrors){
                System.out.println("错误字段:"+fieldError.getField());
                System.out.println("错误信息:"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            System.out.println("保存的数据:"+employee);
            employeeService.saveEmp(employee);
            return Msg.success();
        }
        
    }

    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }



    @ResponseBody
    @RequestMapping(value = "/saveEmp/{empId}" ,method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee,HttpServletRequest request){
        String e=request.getParameter("empGender");
        System.out.println("内部数据："+employee+"---"+e);
        employeeService.updateEmp(employee);
        return Msg.success();
    }


    @ResponseBody
    @RequestMapping(value = "/delemp/{ids}",method = RequestMethod.GET)
    public Msg deleteEmpById(@PathVariable("ids")String ids){
        if(ids.contains("-")){//批量删除
            List<Integer> list_ids=new ArrayList<>();
            String[] split = ids.split("-");
            for (String string:split){
                list_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(list_ids);
        }else {//单个删除
            Integer id=Integer.parseInt(ids);
            employeeService.delete(id);
        }

        return Msg.success();
    }
}
