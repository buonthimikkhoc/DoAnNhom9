<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đơn hàng của tôi - BookStore</title>
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
        <h1 style="font-size: 22px; font-weight: 700; margin-bottom: 20px;">Lịch Sử Đơn Hàng Của Tôi</h1>

        <div class="card" style="padding: 24px;">
            <!-- Filter Tabs -->
            <div class="row wrap chip-container" style="margin-bottom: 20px;">
                <button class="chip on" onclick="filterCustomerOrders('all', this)">Tất cả</button>
                <button class="chip" onclick="filterCustomerOrders('pending', this)">Chờ xử lý</button>
                <button class="chip" onclick="filterCustomerOrders('shipping', this)">Đang giao</button>
                <button class="chip" onclick="filterCustomerOrders('done', this)">Hoàn tất</button>
                <button class="chip" onclick="filterCustomerOrders('cancelled', this)">Đã hủy</button>
            </div>

            <!-- Orders Table -->
            <div class="table-container">
                <table class="t">
                    <thead>
                        <tr>
                            <th style="width: 100px;">Mã đơn</th>
                            <th style="width: 140px;">Ngày đặt</th>
                            <th style="width: 150px;">Tổng tiền</th>
                            <th style="width: 150px;">Trạng thái</th>
                            <th style="text-align: right; width: 140px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="customerOrderTableBody">
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <footer>
        <p>© 2026 BookStore - Đồ án tốt nghiệp / Môn học Eclipse Web - Nhóm 9</p>
    </footer>

    <script src="${pageContext.request.contextPath}/resources/js/main.js"></script>
    <script>
        let currentStatusFilter = 'all';

        function renderCustomerOrders() {
            const orders = DB.getOrders();
            const tbody = document.getElementById('customerOrderTableBody');

            const filtered = orders.filter(o => currentStatusFilter === 'all' || o.status === currentStatusFilter);

            if (filtered.length === 0) {
                tbody.innerHTML = '<tr><td colspan="5" class="c mute" style="padding: 28px;">Bạn chưa có đơn hàng nào trong mục này.</td></tr>';
                return;
            }

            tbody.innerHTML = filtered.map(o => {
                const badgeClass = o.status === 'done' ? 'st-done' : (o.status === 'shipping' ? 'st-shipping' : (o.status === 'pending' ? 'st-pending' : 'st-cancelled'));
                const shipping = Number(o.shippingFee) || 20000;
                
                const itemsHtml = (o.items || []).map((i, idx) => `
                    <div style="display: flex; justify-content: space-between; font-size: 13.5px; padding: 4px 0;">
                        <span>` + (idx + 1) + `. <strong>` + i.title + `</strong> × ` + i.qty + `</span>
                        <span class="b">` + formatMoney(i.price * i.qty) + `</span>
                    </div>
                `).join('');

                return `
                    <tr id="order-row-` + o.id.replace('#', '') + `" style="transition: background 0.15s;">
                        <td class="b" style="color: var(--ink);">` + o.id + `</td>
                        <td>` + o.date + `</td>
                        <td class="b text-ac" style="font-size: 14.5px;">` + formatMoney(o.total) + `</td>
                        <td><span class="st ` + badgeClass + `">● ` + (o.statusText || o.status) + `</span></td>
                        <td style="text-align: right;">
                            <button id="btn-toggle-` + o.id.replace('#', '') + `" class="btn o btn-sm" onclick="toggleCustomerOrderDetail('` + o.id.replace('#', '') + `')">Xem chi tiết ▾</button>
                        </td>
                    </tr>
                    <!-- KHUNG CHI TIẾT ĐƠN HÀNG XỔ XUỐNG NGAY DƯỚI DÒNG ĐƠN TƯƠNG ỨNG -->
                    <tr id="detail-row-` + o.id.replace('#', '') + `" class="order-expand-row" style="display: none; background: #fafaf8;">
                        <td colspan="5" style="padding: 0 16px 20px 16px; border-bottom: 2px solid var(--line);">
                            <div style="background: #ffffff; border: 1px solid var(--line); border-radius: 8px; border-left: 4px solid var(--ac); padding: 18px 20px; box-shadow: var(--shadow-sm); margin-top: 6px;">
                                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 12px;">
                                    <div style="font-weight: 700; font-size: 14.5px; color: var(--ink);">📦 Chi tiết đơn hàng ` + o.id + `</div>
                                    <span class="st ` + badgeClass + `">` + (o.statusText || o.status) + `</span>
                                </div>
                                
                                <div style="display: flex; flex-direction: column; gap: 6px; background: #f8fafc; padding: 14px 18px; border-radius: 6px; border: 1px solid #e2e8f0;">
                                    ` + itemsHtml + `
                                    <div style="display: flex; justify-content: space-between; font-size: 13px; color: var(--mute); padding-top: 6px; border-top: 1px dashed #e2e8f0; margin-top: 4px;">
                                        <span>Phí vận chuyển:</span>
                                        <span>` + formatMoney(shipping) + `</span>
                                    </div>
                                    <hr style="border: none; border-top: 1px solid #e2e8f0; margin: 4px 0;">
                                    <div style="display: flex; justify-content: space-between; font-weight: 700; font-size: 14.5px;">
                                        <span>Tổng thanh toán:</span>
                                        <span class="text-ac">` + formatMoney(o.total) + ` (` + (o.paymentMethod || 'COD') + `)</span>
                                    </div>
                                </div>

                                <div style="margin-top: 12px; font-size: 13px; color: var(--mute); display: flex; align-items: center; gap: 8px; flex-wrap: wrap;">
                                    <svg width="16" height="16" viewBox="0 0 24 24" fill="currentColor" style="color: #64748b;"><path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z"/></svg>
                                    <span>Người nhận: <strong style="color: var(--ink);">` + (o.customer || 'Khách hàng') + `</strong> (SĐT: ` + (o.phone || 'Chưa cập nhật') + `) · Địa chỉ giao hàng: <strong style="color: var(--ink);">` + (o.address || 'Tại cửa hàng') + `</strong></span>
                                </div>
                            </div>
                        </td>
                    </tr>
                `;
            }).join('');
        }

        function filterCustomerOrders(status, btn) {
            currentStatusFilter = status;
            document.querySelectorAll('.chip-container .chip').forEach(c => c.classList.remove('on'));
            btn.classList.add('on');
            renderCustomerOrders();
        }

        // Bấm vào đơn nào thì xổ chi tiết ngay bên dưới đơn đó
        function toggleCustomerOrderDetail(cleanId) {
            var detailRow = document.getElementById('detail-row-' + cleanId);
            var btn = document.getElementById('btn-toggle-' + cleanId);
            if (!detailRow) return;

            var isCurrentlyOpen = detailRow.style.display !== 'none';

            // Thu gọn tất cả các dòng chi tiết khác
            document.querySelectorAll('.order-expand-row').forEach(function(row) {
                row.style.display = 'none';
            });
            document.querySelectorAll('[id^="btn-toggle-"]').forEach(function(b) {
                b.innerHTML = 'Xem chi tiết ▾';
            });

            // Nếu đơn này chưa mở thì mở ra, nếu đang mở thì đã thu gọn ở trên
            if (!isCurrentlyOpen) {
                detailRow.style.display = 'table-row';
                btn.innerHTML = 'Thu gọn ▴';
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            renderCustomerOrders();
        });
    </script>
</body>
</html>
