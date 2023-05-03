package com.js.carpark.controller;

import com.js.carpark.model.employee.EmployeeAddModel;
import com.js.carpark.model.ticket.TicketAddModel;
import com.js.carpark.model.ticket.TicketListModel;
import com.js.carpark.model.ticket.TicketSearchModel;
import com.js.carpark.model.ticket.TicketTripModel;
import com.js.carpark.service.TicketService;
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
public class TicketController {
    @Autowired
    private TicketService ticketService;

    @RequestMapping(value = "/view-ticket-{id}", method = RequestMethod.GET)
    public String getEmployeeByIdPage(Model model, @PathVariable Long id) {
        model.addAttribute("title", "Ticket Information");
        TicketAddModel ticketAddModel = this.ticketService.get(id);
        List<TicketTripModel> ticketTripModels = this.ticketService.getTripModels();
        List<String> licensePlateModels = this.ticketService.getLicensePlateModels();
        model.addAttribute("licensePlateModels", licensePlateModels);
        model.addAttribute("ticketTripModels", ticketTripModels);
        model.addAttribute("ticketAddModel", ticketAddModel);
        model.addAttribute("isUpdate", true);
        return "add_ticket";
    }

    @RequestMapping(value = "/view-ticket-{id}", method = RequestMethod.POST)
    public String update(Model model, @PathVariable Long id, @ModelAttribute("ticketAddModel") TicketAddModel ticketAddModel, BindingResult result) {
        try {
            ticketAddModel.setId(id);
            this.ticketService.save(ticketAddModel);
        } catch (Exception e) {
            model.addAttribute("error", "error");
        }
        return "redirect:/view-ticket-" + id;
    }

    @RequestMapping(value = "/delete-ticket-{id}", method = RequestMethod.GET)
    public String deleteTicket(Model model, @PathVariable Long id) {
        try {
            this.ticketService.deleteById(id);
        } catch (Exception e) {
            model.addAttribute("error", "error on delete");
        }
        return "redirect:/ticket-list";
    }

    @RequestMapping(value = "/ticket-list", method = RequestMethod.GET)
    public String getTicketListPage(Model model) {
        List<TicketListModel> tickets = this.ticketService.listAll();
        model.addAttribute("tickets", tickets);
        model.addAttribute("ticketSearchModel", new TicketSearchModel());
        return "ticket_list";
    }

    @RequestMapping(value = "/add-ticket", method = RequestMethod.GET)
    public String getAddEmployeePage(Model model) {
        model.addAttribute("title", "Add Ticket");
        model.addAttribute("isUpdate", false);
        model.addAttribute("ticketAddModel", new TicketAddModel());
        List<TicketTripModel> ticketTripModels = this.ticketService.getTripModels();
        List<String> licensePlateModels = this.ticketService.getLicensePlateModels();
        model.addAttribute("licensePlateModels", licensePlateModels);
        model.addAttribute("ticketTripModels", ticketTripModels);
        return "add_ticket";
    }

    @RequestMapping(value = "/add-ticket", method = RequestMethod.POST)
    public String add(Model model, @ModelAttribute("ticketAddModel") TicketAddModel ticketAddModel, BindingResult result) {
        try {
            this.ticketService.save(ticketAddModel);
            return "redirect:/ticket-list";
        } catch (Exception e) {
            return "add_ticket";
        }
    }

    @RequestMapping(value = "/ticket-list", method = RequestMethod.POST)
    public String search(Model model, @ModelAttribute("ticketSearchModel") TicketSearchModel ticketSearchModel, BindingResult result) {
        if (result.hasErrors()) {
            return getTicketListPage(model);
        }
        List<TicketListModel> tickets = this.ticketService.listAll(ticketSearchModel);
        model.addAttribute("tickets", tickets);
        model.addAttribute("ticketSearchModel", ticketSearchModel);
        return "ticket_list";
    }
}
