package com.js.carpark.model.employee;

import com.js.carpark.entity.Employee;
import lombok.*;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class EmployeeListModel {
    private Long id;
    private String account;
    private String employeeName;
    private Date employeeBirthdate;
    private String employeeAddress;
    private String employeePhone;
    private String department;

    public String getDate() {
        if (this.employeeBirthdate != null) {
            DateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
            return dateFormat.format(this.employeeBirthdate);
        } else {
            return "";
        }
    }

    public void loadFromEntity(Employee employee) {
        this.id = employee.getId();
        this.account = employee.getAccount();
        this.employeeName = employee.getEmployeeName();
        this.employeePhone = employee.getEmployeePhone();
        this.employeeBirthdate = employee.getEmployeeBirthdate();
        this.employeeAddress = employee.getEmployeeAddress();
        this.department = employee.getDepartment();
    }
}
