package com.js.carpark.model.ticket;


import com.fasterxml.jackson.annotation.JsonFormat;
import com.js.carpark.entity.Car;
import com.js.carpark.entity.Employee;
import com.js.carpark.entity.Ticket;
import com.js.carpark.entity.Trip;
import lombok.*;
import org.apache.tomcat.jni.Time;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalTime;
import java.util.Timer;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString

public class TicketAddModel {
    private Long id;

    private Long tripId;

    private String licensePlate;

    private String customerName;

    @DateTimeFormat(iso = DateTimeFormat.ISO.TIME)
    private LocalTime bookingTime;

    public void loadFromEntity(Ticket ticket) {
        this.id = ticket.getId();
        this.tripId = ticket.getTrip().getId();
        this.licensePlate = ticket.getLicensePlate().getId();
        this.customerName = ticket.getCustomerName();
        this.bookingTime = ticket.getBookingTime();
    }
}
