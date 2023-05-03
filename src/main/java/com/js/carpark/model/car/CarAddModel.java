package com.js.carpark.model.car;

import com.js.carpark.entity.Car;
import com.js.carpark.entity.ParkingLot;
import lombok.*;

import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import static javax.persistence.CascadeType.DETACH;
import static javax.persistence.CascadeType.PERSIST;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CarAddModel {
    private String id;
    private String carType;
    private String carColor;
    private String company;
    private Long parkId;

    public void loadFromEntity(Car entity) {
        this.id = entity.getId();
        this.carType = entity.getCarType();
        this.carColor = entity.getCarColor();
        this.company = entity.getCompany();
        this.parkId = entity.getPark().getId();
    }
}
