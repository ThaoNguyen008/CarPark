package com.js.carpark.model.booking;

import com.js.carpark.entity.BookingOffice;
import com.js.carpark.entity.Employee;
import com.js.carpark.entity.Trip;
import lombok.*;
import org.springframework.format.annotation.DateTimeFormat;

import java.time.LocalDate;
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BookingAddModel {
    private Long id;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate endContractDeadline;
    private String officeName;
    private String officePhone;
    private String officePlace;
    private Long officePrice;
    @DateTimeFormat(iso = DateTimeFormat.ISO.DATE)
    private LocalDate startContractDeadline;
    private Long tripId;
    public void loadFromEntity(BookingOffice bookingOffice) {
        this.id = bookingOffice.getId();
        this.endContractDeadline = bookingOffice.getEndContractDeadline();
        this.officeName = bookingOffice.getOfficeName();
        this.officePhone = bookingOffice.getOfficePhone();
        this.officePlace = bookingOffice.getOfficePlace();
        this.officePrice = bookingOffice.getOfficePrice();
        this.startContractDeadline = bookingOffice.getStartContractDeadline();
        this.tripId = bookingOffice.getTrip().getId();
    }
}
