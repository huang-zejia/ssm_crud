package com.hzj.controller;

import com.hzj.bean.Department;
import com.hzj.bean.Msg;
import com.hzj.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;
    /*返回部门信息*/
    @ResponseBody
    @RequestMapping("/depts")
    public Msg getDepts(){
        List<Department> depts = departmentService.getDepts();
        return Msg.success().add("depts", depts);
    }

}
