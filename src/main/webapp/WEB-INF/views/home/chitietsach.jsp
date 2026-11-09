<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết sách - BookStore</title>
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
        <!-- Breadcrumb -->
        <div style="font-size: 13px; margin-bottom: 20px; color: var(--mute);">
            <a href="${pageContext.request.contextPath}/trangchu" style="color: var(--mute); text-decoration: none;">Trang chủ</a> › 
            <span id="bc-category" style="color: var(--mute);">Văn học</span> › 
            <span id="bc-title" style="color: var(--ink); font-weight: 600;">Tên sách</span>
        </div>

        <!-- Main Product Card -->
        <div class="card" style="padding: 30px;">
            <div class="row" style="align-items: flex-start; gap: 32px; flex-wrap: wrap;">
                <!-- Book Cover Preview -->
                <div style="flex: 0 0 260px; max-width: 100%;">
                    <div id="bookCoverBox" class="book-cover" style="height: 340px; border-radius: var(--radius-md); box-shadow: var(--shadow);">
                        <div style="text-align: center;">
                            <span id="bookCoverIcon" style="font-size: 64px;">📖</span>
                            <div id="bookCoverTitle" style="font-weight: 700; font-size: 16px; margin-top: 10px; color: #1e293b;"></div>
                        </div>
                    </div>
                </div>

                <!-- Book Information -->
                <div class="col" style="flex: 1; min-width: 280px; gap: 16px;">
                    <div>
                        <span id="detailBadge" class="chip on" style="font-size: 11px; padding: 2px 10px; margin-bottom: 8px;">Văn học</span>
                        <h1 id="detailTitle" style="font-size: 24px; font-weight: 700; color: var(--ink); margin-top: 4px;">Cây Cam Ngọt Của Tôi</h1>
                        <p class="mute" style="margin-top: 4px; font-size: 13.5px;">
                            Tác giả: <strong id="detailAuthor" style="color: var(--ink);">José Mauro de Vasconcelos</strong> · NXB: <strong id="detailPublisher" style="color: var(--ink);">NXB Hội Nhà Văn</strong>
                        </p>
                    </div>

                    <!-- Price Box -->
                    <div style="background: var(--ph); padding: 16px 20px; border-radius: var(--radius-sm); display: flex; align-items: baseline; gap: 16px;">
                        <span id="detailPrice" style="font-size: 28px; font-weight: 700; color: var(--ac);">95.000đ</span>
                        <span id="detailOldPrice" style="font-size: 15px; color: #94a3b8; text-decoration: line-through;">108.000đ</span>
                        <span class="st st-done" style="font-size: 12px;">Đang có ưu đãi</span>
                    </div>

                    <!-- Stock Status -->
                    <div class="row" style="font-size: 13.5px;">
                        <span class="mute">Tình trạng:</span>
                        <span id="detailStock" style="color: var(--success); font-weight: 600;">● Còn 24 cuốn trong kho</span>
                    </div>

                    <!-- Quantity selection -->
                    <div class="row" style="gap: 16px;">
                        <span class="mute" style="font-weight: 500;">Số lượng mua:</span>
                        <div class="qty-box">
                            <button type="button" class="qty-btn" onclick="adjustDetailQty(-1)">–</button>
                            <input type="text" class="qty-val" id="book-qty" value="1" readonly>
                            <button type="button" class="qty-btn" onclick="adjustDetailQty(1)">+</button>
                        </div>
                    </div>

                    <!-- Actions -->
                    <div class="row" style="gap: 14px; margin-top: 10px;">
                        <button class="btn" style="padding: 12px 28px; font-size: 14px;" onclick="handleAddDetailToCart()">
                            <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M11 9h2V6h3V4h-3V1h-2v3H8v2h3v3zm-4 9c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zm10 0c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2zm-9.83-3.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.86-7.01L19.42 4h-.01l-1.1 2-2.76 5H8.53l-.13-.27L6.16 6l-.95-2-.94-2H1v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.13 0-.25-.11-.25-.25z"/></svg>
                            Thêm vào giỏ
                        </button>
                        <button class="btn o" style="padding: 12px 28px; font-size: 14px; font-weight: 700;" onclick="handleBuyNow()">
                            Mua ngay
                        </button>
                    </div>
                </div>
            </div>

            <hr style="border: none; border-top: 1px solid var(--line); margin: 30px 0;">

            <!-- Book Description -->
            <div>
                <h3 style="font-size: 18px; margin-bottom: 12px; color: var(--ink);">Mô tả & Giới thiệu nội dung</h3>
                <div id="detailDesc" style="line-height: 1.8; color: var(--ink-light); background: #fdfdfd; padding: 20px; border-radius: var(--radius-sm); border: 1px solid var(--line);">
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>© 2026 BookStore - Đồ án tốt nghiệp / Môn học Eclipse Web - Nhóm 9</p>
    </footer>

    <script src="${pageContext.request.contextPath}/resources/js/main.js?v=3"></script>
    <script>
        let currentBookId = '${bookId}' || 'S01';

        function loadBookDetail() {
            const params = new URLSearchParams(window.location.search);
            const bookId = params.get('id') || currentBookId || 'S01';
            currentBookId = bookId;

            const book = DB.getBookById(bookId) || DB.getBooks()[0];
            if (!book) return;

            document.getElementById('bc-category').innerText = book.category;
            document.getElementById('bc-title').innerText = book.title;

            const coverBox = document.getElementById('bookCoverBox');
            const imgUrl = getBookImageUrl(book.image);
            if (imgUrl) {
                coverBox.style.background = 'transparent';
                coverBox.style.overflow = 'hidden';
                coverBox.innerHTML = '<img src="' + imgUrl + '" alt="' + book.title + '" style="width: 100%; height: 100%; object-fit: cover; border-radius: var(--radius-md); box-shadow: 0 4px 12px rgba(0,0,0,0.15);">';
            } else {
                coverBox.style.background = book.bg || 'linear-gradient(135deg, #fbc2eb 0%, #a6c1ee 100%)';
                coverBox.innerHTML = '<div style="text-align: center;"><span id="bookCoverIcon" style="font-size: 64px;">' + (book.icon || '📖') + '</span><div id="bookCoverTitle" style="font-weight: 700; font-size: 16px; margin-top: 10px; color: #1e293b;">' + book.title + '</div></div>';
            }

            document.getElementById('detailBadge').innerText = book.category;
            document.getElementById('detailTitle').innerText = book.title;
            document.getElementById('detailAuthor').innerText = book.author;
            document.getElementById('detailPublisher').innerText = book.publisher || 'NXB Trẻ';

            document.getElementById('detailPrice').innerText = formatMoney(book.price);
            document.getElementById('detailOldPrice').innerText = book.oldPrice ? formatMoney(book.oldPrice) : '';
            document.getElementById('detailStock').innerHTML = '● Còn <strong>' + book.stock + '</strong> cuốn trong kho';
            document.getElementById('detailDesc').innerHTML = '<p>' + (book.desc || 'Cuốn sách mang đến những tri thức và góc nhìn mới mẻ cho độc giả.') + '</p>';
        }

        function adjustDetailQty(delta) {
            const input = document.getElementById('book-qty');
            let val = parseInt(input.value) || 1;
            val = Math.max(1, val + delta);
            input.value = val;
        }

        function handleAddDetailToCart() {
            const qty = parseInt(document.getElementById('book-qty').value) || 1;
            DB.addToCart(currentBookId, qty);
            showToast('Đã thêm ' + qty + ' cuốn vào giỏ hàng!');
        }

        function handleBuyNow() {
            const qty = parseInt(document.getElementById('book-qty').value) || 1;
            DB.addToCart(currentBookId, qty);
            if (!Auth.isLoggedIn()) {
                showModalAlert('Vui lòng đăng nhập tài khoản để tiến hành thanh toán và đặt hàng!', 'Yêu cầu đăng nhập', function() {
                    window.location.href = '${pageContext.request.contextPath}/login?redirect=thanhtoan';
                });
                return;
            }
            window.location.href = '${pageContext.request.contextPath}/thanhtoan';
        }

        document.addEventListener('DOMContentLoaded', function() {
            loadBookDetail();
        });
    </script>
</body>
</html>
