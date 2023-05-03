package com.js.carpark.service;

import com.js.carpark.entity.Car;
import com.js.carpark.entity.ParkingLot;
import com.js.carpark.model.car.CarAddModel;
import com.js.carpark.model.car.CarListModel;
import com.js.carpark.model.car.CarParkingLotModel;
import com.js.carpark.model.car.CarSearchModel;
import com.js.carpark.repository.CarRepository;
import com.js.carpark.repository.ParkingLotRepository;
import com.js.carpark.repository.TicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Service
public class CarService {
    @Autowired
    private CarRepository carRepository;

    @Autowired
    private ParkingLotRepository parkingLotRepository;
    @Autowired
    private TicketRepository ticketRepository;

    public List<CarListModel> listAll() {
        List<CarListModel> listModels = new ArrayList<>();
        List<Car> cars = this.carRepository.findAll();
        for (Car bookingOffice : cars) {
            CarListModel listModel = new CarListModel();
            listModel.loadFromEntity(bookingOffice);
            listModels.add(listModel);
        }
        Collections.sort(listModels, new CarListModel.CustomComparator());
        return listModels;
    }

    public List<CarListModel> listAll(CarSearchModel bookingSearchModel) {
        List<CarListModel> listModels = new ArrayList<>();
        List<Car> cars = null;
        String text = bookingSearchModel.getText();
        int type = bookingSearchModel.getType();
        switch (type) {
            case 1:
                cars = this.carRepository.findByIdContainingIgnoreCase(text);
                break;
            case 2:
                cars = this.carRepository.findByCarTypeContainingIgnoreCase(text);
                break;
            case 3:
                cars = this.carRepository.findByCarColorContainingIgnoreCase(text);
                break;
            case 4:
                cars = this.carRepository.findByCompanyContainingIgnoreCase(text);
                break;
            case 5:
                List<ParkingLot> parkingLots = this.parkingLotRepository.findByParkNameContainingIgnoreCase(text);
                cars = new ArrayList<>();
                for (ParkingLot parkingLot : parkingLots) {
                    cars.addAll(this.carRepository.findByPark(parkingLot));
                }
                break;

        }
        if (cars != null) {
            for (Car office : cars) {
                CarListModel model = new CarListModel();
                model.loadFromEntity(office);
                listModels.add(model);
            }
            Collections.sort(listModels, new CarListModel.CustomComparator());
        }
        return listModels;
    }

    public void save(CarAddModel carAddModel) {
        Car car = new Car();
        car.loadFromAddModel(carAddModel);
        car.setPark(parkingLotRepository.findById(carAddModel.getParkId()).get());
        this.carRepository.save(car);
    }

    public CarAddModel get(String licensePlate) {
        System.out.println(licensePlate);
        Car car = carRepository.findById(licensePlate).get();
        if (car != null) {
            System.out.println(car);
            CarAddModel carAddModel = new CarAddModel();
            carAddModel.loadFromEntity(car);
            return carAddModel;
        } else {
            return null;
        }
    }

    public void deleteById(String licensePlate) {
        System.out.println(licensePlate);
        Car car = carRepository.findCarById(licensePlate);
        System.out.println(car);
        ticketRepository.deleteByLicensePlate(car);
        carRepository.deleteById(licensePlate);
    }

    public List<CarParkingLotModel> getParkingLotModels() {
        List<ParkingLot> parkingLots = this.parkingLotRepository.findAll();
        List<CarParkingLotModel> modelList = new ArrayList<>();
        for (ParkingLot parkingLot : parkingLots) {
            CarParkingLotModel model = new CarParkingLotModel();
            model.loadFromEntity(parkingLot);
            modelList.add(model);
        }
        return modelList;
    }

    public boolean isFull(Long parkId) {
        ParkingLot parkingLot = parkingLotRepository.findById(parkId).get();
        List<Car> cars = this.carRepository.findByPark(parkingLot);
        return cars.size() >= 10;
    }

}
