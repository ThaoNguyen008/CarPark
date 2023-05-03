package com.js.carpark.entity;

import com.js.carpark.model.booking.BookingAddModel;
import com.js.carpark.model.booking.BookingListModel;
import com.js.carpark.model.booking.BookingTripListModel;
import com.js.carpark.model.employee.EmployeeAddModel;
import com.js.carpark.model.employee.EmployeeListModel;
import lombok.Data;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "bookingoffice")
@Data
public class BookingOffice {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "officeId", nullable = false, updatable = false)
    private Long id;

    @Column(name = "endContractDeadline")
    private LocalDate endContractDeadline;

    @Column(name = "officeName", length = 50)
    private String officeName;

    @Column(name = "officePhone", length = 11)
    private String officePhone;

    @Column(name = "officePlace", length = 50)
    private String officePlace;

    @Column(name = "officePrice")
    private Long officePrice;

    @Column(name = "startContractDeadline")
    private LocalDate startContractDeadline;

    @ManyToOne(cascade=CascadeType.ALL)
    @JoinColumn(name = "tripId")
    private Trip trip;
    public void loadFromAddModel(BookingAddModel model) {
        this.id = model.getId();
        this.endContractDeadline = model.getEndContractDeadline();
        this.officeName = model.getOfficeName();
        this.officePhone = model.getOfficePhone();
        this.officePlace = model.getOfficePlace();
        this.officePrice = model.getOfficePrice();
        this.startContractDeadline = model.getStartContractDeadline();
         this.trip = new Trip();
        trip.setId(model.getId());
        trip.getDestination();


    }
    public void loadFromAddModel(BookingListModel model) {
        this.id = model.getId();
        this.officeName = model.getOfficeName();
        this.trip = model.getTrip();
        this.officePlace= model.getOfficePlace();
    }
    public void loadFromAddModel(BookingTripListModel listModel ){
        this.id = listModel.getId();

    }



}