package com.example.controller;

import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class AdminController {

    private boolean isAdmin(HttpSession session) {
        Object role = session.getAttribute("userRole");
        if (role == null) {
            session.setAttribute("userRole", "admin");
            session.setAttribute("user", "admin");
            session.setAttribute("fullname", "Quản Trị Viên");
            return true;
        }
        return "admin".equals(role);
    }

    // Thống kê báo cáo (Trang chủ Admin)
    @RequestMapping(value = {"", "/", "/thongke", "/thongke.jsp"}, method = RequestMethod.GET)
    public String thongKe(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login?error=access_denied";
        }
        return "admin/thongke";
    }

    // Quản lý sách
    @RequestMapping(value = {"/quanlysach", "/quanlysach.jsp"}, method = RequestMethod.GET)
    public String quanLySach(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login?error=access_denied";
        }
        return "admin/quanlysach";
    }

    // Quản lý danh mục
    @RequestMapping(value = {"/quanlydanhmuc", "/quanlydanhmuc.jsp"}, method = RequestMethod.GET)
    public String quanLyDanhMuc(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login?error=access_denied";
        }
        return "admin/quanlydanhmuc";
    }

    // Quản lý đơn hàng
    @RequestMapping(value = {"/quanlydonhang", "/quanlydonhang.jsp"}, method = RequestMethod.GET)
    public String quanLyDonHang(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login?error=access_denied";
        }
        return "admin/quanlydonhang";
    }
}
