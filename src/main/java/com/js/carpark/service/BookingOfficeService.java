package com.js.carpark.service;

import com.js.carpark.entity.BookingOffice;
import com.js.carpark.entity.Employee;
import com.js.carpark.entity.Ticket;
import com.js.carpark.entity.Trip;
import com.js.carpark.model.booking.*;
import com.js.carpark.model.employee.EmployeeAddModel;
import com.js.carpark.model.employee.EmployeeListModel;
import com.js.carpark.model.employee.EmployeeSearchModel;
import com.js.carpark.model.ticket.TicketListModel;
import com.js.carpark.repository.BookingOfficeRepository;
import com.js.carpark.repository.TripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class BookingOfficeService {
    @Autowired
    private BookingOfficeRepository bookingOfficeRepository;
    @Autowired
    private TripRepository tripRepository;

    public List<BookingListModel> listAll() {
        List<BookingListModel> listModels = new ArrayList<>();
        List<BookingOffice> bookingOffices = new ArrayList<>();
        bookingOffices = bookingOfficeRepository.findAll();
        for (BookingOffice bookingOffice : bookingOffices) {
            BookingListModel listModel = new BookingListModel();
            listModel.loadFromEntity(bookingOffice);
            listModels.add(listModel);
        }

        return listModels;
    }

    public List<BookingTripListModel> listTrip() {
        List<Trip> trips = tripRepository.findAll();
        List<BookingTripListModel> listModels = new ArrayList<>();
        for (Trip trip : trips) {
            BookingTripListModel listModel = new BookingTripListModel();
            listModel.loadFromEntity(trip);
            listModels.add(listModel);
        }
        return listModels;

    }

    public List<BookingPlaceModel> listPlace() {
        List<BookingOffice> bookingOffices = bookingOfficeRepository.findAll();
        List<BookingPlaceModel> listModels = new ArrayList<>();
        for (BookingOffice bookingOffice : bookingOffices) {
            BookingPlaceModel listModel = new BookingPlaceModel();
            listModel.loadFromEntity(bookingOffice);
            listModels.add(listModel);
        }
        return listModels;

    }

    public void add(BookingAddModel bookingAddModel) {
        BookingOffice bookingOffice = new BookingOffice();
        bookingOffice.loadFromAddModel(bookingAddModel);
        bookingOffice.setTrip(tripRepository.findById(bookingAddModel.getTripId()).get());
        this.bookingOfficeRepository.save(bookingOffice);
    }

    public BookingAddModel get(Long id) {
        BookingOffice bookingOffice = bookingOfficeRepository.findById(id).get();
        BookingAddModel model = new BookingAddModel();
        model.loadFromEntity(bookingOffice);
        return model;
    }


    public List<BookingListModel> listAll(BookingSearchModel bookingSearchModel) {
        List<BookingListModel> listModels = new ArrayList<>();
        List<BookingOffice> bookingOffices = null;
        String text = bookingSearchModel.getText();
        int type = bookingSearchModel.getType();
        switch (type) {
            case 1:
              bookingOffices = this.bookingOfficeRepository.findByOfficeNameContainingIgnoreCase(text);
              break;
            case 2:
                List<Trip> trips = this.tripRepository.findByDestinationContainingIgnoreCase(text);
                bookingOffices = new ArrayList<>();
                for (Trip trip : trips) {
                    bookingOffices.addAll(this.bookingOfficeRepository.findByTrip(trip));
                }
                break;

        }
        if (bookingOffices != null) {
            for (BookingOffice office : bookingOffices) {
                BookingListModel model = new BookingListModel();
                model.loadFromEntity(office);
                listModels.add(model);
            }
         Collections.sort(listModels, new BookingListModel.CustomComparator());
        }
        return listModels;
    }
}

