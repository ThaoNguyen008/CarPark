package com.js.carpark.repository;

import com.js.carpark.entity.Car;
import com.js.carpark.entity.ParkingLot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CarRepository extends JpaRepository<Car, String> {
    List<Car> findByIdContainingIgnoreCase(String text);

    List<Car> findByCarTypeContainingIgnoreCase(String text);

    List<Car> findByCarColorContainingIgnoreCase(String text);

    List<Car> findByCompanyContainingIgnoreCase(String text);

    List<Car> findByPark(ParkingLot parkingLot);

    Car findCarById(String id);
}