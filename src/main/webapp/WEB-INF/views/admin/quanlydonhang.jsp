<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng - Admin BookStore</title>
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
            padding: 6px 18px;
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
    </style>
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
            <a href="${pageContext.request.contextPath}/admin/quanlydanhmuc" class="sidebar-item">
                <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M4 10.5c-.83 0-1.5.67-1.5 1.5s.67 1.5 1.5 1.5 1.5-.67 1.5-1.5-.67-1.5-1.5-1.5zm0-6c-.83 0-1.5.67-1.5 1.5S3.17 7.5 4 7.5 5.5 6.83 5.5 6 4.83 4.5 4 4.5zm0 12c-.83 0-1.5.68-1.5 1.5s.68 1.5 1.5 1.5 1.5-.68 1.5-1.5-.67-1.5-1.5-1.5zM7 19h14v-2H7v2zm0-6h14v-2H7v2zm0-8v2h14V5H7z"/></svg>
                <span>Quản lý Danh mục</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/quanlydonhang" class="sidebar-item active">
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
                    Quản lý đơn hàng
                </h1>
                <p style="color: #64748b; font-size: 13px; margin-top: 4px;">Theo dõi và duyệt trạng thái đơn hàng của khách hàng</p>
            </div>

            <!-- Chips lọc trạng thái đơn hàng -->
            <div class="pill-group">
                <button type="button" class="pill-btn active" onclick="filterOrders('all', this)">Tất cả</button>
                <button type="button" class="pill-btn" onclick="filterOrders('pending', this)">Chờ xử lý</button>
                <button type="button" class="pill-btn" onclick="filterOrders('shipping', this)">Đang giao</button>
                <button type="button" class="pill-btn" onclick="filterOrders('done', this)">Hoàn tất</button>
                <button type="button" class="pill-btn" onclick="filterOrders('cancelled', this)">Đã hủy</button>
            </div>

            <!-- Bảng danh sách đơn hàng chuẩn wireframe -->
            <table class="wire-table">
                <thead>
                    <tr>
                        <th style="width: 110px;">Mã</th>
                        <th>Khách</th>
                        <th style="width: 160px;">Tổng</th>
                        <th style="width: 170px; text-align: right;">Trạng thái</th>
                    </tr>
                </thead>
                <tbody id="adminOrderTableBody">
                    <!-- Rendered by JS -->
                </tbody>
            </table>

            <!-- Khung chi tiết đơn hàng được chọn theo Wireframe -->
            <div id="orderDetailBox" style="margin-top: 24px; padding: 18px 22px; border: 1px solid #d9d4ca; border-radius: 8px; background: #fafaf8; border-left: 4px solid #1f5f5b;">
                <div class="b" id="detailOrderTitle" style="font-size: 15px; font-weight: 700; margin-bottom: 8px; color: #23201c;">Chi tiết #1024</div>
                <div id="detailOrderItems" style="font-size: 13.5px; color: #4b5563; margin-bottom: 14px; line-height: 1.6;">
                    Cây Cam Ngọt Của Tôi ×1, Nhà Giả Kim (Tái Bản 2026) ×2 · SĐT: 0987 654 321
                </div>
                <div style="display: flex; gap: 10px;">
                    <button type="button" class="btn" style="background: #1f5f5b; color: #fff; padding: 8px 18px; border: none; border-radius: 4px; font-weight: 600; cursor: pointer; font-size: 13px;" onclick="saveSelectedOrderStatus()">Cập nhật trạng thái</button>
                    <button type="button" class="btn" style="background: #b3412f; color: #fff; padding: 8px 18px; border: none; border-radius: 4px; font-weight: 600; cursor: pointer; font-size: 13px;" onclick="cancelSelectedOrder()">Hủy đơn</button>
                </div>
            </div>
        </main>
    </div>

    <script>
        var currentFilter = 'all';
        var activeOrderId = '#1024';

        function filterOrders(status, btn) {
            currentFilter = status;
            var chips = document.querySelectorAll('.pill-btn');
            chips.forEach(function(c) { c.classList.remove('active'); });
            if (btn) btn.classList.add('active');
            renderOrders();
        }

        function ensureInitialOrders() {
            var raw = localStorage.getItem('bs_orders');
            var list = [];
            try { list = JSON.parse(raw); } catch(e) { list = []; }
            if (!Array.isArray(list) || list.length === 0) {
                list = [
                    {
                        id: '#1024',
                        date: '15/10/2026',
                        customer: 'Nguyễn Văn An',
                        phone: '0987 654 321',
                        address: '12 Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh',
                        items: [
                            { id: 'S01', title: 'Cây Cam Ngọt Của Tôi', price: 95000, qty: 1 },
                            { id: 'S02', title: 'Nhà Giả Kim (Tái Bản 2026)', price: 120000, qty: 2 }
                        ],
                        total: 355000,
                        status: 'shipping'
                    },
                    {
                        id: '#1025',
                        date: '18/10/2026',
                        customer: 'Lê Bình',
                        phone: '0912 345 678',
                        address: '45 Lê Duẩn, Quận 1, TP. Hồ Chí Minh',
                        items: [
                            { id: 'S03', title: 'Hoàng Tử Bé', price: 68000, qty: 1 },
                            { id: 'S04', title: 'Đắc Nhân Tâm (Khổ Lớn)', price: 86000, qty: 1 }
                        ],
                        total: 174000,
                        status: 'pending'
                    },
                    {
                        id: '#1026',
                        date: '20/10/2026',
                        customer: 'Trần Minh Quân',
                        phone: '0903 112 233',
                        address: '88 Võ Văn Tần, Quận 3, TP. Hồ Chí Minh',
                        items: [
                            { id: 'S05', title: 'Lược Sử Loài Người - Sapiens', price: 189000, qty: 1 }
                        ],
                        total: 209000,
                        status: 'done'
                    }
                ];
                localStorage.setItem('bs_orders', JSON.stringify(list));
            }
            return list;
        }

        function formatMoney(amount) {
            if (typeof formatVND === 'function') return formatVND(amount);
            return (amount || 0).toLocaleString('vi-VN') + 'đ';
        }

        function renderOrders() {
            var orders = ensureInitialOrders();
            if (currentFilter !== 'all') {
                orders = orders.filter(function(o) { return o.status === currentFilter; });
            }

            var tbody = document.getElementById('adminOrderTableBody');
            if (!tbody) return;

            if (orders.length === 0) {
                tbody.innerHTML = '<tr><td colspan="4" style="text-align:center; padding: 24px; color: #8a847b;">Không có đơn hàng nào trong mục này</td></tr>';
                document.getElementById('orderDetailBox').style.display = 'none';
                return;
            }

            document.getElementById('orderDetailBox').style.display = 'block';

            var html = '';
            for (var i = 0; i < orders.length; i++) {
                var o = orders[i];
                var customerName = o.customer ? o.customer.split(' ').slice(-2).join(' ') : 'Khách';
                var isSelected = o.id === activeOrderId;
                
                html += '<tr style="' + (isSelected ? 'background: #eef7f6;' : '') + '; cursor: pointer;" onclick="selectOrder(\'' + o.id + '\')">' +
                    '<td style="font-weight: 700; color: #1f5f5b;">' + o.id + '</td>' +
                    '<td><strong>' + (o.customer || customerName) + '</strong></td>' +
                    '<td style="font-weight: 700; color: #1f5f5b;">' + formatMoney(o.total) + '</td>' +
                    '<td style="text-align: right;" onclick="event.stopPropagation()">' +
                        '<select class="inp" style="padding: 6px 10px; font-size: 13px; border-radius: 4px; border: 1px solid #d9d4ca; background: #fff;" onchange="updateOrderStatusInline(\'' + o.id + '\', this.value)">' +
                            '<option value="pending"' + (o.status === 'pending' ? ' selected' : '') + '>Chờ xử lý ▾</option>' +
                            '<option value="shipping"' + (o.status === 'shipping' ? ' selected' : '') + '>Đang giao ▾</option>' +
                            '<option value="done"' + (o.status === 'done' ? ' selected' : '') + '>Hoàn tất ▾</option>' +
                            '<option value="cancelled"' + (o.status === 'cancelled' ? ' selected' : '') + '>Đã hủy ▾</option>' +
                        '</select>' +
                    '</td>' +
                '</tr>';
            }
            tbody.innerHTML = html;

            showOrderDetail(activeOrderId);
        }

        function selectOrder(orderId) {
            activeOrderId = orderId;
            renderOrders();
        }

        function showOrderDetail(orderId) {
            var orders = ensureInitialOrders();
            var o = orders.find(function(item) { return item.id === orderId; });
            if (!o && orders.length > 0) {
                o = orders[0];
                activeOrderId = o.id;
            }
            if (!o) return;

            document.getElementById('detailOrderTitle').innerText = 'Chi tiết ' + o.id + ' - Khách: ' + (o.customer || 'Khách hàng');
            
            var itemsText = (o.items || []).map(function(it) {
                return it.title + ' ×' + it.qty;
            }).join(', ');

            document.getElementById('detailOrderItems').innerText = 
                (itemsText || 'Không có sản phẩm') + ' · SĐT: ' + (o.phone || '0987 654 321') + ' · Đ/c: ' + (o.address || 'TP. Hồ Chí Minh');
        }

        function updateOrderStatusInline(orderId, newStatus) {
            var statusMap = {
                'pending': 'Chờ xử lý',
                'shipping': 'Đang giao',
                'done': 'Hoàn tất',
                'cancelled': 'Đã hủy'
            };
            DB.updateOrderStatus(orderId, newStatus, statusMap[newStatus] || newStatus);
            showToast('Đã cập nhật đơn ' + orderId + ' thành: ' + (statusMap[newStatus] || newStatus));
            renderOrders();
        }

        function saveSelectedOrderStatus() {
            showToast('Đã lưu thông tin đơn hàng ' + activeOrderId + '!');
        }

        function cancelSelectedOrder() {
            showModalConfirm('Bạn có chắc muốn hủy đơn hàng ' + activeOrderId + '?', function() {
                DB.updateOrderStatus(activeOrderId, 'cancelled', 'Đã hủy');
                showToast('Đã hủy đơn hàng ' + activeOrderId + '!', 'danger');
                renderOrders();
            }, null, { title: 'Hủy đơn hàng', confirmText: 'Hủy đơn', confirmDanger: true });
        }

        document.addEventListener('DOMContentLoaded', function() {
            renderOrders();
        });
    </script>
</body>
</html>
