package com.js.carpark.model.booking;

import com.js.carpark.entity.BookingOffice;
import com.js.carpark.entity.Trip;
import lombok.*;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Setter
public class BookingTripListModel {
    private Long id;
    private String destination;
    public void loadFromEntity(Trip trip) {
        this.id = trip.getId();
        this.destination = trip.getDestination();

    }
}
