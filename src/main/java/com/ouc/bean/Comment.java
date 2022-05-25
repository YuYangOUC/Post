package com.ouc.bean;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Comment {
    private Integer cid;
    private Integer uid;
    private Integer fid;
    private Integer replyUid;
    private Integer replyFloorth;
    private String content;
    private Date date;

    public Comment() {
    }

    public Comment(Integer uid, Integer fid, Integer replyUid, Integer replyFloorth, String content, Date date) {
        this.uid = uid;
        this.fid = fid;
        this.replyUid = replyUid;
        this.replyFloorth = replyFloorth;
        this.content = content;
        this.date = date;
    }

    public Integer getCid() {
        return cid;
    }

    public void setCid(Integer cid) {
        this.cid = cid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

    public Integer getFid() {
        return fid;
    }

    public void setFid(Integer fid) {
        this.fid = fid;
    }

    public Integer getReplyUid() {
        return replyUid;
    }

    public void setReplyUid(Integer replyUid) {
        this.replyUid = replyUid;
    }

    public Integer getReplyFloorth() {
        return replyFloorth;
    }

    public void setReplyFloorth(Integer replyFloorth) {
        this.replyFloorth = replyFloorth;
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

    @Override
    public String toString() {
        return "Comment{" +
                "cid=" + cid +
                ", uid=" + uid +
                ", fid=" + fid +
                ", replyUid=" + replyUid +
                ", replyFloorth=" + replyFloorth +
                ", content='" + content + '\'' +
                ", date=" + new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date) +
                '}';
    }
}
