package com.js.carpark.controller;

import com.js.carpark.entity.BookingOffice;
import com.js.carpark.model.booking.*;

import com.js.carpark.model.employee.EmployeeListModel;
import com.js.carpark.model.employee.EmployeeSearchModel;
import com.js.carpark.model.ticket.TicketTripModel;
import com.js.carpark.service.BookingOfficeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.NoSuchElementException;


@Controller
public class BookingOfficeController {
    @Autowired
    private BookingOfficeService bookingOfficeService;

    @RequestMapping(value = "/booking-office-list", method = RequestMethod.GET)
    public String getBookingListPage(Model model) {
        List<BookingListModel> bookings = this.bookingOfficeService.listAll();
        model.addAttribute("bookings", bookings);
        model.addAttribute("bookingSearchModel", new BookingSearchModel());
        return "booking_office_list";
    }
    @RequestMapping(value = "/add-booking-office", method = RequestMethod.GET)
    public String getAddEmployeePage(Model model) {
           List<BookingTripListModel> listModels = this.bookingOfficeService.listTrip();
        model.addAttribute("listModels", listModels);
        List<BookingPlaceModel> bookingPlaceModels = this.bookingOfficeService.listPlace();
        model.addAttribute("isAdd", true);
        model.addAttribute("title", "Booking Add");
        model.addAttribute("bookingPlaceModels", bookingPlaceModels);
        model.addAttribute("bookingAddModel", new BookingAddModel());

        return "add_booking_office";
    }


    @RequestMapping(value = "/add-booking-office", method = RequestMethod.POST)
    public String add(Model model,@ModelAttribute("bookingAddModel") BookingAddModel bookingAddModel, BindingResult result) {
        try {
            System.out.println(bookingAddModel);
            this.bookingOfficeService.add(bookingAddModel);
            return "redirect:/booking-office-list";
        } catch (Exception e) {
            return "add-booking-office";
        }
    }




    @RequestMapping(value = "/view-booking-{id}", method = RequestMethod.GET)
    public String getookingByIdPage(Model model, @PathVariable Long id) {
        List<BookingTripListModel> listModels = this.bookingOfficeService.listTrip();
        model.addAttribute("listModels", listModels);
        List<BookingPlaceModel> bookingPlaceModels = this.bookingOfficeService.listPlace();
        model.addAttribute("bookingPlaceModels", bookingPlaceModels);
       model.addAttribute("title", "Booking View");
        BookingAddModel bookingAddModel = bookingOfficeService.get(id);
        model.addAttribute("bookingAddModel", bookingAddModel);
        System.out.println(bookingAddModel);
        model.addAttribute("isAdd", false);
        return "add_booking_office";
    }
    @RequestMapping(value = "/booking-office-list", method = RequestMethod.POST)
    public String search(Model model, @ModelAttribute("bookingSearchModel") BookingSearchModel bookingSearchModel, BindingResult result) {
        if (result.hasErrors()) {
            return getBookingListPage(model);
        }
        List<BookingListModel> bookings = this.bookingOfficeService.listAll(bookingSearchModel);
        System.out.println(bookings);
        model.addAttribute("bookings", bookings);
        model.addAttribute("bookingSearchModel", bookingSearchModel);
        return "booking_office_list";
    }


}
