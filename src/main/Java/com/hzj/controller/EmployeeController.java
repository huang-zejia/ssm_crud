package com.hzj.controller;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hzj.bean.Employee;
import com.hzj.bean.Msg;
import com.hzj.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工的增删改查
 */
@Controller
public class EmployeeController {

    @Autowired
   EmployeeService employeeService;

    /**
     * 批量删除和单个删除合一
     *  单个删除直接在前端传一个员工id
     *  批量删除将多个员工的id用 - 连接起来，送到后端拆分处理
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("ids")String ids){
        //存在 - 为批量删除
       if (ids.contains("-")){
           ArrayList<Integer> del_ids = new ArrayList<>();
           String[] str_ids = ids.split("-");
            //将id放在list集合中
           for (String str_id : str_ids) {
               del_ids.add(Integer.parseInt(str_id));
           }
           //调用批量删除方法
           employeeService.deleteBatch(del_ids);
       }else {
           //单个删除
           int id = Integer.parseInt(ids);
           employeeService.deletEmp(id);
       }


        return Msg.success();
    }

    /**
     * 员工更新
     * 后端不能拿到Ajax直接发送的put请求中的数据
     * 原因
     *  tomcat只有在Post请求才会封装数据，其他请求不封装成map
     * 解决
     *  配置上HttpPutFormContentFilter过滤器
     *      它可以将请求体中的数据解析包装成一个map
     *      request被重写封装，request.getParameter()被重写，从自己封装的map中取出数据
     * @param employee
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    //查询员工信息
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee emp = employeeService.getEmp(id);
        return Msg.success().add("emp", emp);
    }

    /*检查用户名是否可用*/
    @ResponseBody
    @RequestMapping(value = "/checkUser",method = RequestMethod.GET)
    public Msg checkUser(@RequestParam("empName") String empName){
        //判断用户是否符合规则
        String regx="(^[a-zA-Z0-9_-]{3,16}$)|(^[\\u2E80-\\u9FFF]{2,8})";
        if (!empName.matches(regx)){
            return Msg.fail().add("validator_msg", "用户名必须为3-16字母和数字组合或2-8位中文汉字");
        }
        boolean b = employeeService.checkUser(empName);
        if (b){
            return  Msg.success();
        }else {
            return Msg.fail().add("validator_msg", "用户名不可用");
        }
    }

    //保存员工
    //JSR303数据校验需要导包
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    //使用@Valid注解，进行后端数据校验，后面紧跟BindingResult可以得到错误的信息
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败，在模态框中显示校验失败的错误信息
            Map<String,Object> map=new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }

    /*使用json方式返回数据*/
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                               Model model){
        //引入PageHelper分页插件
        //在查询之前只需要调用startPage方法，传入页码，以及每页的大小
        //startPage紧跟的查询就会变为分页查询
        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();

        //pageInfo封装了详细的分页信息，包括我们查询出来的数据
        PageInfo pageInfo = new PageInfo(emps,5);

        return Msg.success().add("pageInfo",pageInfo);
    }

   /* @RequestMapping("/emps")
    public String getEmps(
            @RequestParam(value = "pn",defaultValue = "1")Integer pn,
            Model model){
        //引入PageHelper分页插件
        //在查询之前只需要调用startPage方法，传入页码，以及每页的大小
        //startPage紧跟的查询就会变为分页查询
        PageHelper.startPage(pn,5);
        List<Employee> emps = employeeService.getAll();

        //pageInfo封装了详细的分页信息，包括我们查询出来的数据
        PageInfo pageInfo = new PageInfo(emps,5);
        model.addAttribute("pageInfo", pageInfo);

        return "list";
    }*/
}
