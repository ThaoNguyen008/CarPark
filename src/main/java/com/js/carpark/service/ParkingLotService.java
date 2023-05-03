package com.js.carpark.service;

import com.js.carpark.entity.ParkingLot;
import com.js.carpark.model.parkinglot.ParkingLotAddModel;
import com.js.carpark.model.parkinglot.ParkingLotListModel;
import com.js.carpark.model.parkinglot.ParkingLotSearchModel;
import com.js.carpark.repository.ParkingLotRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ParkingLotService {
    @Autowired
    private ParkingLotRepository parkingLotRepository;

    public List<ParkingLotListModel> listAll() {
        List<ParkingLot> parkingLots = parkingLotRepository.findAll();
        List<ParkingLotListModel> modelList = new ArrayList<>();
        for (ParkingLot parkingLot : parkingLots) {
            ParkingLotListModel model = new ParkingLotListModel();
            model.loadFromEntity(parkingLot);
            modelList.add(model);
        }
        return modelList;
    }

    public List<ParkingLotListModel> listAll(ParkingLotSearchModel parkingLotSearchModel) {
        List<ParkingLotListModel> listModels = new ArrayList<>();
        List<ParkingLot> parkingLots = null;
        int type = parkingLotSearchModel.getType();
        switch (type) {
            case 1:
                parkingLots = parkingLotRepository.findByParkNameContainingIgnoreCase(parkingLotSearchModel.getText());
                break;
            case 2:
                parkingLots = parkingLotRepository.findByParkPlaceContainingIgnoreCase(parkingLotSearchModel.getText());
                break;
            case 3:
                parkingLots = parkingLotRepository.findByParkArea(parkingLotSearchModel.getLong());
                break;
            case 4:
                parkingLots = parkingLotRepository.findByParkPrice(parkingLotSearchModel.getLong());
                break;
            case 5:
                parkingLots = parkingLotRepository.findByParkStatus(parkingLotSearchModel.getText());
                break;
        }
        for (ParkingLot parkingLot : parkingLots){
            ParkingLotListModel model = new ParkingLotListModel();
            model.loadFromEntity(parkingLot);
            listModels.add(model);
        }
        return listModels;
    }

    public void save(ParkingLotAddModel parkingLotAddModel) {
        ParkingLot parkingLot = new ParkingLot();
        parkingLot.loadFromAddModel(parkingLotAddModel);
        this.parkingLotRepository.save(parkingLot);
    }

    public ParkingLotAddModel get(Long id) {
        ParkingLot parkingLot = parkingLotRepository.findById(id).get();
        ParkingLotAddModel model = new ParkingLotAddModel();
        model.loadFromEntity(parkingLot);
        return model;
    }

    public void deleteById(Long id) {
        parkingLotRepository.deleteById(id);
    }
}
