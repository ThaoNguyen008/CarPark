package com.js.carpark.repository;

import com.js.carpark.entity.BookingOffice;

import com.js.carpark.entity.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
@Repository
public interface BookingOfficeRepository extends JpaRepository<BookingOffice, Long> {


    public   List<BookingOffice> findByTrip(Trip trip);


    List<BookingOffice> findByOfficeNameContainingIgnoreCase(String text);
}