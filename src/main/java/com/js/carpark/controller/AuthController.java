package com.js.carpark.controller;

import com.js.carpark.model.auth.LoginModel;
import com.js.carpark.model.auth.UserModel;
import com.js.carpark.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;

@Controller
public class AuthController {
    @Autowired
    private AuthService authService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String getLoginPage(Model model) {
        model.addAttribute("loginModel", new LoginModel());
        return "login";
    }



    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String getUserLoggedIn(HttpServletRequest request, Model model, @ModelAttribute("loginModel") LoginModel loginModel, BindingResult result) {
        if (result.hasErrors()) {
            return getLoginPage(model);
        }

        UserModel userModel = this.authService.getUserLoggedId(loginModel);
        if (userModel == null) {
            return "redirect:/login";
        }
        request.getSession().setAttribute("userModel", userModel);
        String department = userModel.getDepartment();
        if (department.equals("employee")) {
            return "redirect:/employee-list";
        } else if (department.equals("parking")) {
            return "redirect:/parking-lot-list";
        } else if (department.equals("service")) {
            return "redirect:/trip-list";
        } else {
            return "redirect:/login";
        }
    }
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request,Model model) {
        request.getSession().removeAttribute("userModel");
        model.addAttribute("loginModel", new LoginModel());
        return "home";
    }
}
