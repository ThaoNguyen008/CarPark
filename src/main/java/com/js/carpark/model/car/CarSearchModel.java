package com.js.carpark.model.car;

import lombok.*;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CarSearchModel {
    private int type;
    private String text;
}
