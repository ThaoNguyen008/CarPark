package com.js.carpark.repository;

import com.js.carpark.entity.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface AuthRepository extends JpaRepository<Employee, Long> {

    Employee findByAccountAndPassword(String account, String password);

}
