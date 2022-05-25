package com.ouc.dao.impl;

import com.ouc.bean.Floor;
import com.ouc.dao.FloorDao;

import java.util.List;

public class FloorDaoImpl extends BaseDao implements FloorDao {

    @Override
    public List<Floor> queryFloorsByPid(Integer pid) {
        String sql = "SELECT * FROM Floor WHERE pid=?";
        return queryMulti(Floor.class, sql, pid);
    }

    @Override
    public int addFloor(Floor floor) {
        String sql = "INSERT INTO Floor(uid, pid, content, date, commentNum) VALUES(?,?,?,?,?)";
        return update(sql, floor.getUid(), floor.getPid(), floor.getContent(), floor.getDate(), floor.getCommentNum());
    }

    @Override
    public int deleteFloor(Integer fid) {
        String sql = "DELETE FROM Floor WHERE fid=?";
        return update(sql, fid);
    }

    @Override
    public Floor queryFloorByFid(Integer fid) {
        String sql = "SELECT * FROM Floor WHERE fid=?";
        return querySingle(Floor.class, sql, fid);
    }

    @Override
    public int updateCommentNum(Integer fid, Integer commentNum) {
        String sql = "UPDATE Floor SET commentNum=? WHERE fid=?";
        return update(sql, commentNum, fid);
    }

    @Override
    public List<Floor> queryFloors() {
        String sql = "SELECT * FROM Floor";
        return queryMulti(Floor.class, sql);
    }

    @Override
    public int updateFloor(Integer fid, String content, String date) {
        String sql = "UPDATE Floor SET content=?, date=? WHERE fid=?";
        return update(sql, content, date, fid);
    }
}
