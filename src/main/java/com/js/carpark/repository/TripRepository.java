package com.js.carpark.repository;



import com.js.carpark.entity.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.sql.Time;
import java.time.LocalTime;
import java.util.Date;
import java.util.List;

@Repository
public interface TripRepository extends JpaRepository<Trip, Long> {
    public List<Trip> findByDestinationContainingIgnoreCase(String destination);

    public  List<Trip> findByDestinationContaining(String destination);

    public  List<Trip> findByDriverContaining(String driver);

    public  List<Trip> findByCarTypeContaining(String carType);

    public  List<Trip> findByDepartureTime(LocalTime departureTime);

    public  List<Trip> findByBookedTicketNumber(Integer bookedTicketNumber);
}