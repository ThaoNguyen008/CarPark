package com.js.carpark.controller;





import com.js.carpark.model.trip.TripAddModel;
import com.js.carpark.model.trip.TripListModel;
import com.js.carpark.model.trip.TripSearchModel;
import com.js.carpark.repository.EmployeeRepository;
import com.js.carpark.repository.TripRepository;
import com.js.carpark.service.TripService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Controller
public class TripController {
    @Autowired
    private TripService tripService;
    @Autowired
    private EmployeeRepository employeeRepository;
    @Autowired
    private TripRepository tripRepository;

    @RequestMapping(value = "/trip-list", method = RequestMethod.GET)
    public String getTripListPage(Model model)
    {
        List<TripListModel> trip = this.tripService.listAll();
        model.addAttribute("trip", trip);
        model.addAttribute("tripSearchModel", new TripSearchModel());
        return "trip_list";
    }

//add
    @RequestMapping(value = "/add-trip", method = RequestMethod.GET)
    public String getAddTripPage(Model model) {
        model.addAttribute("title", "Add Trip");
        model.addAttribute("isUpdate", false);
        model.addAttribute("tripAddModel", new TripAddModel());
        return "add_trip";
    }

    @RequestMapping(value = "/add-trip", method = RequestMethod.POST)
    public String add(Model model, @ModelAttribute("tripAddModel") TripAddModel tripAddModel, BindingResult result) {
        try {
            System.out.println(tripAddModel);
            this.tripService.add(tripAddModel);
            return "redirect:/trip-list";
        } catch (Exception e) {
            return "add-trip";
        }
    }


    //delete
   @RequestMapping(value = "/delete-{id}", method = RequestMethod.GET)
    public String deleteTrip(@PathVariable("id") Long id, Model model)
    {
        System.out.println(id);
        tripRepository.deleteById(id);
        model.addAttribute("trip",tripRepository.findAll());
        return "redirect:/trip-list";
    }
//edit
    @RequestMapping(value = "/edit-trip-{id}", method = RequestMethod.GET)
    public String getTripByIdPage(Model model, @PathVariable Long id) {
        model.addAttribute("title", "Edit Trip");
        TripAddModel tripAddModel = tripService.get(id);
        model.addAttribute("tripAddModel", tripAddModel);
        model.addAttribute("isUpdate", true);
        return "add_trip";
    }
    @RequestMapping(value = "/edit-trip-{id}", method = RequestMethod.POST)
    public String update(Model model, @PathVariable Long id, @ModelAttribute("tripAddModel") TripAddModel tripAddModel, BindingResult result) {
        try {
            tripAddModel.setId(id);
            this.tripService.update(tripAddModel);
            return "redirect:/trip-list";
        } catch (Exception e) {
            model.addAttribute("error", "error");
            return "redirect:/edit-trip-" + id;
        }
    }

    @RequestMapping(value = "/trip-list", method = RequestMethod.POST)
    public String search(Model model, @ModelAttribute("tripSearchModel") TripSearchModel tripSearchModel, BindingResult result) {
        if (result.hasErrors()) {
            return getTripListPage(model);
        }
        System.out.println(tripSearchModel);
        List<TripListModel> trips = this.tripService.listAll(tripSearchModel);
        model.addAttribute("trip", trips);
        model.addAttribute("tripSearchModel", tripSearchModel);
        return "trip_list";
    }
}