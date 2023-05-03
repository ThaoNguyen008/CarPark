package com.js.carpark.model.auth;

import com.js.carpark.entity.Employee;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class UserModel {
    private Long id;
    private String name;
    private String department;

    public void loadFromEntity(Employee employee) {
        this.id = employee.getId();
        this.name = employee.getEmployeeName();
        this.department = employee.getDepartment();
    }
}
