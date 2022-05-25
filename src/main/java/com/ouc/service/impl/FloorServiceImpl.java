package com.ouc.service.impl;

import com.ouc.bean.Floor;
import com.ouc.dao.FloorDao;
import com.ouc.dao.impl.FloorDaoImpl;
import com.ouc.service.FloorService;

import java.util.List;

public class FloorServiceImpl implements FloorService {

    private final FloorDao floorDao = new FloorDaoImpl();

    @Override
    public List<Floor> queryFloorsByPid(Integer pid) {
        return floorDao.queryFloorsByPid(pid);
    }

    @Override
    public int addFloor(Floor floor) {
        return floorDao.addFloor(floor);
    }

    @Override
    public int deleteFloor(Integer fid) {
        return floorDao.deleteFloor(fid);
    }

    @Override
    public Floor queryFloorByFid(Integer fid) {
        return floorDao.queryFloorByFid(fid);
    }

    @Override
    public int updateCommentNum(Integer fid, Integer commentNum) {
        return floorDao.updateCommentNum(fid, commentNum);
    }

    @Override
    public List<Floor> queryFloors() {
        return floorDao.queryFloors();
    }

    @Override
    public int updateFloor(Integer fid, String content, String date) {
        return floorDao.updateFloor(fid, content, date);
    }
}
