package com.js.carpark.model.car;

import com.js.carpark.entity.Car;
import lombok.*;

import java.util.Comparator;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CarListModel {
    private String id;
    private String carType;
    private String carColor;
    private String company;
    private CarParkingLotModel park;

    public void loadFromEntity(Car entity) {
        this.id = entity.getId();
        this.carType = entity.getCarType();
        this.carColor = entity.getCarColor();
        this.company = entity.getCompany();
        this.park = new CarParkingLotModel();
        park.loadFromEntity(entity.getPark());
    }

    public static class CustomComparator implements Comparator<CarListModel> {
        @Override
        public int compare(CarListModel o1, CarListModel o2) {
            return o1.id.compareTo(o2.getId());
        }
    }
}
