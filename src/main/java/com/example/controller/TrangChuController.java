package com.example.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class TrangChuController {

    // Trang chủ
    @RequestMapping(value = {"/", "/trangchu", "/trangchu.jsp", "/home"}, method = RequestMethod.GET)
    public String trangChu(Model model) {
        return "home/trangchu";
    }

    // Chi tiết sách
    @RequestMapping(value = {"/chitietsach", "/chitietsach.jsp", "/chitiet"}, method = RequestMethod.GET)
    public String chiTietSach(@RequestParam(value = "id", defaultValue = "S01") String id, Model model) {
        model.addAttribute("bookId", id);
        return "home/chitietsach";
    }

    // Giỏ hàng
    @RequestMapping(value = {"/giohang", "/giohang.jsp"}, method = RequestMethod.GET)
    public String gioHang() {
        return "home/giohang";
    }

    // Thanh toán / Đặt hàng
    @RequestMapping(value = {"/thanhtoan", "/thanhtoan.jsp"}, method = RequestMethod.GET)
    public String thanhToan() {
        return "home/thanhtoan";
    }

    // Lịch sử đơn hàng
    @RequestMapping(value = {"/donhang", "/donhang.jsp"}, method = RequestMethod.GET)
    public String donHang() {
        return "home/donhang";
    }

    // Hồ sơ tài khoản
    @RequestMapping(value = {"/taikhoan", "/taikhoan.jsp"}, method = RequestMethod.GET)
    public String taiKhoan() {
        return "home/taikhoan";
    }
}
