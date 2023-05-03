package com.js.carpark.model.booking;

import com.js.carpark.entity.BookingOffice;
import com.js.carpark.entity.Trip;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BookingPlaceModel {
    private Long id;
    private String officePlace;
    public void loadFromEntity(BookingOffice bookingOffice) {
        this.id = bookingOffice.getId();
        this.officePlace = bookingOffice.getOfficePlace();


    }
}
