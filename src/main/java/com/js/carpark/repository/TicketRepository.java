package com.js.carpark.repository;

import com.js.carpark.entity.Car;
import com.js.carpark.entity.Ticket;
import com.js.carpark.entity.Trip;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalTime;
import java.util.List;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Long> {
    public List<Ticket> findByTrip(Trip trip);

    public List<Ticket> findByLicensePlate(Car licensePlate);

    public List<Ticket> findByCustomerNameContainingIgnoreCase(String name);

    public List<Ticket> findByBookingTime(LocalTime bookingTime);

    public void deleteByLicensePlate(Car licensePlate);
}