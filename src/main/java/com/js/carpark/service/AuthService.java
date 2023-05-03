package com.js.carpark.service;

import com.js.carpark.entity.Employee;
import com.js.carpark.model.auth.LoginModel;
import com.js.carpark.model.auth.UserModel;
import com.js.carpark.model.auth.EmployeePassword;
import com.js.carpark.repository.AuthRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AuthService {
    @Autowired
    private AuthRepository authRepository;

    public UserModel getUserLoggedId(LoginModel loginModel) {
        String passwordEncrypt = EmployeePassword.encrypt(loginModel.getPassword(),"js03");
        Employee employee = this.authRepository.findByAccountAndPassword(loginModel.getAccount(),passwordEncrypt);
        System.out.println("Pass gốc nè nè: "+loginModel.getPassword());
        System.out.println("Pass mã hoá nè: "+passwordEncrypt);
        UserModel userModel = null;
        if (employee != null) {
            userModel = new UserModel();
            userModel.loadFromEntity(employee);
        }
        return userModel;
    }

}
