package com.js.carpark.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author VuBQ5
 */
@Controller
public class HomeController {
    @RequestMapping(value = "/", method = RequestMethod.GET)

    public String hello(@RequestParam(value = "name", defaultValue = "Kinggggg", required = true) String name, Model model){
        model.addAttribute("name",name);
        return "home";
    }
}

