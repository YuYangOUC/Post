package com.ouc.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Floor {
    private Integer fid;
    private Integer uid;
    private Integer pid;
    private String content;
    private Date date;
    private Integer commentNum = 0;

    public Floor() {
    }

    public Floor(Integer uid, Integer pid, String content, Date date) {
        this.uid = uid;
        this.pid = pid;
        this.content = content;
        this.date = date;
    }

    public Integer getFid() {
        return fid;
    }

    public void setFid(Integer fid) {
        this.fid = fid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDate() {
        return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
    }

    public void setDate(String date) {
        try {
            this.date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Integer getCommentNum() {
        return commentNum;
    }

    public void setCommentNum(Integer commentNum) {
        this.commentNum = commentNum;
    }

    @Override
    public String toString() {
        return "Floor{" +
                "fid=" + fid +
                ", uid=" + uid +
                ", pid=" + pid +
                ", content='" + content + '\'' +
                ", date=" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date) +
                ", commentNum=" + commentNum +
                '}';
    }
}
