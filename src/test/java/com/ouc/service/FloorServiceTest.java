package com.ouc.service;

import com.ouc.bean.Floor;
import com.ouc.service.impl.FloorServiceImpl;
import org.junit.jupiter.api.Test;

import java.util.Date;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class FloorServiceTest {

    private final FloorService floorService = new FloorServiceImpl();

    @Test
    void queryFloorsByPid() {
        List<Floor> floors = floorService.queryFloorsByPid(69);
        for (Floor floor : floors) {
            System.out.println(floor);
        }
    }

    @Test
    void addFloor() {
        System.out.println(floorService.addFloor(new Floor(26, 69, "affs", new Date())));
    }

    @Test
    void deleteFloor() {
        System.out.println(floorService.deleteFloor(9));
    }

    @Test
    void queryFloorByFid() {
        System.out.println(floorService.queryFloorByFid(19));
    }

    @Test
    void updateCommentNum() {
        System.out.println(floorService.updateCommentNum(1, 0));
    }
}