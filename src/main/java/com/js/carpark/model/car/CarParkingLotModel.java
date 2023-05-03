package com.js.carpark.model.car;

import com.js.carpark.entity.ParkingLot;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CarParkingLotModel {
    private Long id;
    private String name;

    public void loadFromEntity(ParkingLot entity) {
        this.id = entity.getId();
        this.name = entity.getParkName();
    }
}
