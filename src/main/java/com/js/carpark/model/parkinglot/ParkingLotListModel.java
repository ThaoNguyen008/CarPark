package com.js.carpark.model.parkinglot;

import com.js.carpark.entity.ParkingLot;
import com.js.carpark.entity.Ticket;
import lombok.*;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ParkingLotListModel {
    private Long id;
    private String parkName;
    private String parkPlace;
    private Long parkArea;
    private Long parkPrice;
    private String parkStatus;

    public void loadFromEntity(ParkingLot parkingLot) {
        this.id = parkingLot.getId();
        this.parkName = parkingLot.getParkName();
        this.parkPlace = parkingLot.getParkPlace();
        this.parkArea = parkingLot.getParkArea();
        this.parkPrice = parkingLot.getParkPrice();
        this.parkStatus = parkingLot.getParkStatus();
    }
}
