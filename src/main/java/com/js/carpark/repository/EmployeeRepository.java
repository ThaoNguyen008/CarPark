package com.js.carpark.repository;

import com.js.carpark.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    List<Employee> findByEmployeeNameContainingIgnoreCase(String employeeName);

    List<Employee> findByEmployeeAddressContainingIgnoreCase(String employeeAddress);

    List<Employee> findByEmployeePhoneContaining(String phone);

    List<Employee> findByDepartmentContainingIgnoreCase(String department);

    List<Employee> findByEmployeeBirthdate(Date date);

    Employee findEmployeeByAccount(String account);
}