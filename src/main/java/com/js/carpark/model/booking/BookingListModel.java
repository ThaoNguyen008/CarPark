package com.js.carpark.model.booking;

import com.js.carpark.entity.BookingOffice;
import com.js.carpark.entity.Employee;
import com.js.carpark.entity.Trip;
import com.js.carpark.model.ticket.TicketListModel;
import lombok.*;

import java.util.Comparator;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BookingListModel {
    private Long id;
    private String officeName;
    private Trip trip;
    private String officePlace;
    public void loadFromEntity(BookingOffice bookingOffice) {
        this.id = bookingOffice.getId();
        this.officeName = bookingOffice.getOfficeName();
        this.trip= bookingOffice.getTrip();
        this.officePlace= bookingOffice.getOfficePlace();

    }

    public static class CustomComparator implements Comparator<BookingListModel> {
        @Override
        public int compare(BookingListModel o1, BookingListModel o2) {
            return o1.id.compareTo(o2.getId());
        }
    }
}
