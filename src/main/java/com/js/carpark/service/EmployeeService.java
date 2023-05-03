package com.js.carpark.service;

import com.js.carpark.entity.Employee;
import com.js.carpark.model.employee.EmployeeAddModel;
import com.js.carpark.model.employee.EmployeeListModel;
import com.js.carpark.model.employee.EmployeeSearchModel;
import com.js.carpark.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepository;

    public List<EmployeeListModel> listAll() {
        List<EmployeeListModel> listModels = new ArrayList<>();
        List<Employee> employees = employeeRepository.findAll();
        for (Employee employee : employees){
            EmployeeListModel model = new EmployeeListModel();
            model.loadFromEntity(employee);
            listModels.add(model);
        }
        return listModels;
    }

    public List<EmployeeListModel> listAll(EmployeeSearchModel employeeSearchModel) {
        List<EmployeeListModel> listModels = new ArrayList<>();
        List<Employee> employees = null;
        int type = employeeSearchModel.getType();
        System.out.println("text = " + employeeSearchModel.getText());
        switch (type) {
            case 1:
                employees = employeeRepository.findByEmployeeNameContainingIgnoreCase(employeeSearchModel.getText());
                break;
            case 2:
                Date date = employeeSearchModel.getDate();
                employees = employeeRepository.findByEmployeeBirthdate(date);
                break;
            case 3:
                employees = employeeRepository.findByEmployeeAddressContainingIgnoreCase(employeeSearchModel.getText());
                break;
            case 4:
                employees = employeeRepository.findByEmployeePhoneContaining(employeeSearchModel.getText());
                break;
            case 5:
                employees = employeeRepository.findByDepartmentContainingIgnoreCase(employeeSearchModel.getText());
                break;
        }
        for (Employee employee : employees){
            EmployeeListModel model = new EmployeeListModel();
            model.loadFromEntity(employee);
            listModels.add(model);
        }
        return listModels;
    }

    public void save(EmployeeAddModel employeeAddModel) {
        Employee employee = new Employee();
        employee.loadFromAddModel(employeeAddModel);
        this.employeeRepository.save(employee);
    }

    public EmployeeAddModel get(Long id) {
        Employee employee = employeeRepository.findById(id).get();
        EmployeeAddModel model = new EmployeeAddModel();
        model.loadFromEntity(employee);
        return model;
    }

    public void delete(Long id) {
        employeeRepository.deleteById(id);
    }

    public boolean isExistAccount(String account) {
        Employee employee = employeeRepository.findEmployeeByAccount(account);
        return employee != null;
    }
}
