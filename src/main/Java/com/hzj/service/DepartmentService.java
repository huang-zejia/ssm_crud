package com.hzj.service;

import com.hzj.bean.Department;
import com.hzj.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getDepts(){
        //selectByExample根据条件查询数据，条件为空查询所有
        List<Department> departmentList = departmentMapper.selectByExample(null);
        return departmentList;
    }
}
