package com.js.carpark.entity;

import com.js.carpark.model.parkinglot.ParkingLotAddModel;
import lombok.*;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "parkinglot")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ParkingLot {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "parkId", nullable = false)
    private Long id;

    @Column(name = "parkArea", nullable = false)
    private Long parkArea;

    @Column(name = "parkName", length = 50, nullable = false)
    private String parkName;

    @Column(name = "parkPlace", length = 11, nullable = false)
    private String parkPlace;

    @Column(name = "parkPrice", nullable = false)
    private Long parkPrice;

    @Column(name = "parkStatus", length = 50)
    private String parkStatus;

    @Column(name = "parkMaximumSlot", columnDefinition = "INT default 10")
    private Long parkMaximumSlot;

    @OneToMany(mappedBy = "park")
    @ToString.Exclude
    private List<Car> cars;

    public void loadFromAddModel(ParkingLotAddModel model) {
        this.id = model.getId();
        this.parkName = model.getParkName();
        this.parkPlace = model.getParkPlace();
        this.parkArea = model.getParkArea();
        this.parkPrice = model.getParkPrice();
    }
}