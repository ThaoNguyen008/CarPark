package com.js.carpark.model.trip;

import com.js.carpark.entity.Trip;
import lombok.*;

import java.time.LocalTime;
import java.util.Comparator;
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TripListModel {
    private Long id;

    private String destination;

    private LocalTime departureTime;

    private String driver;

    private String carType;

    private Integer bookedTicketNumber;


    public void loadFromEntity(Trip trip) {
        this.id = trip.getId();
        this.destination = trip.getDestination();
        this.departureTime = trip.getDepartureTime();
        this.driver = trip.getDriver();
        this.carType = trip.getCarType();
        this.bookedTicketNumber = trip.getBookedTicketNumber();
    }

    public static class CustomComparator implements Comparator<TripListModel> {
        @Override
        public int compare(TripListModel o1, TripListModel o2) {
            return o1.id.compareTo(o2.getId());
        }
    }

}
