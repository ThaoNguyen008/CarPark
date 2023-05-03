package com.js.carpark.entity;

import com.js.carpark.model.auth.EmployeePassword;
import com.js.carpark.model.employee.EmployeeAddModel;
import com.js.carpark.model.employee.EmployeeListModel;
import lombok.*;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "employee")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "employeeId", nullable = false)
    private Long id;

    @Column(name = "account", length = 50, nullable = false, unique = true)
    private String account;

    @Column(name = "department", length = 10, nullable = false)
    private String department;

    @Column(name = "employeeAddress", length = 50)
    private String employeeAddress;

    @Column(name = "employeeBirthdate", nullable = false)
    private Date employeeBirthdate;

    @Column(name = "employeeEmail", length = 50)
    private String employeeEmail;

    @Column(name = "employeeName", length = 50, nullable = false)
    private String employeeName;

    @Column(name = "employeePhone", length = 10, nullable = false)
    private String employeePhone;

    @Column(name = "password", length = 50, nullable = false)
    private String password;

    @Column(name = "sex", length = 1, nullable = false)
    private String sex;


    public void loadFromAddModel(EmployeeAddModel model) {
        this.id = model.getId();
        this.account = model.getAccount();
        this.department = model.getDepartment();
        this.employeeAddress = model.getEmployeeAddress();
        this.employeeBirthdate = model.getEmployeeBirthdate();
        this.employeeEmail = model.getEmployeeEmail();
        this.employeeName = model.getEmployeeName();
        this.employeePhone = model.getEmployeePhone();
        this.password = EmployeePassword.encrypt(model.getPassword(),"js03");
        this.sex = model.getSex();
    }

    public void loadFromAddModel(EmployeeListModel model) {
        this.id = model.getId();
        this.department = model.getDepartment();
        this.employeeAddress = model.getEmployeeAddress();
        this.employeeBirthdate = model.getEmployeeBirthdate();
        this.employeeName = model.getEmployeeName();
        this.employeePhone = model.getEmployeePhone();
    }

}