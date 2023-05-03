package com.js.carpark.model.parkinglot;

import com.js.carpark.entity.ParkingLot;
import lombok.*;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ParkingLotAddModel {
    private Long id;
    private String parkName;
    private String parkPlace;
    private Long parkArea;
    private Long parkPrice;

    public void loadFromEntity(ParkingLot entity) {
        this.id = entity.getId();
        this.parkName = entity.getParkName();
        this.parkPlace = entity.getParkPlace();
        this.parkArea = entity.getParkArea();
        this.parkPrice = entity.getParkPrice();
    }
}
