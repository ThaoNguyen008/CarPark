package com.js.carpark.service;

import com.js.carpark.entity.Car;
import com.js.carpark.entity.Employee;
import com.js.carpark.entity.Ticket;
import com.js.carpark.entity.Trip;
import com.js.carpark.model.ticket.TicketAddModel;
import com.js.carpark.model.ticket.TicketListModel;
import com.js.carpark.model.ticket.TicketSearchModel;
import com.js.carpark.model.ticket.TicketTripModel;
import com.js.carpark.repository.CarRepository;
import com.js.carpark.repository.TicketRepository;
import com.js.carpark.repository.TripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

@Service
public class TicketService {
    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private CarRepository carRepository;

    @Autowired
    private TripRepository tripRepository;

    public List<TicketListModel> listAll() {
        List<TicketListModel> listModels = new ArrayList<>();
        List<Ticket> tickets = ticketRepository.findAll();
        for (Ticket ticket : tickets){
            TicketListModel model = new TicketListModel();
            model.loadFromEntity(ticket);
            listModels.add(model);
        }
        return listModels;
    }

    public List<TicketListModel> listAll(TicketSearchModel ticketSearchModel){
        List<TicketListModel> listModels = new ArrayList<>();
        List<Ticket> tickets = null;
        String text = ticketSearchModel.getText();
        int type = ticketSearchModel.getType();
        switch(type){
            case 1:
                List<Trip> trips = this.tripRepository.findByDestinationContainingIgnoreCase(text);
                tickets = new ArrayList<>();
                for (Trip trip : trips) {
                    tickets.addAll(this.ticketRepository.findByTrip(trip));
                }
                break;
            case 2:
                List<Car> cars = this.carRepository.findByIdContainingIgnoreCase(text);
                tickets = new ArrayList<>();
                for (Car car : cars) {
                    tickets.addAll(this.ticketRepository.findByLicensePlate(car));
                }
                break;
            case 3:
                tickets = this.ticketRepository.findByCustomerNameContainingIgnoreCase(text);
                break;
            case 4:
                LocalTime localTime = ticketSearchModel.getTime();
                tickets = this.ticketRepository.findByBookingTime(localTime);
                break;
        }
        if (tickets != null) {
            for (Ticket ticket : tickets){
                TicketListModel model = new TicketListModel();
                model.loadFromEntity(ticket);
                listModels.add(model);
            }
            Collections.sort(listModels, new TicketListModel.CustomComparator());
        }
        return listModels;
    }

    public void save(TicketAddModel ticketAddModel) {
        Ticket ticket = new Ticket();
        ticket.loadFromAddModel(ticketAddModel);
        ticket.setLicensePlate(carRepository.findById(ticketAddModel.getLicensePlate()).get());
        ticket.setTrip(tripRepository.findById(ticketAddModel.getTripId()).get());
        this.ticketRepository.save(ticket);
    }

    public void deleteById(Long id) {
        this.ticketRepository.deleteById(id);
    }

    public TicketAddModel get(Long id) {
        Ticket ticket = ticketRepository.findById(id).get();
        TicketAddModel model = new TicketAddModel();
        model.loadFromEntity(ticket);
        return model;
    }

    public List<TicketTripModel> getTripModels() {
        List<Trip> trips = this.tripRepository.findAll();
        List<TicketTripModel> modelList = new ArrayList<>();
        for (Trip trip : trips) {
            TicketTripModel model = new TicketTripModel();
            model.loadFromEntity(trip);
            modelList.add(model);
        }
        return modelList;
    }

    public List<String> getLicensePlateModels() {
        List<Car> cars = this.carRepository.findAll();
        List<String> modelList = new ArrayList<>();
        for (Car car : cars) {
            modelList.add(car.getId());
        }
        return modelList;
    }
}


