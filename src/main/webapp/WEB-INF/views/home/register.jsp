<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký tài khoản - Quản lý bán sách trực tuyến</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        .inp-error {
            border-color: #ef4444 !important;
            background-color: #fef2f2 !important;
        }
        .text-error {
            color: #b91c1c;
            font-size: 12px;
            margin-top: 4px;
            font-weight: 500;
            display: none;
        }
    </style>
</head>
<body>

    <!-- Navigation Header -->
    <header class="main-nav">
        <a href="${pageContext.request.contextPath}/trangchu" class="brand-logo">
            <svg viewBox="0 0 24 24"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>
            BookStore
        </a>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/login" class="btn o btn-sm" style="color: #fff; border-color: rgba(255,255,255,0.4); text-decoration: none; padding: 6px 14px; font-size: 13px;">Đã có tài khoản? Đăng nhập</a>
        </div>
    </header>

    <!-- Main Content: Register Form -->
    <main class="auth-wrapper">
        <div class="auth-card" style="max-width: 480px;">
            <div class="auth-header">
                <a href="${pageContext.request.contextPath}/trangchu" class="auth-logo">
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="currentColor"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>
                    BookStore
                </a>
                <h1 class="auth-title">Tạo tài khoản</h1>
                <p class="auth-sub">Đăng ký tài khoản để mua sắm và theo dõi đơn hàng</p>
            </div>

            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post" onsubmit="return handleRegisterSubmit(event)">
                <!-- Bắt trường Họ và tên -->
                <div class="form-group">
                    <label class="form-label" for="fullname">Họ và tên</label>
                    <input type="text" id="fullname" name="fullname" class="form-control" placeholder="Ví dụ: Nguyễn Văn An" value="<%= request.getAttribute("val_fullname") != null ? request.getAttribute("val_fullname") : "" %>" required oninput="clearError('fullname')">
                    <div id="err_fullname" class="text-error"><%= request.getAttribute("err_fullname") != null ? request.getAttribute("err_fullname") : "" %></div>
                </div>

                <!-- Bắt trường Tên đăng nhập -->
                <div class="form-group">
                    <label class="form-label" for="username">Tên đăng nhập</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Tối thiểu 3 ký tự (ví dụ: annguyen26)" value="<%= request.getAttribute("val_username") != null ? request.getAttribute("val_username") : "" %>" required oninput="clearError('username')">
                    <div id="err_username" class="text-error"><%= request.getAttribute("err_username") != null ? request.getAttribute("err_username") : "" %></div>
                </div>

                <!-- Bắt trường Email -->
                <div class="form-group">
                    <label class="form-label" for="email">Địa chỉ Email</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="name@example.com" value="<%= request.getAttribute("val_email") != null ? request.getAttribute("val_email") : "" %>" required oninput="clearError('email')">
                    <div id="err_email" class="text-error"><%= request.getAttribute("err_email") != null ? request.getAttribute("err_email") : "" %></div>
                </div>

                <!-- Bắt trường Số điện thoại -->
                <div class="form-group">
                    <label class="form-label" for="phone">Số điện thoại</label>
                    <input type="tel" id="phone" name="phone" class="form-control" placeholder="Ví dụ: 0987654321" value="<%= request.getAttribute("val_phone") != null ? request.getAttribute("val_phone") : "" %>" required oninput="clearError('phone')">
                    <div id="err_phone" class="text-error"><%= request.getAttribute("err_phone") != null ? request.getAttribute("err_phone") : "" %></div>
                </div>

                <!-- Bắt trường Mật khẩu & Xác nhận mật khẩu -->
                <div class="g2" style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px;">
                    <div class="form-group">
                        <label class="form-label" for="password">Mật khẩu</label>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Tối thiểu 6 ký tự" required oninput="clearError('password')">
                        <div id="err_password" class="text-error"><%= request.getAttribute("err_password") != null ? request.getAttribute("err_password") : "" %></div>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="repassword">Nhập lại mật khẩu</label>
                        <input type="password" id="repassword" name="repassword" class="form-control" placeholder="Khớp mật khẩu trên" required oninput="clearError('repassword')">
                        <div id="err_repassword" class="text-error"><%= request.getAttribute("err_repassword") != null ? request.getAttribute("err_repassword") : "" %></div>
                    </div>
                </div>

                <div style="margin-bottom: 20px;">
                    <label style="display: flex; align-items: flex-start; gap: 8px; font-size: 12.5px; color: var(--mute); cursor: pointer;">
                        <input type="checkbox" required checked style="accent-color: var(--ac); margin-top: 3px;">
                        <span>Tôi đồng ý với <a href="#" style="color: var(--ac);">Điều khoản dịch vụ</a> & <a href="#" style="color: var(--ac);">Chính sách bảo mật</a></span>
                    </label>
                </div>

                <button type="submit" class="btn btn-block" style="padding: 11px;">Đăng ký tài khoản</button>

                <div style="text-align: center; margin-top: 22px; font-size: 13.5px;" class="mute">
                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/login" style="color: var(--ac); font-weight: 600; text-decoration: none;">Đăng nhập ngay</a>
                </div>
            </form>
        </div>
    </main>

    <footer>
        <p>© 2026 BookStore - Đồ án tốt nghiệp / Môn học Eclipse Web - Nhóm 9</p>
    </footer>

    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <script>
        // Hiển thị lỗi từ server nếu có
        <% if (request.getAttribute("err_fullname") != null) { %> showError('fullname', '<%= request.getAttribute("err_fullname") %>'); <% } %>
        <% if (request.getAttribute("err_username") != null) { %> showError('username', '<%= request.getAttribute("err_username") %>'); <% } %>
        <% if (request.getAttribute("err_email") != null) { %> showError('email', '<%= request.getAttribute("err_email") %>'); <% } %>
        <% if (request.getAttribute("err_phone") != null) { %> showError('phone', '<%= request.getAttribute("err_phone") %>'); <% } %>
        <% if (request.getAttribute("err_password") != null) { %> showError('password', '<%= request.getAttribute("err_password") %>'); <% } %>
        <% if (request.getAttribute("err_repassword") != null) { %> showError('repassword', '<%= request.getAttribute("err_repassword") %>'); <% } %>

        function clearError(field) {
            var inp = document.getElementById(field);
            var err = document.getElementById('err_' + field);
            if (inp) inp.classList.remove('inp-error');
            if (err) {
                err.innerText = '';
                err.style.display = 'none';
            }
        }

        function showError(field, message) {
            var inp = document.getElementById(field);
            var err = document.getElementById('err_' + field);
            if (inp) {
                inp.classList.add('inp-error');
                inp.focus();
            }
            if (err) {
                err.innerText = '⚠️ ' + message;
                err.style.display = 'block';
            }
        }

        function handleRegisterSubmit(e) {
            // Xóa sạch các lỗi trước đó
            ['fullname', 'username', 'email', 'phone', 'password', 'repassword'].forEach(clearError);

            var fullname = document.getElementById('fullname').value.trim();
            var username = document.getElementById('username').value.trim().toLowerCase();
            var email = document.getElementById('email').value.trim().toLowerCase();
            var phone = document.getElementById('phone').value.trim();
            var password = document.getElementById('password').value;
            var repassword = document.getElementById('repassword').value;

            // 1. Bắt lỗi Họ tên
            if (!fullname) {
                e.preventDefault();
                showError('fullname', 'Vui lòng nhập họ và tên của bạn!');
                return false;
            }

            // 2. Bắt lỗi Tên đăng nhập
            if (!username || username.length < 3) {
                e.preventDefault();
                showError('username', 'Tên đăng nhập phải có ít nhất 3 ký tự!');
                return false;
            }
            if (!/^[a-zA-Z0-9_]+$/.test(username)) {
                e.preventDefault();
                showError('username', 'Tên đăng nhập chỉ chứa chữ cái, số và dấu gạch dưới!');
                return false;
            }

            // 3. Bắt lỗi Email
            if (!email || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
                e.preventDefault();
                showError('email', 'Địa chỉ email không đúng định dạng (vd: name@example.com)!');
                return false;
            }

            // 4. Bắt lỗi Số điện thoại
            if (!phone || !/^(0|\+84)[0-9]{9,10}$/.test(phone)) {
                e.preventDefault();
                showError('phone', 'Số điện thoại không hợp lệ (phải có 10 số, bắt đầu bằng 0)!');
                return false;
            }

            // 5. Bắt lỗi Mật khẩu
            if (!password || password.length < 6) {
                e.preventDefault();
                showError('password', 'Mật khẩu phải có tối thiểu 6 ký tự!');
                return false;
            }

            // 6. Bắt lỗi Nhập lại mật khẩu
            if (password !== repassword) {
                e.preventDefault();
                showError('repassword', 'Mật khẩu nhập lại không khớp với mật khẩu trên!');
                return false;
            }

            // 7. Kiểm tra trùng tài khoản và lưu vào danh sách đăng ký
            var res = Auth.register({
                fullname: fullname,
                username: username,
                email: email,
                phone: phone,
                password: password
            });

            if (!res.success) {
                e.preventDefault();
                showError(res.field, res.message);
                return false;
            }

            // Hợp lệ -> cho phép form POST lên Spring MVC
            return true;
        }
    </script>
</body>
</html>
