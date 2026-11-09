<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang chủ - Cửa Hàng Sách Trực Tuyến BookStore</title>
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
            <div class="user-menu-wrapper">
                <a href="${pageContext.request.contextPath}/taikhoan" class="user-menu-btn">
                    <span class="avatar-sm">A</span>
                    <span>Xin chào, An ▾</span>
                </a>
                <div class="user-dropdown-menu">
                    <a href="${pageContext.request.contextPath}/donhang" class="user-dropdown-item">
                        <span class="dropdown-icon">📦</span>
                        <span>Đơn hàng của tôi</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/taikhoan" class="user-dropdown-item">
                        <span class="dropdown-icon">👤</span>
                        <span>Thông tin tài khoản</span>
                    </a>
                    <a href="javascript:void(0)" onclick="Auth.logout()" class="user-dropdown-item danger">
                        <span class="dropdown-icon">🚪</span>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </div>
        </div>
    </header>

    <div class="container">
        <!-- Banner chào mừng -->
        <div style="background: linear-gradient(135deg, #1f5f5b 0%, #13423f 100%); color: #fff; padding: 28px 32px; border-radius: var(--radius-lg); margin-bottom: 24px; display: flex; justify-content: space-between; align-items: center; box-shadow: var(--shadow);">
            <div>
                <span style="background: rgba(255,255,255,0.2); padding: 4px 12px; border-radius: 20px; font-size: 12px; font-weight: 600;">Hội Sách 2026</span>
                <h1 style="font-size: 26px; margin: 8px 0 6px;">Chào mừng bạn đến với BookStore Online</h1>
                <p style="opacity: 0.9; max-width: 500px; font-size: 13.5px;">Dữ liệu sách và đơn hàng được đồng bộ tự động giữa Khách hàng và Quản trị viên.</p>
            </div>
            <a href="#book-list" class="btn" style="background: #fff; color: var(--ac); border-color: #fff; font-weight: 700;">Xem Sách Ngay</a>
        </div>

        <!-- Search Bar -->
        <div class="row" style="margin-bottom: 20px; gap: 10px;">
            <div style="flex: 1; position: relative;">
                <input type="text" id="homeSearchInput" class="inp" placeholder="Tìm kiếm theo tên sách, tác giả, nhà xuất bản..." style="padding-left: 36px; height: 42px;" onkeyup="renderHomeBooks()">
                <svg style="position: absolute; left: 12px; top: 12px; width: 18px; height: 18px; color: var(--mute);" viewBox="0 0 24 24" fill="currentColor">
                    <path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/>
                </svg>
            </div>
            <button class="btn" style="height: 42px; padding: 0 24px;" onclick="renderHomeBooks()">Tìm kiếm</button>
        </div>

        <!-- Category Filter Chips -->
        <div class="row wrap chip-container" style="margin-bottom: 24px;" id="homeCategoryChips">
            <button class="chip on" onclick="filterCategory('', this)">Tất cả</button>
            <button class="chip" onclick="filterCategory('Văn học', this)">Văn học</button>
            <button class="chip" onclick="filterCategory('Kinh tế', this)">Kinh tế</button>
            <button class="chip" onclick="filterCategory('Thiếu nhi', this)">Thiếu nhi</button>
            <button class="chip" onclick="filterCategory('Kỹ năng', this)">Kỹ năng</button>
            <button class="chip" onclick="filterCategory('Lịch sử', this)">Lịch sử</button>
            <button class="chip" onclick="filterCategory('Khoa học', this)">Khoa học</button>
            <button class="chip" onclick="filterCategory('Công nghệ', this)">Công nghệ</button>
        </div>

        <!-- Books Grid (Render động từ DB.getBooks()) -->
        <div class="g3" id="book-list">
        </div>

        <!-- Pagination (Tối đa 12 sách / trang) -->
        <div id="homePagination" style="margin-top: 36px; display: flex; align-items: center; justify-content: center; gap: 10px;">
        </div>
    </div>

    <footer>
        <p>© 2026 BookStore - Đồ án tốt nghiệp / Môn học Eclipse Web - Nhóm 9</p>
    </footer>

    <script src="${pageContext.request.contextPath}/resources/js/main.js?v=3"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            initHomePage();
        });
    </script>
</body>
</html>
