package com.js.carpark.service;


import com.js.carpark.entity.Trip;
import com.js.carpark.model.trip.TripAddModel;
import com.js.carpark.model.trip.TripListModel;
import com.js.carpark.model.trip.TripSearchModel;
import com.js.carpark.repository.TripRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Time;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class TripService {
    @Autowired
    private TripRepository tripRepository;

    public List<TripListModel> listAll() {
        List<TripListModel> listModels = new ArrayList<>();
        List<Trip> trips = tripRepository.findAll();
        for (Trip trip : trips){
            TripListModel model = new TripListModel();
            model.loadFromEntity(trip);
            listModels.add(model);
        }
        return listModels;
    }

    public void save(Trip trip) {
        tripRepository.save(trip);
    }

    public void add(TripAddModel tripAddModel) {
        Trip trip = new Trip();
        trip.loadFromAddModel(tripAddModel);
        this.tripRepository.save(trip);
    }


    public void delete(Long id) {
        tripRepository.deleteById(id);
    }

    public void update(TripAddModel tripAddModel) {
        Trip trip = new Trip();
        trip.loadFromAddModel(tripAddModel);
        System.out.println(trip);
        this.tripRepository.save(trip);
    }

    public TripAddModel get(Long id) {
        Trip trip = tripRepository.findById(id).get();
        System.out.println(trip);
        TripAddModel model = new TripAddModel();
        model.loadFromEntity(trip);
        return model;
    }

    public List<TripListModel> listAll(TripSearchModel tripSearchModel){
        List<TripListModel> listModels = new ArrayList<>();
        List<Trip> trips = null;
        String text = tripSearchModel.getText();
        int type = tripSearchModel.getType();
        switch(type) {
            case 1:
                trips = this.tripRepository.findByDestinationContainingIgnoreCase(text);
                break;
            case 2:
                LocalTime localTime = tripSearchModel.getTime();
                trips = this.tripRepository.findByDepartureTime(localTime);
                break;
            case 3:
                trips = this.tripRepository.findByDriverContaining(text);
                break;
            case 4:
                trips = this.tripRepository.findByCarTypeContaining(text);
                break;
            case 5:
                trips = this.tripRepository.findByBookedTicketNumber(tripSearchModel.getInt());
                System.out.println(trips);
                break;
        }
        if (trips != null) {
            for (Trip trip : trips){
                TripListModel model = new TripListModel();
                model.loadFromEntity(trip);
                listModels.add(model);
            }
            Collections.sort(listModels, new TripListModel.CustomComparator());
        }
        return listModels;
    }



}
