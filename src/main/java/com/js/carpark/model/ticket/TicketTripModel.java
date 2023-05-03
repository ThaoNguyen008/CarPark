package com.js.carpark.model.ticket;

import com.js.carpark.entity.Ticket;
import com.js.carpark.entity.Trip;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class TicketTripModel {
    private Long id;
    private String destination;

    public void loadFromEntity(Trip trip) {
        this.id = trip.getId();
        this.destination = trip.getDestination();
    }
}
