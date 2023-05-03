package com.js.carpark.model.employee;

import lombok.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class EmployeeSearchModel {
    private int type;
    private String text;

    public Date getDate() {
        if (type == 2) {
            try {
                System.out.println(text);
                return new SimpleDateFormat("yyyy-MM-dd").parse(text);
            } catch (Exception e) {
                return null;
            }
        }
        return null;
    }
}
