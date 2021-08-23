package com.hzj.service;

import com.hzj.bean.Employee;
import com.hzj.bean.EmployeeExample;
import com.hzj.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    //保存员工
    public void saveEmp(Employee employee){
        //根据传入的参数插入
        employeeMapper.insertSelective(employee);
    }

    //员工更新
    public void updateEmp(Employee employee){
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 校验用户名是否可用
     * @param empName
     * @return true,表示当前用户名可用，false，不可用
     */
    public boolean checkUser(String empName) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        //根据条件统计总数
        long count = employeeMapper.countByExample(example);
        return count==0;
    }

    /**
     * 按照员工id查询员工
     * @param id
     * @return
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    public void deletEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    //批量删除
    public void deleteBatch(List<Integer> del_ids) {
        EmployeeExample example=new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        //相当于delet from xxx where emp_id in(1,2,3)
        criteria.andEmpIdIn(del_ids);
        employeeMapper.deleteByExample(example);
    }
}
