package com.js.carpark.entity;

import com.js.carpark.model.car.CarAddModel;
import lombok.*;

import javax.persistence.*;
import java.util.List;
import java.util.Set;

import static javax.persistence.CascadeType.DETACH;
import static javax.persistence.CascadeType.PERSIST;

@Entity
@Table(name = "car")
@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class Car {
    @Id
    @Column(name = "licensePlate", nullable = false, length = 50)
    private String id;

    @Column(name = "carColor", length = 11)
    private String carColor;

    @Column(name = "carType", length = 50)
    private String carType;

    @Column(name = "company", length = 50)
    private String company;

    @ManyToOne(fetch = FetchType.LAZY, cascade = {DETACH, PERSIST})
    @JoinColumn(name = "parkId")
    private ParkingLot park;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "licensePlate")
    @ToString.Exclude
    private List<Ticket> tickets;

    public void loadFromAddModel(CarAddModel model) {
        this.id = model.getId();
        this.carColor = model.getCarColor();
        this.carType = model.getCarType();
        this.company = model.getCompany();
    }

}