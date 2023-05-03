package com.js.carpark.model.trip;

import lombok.*;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;


@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TripSearchModel {
    private int type;
    private String text;

    public Integer getInt() {
        try {
            return Integer.parseInt(this.text);
        } catch (Exception exception) {
            return null;
        }
    }

    public LocalTime getTime() {
        try {
            DateTimeFormatter format = DateTimeFormatter.ofPattern("HH:mm");
            return LocalTime.parse(this.text, format);
        } catch (Exception e) {
            return null;
        }
    }


}
