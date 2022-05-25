package com.ouc.dao;

import com.ouc.bean.Floor;

import java.util.List;

public interface FloorDao {

    List<Floor> queryFloorsByPid(Integer pid);

    int addFloor(Floor floor);

    int deleteFloor(Integer fid);

    Floor queryFloorByFid(Integer fid);

    int updateCommentNum(Integer fid, Integer commentNum);

    List<Floor> queryFloors();

    int updateFloor(Integer fid, String content, String date);
}
