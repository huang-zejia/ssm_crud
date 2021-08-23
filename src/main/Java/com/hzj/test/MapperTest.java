package com.hzj.test;

import com.hzj.bean.Department;
import com.hzj.bean.Employee;
import com.hzj.dao.DepartmentMapper;
import com.hzj.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:Spring.xml"})
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

        /*插入部门*/
//        int i = departmentMapper.insertSelective(new Department(null, "技术部"));
//        int i1 = departmentMapper.insertSelective(new Department(null, "组织部"));
//        System.out.println(i+"   "+i1);

        //插入员工信息
        //employeeMapper.insertSelective(new Employee(null, "hzj", "f", "hzj@hzj.com", 1, null));
        //批量插入多个员工
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        /*for (int i=0;i<500;i++){
            String uid=UUID.randomUUID().toString().substring(0,5)+i;
            mapper.insertSelective(new Employee(null, uid, "f", uid+"@hzj.com", 1, null));
        }*/
        int i=2;
        for (;i<=500;i= i+(int) ((Math.random()*5)))
        {

            mapper.updateByPrimaryKeySelective(new Employee(i,null,"M",null,null,null));
        }


        System.out.println("执行成功");


    }
}
