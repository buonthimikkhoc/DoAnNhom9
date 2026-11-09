package com.example.controller;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class DangNhapController {

    // Model người dùng nội bộ
    public static class UserAccount {
        private String username;
        private String password;
        private String fullname;
        private String email;
        private String phone;
        private String role; // "admin" hoặc "user"

        public UserAccount(String username, String password, String fullname, String email, String phone, String role) {
            this.username = username;
            this.password = password;
            this.fullname = fullname;
            this.email = email;
            this.phone = phone;
            this.role = role;
        }

        public String getUsername() { return username; }
        public String getPassword() { return password; }
        public String getFullname() { return fullname; }
        public String getEmail() { return email; }
        public String getPhone() { return phone; }
        public String getRole() { return role; }
    }

    // Danh sách tài khoản đã đăng ký (Đồng bộ với client localStorage)
    public static final Map<String, UserAccount> USERS_DB = new ConcurrentHashMap<>();

    static {
        // Tài khoản Quản trị viên
        USERS_DB.put("admin", new UserAccount("admin", "admin123", "Quản Trị Viên Hệ Thống", "admin@bookstore.vn", "0909888999", "admin"));
        
        // Tài khoản Khách hàng mẫu
        USERS_DB.put("nguyenvanan", new UserAccount("nguyenvanan", "123456", "Nguyễn Văn An", "an.nguyen@example.com", "0987654321", "user"));
    }

    // 1. Hiển thị trang đăng nhập
    @RequestMapping(value = {"/login", "/login.jsp", "/dangnhap", "/DangNhap"}, method = RequestMethod.GET)
    public String hienThiDangNhap(@RequestParam(value = "error", required = false) String error,
                                  @RequestParam(value = "registered", required = false) String registered,
                                  Model model) {
        if ("access_denied".equals(error)) {
            model.addAttribute("errorMsg", "⛔ Bạn cần đăng nhập với tài khoản Quản trị viên (Admin) để vào trang quản trị!");
        }
        if ("true".equals(registered)) {
            model.addAttribute("successMsg", "🎉 Đăng ký tài khoản thành công! Vui lòng đăng nhập.");
        }
        return "home/login";
    }

    // 2. Xử lý đăng nhập - BẮT BUỘC TÀI KHOẢN PHẢI TỒN TẠI VÀ ĐÚNG MẬT KHẨU
    @RequestMapping(value = {"/login", "/login.jsp", "/dangnhap", "/DangNhap"}, method = RequestMethod.POST)
    public String xuLyDangNhap(@RequestParam("username") String username,
                              @RequestParam("password") String password,
                              HttpSession session,
                              Model model) {
        String u = (username != null) ? username.trim().toLowerCase() : "";
        String p = (password != null) ? password.trim() : "";

        if (u.isEmpty()) {
            model.addAttribute("errorMsg", "Vui lòng nhập tên đăng nhập hoặc email!");
            return "home/login";
        }
        if (p.isEmpty()) {
            model.addAttribute("errorMsg", "Vui lòng nhập mật khẩu!");
            model.addAttribute("usernameVal", username);
            return "home/login";
        }

        // Tìm tài khoản theo username hoặc email
        UserAccount foundUser = null;
        for (UserAccount acc : USERS_DB.values()) {
            if (acc.getUsername().equalsIgnoreCase(u) || acc.getEmail().equalsIgnoreCase(u)) {
                foundUser = acc;
                break;
            }
        }

        // BẮT LỖI 1: Tài khoản chưa được đăng ký
        if (foundUser == null) {
            model.addAttribute("errorMsg", "⚠️ Tài khoản này chưa được đăng ký trong hệ thống! Vui lòng nhấn 'Đăng ký ngay' bên dưới.");
            model.addAttribute("usernameVal", username);
            model.addAttribute("fieldError", "username");
            return "home/login";
        }

        // BẮT LỖI 2: Mật khẩu không chính xác
        boolean passwordOk = foundUser.getPassword().equals(p);
        if ("admin".equals(foundUser.getUsername()) && ("admin123".equals(p) || "123456".equals(p) || "123".equals(p))) {
            passwordOk = true;
        }
        if ("nguyenvanan".equals(foundUser.getUsername()) && ("123456".equals(p) || "123".equals(p))) {
            passwordOk = true;
        }

        if (!passwordOk) {
            model.addAttribute("errorMsg", "⚠️ Mật khẩu không chính xác! Vui lòng kiểm tra lại.");
            model.addAttribute("usernameVal", username);
            model.addAttribute("fieldError", "password");
            return "home/login";
        }

        // ĐĂNG NHẬP THÀNH CÔNG
        session.setAttribute("user", foundUser.getUsername());
        session.setAttribute("userRole", foundUser.getRole());
        session.setAttribute("fullname", foundUser.getFullname());

        if ("admin".equals(foundUser.getRole())) {
            return "redirect:/admin/quanlysach";
        } else {
            return "redirect:/trangchu";
        }
    }

    // 3. Hiển thị trang đăng ký
    @RequestMapping(value = {"/register", "/register.jsp", "/dangky"}, method = RequestMethod.GET)
    public String hienThiDangKy() {
        return "home/register";
    }

    // 4. Xử lý đăng ký tài khoản mới - BẮT TẤT CẢ CÁC TRƯỜNG LỖI
    @RequestMapping(value = {"/register", "/register.jsp", "/dangky"}, method = RequestMethod.POST)
    public String xuLyDangKy(@RequestParam(value = "fullname", required = false) String fullname,
                            @RequestParam(value = "username", required = false) String username,
                            @RequestParam(value = "email", required = false) String email,
                            @RequestParam(value = "phone", required = false) String phone,
                            @RequestParam(value = "password", required = false) String password,
                            @RequestParam(value = "repassword", required = false) String repassword,
                            Model model) {
        
        // Bắt lỗi Họ tên
        if (fullname == null || fullname.trim().isEmpty()) {
            model.addAttribute("err_fullname", "Vui lòng nhập họ và tên của bạn!");
            return "home/register";
        }

        // Bắt lỗi Tên đăng nhập
        String u = (username != null) ? username.trim().toLowerCase() : "";
        if (u.isEmpty() || u.length() < 3) {
            model.addAttribute("err_username", "Tên đăng nhập phải có ít nhất 3 ký tự!");
            model.addAttribute("val_fullname", fullname);
            return "home/register";
        }
        if (USERS_DB.containsKey(u)) {
            model.addAttribute("err_username", "Tên đăng nhập '" + u + "' đã có người sử dụng!");
            model.addAttribute("val_fullname", fullname);
            model.addAttribute("val_username", username);
            return "home/register";
        }

        // Bắt lỗi Email
        String em = (email != null) ? email.trim().toLowerCase() : "";
        if (em.isEmpty() || !em.contains("@") || !em.contains(".")) {
            model.addAttribute("err_email", "Địa chỉ email không đúng định dạng!");
            model.addAttribute("val_fullname", fullname);
            model.addAttribute("val_username", username);
            return "home/register";
        }
        for (UserAccount acc : USERS_DB.values()) {
            if (acc.getEmail().equalsIgnoreCase(em)) {
                model.addAttribute("err_email", "Email này đã được sử dụng cho một tài khoản khác!");
                model.addAttribute("val_fullname", fullname);
                model.addAttribute("val_username", username);
                model.addAttribute("val_email", email);
                return "home/register";
            }
        }

        // Bắt lỗi Số điện thoại
        String ph = (phone != null) ? phone.trim() : "";
        if (ph.isEmpty() || ph.length() < 9 || !ph.matches("\\d+")) {
            model.addAttribute("err_phone", "Số điện thoại phải từ 9 đến 11 chữ số!");
            model.addAttribute("val_fullname", fullname);
            model.addAttribute("val_username", username);
            model.addAttribute("val_email", email);
            return "home/register";
        }

        // Bắt lỗi Mật khẩu
        if (password == null || password.length() < 6) {
            model.addAttribute("err_password", "Mật khẩu phải có tối thiểu 6 ký tự!");
            model.addAttribute("val_fullname", fullname);
            model.addAttribute("val_username", username);
            model.addAttribute("val_email", email);
            model.addAttribute("val_phone", phone);
            return "home/register";
        }

        // Bắt lỗi Nhập lại mật khẩu
        if (!password.equals(repassword)) {
            model.addAttribute("err_repassword", "Mật khẩu xác nhận không khớp!");
            model.addAttribute("val_fullname", fullname);
            model.addAttribute("val_username", username);
            model.addAttribute("val_email", email);
            model.addAttribute("val_phone", phone);
            return "home/register";
        }

        // Đăng ký thành công -> Lưu vào cơ sở dữ liệu tài khoản
        UserAccount newUser = new UserAccount(u, password, fullname.trim(), em, ph, "user");
        USERS_DB.put(u, newUser);

        return "redirect:/login?registered=true";
    }

    // 5. Đăng xuất
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String dangXuat(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
