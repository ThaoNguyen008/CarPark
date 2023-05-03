package com.js.carpark.model.ticket;

import lombok.*;

import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class TicketSearchModel {
    private int type;
    private String text;

    public LocalTime getTime() {
        try {
            DateTimeFormatter format = DateTimeFormatter.ofPattern("HH:mm");
            return LocalTime.parse(this.text, format);
        } catch (Exception e) {
            return null;
        }
    }
}