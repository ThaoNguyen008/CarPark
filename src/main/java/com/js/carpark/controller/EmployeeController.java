package com.js.carpark.controller;

import com.js.carpark.model.employee.EmployeeAddModel;
import com.js.carpark.model.employee.EmployeeListModel;
import com.js.carpark.model.employee.EmployeeSearchModel;
import com.js.carpark.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;
    @RequestMapping( value = "/view-employee-{id}", method = RequestMethod.GET)
        public String getEmployeeByIdPage(HttpServletRequest request,Model model, @PathVariable Long id) {
        model.addAttribute("title", "Employee Profile");
        EmployeeAddModel employeeAddModel = employeeService.get(id);
        model.addAttribute("employeeAddModel", employeeAddModel);
        request.getSession().setAttribute("employeeAddModel", employeeAddModel);
        model.addAttribute("isUpdate", true);
        return "add_employee";
    }
    @RequestMapping(value = "/view-employee-{id}", method = RequestMethod.POST)
    public String update(Model model, @PathVariable Long id, @ModelAttribute("employeeAddModel") EmployeeAddModel employeeAddModel, BindingResult result) {
        try {
            employeeAddModel.setId(id);
            this.employeeService.save(employeeAddModel);
        } catch (Exception e) {
            model.addAttribute("error", "error");
        }
        return "redirect:/view-employee-" + id;
    }


    @RequestMapping(value = "/add-employee", method = RequestMethod.GET)
    public String getAddEmployeePage(Model model) {
        model.addAttribute("title", "Add Employee");
        model.addAttribute("isUpdate", false);
        model.addAttribute("employeeAddModel", new EmployeeAddModel());
        return "add_employee";
    }

    @RequestMapping(value = "/add-employee", method = RequestMethod.POST)
    public String add(Model model, @ModelAttribute("employeeAddModel") EmployeeAddModel employeeAddModel, BindingResult result) {
        try {
            System.out.println(employeeAddModel);
            this.employeeService.save(employeeAddModel);
            return "redirect:/employee-list";
        } catch (Exception e) {
            model.addAttribute("title", "Add Employee");
            model.addAttribute("isUpdate", false);
            if (employeeService.isExistAccount(employeeAddModel.getAccount())) {
                model.addAttribute("error", "Account is existed!");
                System.out.println("Account is existed!");
                employeeAddModel.setAccount(null);
                employeeAddModel.setPassword(null);
            }
            model.addAttribute("employeeAddModel", employeeAddModel);
            return "add_employee";
        }
    }

    @RequestMapping(value = "/employee-list", method = RequestMethod.GET)
    public String getEmployeeListPage(Model model) {
        List<EmployeeListModel> employees = this.employeeService.listAll();
        model.addAttribute("employees", employees);
        model.addAttribute("employeeSearchModel", new EmployeeSearchModel());
        return "employee_list";
    }

    @RequestMapping(value = "/employee-list", method = RequestMethod.POST)
    public String search(Model model, @ModelAttribute("employeeSearchModel") EmployeeSearchModel employeeSearchModel, BindingResult result) {
        if (result.hasErrors()) {
            return getEmployeeListPage(model);
        }
        List<EmployeeListModel> employees = this.employeeService.listAll(employeeSearchModel);
        model.addAttribute("employees", employees);
        model.addAttribute("employeeSearchModel", employeeSearchModel);
        return "employee_list";
    }
}
