# HƯỚNG DẪN CHẠY DỰ ÁN MAVEN SPRING MVC (NHÓM 9)

**Dự án:** Quản Lý Bán Sách Trực Tuyến  
**Mô hình:** Maven Spring MVC Web Project (Tương tự `C2_NguyenVanThuc`)

---

## 1. Các Bước Khởi Chạy Trong Eclipse

### Bước 1: Cập nhật thư viện Maven
1. Trong cửa sổ **Project Explorer** của Eclipse, nhấp chuột phải vào project **`DoAn-NHOM9`**.
2. Chọn **Maven** ➔ **Update Project...** (phím tắt `Alt + F5`).
3. Tích chọn **`DoAn-NHOM9`** ➔ bấm **OK**.

---

### Bước 2: Chạy trên máy chủ Apache Tomcat
1. Chuột phải vào project **`DoAn-NHOM9`** ➔ chọn **Run As** ➔ **Run on Server**.
2. Chọn máy chủ **Apache Tomcat** có sẵn trong Eclipse ➔ bấm **Finish**.

---

## 2. Các Đường Dẫn Truy Cập (Hỗ trợ cả 2 dạng URL)

Hệ thống Spring Controller đã được cấu hình nhận diện cả 2 dạng đường dẫn:

- **Trang chủ:**
  - `http://localhost:8080/DoAn-NHOM9/`
  - `http://localhost:8080/DoAn-NHOM9/trangchu` hoặc `http://localhost:8080/DoAn-NHOM9/trangchu.jsp`
- **Đăng nhập:**
  - `http://localhost:8080/DoAn-NHOM9/login` hoặc `http://localhost:8080/DoAn-NHOM9/login.jsp`
- **Quản trị viên:**
  - `http://localhost:8080/DoAn-NHOM9/admin/quanlysach`
  - `http://localhost:8080/DoAn-NHOM9/admin/quanlydanhmuc`
  - `http://localhost:8080/DoAn-NHOM9/admin/quanlydonhang`

---

## 3. Tài Khoản Phân Quyền & Test

- **Quản trị viên (Admin):**
  - Username: `admin` | Mật khẩu: `admin123` (hoặc `123`)
  - Vào thẳng trang Quản lý sách, Quản lý danh mục, Quản lý đơn hàng.
- **Khách hàng (User):**
  - Username: `nguyenvanan` | Mật khẩu: `123456`
  - Đặt sách, quản lý giỏ hàng, xem lịch sử đơn hàng.
