package com.js.carpark.entity;

import com.js.carpark.model.ticket.TicketAddModel;
import com.js.carpark.repository.CarRepository;
import com.js.carpark.repository.TripRepository;
import lombok.*;
import org.apache.tomcat.jni.Time;
import org.springframework.beans.factory.annotation.Autowired;

import javax.persistence.*;
import java.time.LocalTime;
import java.util.Timer;

import static javax.persistence.CascadeType.DETACH;
import static javax.persistence.CascadeType.PERSIST;

@Entity
@Table(name = "ticket")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Ticket {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "ticketId", nullable = false)
    private Long id;

    @Column(name = "bookingTime", nullable = false)
    private LocalTime bookingTime;

    @Column(name = "customerName", length = 11, nullable = false)
    private String customerName;

    @ManyToOne(cascade = {PERSIST, DETACH})
    @JoinColumn(name = "licensePlate", nullable = false)
    private Car licensePlate;

    @ManyToOne(cascade = {PERSIST, DETACH})
    @JoinColumn(name = "tripId", nullable = false)
    private Trip trip;

    public void loadFromAddModel(TicketAddModel model) {
        this.id = model.getId();
        this.bookingTime = model.getBookingTime();
        this.customerName = model.getCustomerName();
    }
}