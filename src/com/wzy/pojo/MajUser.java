package com.wzy.pojo;

import javax.persistence.*;
import java.util.Objects;

@Entity
@Table(name = "maj_user", schema = "majhong")
public class MajUser {
    private String userId;
    private String userName;
    private String password;
    private String happyBean;
    private String userImg;

    @Id
    @Column(name = "userId")
    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    @Basic
    @Column(name = "userName")
    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    @Basic
    @Column(name = "password")
    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Basic
    @Column(name = "happyBean")
    public String getHappyBean() {
        return happyBean;
    }

    public void setHappyBean(String happyBean) {
        this.happyBean = happyBean;
    }

    @Basic
    @Column(name = "userImg")
    public String getUserImg() {
        return userImg;
    }

    public void setUserImg(String userImg) {
        this.userImg = userImg;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        MajUser majUser = (MajUser) o;
        return Objects.equals(userId, majUser.userId) &&
                Objects.equals(userName, majUser.userName) &&
                Objects.equals(password, majUser.password) &&
                Objects.equals(happyBean, majUser.happyBean) &&
                Objects.equals(userImg, majUser.userImg);
    }

    @Override
    public int hashCode() {
        return Objects.hash(userId, userName, password, happyBean, userImg);
    }
}
