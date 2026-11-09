package com.example.controller;

import java.io.Serializable;

public class SanPham implements Serializable {
    private static final long serialVersionUID = 1L;

    private String id;
    private String ten;
    private String tacGia;
    private String danhMuc;
    private double gia;
    private double giaCu;
    private int soLuongTon;
    private String hinhAnh;
    private String moTa;

    public SanPham() {
    }

    public SanPham(String id, String ten, String tacGia, String danhMuc, double gia, double giaCu, int soLuongTon, String hinhAnh, String moTa) {
        this.id = id;
        this.ten = ten;
        this.tacGia = tacGia;
        this.danhMuc = danhMuc;
        this.gia = gia;
        this.giaCu = giaCu;
        this.soLuongTon = soLuongTon;
        this.hinhAnh = hinhAnh;
        this.moTa = moTa;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTen() { return ten; }
    public void setTen(String ten) { this.ten = ten; }

    public String getTacGia() { return tacGia; }
    public void setTacGia(String tacGia) { this.tacGia = tacGia; }

    public String getDanhMuc() { return danhMuc; }
    public void setDanhMuc(String danhMuc) { this.danhMuc = danhMuc; }

    public double getGia() { return gia; }
    public void setGia(double gia) { this.gia = gia; }

    public double getGiaCu() { return giaCu; }
    public void setGiaCu(double giaCu) { this.giaCu = giaCu; }

    public int getSoLuongTon() { return soLuongTon; }
    public void setSoLuongTon(int soLuongTon) { this.soLuongTon = soLuongTon; }

    public String getHinhAnh() { return hinhAnh; }
    public void setHinhAnh(String hinhAnh) { this.hinhAnh = hinhAnh; }

    public String getMoTa() { return moTa; }
    public void setMoTa(String moTa) { this.moTa = moTa; }
}
