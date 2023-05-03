package com.js.carpark.model.parkinglot;

import lombok.*;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ParkingLotSearchModel {
    private int type;
    private String text;

    public Long getLong() {
        try {
            return Long.parseLong(this.text);
        } catch (Exception exception) {
            return null;
        }
    }
}
