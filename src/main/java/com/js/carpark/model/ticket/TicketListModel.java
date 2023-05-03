package com.js.carpark.model.ticket;

import com.js.carpark.entity.Car;
import com.js.carpark.entity.Ticket;
import com.js.carpark.entity.Trip;
import lombok.*;
import org.apache.tomcat.jni.Time;

import java.time.LocalTime;
import java.util.Comparator;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TicketListModel {

    private Long id;

    private LocalTime bookingTime;

    private String customerName;

    private String licensePlate;

    private String trip;

    public void loadFromEntity(Ticket ticket) {
        this.id = ticket.getId();
        this.trip = ticket.getTrip().getDestination();
        this.licensePlate = ticket.getLicensePlate().getId();
        this.customerName = ticket.getCustomerName();
        this.bookingTime = ticket.getBookingTime();
    }

    public static class CustomComparator implements Comparator<TicketListModel> {
        @Override
        public int compare(TicketListModel o1, TicketListModel o2) {
            return o1.id.compareTo(o2.getId());
        }
    }

}
