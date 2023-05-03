package com.js.carpark.model.employee;

import com.js.carpark.entity.Employee;
import com.js.carpark.model.auth.EmployeePassword;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.util.Date;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class EmployeeAddModel {
    private Long id;
    private String employeeName;
    private String employeePhone;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private Date employeeBirthdate;
    private String sex;
    private String employeeAddress;
    private String employeeEmail;
    private String account;
    private String password;
    private String department;

    public void loadFromEntity(Employee entity) {
        this.id = entity.getId();
        this.employeeName = entity.getEmployeeName();
        this.employeePhone = entity.getEmployeePhone();
        this.employeeBirthdate = entity.getEmployeeBirthdate();
        this.sex = entity.getSex();
        this.employeeAddress = entity.getEmployeeAddress();
        this.employeeEmail = entity.getEmployeeEmail();
        this.account = entity.getAccount();
        this.password = EmployeePassword.decrypt(entity.getPassword(), "js03");
        this.department = entity.getDepartment();
    }
}
