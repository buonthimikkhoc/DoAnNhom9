<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="vi">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giỏ hàng của bạn - BookStore</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
    </head>

    <body>



        <!-- Navigation Header -->
        <header class="main-nav">
            <a href="${pageContext.request.contextPath}/trangchu" class="brand-logo">
                <svg viewBox="0 0 24 24">
                    <path
                        d="M18 2H6c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM6 4h5v8l-2.5-1.5L6 12V4z" />
                </svg>
                BookStore
            </a>
            <!-- Logo nhấn về trang chủ -->
            <div class="nav-right">
                <a href="${pageContext.request.contextPath}/giohang" class="nav-cart-btn active">
                    <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor">
                        <path
                            d="M7 18c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zM1 2v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.14 0-.25-.11-.25-.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.58-6.49c.08-.14.12-.31.12-.48 0-.55-.45-1-1-1H5.21l-.94-2H1zm16 16c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2z" />
                    </svg>
                    Giỏ hàng <span class="cart-badge" id="nav-cart-count">0</span>
                </a>
                <a href="${pageContext.request.contextPath}/taikhoan" class="user-menu-btn">
                    <span class="avatar-sm">A</span>
                    <span>Xin chào, An ▾</span>
                </a>
            </div>
        </header>

        <div class="container">
            <div style="display: flex; align-items: baseline; justify-content: space-between; margin-bottom: 20px;">
                <h1 style="font-size: 22px; font-weight: 700;">Giỏ Hàng Mua Sắm</h1>
                <span class="mute" id="cart-item-count">Đang tải giỏ hàng...</span>
            </div>

            <div class="card" style="padding: 24px;">
                <!-- Cart Table -->
                <div class="table-container" style="border: none;">
                    <table class="t" id="cart-table">
                        <thead>
                            <tr>
                                <th style="width: 45%;">Sản phẩm sách</th>
                                <th style="width: 15%;">Đơn giá</th>
                                <th style="width: 15%; text-align: center;">Số lượng</th>
                                <th style="width: 15%; text-align: right;">Thành tiền</th>
                                <th style="width: 10%; text-align: center;">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody id="cartTableBody">
                        </tbody>
                    </table>
                </div>

                <hr style="border: none; border-top: 1px solid var(--line); margin: 24px 0 16px;">

                <!-- Total and Next actions -->
                <div style="display: flex; flex-direction: column; align-items: flex-end; gap: 8px;">
                    <div class="mute" style="font-size: 13px;">Tạm tính: <span id="cart-temp-total">0đ</span></div>
                    <div class="r b" style="font-size: 18px; color: var(--ink);">
                        Tổng thanh toán: <span id="cart-grand-total"
                            style="color: var(--ac); font-size: 22px;">0đ</span>
                    </div>
                </div>

                <div class="row" style="justify-content: space-between; margin-top: 24px;">
                    <a href="${pageContext.request.contextPath}/trangchu" class="btn o">
                        ‹ Tiếp tục mua sách
                    </a>
                    <button type="button" class="btn" style="padding: 11px 28px;" onclick="proceedToCheckout()">
                        Tiến hành thanh toán ›
                    </button>
                </div>
            </div>
        </div>

        <footer>
            <p>© 2026 BookStore - Đồ án tốt nghiệp / Môn học Eclipse Web - Nhóm 9</p>
        </footer>

        <script src="${pageContext.request.contextPath}/resources/js/main.js?v=3"></script>
        <script>
            function renderCart() {
                const cart = DB.getCart();
                const tbody = document.getElementById('cartTableBody');

                if (cart.length === 0) {
                    tbody.innerHTML = '<tr><td colspan="5" class="c mute" style="padding: 30px;">Giỏ hàng của bạn đang trống. Hãy quay lại Trang chủ để chọn sách nhé!</td></tr>';
                    document.getElementById('cart-temp-total').innerText = '0đ';
                    document.getElementById('cart-grand-total').innerText = '0đ';
                    document.getElementById('cart-item-count').innerText = 'Giỏ hàng (0)';
                    return;
                }

                let total = 0;
                tbody.innerHTML = cart.map(item => {
                    const subtotal = item.price * item.qty;
                    total += subtotal;
                    const book = DB.getBookById(item.id);
                    const img = item.image || (book ? book.image : '');
                    const imgUrl = getBookImageUrl(img);
                    const thumbHtml = imgUrl ?
                        '<img src="' + imgUrl + '" alt="' + item.title + '" style="width: 100%; height: 100%; object-fit: cover;">' :
                        '<span style="font-size: 22px;">' + (item.icon || '📖') + '</span>';

                    return `
                    <tr>
                        <td>
                            <div class="row">
                                <div style="width: 44px; height: 56px; border-radius: 4px; overflow: hidden; background: #e2e8f0; display: flex; align-items: center; justify-content: center; flex-shrink: 0; box-shadow: 0 1px 3px rgba(0,0,0,0.1);">
                                    ` + thumbHtml + `
                                </div>
                                <div>
                                    <div class="b" style="font-size: 14px;">` + item.title + `</div>
                                    <div class="mute" style="font-size: 12px;">Mã: ` + item.id + `</div>
                                </div>
                            </div>
                        </td>
                        <td>` + formatMoney(item.price) + `</td>
                        <td style="text-align: center;">
                            <div class="qty-box">
                                <button type="button" class="qty-btn" onclick="changeQty('` + item.id + `', -1)">–</button>
                                <input type="text" class="qty-val" value="` + item.qty + `" readonly>
                                <button type="button" class="qty-btn" onclick="changeQty('` + item.id + `', 1)">+</button>
                            </div>
                        </td>
                        <td style="text-align: right; font-weight: 700; color: var(--ac);">
                            ` + formatMoney(subtotal) + `
                        </td>
                        <td style="text-align: center;">
                            <button type="button" class="btn o btn-sm" onclick="removeItem('` + item.id + `')" title="Xóa" style="color: var(--danger); border-color: transparent;">✕</button>
                        </td>
                    </tr>
                `;
                }).join('');

                document.getElementById('cart-temp-total').innerText = formatMoney(total);
                document.getElementById('cart-grand-total').innerText = formatMoney(total);
                document.getElementById('cart-item-count').innerText = 'Có ' + cart.length + ' tựa sách trong giỏ (' + DB.getCartTotalCount() + ' cuốn)';
            }

            function changeQty(bookId, delta) {
                const cart = DB.getCart();
                const item = cart.find(i => i.id === bookId);
                if (item) {
                    const newQty = item.qty + delta;
                    if (newQty <= 0) {
                        removeItem(bookId);
                    } else {
                        DB.updateCartQty(bookId, newQty);
                        renderCart();
                    }
                }
            }

            function removeItem(bookId) {
                showModalConfirm('Bạn có chắc muốn xóa cuốn sách này khỏi giỏ hàng?', function () {
                    DB.removeFromCart(bookId);
                    showToast('Đã xóa sách khỏi giỏ hàng', 'danger');
                    renderCart();
                }, null, { title: 'Xóa khỏi giỏ hàng', confirmText: 'Xóa sách', confirmDanger: true });
            }

            function proceedToCheckout() {
                const cart = DB.getCart();
                if (cart.length === 0) {
                    showModalAlert('Giỏ hàng của bạn đang trống! Vui lòng chọn ít nhất 1 cuốn sách để thanh toán.', 'Giỏ hàng trống');
                    return;
                }
                if (!Auth.isLoggedIn()) {
                    showModalAlert('Vui lòng đăng nhập tài khoản để tiếp tục thanh toán và đặt hàng!', 'Yêu cầu đăng nhập', function () {
                        window.location.href = '${pageContext.request.contextPath}/login?redirect=thanhtoan';
                    });
                    return;
                }
                window.location.href = '${pageContext.request.contextPath}/thanhtoan';
            }

            document.addEventListener('DOMContentLoaded', function () {
                renderCart();
            });
        </script>
    </body>

    </html>