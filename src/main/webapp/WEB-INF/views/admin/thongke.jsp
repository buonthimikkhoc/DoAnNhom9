<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thống kê - Quản trị BookStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Be Vietnam Pro', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
            background: #f8fafc;
            color: #23201c;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Top Header */
        .admin-nav {
            background: #1f5f5b;
            color: #ffffff;
            height: 56px;
            padding: 0 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            width: 100%;
            position: sticky;
            top: 0;
            z-index: 100;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }
        .admin-nav .brand {
            font-size: 17px;
            font-weight: 700;
            color: #ffffff;
            letter-spacing: 0.3px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .admin-nav .nav-right {
            display: flex;
            align-items: center;
            gap: 16px;
            font-size: 13px;
        }
        .admin-nav .btn-back {
            color: #ffffff;
            text-decoration: none;
            padding: 5px 12px;
            border-radius: 4px;
            border: 1px solid rgba(255,255,255,0.35);
            background: rgba(255,255,255,0.08);
            font-size: 12px;
            font-weight: 500;
            transition: all 0.2s;
        }
        .admin-nav .btn-back:hover {
            background: rgba(255,255,255,0.2);
        }

        /* Layout 2 Cột */
        .admin-body {
            display: flex;
            flex: 1;
            min-height: calc(100vh - 56px);
            width: 100%;
        }

        /* Sidebar bên trái (Đồng bộ 240px chuẩn) */
        .admin-sidebar {
            width: 240px;
            background: #ebe7df;
            border-right: 1px solid #d9d4ca;
            padding: 20px 14px;
            display: flex;
            flex-direction: column;
            gap: 6px;
            flex-shrink: 0;
        }
        .sidebar-heading {
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            color: #8a847b;
            padding: 4px 14px 8px;
        }
        .sidebar-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 10px 14px;
            border-radius: 6px;
            color: #23201c;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.15s ease;
        }
        .sidebar-item svg {
            flex-shrink: 0;
            fill: currentColor;
        }
        .sidebar-item:hover {
            background: rgba(31, 95, 91, 0.08);
            color: #1f5f5b;
        }
        .sidebar-item.active {
            background: #1f5f5b;
            color: #ffffff;
            font-weight: 700;
            box-shadow: 0 2px 6px rgba(31,95,91,0.25);
        }
        .sidebar-item.active svg {
            fill: #ffffff;
        }
        .sidebar-footer {
            margin-top: auto;
            padding-top: 16px;
            border-top: 1px solid #d9d4ca;
            display: flex;
            flex-direction: column;
            gap: 4px;
        }
        .sidebar-footer-link {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 8px 12px;
            color: #6b7280;
            text-decoration: none;
            font-size: 13px;
            border-radius: 4px;
            transition: all 0.15s;
        }
        .sidebar-footer-link:hover {
            color: #1f5f5b;
            background: rgba(31, 95, 91, 0.06);
        }

        /* Vùng nội dung chính bên phải */
        .admin-main {
            flex: 1;
            padding: 28px 36px;
            background: #ffffff;
            overflow-y: auto;
        }

        /* Bộ lọc thời gian (Pills) & Nút xuất báo cáo */
        .top-toolbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 12px;
        }
        .filter-group {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .filter-pill {
            padding: 6px 18px;
            border-radius: 20px;
            font-size: 13.5px;
            font-weight: 500;
            border: 1px solid #d1d5db;
            background: #ffffff;
            color: #4b5563;
            cursor: pointer;
            transition: all 0.15s ease;
            outline: none;
        }
        .filter-pill:hover {
            border-color: #0284c7;
            color: #0284c7;
        }
        .filter-pill.active {
            border: 2px solid #0284c7;
            color: #0284c7;
            font-weight: 600;
            background: #ffffff;
        }
        .btn-export {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 8px 22px;
            border-radius: 6px;
            border: 1.5px solid #1f5f5b;
            background: #ffffff;
            color: #1f5f5b;
            font-size: 13.5px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        .btn-export:hover {
            background: #1f5f5b;
            color: #ffffff;
            box-shadow: 0 2px 8px rgba(31,95,91,0.25);
        }

        /* Lưới 4 Thẻ chỉ số KPI */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 16px;
            margin-bottom: 28px;
        }
        .stat-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 16px 20px;
            display: flex;
            flex-direction: column;
            gap: 6px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
            transition: transform 0.15s ease;
        }
        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }
        .stat-label {
            font-size: 13px;
            color: #6b7280;
            font-weight: 500;
        }
        .stat-val {
            font-size: 24px;
            font-weight: 800;
            color: #1f5f5b;
            letter-spacing: -0.5px;
        }

        /* Lưới 2 Cột Biểu Đồ & Sách Bán Chạy */
        .charts-row {
            display: grid;
            grid-template-columns: 1.6fr 1fr;
            gap: 20px;
            align-items: stretch;
        }
        .panel-card {
            background: #ffffff;
            border: 1px solid #e5e7eb;
            border-radius: 8px;
            padding: 22px 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.02);
            display: flex;
            flex-direction: column;
        }
        .panel-title {
            font-size: 16px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 20px;
        }

        /* Biểu đồ cột Doanh thu theo tháng */
        .chart-box {
            position: relative;
            flex: 1;
            min-height: 250px;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            padding-top: 15px;
        }
        .chart-grid-lines {
            position: absolute;
            top: 25px;
            left: 0;
            right: 0;
            bottom: 35px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            pointer-events: none;
        }
        .grid-line {
            width: 100%;
            height: 1px;
            background: #e5e7eb;
        }
        .bars-container {
            position: relative;
            z-index: 2;
            display: flex;
            align-items: flex-end;
            justify-content: space-around;
            height: 210px;
            border-bottom: 1px solid #d1d5db;
            padding: 0 10px;
        }
        .bar-col {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 52px;
            height: 100%;
            justify-content: flex-end;
            cursor: pointer;
        }
        .bar-val {
            font-size: 12px;
            font-weight: 700;
            color: #1e293b;
            margin-bottom: 6px;
            transition: all 0.2s;
        }
        .bar-fill {
            width: 42px;
            background: #1f5f5b;
            border-radius: 3px 3px 0 0;
            transition: height 0.4s ease, background 0.2s;
        }
        .bar-col:hover .bar-fill {
            background: #15423f;
            filter: brightness(1.1);
        }
        .bar-col:hover .bar-val {
            color: #1f5f5b;
            transform: scale(1.1);
        }
        .chart-x-labels {
            display: flex;
            justify-content: space-around;
            padding: 10px 10px 0;
        }
        .x-label {
            font-size: 12px;
            color: #6b7280;
            font-weight: 500;
            width: 52px;
            text-align: center;
        }

        /* Danh sách Top Sách Bán Chạy */
        .top-books-list {
            list-style: none;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }
        .top-book-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 4px;
        }
        .top-book-info {
            display: flex;
            align-items: center;
            gap: 14px;
            flex: 1;
            overflow: hidden;
        }
        .rank-badge {
            width: 24px;
            height: 24px;
            border-radius: 50%;
            border: 1.5px solid #0f766e;
            color: #0f766e;
            background: #f0fdfa;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11.5px;
            font-weight: 700;
            flex-shrink: 0;
        }
        .top-book-title {
            font-size: 13.5px;
            color: #1e293b;
            font-weight: 500;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .top-book-qty {
            font-size: 13px;
            color: #6b7280;
            font-weight: 500;
            margin-left: 12px;
            white-space: nowrap;
        }

        @media (max-width: 900px) {
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
            .charts-row { grid-template-columns: 1fr; }
            .admin-sidebar { width: 180px; }
        }
        @media (max-width: 640px) {
            .admin-body { flex-direction: column; }
            .admin-sidebar { width: 100%; border-right: none; border-bottom: 1px solid #d9d4ca; }
            .stats-grid { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>

    <!-- Header Full Màn Hình Đồng Bộ -->
    <header class="admin-nav">
        <div class="brand">
            <svg width="22" height="22" viewBox="0 0 24 24" fill="currentColor"><path d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z"/></svg>
            Quản trị BookStore
        </div>
        <div class="nav-right">
            <a href="${pageContext.request.contextPath}/trangchu" class="btn-back">Xem Website ↗</a>
            <div style="display: flex; align-items: center; gap: 8px; background: rgba(0,0,0,0.12); padding: 5px 12px; border-radius: 20px;">
                <span style="display: inline-flex; align-items: center; justify-content: center; width: 22px; height: 22px; border-radius: 50%; background: #ffffff; color: #1f5f5b; font-size: 11px; font-weight: 800;">AD</span>
                <span style="font-weight: 600; font-size: 13px;">admin</span>
            </div>
        </div>
    </header>

    <!-- Thân giao diện 2 cột Full màn hình -->
    <div class="admin-body">
        
        <!-- SIDEBAR BÊN TRÁI ĐỒNG BỘ -->
        <aside class="admin-sidebar" style="min-height: calc(100vh - 56px); display: flex; flex-direction: column; width: 240px; box-sizing: border-box;">
            <div class="sidebar-heading">Menu Quản Trị</div>
            <a href="${pageContext.request.contextPath}/admin/thongke" class="sidebar-item active">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M5 9.2h3V19H5zM10.6 5h2.8v14h-2.8zm5.6 8H19v6h-2.8z"/></svg>
                <span>Thống kê</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/quanlysach" class="sidebar-item">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-1 9H9V9h10v2zm-4 4H9v-2h6v2zm4-8H9V5h10v2z"/></svg>
                <span>Quản lý Sách</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/quanlydanhmuc" class="sidebar-item">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M4 10.5c-.83 0-1.5.67-1.5 1.5s.67 1.5 1.5 1.5 1.5-.67 1.5-1.5-.67-1.5-1.5-1.5zm0-6c-.83 0-1.5.67-1.5 1.5S3.17 7.5 4 7.5 5.5 6.83 5.5 6 4.83 4.5 4 4.5zm0 12c-.83 0-1.5.68-1.5 1.5s.68 1.5 1.5 1.5 1.5-.68 1.5-1.5-.67-1.5-1.5-1.5zM7 19h14v-2H7v2zm0-6h14v-2H7v2zm0-8v2h14V5H7z"/></svg>
                <span>Quản lý Danh mục</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/quanlydonhang" class="sidebar-item">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M19 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm-2 10h-4v4h-2v-4H7v-2h4V7h2v4h4v2z"/></svg>
                <span>Quản lý Đơn hàng</span>
            </a>

            <div class="sidebar-footer" style="margin-top: auto; padding-top: 16px; border-top: 1px solid #d9d4ca; display: flex; flex-direction: column; gap: 4px;">
                <a href="${pageContext.request.contextPath}/taikhoan" class="sidebar-footer-link" style="display: flex; align-items: center; gap: 8px; padding: 8px 12px; color: #6b7280; text-decoration: none; font-size: 13px; border-radius: 4px; transition: all 0.15s;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 3c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 14.2c-2.5 0-4.71-1.28-6-3.22.03-1.99 4-3.08 6-3.08 1.99 0 5.97 1.09 6 3.08-1.29 1.94-3.5 3.22-6 3.22z"/></svg>
                    <span>Trang cá nhân</span>
                </a>
                <a href="${pageContext.request.contextPath}/trangchu" class="sidebar-footer-link" style="display: flex; align-items: center; gap: 8px; padding: 8px 12px; color: #6b7280; text-decoration: none; font-size: 13px; border-radius: 4px; transition: all 0.15s;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/></svg>
                    <span>Về Trang Bán Hàng</span>
                </a>
                <a href="${pageContext.request.contextPath}/login" onclick="if(window.Auth){Auth.logout();}else{localStorage.removeItem('bs_user');}" class="sidebar-footer-link" style="display: flex; align-items: center; gap: 8px; padding: 8px 12px; color: #dc2626; text-decoration: none; font-size: 13px; border-radius: 4px; transition: all 0.15s;">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M17 7l-1.41 1.41L18.17 11H8v2h10.17l-2.58 2.58L17 17l5-5zM4 5h8V3H4c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h8v-2H4V5z"/></svg>
                    <span>Đăng xuất</span>
                </a>
            </div>
        </aside>

        <!-- NỘI DUNG CHÍNH BÊN PHẢI -->
        <main class="admin-main">
            
            <!-- Hàng bộ lọc thời gian & Nút xuất báo cáo -->
            <div class="top-toolbar">
                <div class="filter-group">
                    <button type="button" class="filter-pill active" onclick="switchPeriod('7day', this)">7 ngày</button>
                    <button type="button" class="filter-pill" onclick="switchPeriod('30day', this)">30 ngày</button>
                    <button type="button" class="filter-pill" onclick="switchPeriod('year', this)">Năm nay</button>
                </div>
                <button type="button" class="btn-export" onclick="exportReport()">
                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor"><path d="M19 9h-4V3H9v6H5l7 7 7-7zM5 18v2h14v-2H5z"/></svg>
                    Xuất báo cáo
                </button>
            </div>

            <!-- 4 Thẻ KPI Chỉ Số Thống Kê -->
            <div class="stats-grid">
                <div class="stat-card">
                    <span class="stat-label">Doanh thu tháng</span>
                    <span class="stat-val" id="statRevenue">27.000.000đ</span>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Đơn hàng</span>
                    <span class="stat-val" id="statOrders">148</span>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Sách đã bán</span>
                    <span class="stat-val" id="statBooksSold">412</span>
                </div>
                <div class="stat-card">
                    <span class="stat-label">Khách hàng mới</span>
                    <span class="stat-val" id="statNewCustomers">36</span>
                </div>
            </div>

            <!-- Khu vực 2 Biểu Đồ & Sách Bán Chạy -->
            <div class="charts-row">
                
                <!-- Cột Trái: Biểu đồ cột Doanh thu theo tháng -->
                <div class="panel-card">
                    <h2 class="panel-title">Doanh thu theo tháng (triệu đồng)</h2>
                    
                    <div class="chart-box">
                        <!-- Đường kẻ phụ ngang -->
                        <div class="chart-grid-lines">
                            <div class="grid-line"></div>
                            <div class="grid-line"></div>
                            <div class="grid-line"></div>
                            <div class="grid-line"></div>
                        </div>

                        <!-- Cột biểu đồ -->
                        <div class="bars-container" id="barChartContainer">
                            <div class="bar-col" title="Tháng 5: 12 triệu">
                                <span class="bar-val">12</span>
                                <div class="bar-fill" style="height: 44%;"></div>
                            </div>
                            <div class="bar-col" title="Tháng 6: 16.5 triệu">
                                <span class="bar-val">16.5</span>
                                <div class="bar-fill" style="height: 61%;"></div>
                            </div>
                            <div class="bar-col" title="Tháng 7: 14.4 triệu">
                                <span class="bar-val">14.4</span>
                                <div class="bar-fill" style="height: 53%;"></div>
                            </div>
                            <div class="bar-col" title="Tháng 8: 21 triệu">
                                <span class="bar-val">21</span>
                                <div class="bar-fill" style="height: 78%;"></div>
                            </div>
                            <div class="bar-col" title="Tháng 9: 18.6 triệu">
                                <span class="bar-val">18.6</span>
                                <div class="bar-fill" style="height: 69%;"></div>
                            </div>
                            <div class="bar-col" title="Tháng 10: 27 triệu">
                                <span class="bar-val">27</span>
                                <div class="bar-fill" style="height: 100%;"></div>
                            </div>
                        </div>

                        <!-- Nhãn trục hoành (Tháng) -->
                        <div class="chart-x-labels">
                            <span class="x-label">T5</span>
                            <span class="x-label">T6</span>
                            <span class="x-label">T7</span>
                            <span class="x-label">T8</span>
                            <span class="x-label">T9</span>
                            <span class="x-label">T10</span>
                        </div>
                    </div>
                </div>

                <!-- Cột Phải: Danh sách Sách Bán Chạy -->
                <div class="panel-card">
                    <h2 class="panel-title">Sách bán chạy</h2>
                    
                    <ul class="top-books-list" id="topBooksList">
                        <li class="top-book-item">
                            <div class="top-book-info">
                                <span class="rank-badge">1</span>
                                <span class="top-book-title" title="Cây Cam Ngọt Của Tôi">Cây Cam Ngọt Của Tôi</span>
                            </div>
                            <span class="top-book-qty">86 cuốn</span>
                        </li>
                        <li class="top-book-item">
                            <div class="top-book-info">
                                <span class="rank-badge">2</span>
                                <span class="top-book-title" title="Nhà Giả Kim (Tái Bản 2026)">Nhà Giả Kim (Tái Bản 2026)</span>
                            </div>
                            <span class="top-book-qty">64 cuốn</span>
                        </li>
                        <li class="top-book-item">
                            <div class="top-book-info">
                                <span class="rank-badge">3</span>
                                <span class="top-book-title" title="Hoàng Tử Bé">Hoàng Tử Bé</span>
                            </div>
                            <span class="top-book-qty">51 cuốn</span>
                        </li>
                        <li class="top-book-item">
                            <div class="top-book-info">
                                <span class="rank-badge">4</span>
                                <span class="top-book-title" title="Đắc Nhân Tâm (Khổ Lớn)">Đắc Nhân Tâm (Khổ Lớn)</span>
                            </div>
                            <span class="top-book-qty">47 cuốn</span>
                        </li>
                        <li class="top-book-item">
                            <div class="top-book-info">
                                <span class="rank-badge">5</span>
                                <span class="top-book-title" title="Lược Sử Loài Người - Sapiens">Lược Sử Loài Người - Sapiens</span>
                            </div>
                            <span class="top-book-qty">39 cuốn</span>
                        </li>
                    </ul>
                </div>

            </div>

        </main>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <script>
        // Dữ liệu mẫu theo các khoảng thời gian
        var PERIOD_DATA = {
            '7day': {
                revenue: '6.850.000đ',
                orders: '38',
                booksSold: '105',
                customers: '9',
                bars: [
                    { label: 'T2', val: '0.8', height: '30%' },
                    { label: 'T3', val: '1.2', height: '45%' },
                    { label: 'T4', val: '0.9', height: '35%' },
                    { label: 'T5', val: '1.5', height: '58%' },
                    { label: 'T6', val: '1.1', height: '42%' },
                    { label: 'T7', val: '1.35', height: '52%' }
                ]
            },
            '30day': {
                revenue: '27.000.000đ',
                orders: '148',
                booksSold: '412',
                customers: '36',
                bars: [
                    { label: 'T5', val: '12', height: '44%' },
                    { label: 'T6', val: '16.5', height: '61%' },
                    { label: 'T7', val: '14.4', height: '53%' },
                    { label: 'T8', val: '21', height: '78%' },
                    { label: 'T9', val: '18.6', height: '69%' },
                    { label: 'T10', val: '27', height: '100%' }
                ]
            },
            'year': {
                revenue: '185.000.000đ',
                orders: '1.240',
                booksSold: '3.850',
                customers: '420',
                bars: [
                    { label: 'Q1', val: '38', height: '65%' },
                    { label: 'Q2', val: '46', height: '79%' },
                    { label: 'Q3', val: '43', height: '74%' },
                    { label: 'Q4', val: '58', height: '100%' }
                ]
            }
        };

        function switchPeriod(period, btn) {
            document.querySelectorAll('.filter-pill').forEach(function(p) { p.classList.remove('active'); });
            if (btn) btn.classList.add('active');

            var d = PERIOD_DATA[period];
            if (!d) return;

            document.getElementById('statRevenue').innerText = d.revenue;
            document.getElementById('statOrders').innerText = d.orders;
            document.getElementById('statBooksSold').innerText = d.booksSold;
            document.getElementById('statNewCustomers').innerText = d.customers;

            var container = document.getElementById('barChartContainer');
            var xContainer = document.querySelector('.chart-x-labels');

            container.innerHTML = d.bars.map(function(b) {
                return '<div class="bar-col" title="' + b.label + ': ' + b.val + ' triệu">' +
                       '  <span class="bar-val">' + b.val + '</span>' +
                       '  <div class="bar-fill" style="height: ' + b.height + ';"></div>' +
                       '</div>';
            }).join('');

            xContainer.innerHTML = d.bars.map(function(b) {
                return '<span class="x-label">' + b.label + '</span>';
            }).join('');
        }

        function exportReport() {
            var activePill = document.querySelector('.filter-pill.active');
            var periodName = activePill ? activePill.innerText : 'Tháng này';
            alert('📊 Đang xuất báo cáo thống kê [' + periodName + ']...\nHệ thống đã tạo bản ghi báo cáo doanh thu & sách bán chạy.');
        }
    </script>
</body>
</html>
