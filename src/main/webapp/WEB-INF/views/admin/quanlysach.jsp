<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý sách - Admin BookStore</title>
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
    <script src="${pageContext.request.contextPath}/resources/js/main.js?v=20261109"></script>
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
            <a href="${pageContext.request.contextPath}/admin/quanlysach" class="sidebar-item active">
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

        <!-- NỘI DUNG CHÍNH BÊN PHẢI TOÀN MÀN HÌNH -->
        <main class="admin-main">
            <div style="margin-bottom: 20px;">
                <h1 style="font-size: 20px; font-weight: 700; color: #23201c;">
                    Quản lý sách
                </h1>
                <p style="color: #64748b; font-size: 13px; margin-top: 4px;">Quản lý kho sách, giá bán và thêm mới sách trong hệ thống</p>
            </div>

            <!-- Ô tìm kiếm và nút thêm sách -->
            <div style="display: flex; gap: 10px; margin-bottom: 20px; max-width: 700px;">
                <input type="text" id="adminBookSearch" class="inp" placeholder="Tìm theo tên sách, tác giả..." style="flex: 1; padding: 9px 14px; border: 1px solid #d9d4ca; border-radius: 4px; font-size: 14px;" onkeyup="renderBooks()">
                <button type="button" class="btn" style="background: #1f5f5b; color: #fff; padding: 9px 24px; border: none; border-radius: 4px; font-weight: 600; cursor: pointer; white-space: nowrap; font-size: 14px;" onclick="focusAddForm()">+ Thêm sách</button>
            </div>

            <!-- Bảng danh sách sách chuẩn wireframe -->
            <table class="wire-table">
                <thead>
                    <tr>
                        <th style="width: 80px;">Mã</th>
                        <th>Tên sách</th>
                        <th style="width: 140px;">Giá</th>
                        <th style="width: 90px; text-align: center;">Kho</th>
                        <th style="width: 140px; text-align: right;"></th>
                    </tr>
                </thead>
                <tbody id="adminBookTableBody">
                    <!-- Rendered by JS -->
                </tbody>
            </table>
        </main>
    </div>

    <!-- MODAL POPUP THÊM / SỬA SÁCH HIỆN ĐẠI -->
    <div id="bookModal" class="modal-overlay" style="display: none; position: fixed; inset: 0; background: rgba(15, 23, 42, 0.6); backdrop-filter: blur(3px); z-index: 9999; align-items: center; justify-content: center; padding: 20px;">
        <div class="modal-box" style="background: #ffffff; border-radius: 12px; width: 100%; max-width: 560px; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.2), 0 10px 10px -5px rgba(0,0,0,0.05); overflow: hidden; animation: popIn 0.2s ease;">
            
            <!-- Modal Header -->
            <div style="background: #f8fafc; padding: 18px 24px; border-bottom: 1px solid #e2e8f0; display: flex; align-items: center; justify-content: space-between;">
                <div style="display: flex; align-items: center; gap: 10px;">
                    <div style="width: 32px; height: 32px; border-radius: 8px; background: rgba(31, 95, 91, 0.1); color: #1f5f5b; display: flex; align-items: center; justify-content: center; font-size: 16px;">
                        📖
                    </div>
                    <h3 id="bookModalTitle" style="font-size: 16px; font-weight: 700; color: #1e293b; margin: 0;">Thêm sách mới</h3>
                </div>
                <button type="button" onclick="closeBookModal()" style="background: transparent; border: none; font-size: 24px; line-height: 1; color: #94a3b8; cursor: pointer; padding: 4px 8px; border-radius: 6px;" onmouseover="this.style.color='#1e293b'" onmouseout="this.style.color='#94a3b8'">&times;</button>
            </div>

            <!-- Modal Body (Form Fields) -->
            <!-- Modal Body (Form Fields) -->
            <div style="padding: 24px; max-height: calc(85vh - 140px); overflow-y: auto;">
                <input type="hidden" id="edit_book_id" value="">
                
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px;">
                    <!-- Upload Ảnh Bìa -->
                    <div style="grid-column: 1 / -1;">
                        <label style="display: block; font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 6px;">
                            Ảnh bìa sách
                        </label>
                        <div style="display: flex; gap: 16px; align-items: center; padding: 14px 18px; background: #f8fafc; border: 1.5px dashed #cbd5e1; border-radius: 8px;">
                            <!-- Khung Preview Ảnh Bìa -->
                            <div id="imagePreviewContainer" style="width: 76px; height: 102px; border-radius: 6px; border: 1px solid #cbd5e1; background: #ffffff; display: flex; align-items: center; justify-content: center; overflow: hidden; flex-shrink: 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                                <img id="fb_image_preview" src="" alt="Ảnh bìa" style="display: none; width: 100%; height: 100%; object-fit: cover;">
                                <span id="fb_image_placeholder" style="font-size: 32px; color: #94a3b8;">📖</span>
                            </div>

                            <!-- Nút Tải Lên & Nhập URL -->
                            <div style="flex: 1;">
                                <div style="display: flex; gap: 8px; align-items: center; margin-bottom: 8px;">
                                    <input type="file" id="fb_image_file" accept="image/*" style="display: none;" onchange="handleImageFileSelect(event)">
                                    <button type="button" onclick="document.getElementById('fb_image_file').click()" style="background: #1f5f5b; color: #ffffff; border: none; padding: 8px 16px; border-radius: 6px; font-size: 13px; font-weight: 600; cursor: pointer; display: inline-flex; align-items: center; gap: 6px;" onmouseover="this.style.background='#184b48'" onmouseout="this.style.background='#1f5f5b'">
                                        <svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><path d="M19.35 10.04C18.67 6.59 15.64 4 12 4 9.11 4 6.6 5.64 5.35 8.04 2.34 8.36 0 10.91 0 14c0 3.31 2.69 6 6 6h13c2.76 0 5-2.24 5-5 0-2.64-2.05-4.78-4.65-4.96zM14 13v4h-4v-4H7l5-5 5 5h-3z"/></svg>
                                        Tải ảnh từ máy tính
                                    </button>
                                    <button type="button" id="btnRemoveImage" onclick="removeBookImage()" style="display: none; background: #fee2e2; color: #dc2626; border: 1px solid #fca5a5; padding: 7px 12px; border-radius: 6px; font-size: 13px; font-weight: 500; cursor: pointer;">
                                        ✕ Xóa ảnh
                                    </button>
                                </div>
                                <div>
                                    <input type="text" id="fb_image_url" class="inp" placeholder="Hoặc dán URL ảnh trực tiếp (https://...)" style="width: 100%; font-size: 12.5px; padding: 7px 12px; border: 1px solid #cbd5e1; border-radius: 6px; outline: none;" oninput="handleImageUrlInput(this.value)">
                                </div>
                                <div style="font-size: 11.5px; color: #64748b; margin-top: 5px;">
                                    Hỗ trợ định dạng JPG, PNG, WEBP. Ảnh được lưu trữ tự động vào trình duyệt.
                                </div>
                            </div>
                        </div>
                    </div>

                    <div style="grid-column: 1 / -1;">
                        <label style="display: block; font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 6px;">Tên sách <span style="color: #ef4444;">*</span></label>
                        <input type="text" id="fb_title" class="inp" placeholder="Nhập tên tựa sách..." style="width: 100%; padding: 10px 14px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 14px; outline: none;" required>
                    </div>

                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 6px;">Giá bán (VNĐ) <span style="color: #ef4444;">*</span></label>
                        <input type="number" id="fb_price" class="inp" placeholder="Ví dụ: 95000" style="width: 100%; padding: 10px 14px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 14px; outline: none;" required>
                    </div>

                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 6px;">Thể loại</label>
                        <select id="fb_cat" class="inp" style="width: 100%; padding: 10px 14px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 14px; background: #fff; outline: none;">
                            <option value="Văn học">Văn học</option>
                            <option value="Kinh tế">Kinh tế</option>
                            <option value="Thiếu nhi">Thiếu nhi</option>
                            <option value="Kỹ năng">Kỹ năng</option>
                            <option value="Công nghệ">Công nghệ</option>
                            <option value="Lịch sử">Lịch sử</option>
                            <option value="Khoa học">Khoa học</option>
                        </select>
                    </div>

                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 6px;">Số lượng kho <span style="color: #ef4444;">*</span></label>
                        <input type="number" id="fb_stock" class="inp" placeholder="Ví dụ: 20" style="width: 100%; padding: 10px 14px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 14px; outline: none;" required>
                    </div>

                    <div>
                        <label style="display: block; font-size: 13px; font-weight: 600; color: #334155; margin-bottom: 6px;">Tác giả</label>
                        <input type="text" id="fb_author" class="inp" placeholder="Ví dụ: Paulo Coelho" style="width: 100%; padding: 10px 14px; border: 1px solid #cbd5e1; border-radius: 6px; font-size: 14px; outline: none;">
                    </div>
                </div>
            </div>

            <!-- Modal Footer -->
            <div style="background: #f8fafc; padding: 14px 24px; border-top: 1px solid #e2e8f0; display: flex; justify-content: flex-end; gap: 10px;">
                <button type="button" onclick="closeBookModal()" style="background: #ffffff; color: #475569; border: 1px solid #cbd5e1; padding: 9px 20px; border-radius: 6px; font-size: 13.5px; font-weight: 600; cursor: pointer; transition: all 0.15s;" onmouseover="this.style.background='#f1f5f9'" onmouseout="this.style.background='#ffffff'">Hủy</button>
                <button type="button" onclick="handleSaveBook()" style="background: #1f5f5b; color: #ffffff; border: none; padding: 9px 24px; border-radius: 6px; font-size: 13.5px; font-weight: 600; cursor: pointer; transition: all 0.2s; box-shadow: 0 2px 6px rgba(31,95,91,0.25);" onmouseover="this.style.background='#184b48'" onmouseout="this.style.background='#1f5f5b'">Lưu sách</button>
            </div>
        </div>
    </div>

    <script>
        var currentBookImageData = '';

        function formatMoney(amount) {
            if (typeof formatVND === 'function') return formatVND(amount);
            return (amount || 0).toLocaleString('vi-VN') + 'đ';
        }

        // Xử lý chọn tệp ảnh từ máy tính (chuyển sang Base64)
        function handleImageFileSelect(event) {
            var file = event.target.files && event.target.files[0];
            if (!file) return;

            // Giới hạn dung lượng tối đa 5MB để tránh lag localStorage
            if (file.size > 5 * 1024 * 1024) {
                alert('Dung lượng ảnh quá lớn! Vui lòng chọn ảnh dưới 5MB.');
                return;
            }

            var reader = new FileReader();
            reader.onload = function(e) {
                currentBookImageData = e.target.result;
                setPreviewImage(currentBookImageData);
                document.getElementById('fb_image_url').value = '';
            };
            reader.readAsDataURL(file);
        }

        // Xử lý nhập URL ảnh trực tuyến
        function handleImageUrlInput(url) {
            url = (url || '').trim();
            if (url) {
                currentBookImageData = url;
                setPreviewImage(url);
            } else {
                removeBookImage();
            }
        }

        // Cập nhật khung hiển thị ảnh xem trước
        function setPreviewImage(src) {
            var img = document.getElementById('fb_image_preview');
            var placeholder = document.getElementById('fb_image_placeholder');
            var btnRemove = document.getElementById('btnRemoveImage');

            if (src) {
                var displayUrl = (typeof getBookImageUrl === 'function') ? getBookImageUrl(src) : src;
                img.src = displayUrl;
                img.style.display = 'block';
                placeholder.style.display = 'none';
                if (btnRemove) btnRemove.style.display = 'inline-block';
            } else {
                img.src = '';
                img.style.display = 'none';
                placeholder.style.display = 'inline-block';
                if (btnRemove) btnRemove.style.display = 'none';
            }
        }

        // Xóa ảnh đã chọn
        function removeBookImage() {
            currentBookImageData = '';
            setPreviewImage('');
            document.getElementById('fb_image_file').value = '';
            document.getElementById('fb_image_url').value = '';
        }

        function renderBooks() {
            var books = DB.getBooks();
            var searchInp = document.getElementById('adminBookSearch');
            var q = searchInp ? (searchInp.value || '').toLowerCase().trim() : '';
            if (q) {
                books = books.filter(function(b) {
                    return (b.title || '').toLowerCase().indexOf(q) !== -1 || 
                           (b.author || '').toLowerCase().indexOf(q) !== -1 ||
                           (b.id || '').toLowerCase().indexOf(q) !== -1;
                });
            }

            var tbody = document.getElementById('adminBookTableBody');
            if (!tbody) return;

            if (books.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" style="text-align:center; padding: 24px; color: #8a847b;">Không tìm thấy sách nào</td></tr>';
                return;
            }

            var html = '';
            for (var i = 0; i < books.length; i++) {
                var b = books[i];
                var imgUrl = (typeof getBookImageUrl === 'function') ? getBookImageUrl(b.image) : (b.image || '');
                var thumbContent = imgUrl ? 
                    '<img src="' + imgUrl + '" alt="' + (b.title || '').replace(/"/g, '&quot;') + '" style="width: 100%; height: 100%; object-fit: cover;" onerror="this.onerror=null; this.parentElement.innerHTML=\'<span style=\\\'font-size: 20px;\\\'>' + (b.icon || '📖') + '</span>\';">' :
                    '<span style="font-size: 20px;">' + (b.icon || '📖') + '</span>';

                html += '<tr>' +
                    '<td style="font-weight: 700; color: #1f5f5b;">' + b.id + '</td>' +
                    '<td style="font-weight: 600;">' +
                        '<div style="display: flex; align-items: center; gap: 12px;">' +
                            '<div style="width: 36px; height: 48px; border-radius: 4px; overflow: hidden; background: ' + (b.bg || '#e2e8f0') + '; display: flex; align-items: center; justify-content: center; flex-shrink: 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">' +
                                thumbContent +
                            '</div>' +
                            '<div>' +
                                '<div style="color: #1e293b; font-size: 14px;">' + b.title + '</div>' +
                                '<div style="font-size: 12px; color: #64748b; font-weight: 400; margin-top: 2px;">' + b.author + ' · <span style="color: #1f5f5b; font-weight: 500;">' + b.category + '</span></div>' +
                            '</div>' +
                        '</div>' +
                    '</td>' +
                    '<td style="color: #1f5f5b; font-weight: 700;">' + formatMoney(b.price) + '</td>' +
                    '<td style="text-align: center; font-weight: 600;">' + b.stock + '</td>' +
                    '<td style="text-align: right; white-space: nowrap;">' +
                        '<a href="javascript:void(0)" class="wire-act" onclick="editBook(\'' + b.id + '\')">Sửa</a>' +
                        '<span class="wire-dot">·</span>' +
                        '<a href="javascript:void(0)" class="wire-act" onclick="deleteBook(\'' + b.id + '\')">Xóa</a>' +
                    '</td>' +
                '</tr>';
            }
            tbody.innerHTML = html;
        }

        // Mở Modal Popup Thêm sách mới
        function openAddBookModal() {
            closeBookModal();
            removeBookImage();
            document.getElementById('bookModalTitle').innerText = 'Thêm sách mới';
            document.getElementById('bookModal').style.display = 'flex';
            setTimeout(function() {
                var inp = document.getElementById('fb_title');
                if (inp) inp.focus();
            }, 100);
        }

        // Tương thích nút cũ focusAddForm -> mở popup
        function focusAddForm() {
            openAddBookModal();
        }

        // Đóng Modal Popup
        function closeBookModal() {
            var modal = document.getElementById('bookModal');
            if (modal) modal.style.display = 'none';
            document.getElementById('edit_book_id').value = '';
            document.getElementById('fb_title').value = '';
            document.getElementById('fb_price').value = '';
            document.getElementById('fb_stock').value = '';
            document.getElementById('fb_author').value = '';
            removeBookImage();
        }

        // Mở Modal Popup Sửa sách
        function editBook(id) {
            var b = DB.getBookById(id);
            if (!b) return;

            document.getElementById('edit_book_id').value = b.id;
            document.getElementById('fb_title').value = b.title || '';
            document.getElementById('fb_price').value = b.price || '';
            document.getElementById('fb_cat').value = b.category || 'Văn học';
            document.getElementById('fb_stock').value = b.stock || '';
            document.getElementById('fb_author').value = b.author || '';

            // Nạp ảnh hiện tại nếu có
            if (b.image) {
                currentBookImageData = b.image;
                setPreviewImage(b.image);
                if (b.image.startsWith('http')) {
                    document.getElementById('fb_image_url').value = b.image;
                } else {
                    document.getElementById('fb_image_url').value = '';
                }
            } else {
                removeBookImage();
            }

            document.getElementById('bookModalTitle').innerText = 'Chỉnh sửa sách: ' + b.id + ' - ' + b.title;
            document.getElementById('bookModal').style.display = 'flex';
            setTimeout(function() {
                var inp = document.getElementById('fb_title');
                if (inp) inp.focus();
            }, 100);
        }

        // Lưu sách (Thêm mới hoặc Cập nhật)
        function handleSaveBook() {
            var editId = document.getElementById('edit_book_id').value;
            var title = (document.getElementById('fb_title').value || '').trim();
            var price = parseInt(document.getElementById('fb_price').value, 10);
            var cat = document.getElementById('fb_cat').value;
            var stock = parseInt(document.getElementById('fb_stock').value, 10);
            var author = (document.getElementById('fb_author').value || '').trim() || 'Nhiều tác giả';

            if (!title) {
                alert('Vui lòng nhập tên tựa sách!');
                document.getElementById('fb_title').focus();
                return;
            }
            if (isNaN(price) || price <= 0) {
                alert('Vui lòng nhập giá sách hợp lệ!');
                document.getElementById('fb_price').focus();
                return;
            }
            if (isNaN(stock) || stock < 0) {
                stock = 10;
            }

            if (editId) {
                var updatePayload = {
                    id: editId,
                    title: title,
                    price: price,
                    category: cat,
                    stock: stock,
                    author: author
                };
                updatePayload.image = currentBookImageData;
                DB.updateBook(updatePayload);
                showToast('Đã cập nhật sách ' + editId + ' thành công!');
            } else {
                var books = DB.getBooks();
                var nextId = 'S' + String(books.length + 1).padStart(2, '0');
                var newBook = {
                    id: nextId,
                    title: title,
                    author: author,
                    publisher: 'NXB Trẻ',
                    category: cat,
                    price: price,
                    oldPrice: price + 15000,
                    stock: stock,
                    badge: 'Mới',
                    icon: '📘',
                    bg: 'linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%)',
                    desc: 'Sách mới thêm vào hệ thống kho.'
                };
                newBook.image = currentBookImageData || '';
                DB.addBook(newBook);
                showToast('Đã thêm cuốn sách ' + nextId + ' thành công!');
            }

            closeBookModal();
            renderBooks();
        }

        function deleteBook(id) {
            showModalConfirm('Bạn có chắc muốn xóa cuốn sách mã ' + id + '?', function() {
                DB.deleteBook(id);
                showToast('Đã xóa sách ' + id + ' thành công!');
                renderBooks();
            }, null, { title: 'Xóa sách', confirmText: 'Xóa sách', confirmDanger: true });
        }

        // Đóng popup khi click ra ngoài vùng mờ
        window.addEventListener('click', function(e) {
            var modal = document.getElementById('bookModal');
            if (e.target === modal) {
                closeBookModal();
            }
        });

        document.addEventListener('DOMContentLoaded', function() {
            renderBooks();
        });
    </script>
</body>
</html>
