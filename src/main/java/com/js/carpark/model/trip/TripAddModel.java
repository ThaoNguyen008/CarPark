package com.js.carpark.model.trip;

import com.js.carpark.entity.Trip;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
import java.time.LocalTime;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class TripAddModel {
    private Long id;

    private String carType;

    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate departureDate;

    @DateTimeFormat(iso = DateTimeFormat.ISO.TIME)
    private LocalTime departureTime;

    private String destination;

    private String driver;

    private Integer maximumOnlineTicketNumber;

    private Integer bookedTicketNumber = 25;

    public void loadFromEntity(Trip trip) {
        this.id = trip.getId();
        this.carType = trip.getCarType();
        this.departureDate = trip.getDepartureDate();
        this.departureTime = trip.getDepartureTime();
        this.destination = trip.getDestination();
        this.driver = trip.getDriver();
        this.maximumOnlineTicketNumber = trip.getMaximumOnlineTicketNumber();
        this.bookedTicketNumber = trip.getBookedTicketNumber();
    }
}
