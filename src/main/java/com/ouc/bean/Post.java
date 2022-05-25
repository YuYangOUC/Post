package com.ouc.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Post {
    private Integer pid;
    private Integer uid;
    private String title;
    private String content;
    private String imgUrl;
    private Date date;
    private Integer floorNum = 0;

    public Post() {
    }

    public Post(Integer uid, String title, String content, String imgUrl, Date date) {
        this.uid = uid;
        this.title = title;
        this.content = content;
        this.imgUrl = imgUrl;
        this.date = date;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl;
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

    public Integer getFloorNum() {
        return floorNum;
    }

    public void setFloorNum(Integer floorNum) {
        this.floorNum = floorNum;
    }

    @Override
    public String toString() {
        return "Post{" +
                "pid=" + pid +
                ", uid=" + uid +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", imgUrl='" + imgUrl + '\'' +
                ", date=" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date) +
                ", floorNum=" + floorNum +
                '}';
    }
}
