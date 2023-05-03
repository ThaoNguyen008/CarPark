package com.js.carpark.controller;

import com.js.carpark.model.employee.EmployeeAddModel;
import com.js.carpark.model.parkinglot.ParkingLotAddModel;
import com.js.carpark.model.parkinglot.ParkingLotListModel;
import com.js.carpark.model.parkinglot.ParkingLotSearchModel;
import com.js.carpark.service.ParkingLotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import java.util.List;

@Controller
public class ParkingLotController {
    @Autowired
    private ParkingLotService parkingLotService;

    @RequestMapping(value = "/parking-lot-list", method = RequestMethod.GET)
    public String getListPage(Model model) {
        List<ParkingLotListModel> parkingLots = this.parkingLotService.listAll();
        model.addAttribute("parkingLots", parkingLots);
        model.addAttribute("parkingLotSearchModel", new ParkingLotSearchModel());
        return "parking_lot_list";
    }

    @RequestMapping(value = "/parking-lot-list", method = RequestMethod.POST)
    public String search(Model model, @ModelAttribute("parkingLotSearchModel") ParkingLotSearchModel parkingLotSearchModel, BindingResult result) {
        if (result.hasErrors()) {
            return getListPage(model);
        }
        List<ParkingLotListModel> parkingLots = this.parkingLotService.listAll(parkingLotSearchModel);
        model.addAttribute("parkingLots", parkingLots);
        model.addAttribute("parkingLotSearchModel", parkingLotSearchModel);
        return "parking_lot_list";
    }

    @RequestMapping(value = "/add-parking-lot", method = RequestMethod.GET)
    public String getAddPage(Model model) {
        model.addAttribute("title", "Add Parking Lot");
        model.addAttribute("isUpdate", false);
        model.addAttribute("parkingLotAddModel", new ParkingLotAddModel());
        return "add_parking_lot";
    }

    @RequestMapping(value = "/add-parking-lot", method = RequestMethod.POST)
    public String add(Model model, @ModelAttribute("parkingLotAddModel") ParkingLotAddModel parkingLotAddModel, BindingResult result) {
        try {
            System.out.println(parkingLotAddModel);
            this.parkingLotService.save(parkingLotAddModel);
            return "redirect:/parking-lot-list";
        } catch (Exception e) {
            System.out.println(e);
            return "add-parking-lot";
        }
    }

    @RequestMapping(value = "/view-parking-lot-{id}", method = RequestMethod.GET)
    public String getByIdPage(Model model, @PathVariable Long id) {
        model.addAttribute("title", "Parking Lot Information");
        ParkingLotAddModel parkingLotAddModel = parkingLotService.get(id);
        model.addAttribute("parkingLotAddModel", parkingLotAddModel);
        model.addAttribute("isUpdate", true);
        return "add_parking_lot";
    }

    @RequestMapping(value = "/view-parking-lot-{id}", method = RequestMethod.POST)
    public String update(Model model, @PathVariable Long id, @ModelAttribute("parkingLotAddModel") ParkingLotAddModel parkingLotAddModel, BindingResult result) {
        try {
            parkingLotAddModel.setId(id);
            this.parkingLotService.save(parkingLotAddModel);
        } catch (Exception e) {
            model.addAttribute("error", "error");
        }
        return "redirect:/view-parking-lot-" + id;
    }

    @RequestMapping(value = "/delete-parking-lot-{id}", method = RequestMethod.GET)
    public String delete(Model model, @PathVariable Long id) {
        try {
            this.parkingLotService.deleteById(id);
        } catch (Exception e) {
            model.addAttribute("error", "error on delete");
        }
        return "redirect:/parking-lot-list";
    }
}
