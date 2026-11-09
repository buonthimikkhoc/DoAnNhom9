<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý danh mục - Admin BookStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Be Vietnam Pro', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; background: #f8fafc; color: #23201c; min-height: 100vh; display: flex; flex-direction: column; }
        
        /* Top Navigation Header - Full Screen Width */
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

        /* 2-Column Full Screen Layout */
        .admin-body {
            display: flex;
            flex: 1;
            min-height: calc(100vh - 56px);
            width: 100%;
        }

        /* 3 Thanh công cụ bên trái - Full Height Sidebar */
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
            padding: 0 12px 6px;
        }
        .sidebar-item {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 11px 14px;
            border-radius: 6px;
            color: #23201c;
            text-decoration: none;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.15s ease;
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

        /* Main Content on the Right - Full remaining width */
        .admin-main {
            flex: 1;
            padding: 28px 36px;
            background: #ffffff;
            overflow-y: auto;
        }

        /* Pills, Tables & Inputs */
        .pill-group {
            display: flex;
            gap: 8px;
            margin-bottom: 18px;
            flex-wrap: wrap;
        }
        .pill-btn {
            border: 1px solid #d9d4ca;
            border-radius: 20px;
            padding: 6px 20px;
            font-size: 13px;
            color: #4b5563;
            background: #ffffff;
            cursor: pointer;
            transition: all 0.15s ease;
            user-select: none;
        }
        .pill-btn:hover {
            border-color: #1f5f5b;
            color: #1f5f5b;
        }
        .pill-btn.active {
            border: 1.5px solid #1f5f5b;
            color: #1f5f5b;
            background: #eaf4f3;
            font-weight: 700;
        }

        /* Wireframe Table */
        .wire-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }
        .wire-table thead tr {
            background: #ded9ce;
        }
        .wire-table th {
            padding: 11px 16px;
            text-align: left;
            font-weight: 700;
            font-size: 13px;
            color: #23201c;
        }
        .wire-table td {
            padding: 12px 16px;
            font-size: 13.5px;
            color: #23201c;
            border-bottom: 1px solid #e7e2d8;
        }
        .wire-table tbody tr:hover {
            background: #fafaf8;
        }
        .wire-act {
            color: #23201c;
            text-decoration: none;
            font-weight: 500;
            cursor: pointer;
        }
        .wire-act:hover {
            color: #1f5f5b;
            text-decoration: underline;
        }
        .wire-dot {
            color: #9ca3af;
            margin: 0 6px;
        }
    </style>
    <script>
        window.APP_CONTEXT_PATH = '${pageContext.request.contextPath}';
    </script>
    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <script>
        var currentUser = Auth.getUser();
        if (!currentUser || currentUser.role !== 'admin') {
            document.addEventListener('DOMContentLoaded', function() {
                showModalAlert('⛔ Quyền truy cập bị từ chối!\nBạn đang đăng nhập bằng tài khoản người dùng thường nên không thể truy cập vào trang Quản trị (Admin).\nVui lòng đăng nhập với tài khoản Quản trị viên (admin).', 'Truy cập bị từ chối', function() {
                    window.location.replace('${pageContext.request.contextPath}/login?error=access_denied');
                });
            });
        }
    </script>
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
            <a href="${pageContext.request.contextPath}/admin/thongke" class="sidebar-item">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M5 9.2h3V19H5zM10.6 5h2.8v14h-2.8zm5.6 8H19v6h-2.8z"/></svg>
                <span>Thống kê</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/quanlysach" class="sidebar-item">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M4 6H2v14c0 1.1.9 2 2 2h14v-2H4V6zm16-4H8c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zm-1 9H9V9h10v2zm-4 4H9v-2h6v2zm4-8H9V5h10v2z"/></svg>
                <span>Quản lý Sách</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/quanlydanhmuc" class="sidebar-item active">
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

        <!-- NỘI DUNG CHÍNH BÊN PHẢI TOÀN MÀN HÌNH -->
        <main class="admin-main">
            <div style="margin-bottom: 20px;">
                <h1 style="font-size: 20px; font-weight: 700; color: #23201c;">
                    Quản lý danh mục
                </h1>
                <p style="color: #64748b; font-size: 13px; margin-top: 4px;">Phân loại và quản lý các thể loại sách, tác giả và nhà xuất bản</p>
            </div>

            <!-- Các nút phân loại dạng viên thuốc (Pill tabs) -->
            <div class="pill-group">
                <button type="button" class="pill-btn active" id="pillGenre" onclick="switchCategoryTab('genres', this)">Thể loại</button>
                <button type="button" class="pill-btn" id="pillAuthor" onclick="switchCategoryTab('authors', this)">Tác giả</button>
                <button type="button" class="pill-btn" id="pillPub" onclick="switchCategoryTab('publishers', this)">Nhà xuất bản</button>
            </div>

            <!-- Ô nhập thêm mới -->
            <form id="addCatForm" onsubmit="addCategory(event)" style="display: flex; gap: 10px; margin-bottom: 20px; max-width: 700px;">
                <input type="text" id="newCatName" class="inp" placeholder="Tên thể loại mới" style="flex: 1; padding: 9px 14px; border: 1px solid #d9d4ca; border-radius: 4px; font-size: 14px;" required>
                <button type="submit" class="btn" style="background: #1f5f5b; color: #fff; padding: 9px 24px; border: none; border-radius: 4px; font-weight: 600; cursor: pointer; white-space: nowrap; font-size: 14px;">+ Thêm</button>
            </form>

            <!-- Bảng danh sách danh mục chuẩn wireframe -->
            <table class="wire-table">
                <thead>
                    <tr>
                        <th style="width: 140px;">Mã</th>
                        <th>Tên</th>
                        <th style="width: 140px; text-align: right;"></th>
                    </tr>
                </thead>
                <tbody id="categoryTableBody">
                    <!-- Rendered by JS -->
                </tbody>
            </table>

            <!-- Phân trang danh mục -->
            <div id="categoryPagination"></div>
        </main>
    </div>

    <script>
        var currentTab = 'genres';
        var catCurrentPage = 1;
        var CAT_PAGE_SIZE = 8;

        function renderAdminPagination(containerId, currentPage, totalPages, totalItems, pageSize, onPageChangeFnName) {
            var container = document.getElementById(containerId);
            if (!container) return;
            if (totalItems === 0) {
                container.innerHTML = '';
                return;
            }

            var startItem = (currentPage - 1) * pageSize + 1;
            var endItem = Math.min(currentPage * pageSize, totalItems);

            var btnBase = 'min-width: 34px; height: 34px; padding: 0 8px; border-radius: 6px; font-size: 13px; font-weight: 600; display: inline-flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.15s; border: 1px solid #cbd5e1; background: #ffffff; color: #334155;';
            var btnActive = 'min-width: 34px; height: 34px; padding: 0 8px; border-radius: 6px; font-size: 13px; font-weight: 700; display: inline-flex; align-items: center; justify-content: center; cursor: default; border: 1.5px solid #1f5f5b; background: #1f5f5b; color: #ffffff; box-shadow: 0 2px 5px rgba(31,95,91,0.25);';
            var btnDisabled = 'min-width: 34px; height: 34px; padding: 0 8px; border-radius: 6px; font-size: 13px; font-weight: 600; display: inline-flex; align-items: center; justify-content: center; border: 1px solid #e2e8f0; background: #f8fafc; color: #cbd5e1; cursor: not-allowed;';

            var html = '<div class="admin-pagination" style="margin-top: 18px; display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; padding: 12px 4px; border-top: 1px solid #e7e2d8;">';
            html += '<div style="font-size: 13px; color: #64748b; font-weight: 500;">Hiển thị <strong>' + startItem + ' - ' + endItem + '</strong> trên <strong>' + totalItems + '</strong> mục</div>';

            if (totalPages <= 1) {
                html += '</div>';
                container.innerHTML = html;
                return;
            }

            html += '<div style="display: flex; align-items: center; gap: 6px;">';

            // Nút Đầu « và Trước ‹
            if (currentPage > 1) {
                html += '<button type="button" onclick="' + onPageChangeFnName + '(1)" style="' + btnBase + '" title="Trang đầu">«</button>';
                html += '<button type="button" onclick="' + onPageChangeFnName + '(' + (currentPage - 1) + ')" style="' + btnBase + '" title="Trang trước">‹</button>';
            } else {
                html += '<button type="button" disabled style="' + btnDisabled + '">«</button>';
                html += '<button type="button" disabled style="' + btnDisabled + '">‹</button>';
            }

            // Trang số
            var startPage = Math.max(1, currentPage - 2);
            var endPage = Math.min(totalPages, currentPage + 2);
            if (endPage - startPage < 4) {
                if (startPage === 1) endPage = Math.min(totalPages, startPage + 4);
                else if (endPage === totalPages) startPage = Math.max(1, endPage - 4);
            }

            if (startPage > 1) {
                html += '<button type="button" onclick="' + onPageChangeFnName + '(1)" style="' + btnBase + '">1</button>';
                if (startPage > 2) html += '<span style="color: #94a3b8; padding: 0 2px;">…</span>';
            }

            for (var p = startPage; p <= endPage; p++) {
                if (p === currentPage) {
                    html += '<button type="button" style="' + btnActive + '">' + p + '</button>';
                } else {
                    html += '<button type="button" onclick="' + onPageChangeFnName + '(' + p + ')" style="' + btnBase + '" onmouseover="this.style.borderColor=\'#1f5f5b\'; this.style.color=\'#1f5f5b\'" onmouseout="this.style.borderColor=\'#cbd5e1\'; this.style.color=\'#334155\'">' + p + '</button>';
                }
            }

            if (endPage < totalPages) {
                if (endPage < totalPages - 1) html += '<span style="color: #94a3b8; padding: 0 2px;">…</span>';
                html += '<button type="button" onclick="' + onPageChangeFnName + '(' + totalPages + ')" style="' + btnBase + '">' + totalPages + '</button>';
            }

            // Nút Sau › và Cuối »
            if (currentPage < totalPages) {
                html += '<button type="button" onclick="' + onPageChangeFnName + '(' + (currentPage + 1) + ')" style="' + btnBase + '" title="Trang sau">›</button>';
                html += '<button type="button" onclick="' + onPageChangeFnName + '(' + totalPages + ')" style="' + btnBase + '" title="Trang cuối">»</button>';
            } else {
                html += '<button type="button" disabled style="' + btnDisabled + '">›</button>';
                html += '<button type="button" disabled style="' + btnDisabled + '">»</button>';
            }

            html += '</div></div>';
            container.innerHTML = html;
        }

        function changeCategoryPage(page) {
            catCurrentPage = page;
            renderCategories();
            var mainContent = document.querySelector('.admin-main');
            if (mainContent) mainContent.scrollTop = 0;
        }

        function switchCategoryTab(tab, btn) {
            currentTab = tab;
            catCurrentPage = 1;
            document.getElementById('pillGenre').classList.remove('active');
            document.getElementById('pillAuthor').classList.remove('active');
            document.getElementById('pillPub').classList.remove('active');
            btn.classList.add('active');

            var input = document.getElementById('newCatName');
            if (tab === 'genres') input.placeholder = 'Tên thể loại mới';
            else if (tab === 'authors') input.placeholder = 'Tên tác giả mới';
            else input.placeholder = 'Tên nhà xuất bản mới';

            renderCategories();
        }

        function renderCategories() {
            var allCats = DB.getCategories();
            if (!allCats || !allCats[currentTab]) {
                allCats = {
                    genres: [
                        { code: 'TL01', name: 'Văn học', count: 42 },
                        { code: 'TL02', name: 'Kinh tế', count: 28 },
                        { code: 'TL03', name: 'Thiếu nhi', count: 35 },
                        { code: 'TL04', name: 'Kỹ năng', count: 19 },
                        { code: 'TL05', name: 'Công nghệ', count: 15 }
                    ],
                    authors: [
                        { code: 'TG01', name: 'José Mauro de Vasconcelos', count: 4 },
                        { code: 'TG02', name: 'Paulo Coelho', count: 8 },
                        { code: 'TG03', name: 'Dale Carnegie', count: 6 }
                    ],
                    publishers: [
                        { code: 'NXB01', name: 'NXB Trẻ', count: 120 },
                        { code: 'NXB02', name: 'NXB Kim Đồng', count: 94 },
                        { code: 'NXB03', name: 'NXB Hội Nhà Văn', count: 45 }
                    ]
                };
                DB.saveCategories(allCats);
            }

            var list = allCats[currentTab] || [];
            var tbody = document.getElementById('categoryTableBody');
            var paginationEl = document.getElementById('categoryPagination');

            if (list.length === 0) {
                tbody.innerHTML = '<tr><td colspan="3" style="text-align:center; padding: 24px; color: #8a847b;">Chưa có dữ liệu danh mục</td></tr>';
                if (paginationEl) paginationEl.innerHTML = '';
                return;
            }

            var totalPages = Math.ceil(list.length / CAT_PAGE_SIZE);
            if (catCurrentPage > totalPages) catCurrentPage = totalPages;
            if (catCurrentPage < 1) catCurrentPage = 1;

            var startIndex = (catCurrentPage - 1) * CAT_PAGE_SIZE;
            var pageList = list.slice(startIndex, startIndex + CAT_PAGE_SIZE);

            var html = '';
            for (var i = 0; i < pageList.length; i++) {
                var item = pageList[i];
                html += '<tr>' +
                    '<td style="font-weight: 500;">' + item.code + '</td>' +
                    '<td style="font-weight: 600;">' + item.name + '</td>' +
                    '<td style="text-align: right; white-space: nowrap;">' +
                        '<a href="javascript:void(0)" class="wire-act" onclick="editCat(\'' + item.code + '\')">Sửa</a>' +
                        '<span class="wire-dot">·</span>' +
                        '<a href="javascript:void(0)" class="wire-act" onclick="deleteCat(\'' + item.code + '\')">Xóa</a>' +
                    '</td>' +
                '</tr>';
            }
            tbody.innerHTML = html;

            renderAdminPagination('categoryPagination', catCurrentPage, totalPages, list.length, CAT_PAGE_SIZE, 'changeCategoryPage');
        }

        function addCategory(e) {
            e.preventDefault();
            var inp = document.getElementById('newCatName');
            var val = (inp.value || '').trim();
            if (!val) return;

            var allCats = DB.getCategories();
            if (!allCats[currentTab]) allCats[currentTab] = [];

            var prefix = currentTab === 'genres' ? 'TL' : (currentTab === 'authors' ? 'TG' : 'NXB');
            var nextNum = allCats[currentTab].length + 1;
            var numStr = nextNum < 10 ? ('0' + nextNum) : String(nextNum);
            var newCode = prefix + numStr;

            allCats[currentTab].push({
                code: newCode,
                name: val,
                count: 0
            });

            DB.saveCategories(allCats);
            inp.value = '';
            showToast('Đã thêm "' + val + '" (' + newCode + ') thành công!');
            catCurrentPage = Math.ceil(allCats[currentTab].length / CAT_PAGE_SIZE);
            renderCategories();
        }

        function editCat(code) {
            var allCats = DB.getCategories();
            var list = allCats[currentTab] || [];
            var target = null;
            for (var i = 0; i < list.length; i++) {
                if (list[i].code === code) {
                    target = list[i];
                    break;
                }
            }
            if (!target) return;

            var newName = prompt('Sửa tên danh mục (' + code + '):', target.name);
            if (newName && newName.trim() && newName.trim() !== target.name) {
                target.name = newName.trim();
                DB.saveCategories(allCats);
                showToast('Đã cập nhật danh mục ' + code + '!');
                renderCategories();
            }
        }

        function deleteCat(code) {
            showModalConfirm('Bạn có chắc muốn xóa danh mục mã ' + code + '?', function() {
                var allCats = DB.getCategories();
                allCats[currentTab] = (allCats[currentTab] || []).filter(function(i) {
                    return i.code !== code;
                });
                DB.saveCategories(allCats);
                showToast('Đã xóa danh mục ' + code + '!');
                renderCategories();
            }, null, { title: 'Xóa danh mục', confirmText: 'Xóa', confirmDanger: true });
        }

        document.addEventListener('DOMContentLoaded', function() {
            renderCategories();
        });
    </script>
</body>
</html>
