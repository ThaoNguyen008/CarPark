package com.js.carpark.repository;

import com.js.carpark.entity.ParkingLot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ParkingLotRepository extends JpaRepository<ParkingLot, Long> {
    public List<ParkingLot> findByParkNameContainingIgnoreCase(String name);

    public List<ParkingLot> findByParkPlaceContainingIgnoreCase(String place);

    public List<ParkingLot> findByParkArea(Long area);

    public List<ParkingLot> findByParkPrice(Long price);

    public List<ParkingLot> findByParkStatus(String status);
}