<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông tin cá nhân - BookStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
</head>
<body>

    <!-- Navigation Header -->
    <header class="main-nav">
        <a href="${pageContext.request.contextPath}/trangchu" class="brand-logo">
            <svg viewBox="0 0 24 24"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>
            BookStore
        </a>
        <!-- Logo nhấn về trang chủ -->
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/giohang" class="nav-cart-btn">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z"/></svg>
                Giỏ hàng <span class="cart-badge" id="nav-cart-count">0</span>
            </a>
            <a href="${pageContext.request.contextPath}/taikhoan" class="user-menu-btn active">
                <span class="avatar-sm">A</span>
                <span>Tài khoản ▾</span>
            </a>
        </div>
    </header>

    <div class="container">
        <!-- Nút chuyển sang Màn hình Quản Trị riêng biệt (Chỉ hiển thị với Admin) -->
        <div class="card" id="adminNoticeCard" style="display: none; padding: 16px 20px; margin-bottom: 24px; background: #eaf4f3; border: 1.5px solid #1f5f5b; border-radius: 8px; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 12px;">
            <div>
                <div style="font-weight: 700; color: #1f5f5b; font-size: 15px; display: flex; align-items: center; gap: 6px;">
                    <span>🛡️</span> <span>Màn Hình Quản Trị Viên (Admin)</span>
                </div>
                <div style="color: #4b5563; font-size: 13px; margin-top: 3px;">
                    Nhấn vào nút bên cạnh để chuyển sang giao diện quản trị riêng biệt (Quản lý Sách, Danh mục, Đơn hàng).
                </div>
            </div>
            <div style="display: flex; gap: 8px;">
                <a href="${pageContext.request.contextPath}/admin/quanlysach" class="btn" style="background: #1f5f5b; color: #fff; padding: 8px 18px; border-radius: 4px; font-weight: 600; font-size: 13px; text-decoration: none;">
                    Vào Trang Quản Trị ➔
                </a>
            </div>
        </div>

        <h1 style="font-size: 22px; font-weight: 700; margin-bottom: 24px;">Hồ Sơ & Cài Đặt Tài Khoản</h1>

        <div class="g2" style="align-items: flex-start;">
            <!-- Cột 1: Thông tin cá nhân -->
            <div class="card" style="padding: 24px;">
                <div style="display: flex; align-items: center; gap: 16px; margin-bottom: 20px;">
                    <div id="profileAvatar" style="width: 56px; height: 56px; border-radius: 50%; background: var(--ac); color: #fff; font-size: 24px; font-weight: 700; display: flex; align-items: center; justify-content: center;">
                        A
                    </div>
                    <div>
                        <div class="b" id="profileDisplayName" style="font-size: 16px;">Nguyễn Văn An</div>
                        <div class="mute" id="profileRoleBadge" style="font-size: 13px;">Khách hàng thân thiết · Thành viên từ 2024</div>
                    </div>
                </div>

                <form id="profileForm" onsubmit="handleSaveProfile(event)">
                    <h2 class="b" style="font-size: 15px; margin-bottom: 14px; color: var(--ink);">Thông tin cá nhân</h2>
                    
                    <div class="form-group">
                        <label class="form-label" for="acc_name">Họ và tên</label>
                        <input type="text" id="acc_name" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="acc_email">Địa chỉ Email</label>
                        <input type="email" id="acc_email" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="acc_phone">Số điện thoại</label>
                        <input type="tel" id="acc_phone" class="form-control" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="acc_address">Địa chỉ mặc định</label>
                        <input type="text" id="acc_address" class="form-control" required>
                    </div>

                    <div style="display: flex; gap: 10px; margin-top: 14px; flex-wrap: wrap;">
                        <button type="submit" class="btn">
                            Lưu thay đổi hồ sơ
                        </button>
                        <button type="button" class="btn o" style="color: var(--danger); border-color: var(--danger);" onclick="Auth.logout()">
                            Đăng xuất tài khoản
                        </button>
                    </div>
                </form>
            </div>

            <!-- Cột 2: Đổi mật khẩu -->
            <div class="card" style="padding: 24px;">
                <h2 class="b" style="font-size: 15px; margin-bottom: 14px; color: var(--ink);">Đổi mật khẩu tài khoản</h2>
                <p class="mute" style="font-size: 13px; margin-bottom: 16px;">Để bảo mật tài khoản, vui lòng không chia sẻ mật khẩu cho người khác.</p>

                <form onsubmit="event.preventDefault(); showToast('Cập nhật mật khẩu mới thành công!'); this.reset();">
                    <div class="form-group">
                        <label class="form-label" for="curr_pass">Mật khẩu hiện tại</label>
                        <input type="password" id="curr_pass" class="form-control" placeholder="••••••••" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="new_pass">Mật khẩu mới</label>
                        <input type="password" id="new_pass" class="form-control" placeholder="Tối thiểu 6 ký tự..." required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="renew_pass">Nhập lại mật khẩu mới</label>
                        <input type="password" id="renew_pass" class="form-control" placeholder="Nhập lại mật khẩu mới..." required>
                    </div>

                    <button type="submit" class="btn o" style="margin-top: 10px;">
                        Cập nhật mật khẩu
                    </button>
                </form>
            </div>
        </div>
    </div>

    <footer>
        <p>© 2026 BookStore - Đồ án tốt nghiệp / Môn học Eclipse Web - Nhóm 9</p>
    </footer>

    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <script>
        function loadProfileData() {
            var user = Auth.getUser() || {
                username: 'nguyenvanan',
                fullname: 'Nguyễn Văn An',
                email: 'an.nguyen@example.com',
                phone: '0987 654 321',
                address: '12 Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh',
                role: 'user'
            };

            document.getElementById('acc_name').value = user.fullname || '';
            document.getElementById('acc_email').value = user.email || '';
            document.getElementById('acc_phone').value = user.phone || '';
            document.getElementById('acc_address').value = user.address || '';

            document.getElementById('profileDisplayName').innerText = user.fullname || user.username;
            document.getElementById('profileAvatar').innerText = user.role === 'admin' ? 'AD' : (user.fullname ? user.fullname.charAt(0) : 'U');
            document.getElementById('profileRoleBadge').innerText = user.role === 'admin' ? '🛡️ Quản trị viên cấp cao' : 'Khách hàng thân thiết · Thành viên từ 2024';

            // CHỈ HIỂN THỊ NÚT VÀO ADMIN NẾU LÀ ADMIN
            var adminCard = document.getElementById('adminNoticeCard');
            if (adminCard) {
                if (user.role === 'admin') {
                    adminCard.style.display = 'flex';
                } else {
                    adminCard.style.display = 'none';
                }
            }
        }

        function handleSaveProfile(e) {
            e.preventDefault();
            var user = Auth.getUser() || {};
            user.fullname = document.getElementById('acc_name').value;
            user.email = document.getElementById('acc_email').value;
            user.phone = document.getElementById('acc_phone').value;
            user.address = document.getElementById('acc_address').value;

            localStorage.setItem('bs_current_user', JSON.stringify(user));
            showToast('Đã lưu thông tin cá nhân thành công!');
            loadProfileData();
            Auth.applyHeaderUI();
        }

        document.addEventListener('DOMContentLoaded', function() {
            loadProfileData();
        });
    </script>
</body>
</html>
