package com.js.carpark.model.booking;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class BookingSearchModel {
    private int type;
    private String text;
}
