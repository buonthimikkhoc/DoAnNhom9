package com.example.controller;

import java.io.Serializable;

public class GioHangItem implements Serializable {
    private static final long serialVersionUID = 1L;

    private SanPham sanPham;
    private int soLuong;

    public GioHangItem() {
    }

    public GioHangItem(SanPham sanPham, int soLuong) {
        this.sanPham = sanPham;
        this.soLuong = soLuong;
    }

    public SanPham getSanPham() { return sanPham; }
    public void setSanPham(SanPham sanPham) { this.sanPham = sanPham; }

    public int getSoLuong() { return soLuong; }
    public void setSoLuong(int soLuong) { this.soLuong = soLuong; }

    public double getThanhTien() {
        if (sanPham != null) {
            return sanPham.getGia() * soLuong;
        }
        return 0;
    }
}
