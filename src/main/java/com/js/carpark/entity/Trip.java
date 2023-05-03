package com.js.carpark.entity;

import javax.persistence.*;

import com.js.carpark.model.trip.TripAddModel;
import com.js.carpark.model.trip.TripListModel;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

@Entity
@Table(name = "trip")
@Data
@Getter
@Setter
public class Trip {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "tripId", nullable = false)
    private Long id;

    @Column(name = "bookedTicketNumber", columnDefinition = "integer default 0")
    private Integer bookedTicketNumber;

    @Column(name = "carType", length = 11)
    private String carType;

    @Column(name = "departureDate")
    private LocalDate departureDate;

    @Column(name = "departureTime")
    private LocalTime departureTime;

    @Column(name = "destination", length = 50)
    private String destination;

    @Column(name = "driver", length = 11)
    private String driver;

    @Column(name = "maximumOnlineTicketNumber")
    private Integer maximumOnlineTicketNumber;

    @OneToMany(cascade=CascadeType.ALL, mappedBy = "trip")
    @ToString.Exclude
    private List<BookingOffice> bookingOffices;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "id")
    @ToString.Exclude
    private List<Ticket> tickets;

    public void loadFromAddModel(TripAddModel model) {
        this.id = model.getId();
        this.carType = model.getCarType();
        this.departureDate = model.getDepartureDate();
        this.departureTime = model.getDepartureTime();
        this.destination = model.getDestination();
        this.driver = model.getDriver();
        this.maximumOnlineTicketNumber = model.getMaximumOnlineTicketNumber();
        if (model.getBookedTicketNumber() != null) {
            this.bookedTicketNumber = model.getBookedTicketNumber();
        } else {
            this.bookedTicketNumber = 0;
        }
    }

    public void loadFromAddModel(TripListModel model) {
        this.id = model.getId();
        this.id = model.getId();
        this.carType = model.getCarType();
        this.departureTime = model.getDepartureTime();
        this.destination = model.getDestination();
        this.driver = model.getDriver();
        this.bookedTicketNumber = getBookedTicketNumber();
//        if (model.getBookedTicketNumber() != null) {
//            this.bookedTicketNumber = model.getBookedTicketNumber();
//        } else {
//            this.bookedTicketNumber = 0;
//        }
    }

}




