package com.js.carpark.controller;

import com.js.carpark.model.car.CarAddModel;
import com.js.carpark.model.car.CarListModel;
import com.js.carpark.model.car.CarParkingLotModel;
import com.js.carpark.model.car.CarSearchModel;
import com.js.carpark.service.CarService;
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
public class CarController {
    @Autowired
    private CarService carService;

    @Autowired
    private ParkingLotService parkingLotService;

    @RequestMapping(value = "/car-list", method = RequestMethod.GET)
    public String getListPage(Model model) {
        List<CarListModel> cars = this.carService.listAll();
        model.addAttribute("cars", cars);
        model.addAttribute("carSearchModel", new CarSearchModel());
        return "car_list";
    }

    @RequestMapping(value = "/car-list", method = RequestMethod.POST)
    public String search(Model model, @ModelAttribute("carSearchModel") CarSearchModel carSearchModel, BindingResult result) {
        if (result.hasErrors()) {
            return getListPage(model);
        }
        List<CarListModel> cars = this.carService.listAll(carSearchModel);
        System.out.println(cars);
        model.addAttribute("cars", cars);
        model.addAttribute("carSearchModel", carSearchModel);
        return "car_list";
    }

    @RequestMapping(value = "/delete-car-{id:.+}", method = RequestMethod.GET)
    public String delete(Model model, @PathVariable String id) {
        try {
            this.carService.deleteById(id);
        } catch (Exception e) {
            model.addAttribute("error", "error on delete");
        }
        return "redirect:/car-list";
    }

    @RequestMapping(value = "/view-car-{id:.+}", method = RequestMethod.GET)
    public String getIdPage(Model model, @PathVariable String id) {
        model.addAttribute("title", "Car Information");
        CarAddModel carAddModel = this.carService.get(id);
        if (carAddModel == null) {
            return "redirect:/car_list";
        }
        List<CarParkingLotModel> parkingLotModels = this.carService.getParkingLotModels();
        model.addAttribute("parkingLotModels", parkingLotModels);
        model.addAttribute("carAddModel", carAddModel);
        model.addAttribute("isUpdate", true);
        return "add_car";
    }

    @RequestMapping(value = "/view-car-{id:.+}", method = RequestMethod.POST)
    public String update(Model model, @PathVariable String id, @ModelAttribute("carAddModel") CarAddModel carAddModel) {
        try {
            if (carService.isFull(carAddModel.getParkId())) {
                model.addAttribute("error", "Parking Lot " + this.parkingLotService.get(carAddModel.getParkId()).getParkName() + " is full!");
                carAddModel = this.carService.get(id);
            } else {
                carAddModel.setId(id);
                this.carService.save(carAddModel);
            }
        } catch (Exception e) {
            model.addAttribute("error", "Cannot Save!");
        }
        model.addAttribute("title", "Car Information");
        List<CarParkingLotModel> parkingLotModels = this.carService.getParkingLotModels();
        model.addAttribute("parkingLotModels", parkingLotModels);
        model.addAttribute("carAddModel", carAddModel);
        model.addAttribute("isUpdate", true);
        return "add_car";
    }

    @RequestMapping(value = "/add-car", method = RequestMethod.GET)
    public String getAddPage(Model model) {
        model.addAttribute("title", "Add Car");
        model.addAttribute("isUpdate", false);
        model.addAttribute("carAddModel", new CarAddModel());
        List<CarParkingLotModel> parkingLotModels = this.carService.getParkingLotModels();
        model.addAttribute("parkingLotModels", parkingLotModels);
        return "add_car";
    }

    @RequestMapping(value = "/add-car", method = RequestMethod.POST)
    public String add(Model model, @ModelAttribute("carAddModel") CarAddModel carAddModel) {
        try {
            CarAddModel carAddModel1 = carService.get(carAddModel.getId());
            if (carAddModel1 != null) {
                model.addAttribute("error", carAddModel.getId() + " is existed!");
            } else if (carService.isFull(carAddModel.getParkId())) {
                model.addAttribute("error", "Parking Lot " + this.parkingLotService.get(carAddModel.getParkId()).getParkName() + " is full!");
            } else {
                this.carService.save(carAddModel);
                return "redirect:/car-list";
            }
        } catch (Exception e) {
            model.addAttribute("error", "Cannot Save!");
        }
        model.addAttribute("title", "Add Car");
        List<CarParkingLotModel> parkingLotModels = this.carService.getParkingLotModels();
        model.addAttribute("parkingLotModels", parkingLotModels);
        model.addAttribute("carAddModel", carAddModel);
        model.addAttribute("isUpdate", false);
        return "add_car";
    }
}
