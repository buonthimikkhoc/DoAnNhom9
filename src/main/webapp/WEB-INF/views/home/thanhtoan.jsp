<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán & Đặt hàng - BookStore</title>
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
            <a href="${pageContext.request.contextPath}/taikhoan" class="user-menu-btn">
                <span class="avatar-sm">A</span>
                <span>Xin chào, An ▾</span>
            </a>
        </div>
    </header>

    <div class="container">
        <h1 style="font-size: 22px; font-weight: 700; margin-bottom: 24px;">Xác Nhận Thanh Toán & Đặt Hàng</h1>

        <form id="checkoutForm" onsubmit="handlePlaceOrder(event)">
            <div class="g2" style="align-items: flex-start;">
                <!-- Column 1: Shipping Info & Payment Methods -->
                <div class="card" style="padding: 24px;">
                    <h2 class="b" style="font-size: 16px; margin-bottom: 16px; color: var(--ink);">1. Thông tin giao hàng</h2>
                    
                    <div class="form-group">
                        <label class="form-label" for="receiver_name">Họ và tên người nhận</label>
                        <input type="text" id="receiver_name" class="form-control" value="Nguyễn Văn An" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="receiver_phone">Số điện thoại liên lạc</label>
                        <input type="tel" id="receiver_phone" class="form-control" value="0987 654 321" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="receiver_address">Địa chỉ nhận hàng chi tiết</label>
                        <input type="text" id="receiver_address" class="form-control" value="12 Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label" for="order_notes">Ghi chú giao hàng (tùy chọn)</label>
                        <textarea id="order_notes" class="form-control" rows="2" placeholder="Ví dụ: Giao giờ hành chính, gọi trước khi giao..."></textarea>
                    </div>

                    <h2 class="b" style="font-size: 16px; margin: 24px 0 14px; color: var(--ink);">2. Phương thức thanh toán</h2>
                    
                    <div class="col" style="gap: 10px;">
                        <label class="card" style="padding: 12px 16px; display: flex; align-items: center; gap: 12px; cursor: pointer; border-color: var(--ac); background: var(--ac-light);">
                            <input type="radio" name="payment_method" value="COD" checked style="accent-color: var(--ac);">
                            <div>
                                <div class="b" style="font-size: 13.5px;">◉ Thanh toán khi nhận hàng (COD)</div>
                                <div class="mute" style="font-size: 12px;">Nhận sách kiểm tra rồi thanh toán tiền mặt</div>
                            </div>
                        </label>

                        <label class="card" style="padding: 12px 16px; display: flex; align-items: center; gap: 12px; cursor: pointer;">
                            <input type="radio" name="payment_method" value="Chuyển khoản" style="accent-color: var(--ac);">
                            <div>
                                <div class="b" style="font-size: 13.5px;">○ Chuyển khoản ngân hàng (VietQR / MoMo)</div>
                                <div class="mute" style="font-size: 12px;">Quét mã QR chuyển khoản nhanh 24/7</div>
                            </div>
                        </label>
                    </div>
                </div>

                <!-- Column 2: Order Summary Card -->
                <div class="card" style="padding: 24px; background: #ffffff;">
                    <h2 class="b" style="font-size: 16px; margin-bottom: 16px; color: var(--ink); display: flex; justify-content: space-between;">
                        <span>Tóm tắt đơn hàng</span>
                        <span class="mute" style="font-size: 13px; font-weight: normal;" id="checkoutItemCount">(0 món)</span>
                    </h2>

                    <!-- Items List -->
                    <div class="col" id="checkoutItemsList" style="gap: 12px; border-bottom: 1px solid var(--line); padding-bottom: 16px; max-height: 240px; overflow-y: auto;">
                    </div>

                    <div class="col" style="gap: 10px; margin: 16px 0; font-size: 13.5px;">
                        <div class="row" style="justify-content: space-between;">
                            <span class="mute">Tiền hàng:</span>
                            <span id="checkoutSubtotal">0đ</span>
                        </div>
                        <div class="row" style="justify-content: space-between;">
                            <span class="mute">Phí vận chuyển:</span>
                            <span id="checkoutShipping">20.000đ</span>
                        </div>
                        <div class="row" style="justify-content: space-between;">
                            <span class="mute">Giảm giá:</span>
                            <span style="color: var(--success);">-0đ</span>
                        </div>
                    </div>

                    <hr style="border: none; border-top: 2px dashed var(--line); margin: 12px 0;">

                    <div class="row b" style="justify-content: space-between; font-size: 16px; margin-bottom: 24px;">
                        <span>Tổng thanh toán:</span>
                        <span id="checkoutGrandTotal" style="color: var(--ac); font-size: 22px;">0đ</span>
                    </div>

                    <button type="submit" class="btn btn-block" style="padding: 12px; font-size: 15px;">
                        Xác Nhận Đặt Hàng
                    </button>

                    <div class="c mute" style="font-size: 12px; margin-top: 14px;">
                        Đơn hàng sau khi đặt sẽ được đồng bộ ngay sang trang Quản Trị Viên!
                    </div>
                </div>
            </div>
        </form>
    </div>

    <footer>
        <p>© 2026 BookStore - Đồ án tốt nghiệp / Môn học Eclipse Web - Nhóm 9</p>
    </footer>

    <script src="${pageContext.request.contextPath}/resources/js/main.js?v=3"></script>
    <script>
        let currentSubtotal = 0;
        let currentTotal = 0;
        const shippingFee = 20000;

        function loadCheckoutData() {
            if (!Auth.isLoggedIn()) {
                showModalAlert('Vui lòng đăng nhập để tiến hành thanh toán và đặt hàng!', 'Yêu cầu đăng nhập', function() {
                    window.location.href = '${pageContext.request.contextPath}/login?redirect=thanhtoan';
                });
                return;
            }

            const user = Auth.getUser();
            if (user) {
                if (user.fullname) document.getElementById('receiver_name').value = user.fullname;
                if (user.phone) document.getElementById('receiver_phone').value = user.phone;
                if (user.address) document.getElementById('receiver_address').value = user.address;
            }

            const cart = DB.getCart();
            const listEl = document.getElementById('checkoutItemsList');

            if (cart.length === 0) {
                listEl.innerHTML = '<div class="mute c" style="padding: 16px;">Không có sản phẩm nào trong giỏ. Vui lòng quay lại chọn sách.</div>';
                return;
            }

            currentSubtotal = 0;
            listEl.innerHTML = cart.map(item => {
                const sub = item.price * item.qty;
                currentSubtotal += sub;
                const book = DB.getBookById(item.id);
                const img = item.image || (book ? book.image : '');
                const imgUrl = getBookImageUrl(img);
                const thumbHtml = imgUrl ? 
                    '<img src="' + imgUrl + '" alt="' + item.title + '" style="width: 100%; height: 100%; object-fit: cover;">' :
                    '<span style="font-size: 16px;">' + (item.icon || '📖') + '</span>';

                return `
                    <div class="row" style="justify-content: space-between; align-items: center; gap: 10px; margin-bottom: 8px;">
                        <div class="row" style="gap: 10px; align-items: center;">
                            <div style="width: 36px; height: 46px; border-radius: 4px; overflow: hidden; background: #e2e8f0; display: flex; align-items: center; justify-content: center; flex-shrink: 0; box-shadow: 0 1px 2px rgba(0,0,0,0.08);">
                                ` + thumbHtml + `
                            </div>
                            <div>
                                <div class="b" style="font-size: 13.5px;">` + item.title + `</div>
                                <div class="mute" style="font-size: 12px;">Số lượng: ` + item.qty + ` × ` + formatMoney(item.price) + `</div>
                            </div>
                        </div>
                        <span class="b">` + formatMoney(sub) + `</span>
                    </div>
                `;
            }).join('');

            currentTotal = currentSubtotal + shippingFee;
            document.getElementById('checkoutItemCount').innerText = '(' + cart.length + ' tựa sách)';
            document.getElementById('checkoutSubtotal').innerText = formatMoney(currentSubtotal);
            document.getElementById('checkoutShipping').innerText = formatMoney(shippingFee);
            document.getElementById('checkoutGrandTotal').innerText = formatMoney(currentTotal);
        }

        function handlePlaceOrder(e) {
            e.preventDefault();
            const cart = DB.getCart();
            if (cart.length === 0) {
                showModalAlert('Giỏ hàng của bạn đang trống! Vui lòng chọn sách trước.', 'Giỏ hàng trống');
                return;
            }

            const receiverName = document.getElementById('receiver_name').value;
            const receiverPhone = document.getElementById('receiver_phone').value;
            const receiverAddress = document.getElementById('receiver_address').value;
            const paymentMethod = document.querySelector('input[name="payment_method"]:checked')?.value || 'COD';

            const newOrder = DB.createOrder({
                customer: receiverName,
                phone: receiverPhone,
                address: receiverAddress,
                items: cart,
                subtotal: currentSubtotal,
                total: currentTotal,
                paymentMethod: paymentMethod
            });

            showModalAlert('🎉 ĐẶT HÀNG THÀNH CÔNG!\n\nMã đơn hàng của bạn là: ' + newOrder.id + '\nĐơn hàng đã được đồng bộ sang trang Quản trị viên.', 'Đặt hàng thành công', function() {
                window.location.href = '${pageContext.request.contextPath}/donhang';
            });
        }

        document.addEventListener('DOMContentLoaded', function() {
            loadCheckoutData();
        });
    </script>
</body>
</html>
