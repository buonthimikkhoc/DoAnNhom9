<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập - Quản lý bán sách trực tuyến</title>
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
            <a href="${pageContext.request.contextPath}/trangchu" class="btn o btn-sm" style="color: #fff; border-color: rgba(255,255,255,0.4); text-decoration: none; padding: 6px 14px; font-size: 13px;">‹ Về Trang Chủ</a>
        </div>
    </header>

    <!-- Main Content: Login Form -->
    <main class="auth-wrapper">
        <div class="auth-card">
            <!-- Thông báo từ chối quyền Admin -->
            <div id="accessDeniedAlert" style="display: none; background: #fee2e2; border: 1px solid #f87171; color: #b91c1c; padding: 12px 14px; border-radius: var(--radius-sm); margin-bottom: 20px; font-size: 13px;">
                <strong>⛔ Quyền truy cập bị từ chối:</strong><br>
                Bạn phải đăng nhập bằng tài khoản <strong>Admin</strong> để vào trang quản trị!
            </div>

            <!-- Thông báo chuyển hướng khi chưa đăng nhập mà thanh toán -->
            <div id="checkoutRedirectAlert" style="display: none; background: #ecfdf5; border: 1px solid #a7f3d0; color: #065f46; padding: 12px; border-radius: var(--radius); font-size: 13px; margin-bottom: 18px; line-height: 1.4;">
                🛒 <strong>Yêu cầu đăng nhập:</strong> Vui lòng đăng nhập tài khoản để tiếp tục thanh toán và đặt hàng!
            </div>

            <!-- Thông báo đăng ký thành công -->
            <% if (request.getAttribute("successMsg") != null || request.getParameter("registered") != null) { %>
            <div style="background: #ecfdf5; border: 1px solid #10b981; color: #065f46; padding: 12px 14px; border-radius: var(--radius-sm); margin-bottom: 18px; font-size: 13px; font-weight: 500;">
                🎉 Đăng ký tài khoản thành công! Bạn có thể dùng tài khoản vừa tạo để đăng nhập ngay bây giờ.
            </div>
            <% } %>

            <!-- Thông báo lỗi chung từ Server -->
            <% if (request.getAttribute("errorMsg") != null) { %>
            <div id="serverErrorMsg" style="background: #fee2e2; border: 1px solid #f87171; color: #b91c1c; padding: 12px 14px; border-radius: var(--radius-sm); margin-bottom: 18px; font-size: 13px; font-weight: 500;">
                <%= request.getAttribute("errorMsg") %>
            </div>
            <% } %>

            <div class="auth-header">
                <a href="${pageContext.request.contextPath}/trangchu" class="auth-logo">
                    <svg width="28" height="28" viewBox="0 0 24 24" fill="currentColor"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>
                    BookStore
                </a>
                <h1 class="auth-title">Đăng nhập</h1>
                <p class="auth-sub">Vui lòng đăng nhập để tiếp tục sử dụng hệ thống</p>
            </div>

            <form id="loginForm" action="${pageContext.request.contextPath}/login" method="post" onsubmit="return handleLoginSubmit(event)">
                <!-- Bắt trường Tên đăng nhập -->
                <div class="form-group">
                    <label class="form-label" for="username">Tên đăng nhập hoặc Email</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Nhập tên đăng nhập hoặc email..." value="<%= request.getAttribute("usernameVal") != null ? request.getAttribute("usernameVal") : "" %>" required oninput="clearError('username')">
                    <div id="err_username" class="text-error"></div>
                </div>

                <!-- Bắt trường Mật khẩu -->
                <div class="form-group">
                    <div style="display: flex; justify-content: space-between; align-items: center;">
                        <label class="form-label" for="password">Mật khẩu</label>
                        <a href="javascript:void(0)" onclick="showModalAlert('Vui lòng liên hệ Quản trị viên (Hotline: 1900 8888 hoặc Email: admin@bookstore.vn) để lấy lại mật khẩu.', 'Quên mật khẩu')" style="font-size: 12px; color: var(--ac); text-decoration: none;">Quên mật khẩu?</a>
                    </div>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu..." required oninput="clearError('password')">
                    <div id="err_password" class="text-error"></div>
                </div>

                <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px;">
                    <label style="display: flex; align-items: center; gap: 8px; font-size: 13px; color: var(--mute); cursor: pointer;">
                        <input type="checkbox" checked style="accent-color: var(--ac);"> Ghi nhớ đăng nhập
                    </label>
                </div>

                <button type="submit" class="btn btn-block" style="padding: 11px;">Đăng nhập hệ thống</button>

                <div style="text-align: center; margin-top: 24px; font-size: 13.5px;" class="mute">
                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register" style="color: var(--ac); font-weight: 600; text-decoration: none;">Đăng ký ngay ➔</a>
                </div>
            </form>
        </div>
    </main>

    <footer>
        <p>© 2026 BookStore - Đồ án tốt nghiệp / Môn học Eclipse Web - Nhóm 9</p>
    </footer>

    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <script>
        if (window.location.search.includes('error=access_denied')) {
            document.getElementById('accessDeniedAlert').style.display = 'block';
        }
        if (window.location.search.includes('redirect=thanhtoan')) {
            document.getElementById('checkoutRedirectAlert').style.display = 'block';
        }

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
                err.innerText = message;
                err.style.display = 'block';
            }
        }

        function handleLoginSubmit(e) {
            clearError('username');
            clearError('password');

            var u = document.getElementById('username').value.trim();
            var p = document.getElementById('password').value;

            // 1. Kiểm tra rỗng
            if (!u) {
                e.preventDefault();
                showError('username', '⚠️ Vui lòng nhập tên đăng nhập hoặc email!');
                return false;
            }
            if (!p) {
                e.preventDefault();
                showError('password', '⚠️ Vui lòng nhập mật khẩu!');
                return false;
            }

            // 2. Kiểm tra tài khoản đã đăng ký chưa
            var res = Auth.login(u, p);
            if (!res.success) {
                e.preventDefault();
                if (res.field === 'username') {
                    showError('username', '⚠️ ' + res.message);
                } else if (res.field === 'password') {
                    showError('password', '⚠️ ' + res.message);
                } else {
                    showModalAlert(res.message, 'Đăng nhập không thành công');
                }
                return false;
            }

            // Nếu hợp lệ, cho phép gửi form POST lên Server để tạo session
            return true;
        }
    </script>
</body>
</html>
