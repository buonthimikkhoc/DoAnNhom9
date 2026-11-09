/**
 * DoAn-NHOM9 - JavaScript Tiện Ích & Render Giao Diện
 * Tách biệt hoàn toàn khỏi JSP để tránh xung đột cú pháp JSP EL
 */

function getBookImageUrl(img) {
  if (!img) return '';
  if (img.startsWith('http://') || img.startsWith('https://') || img.startsWith('data:')) return img;
  var root = (typeof window !== 'undefined' && typeof window.APP_CONTEXT_PATH === 'string')
    ? window.APP_CONTEXT_PATH
    : ((typeof Auth !== 'undefined' && Auth.getAppRoot) ? Auth.getAppRoot() : '/DoAn-NHOM9');
  if (root.endsWith('/')) root = root.slice(0, -1);
  var cleanPath = img.startsWith('/') ? img : ('/' + img);
  if (root && !cleanPath.startsWith(root + '/') && cleanPath !== root) {
    cleanPath = root + cleanPath;
  }
  try {
    cleanPath = decodeURI(cleanPath);
  } catch (e) {}
  return encodeURI(cleanPath);
}

// ====================== 1. SEED DATA ======================
const INITIAL_BOOKS = [
  // --- VĂN HỌC & TIỂU THUYẾT ---
  { 
    id: 'S01', 
    title: 'Cây Cam Ngọt Của Tôi', 
    author: 'José Mauro de Vasconcelos', 
    publisher: 'NXB Hội Nhà Văn', 
    category: 'Văn học', 
    price: 95000, 
    oldPrice: 108000, 
    stock: 45, 
    badge: 'Bán chạy', 
    icon: '📖', 
    image: 'resources/images/books/Cây Cam Ngọt Của Tôi.png',
    bg: 'linear-gradient(135deg, #fbc2eb 0%, #a6c1ee 100%)', 
    desc: 'Tác phẩm kinh điển bán tự truyện của nhà văn Brazil José Mauro de Vasconcelos về cậu bé Zezé thông minh và nhạy cảm.' 
  },
  { 
    id: 'S02', 
    title: 'Nhà Giả Kim (Tái Bản 2026)', 
    author: 'Paulo Coelho', 
    publisher: 'NXB Hội Nhà Văn', 
    category: 'Văn học', 
    price: 120000, 
    oldPrice: 135000, 
    stock: 38, 
    badge: 'Hot', 
    icon: '📘', 
    image: 'resources/images/books/Nhà Giả Kim.png',
    bg: 'linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%)', 
    desc: 'Hành trình đi tìm kho báu và lẽ sống của chàng chăn cừu Santiago qua sa mạc mênh mông.' 
  },
  { 
    id: 'S07', 
    title: 'Chiến Binh Cầu Vồng', 
    author: 'Andrea Hirata', 
    publisher: 'NXB Hội Nhà Văn', 
    category: 'Văn học', 
    price: 109000, 
    oldPrice: 125000, 
    stock: 32, 
    badge: 'Bán chạy', 
    icon: '🌈', 
    image: 'resources/images/books/Chiến Binh Cầu Vồng.png',
    bg: 'linear-gradient(135deg, #f6d365 0%, #fda085 100%)', 
    desc: 'Bức tranh cảm động và tràn đầy hy vọng về ước mơ đến trường của những đứa trẻ nghèo đảo Belitong.' 
  },
  { 
    id: 'S08', 
    title: 'Muôn Kiếp Nhân Sinh - Tập 1', 
    author: 'Nguyên Phong', 
    publisher: 'NXB Tổng Hợp TPHCM', 
    category: 'Văn học', 
    price: 168000, 
    oldPrice: 188000, 
    stock: 27, 
    badge: 'Hot', 
    icon: '🔮', 
    image: 'resources/images/books/Muôn Kiếp Nhân Sinh.png',
    bg: 'linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%)', 
    desc: 'Tác phẩm vén bức màn bí mật về tiền kiếp, nhân quả và hành trình chuyển hóa tâm thức.' 
  },
  { 
    id: 'S09', 
    title: 'Bắt Trẻ Đồng Xanh', 
    author: 'J.D. Salinger', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 85000, 
    oldPrice: 98000, 
    stock: 20, 
    badge: 'Kinh điển', 
    icon: '🌾', 
    image: 'resources/images/books/Bắt Trẻ Đồng Xanh.png',
    bg: 'linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%)', 
    desc: 'Khúc ca nổi loạn, trăn trở và chân thực của tuổi trẻ trước thế giới người lớn giả tạo.' 
  },
  { 
    id: 'S10', 
    title: 'Không Gia Đình', 
    author: 'Hector Malot', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 135000, 
    oldPrice: 155000, 
    stock: 25, 
    badge: 'Kinh điển', 
    icon: '🎪', 
    image: 'resources/images/books/Không Gia Đình.png',
    bg: 'linear-gradient(135deg, #fbc2eb 0%, #a18cd1 100%)', 
    desc: 'Cuộc phiêu lưu đầy sóng gió, tình yêu thương và nghị lực phi thường của cậu bé Rémi mồ côi.' 
  },
  { 
    id: 'S21', 
    title: 'Bố Già (The Godfather)', 
    author: 'Mario Puzo', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 135000, 
    oldPrice: 155000, 
    stock: 40, 
    badge: 'Hot', 
    icon: '🎩', 
    image: 'resources/images/books/Bố Già.png',
    bg: 'linear-gradient(135deg, #e0c3fc 0%, #8ec5fc 100%)', 
    desc: 'Tiểu thuyết kinh điển về gia tộc mafia Corleone và những quy luật sinh tồn khắc nghiệt trong thế giới ngầm.' 
  },
  { 
    id: 'S31', 
    title: 'Bá Tước Monte Cristo', 
    author: 'Alexandre Dumas', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 175000, 
    oldPrice: 210000, 
    stock: 30, 
    badge: 'Kinh điển', 
    icon: '⚔️', 
    image: 'resources/images/books/Bá Tước Monte Cristo.png',
    bg: 'linear-gradient(135deg, #fbc2eb 0%, #a6c1ee 100%)', 
    desc: 'Bản hùng ca về sự phản bội, niềm hy vọng và cuộc báo thù vĩ đại nhất lịch sử văn học thế giới.' 
  },
  { 
    id: 'S32', 
    title: 'Chiến Tranh Và Hòa Bình', 
    author: 'Leo Tolstoy', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 260000, 
    oldPrice: 295000, 
    stock: 24, 
    badge: 'Đề cử', 
    icon: '📜', 
    image: 'resources/images/books/Chiến Tranh Và Hòa Bình.png',
    bg: 'linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%)', 
    desc: 'Đại sử thi bất hủ khắc họa toàn cảnh xã hội Nga qua các cuộc chiến tranh Napoléon oanh liệt.' 
  },
  { 
    id: 'S33', 
    title: 'Trăm Năm Cô Đơn', 
    author: 'Gabriel García Márquez', 
    publisher: 'NXB Hội Nhà Văn', 
    category: 'Văn học', 
    price: 145000, 
    oldPrice: 168000, 
    stock: 35, 
    badge: 'Nobel', 
    icon: '🦋', 
    image: 'resources/images/books/Trăm Năm Cô Đơn.png',
    bg: 'linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%)', 
    desc: 'Kiệt tác hiện thực huyền ảo về bảy thế hệ thăng trầm của dòng họ Buendía tại ngôi làng Macondo.' 
  },
  { 
    id: 'S34', 
    title: 'Tội Ác Và Trừng Phạt', 
    author: 'Fyodor Dostoevsky', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 155000, 
    oldPrice: 180000, 
    stock: 28, 
    badge: 'Kinh điển', 
    icon: '⚖️', 
    image: 'resources/images/books/Tội Ác Và Trừng Phạt.png',
    bg: 'linear-gradient(135deg, #a18cd1 0%, #fbc2eb 100%)', 
    desc: 'Hành trình đấu tranh tâm lý dữ dội và sự chuộc tội thiêng liêng của chàng sinh viên nghèo Raskolnikov.' 
  },
  { 
    id: 'S35', 
    title: 'Hai Số Phận (Kane and Abel)', 
    author: 'Jeffrey Archer', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 149000, 
    oldPrice: 175000, 
    stock: 36, 
    badge: 'Bán chạy', 
    icon: '👥', 
    image: 'resources/images/books/Hai Số Phận.png',
    bg: 'linear-gradient(135deg, #f6d365 0%, #fda085 100%)', 
    desc: 'Cuộc đối đầu kịch tính kéo dài suốt đời của hai người đàn ông sinh cùng ngày nhưng mang hai số phận trái ngược.' 
  },
  { 
    id: 'S36', 
    title: 'Người Đua Diều', 
    author: 'Khaled Hosseini', 
    publisher: 'NXB Nhã Nam', 
    category: 'Văn học', 
    price: 125000, 
    oldPrice: 145000, 
    stock: 32, 
    badge: 'Best Seller', 
    icon: '🪁', 
    image: 'resources/images/books/Người Đua Diều.png',
    bg: 'linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)', 
    desc: 'Câu chuyện lay động tâm can về tình bạn, sự phản bội và hành trình chuộc lỗi giữa lòng Afghanistan hoang tàn.' 
  },
  { 
    id: 'S37', 
    title: 'Những Cuộc Phiêu Lưu Của Sherlock Holmes', 
    author: 'Arthur Conan Doyle', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 135000, 
    oldPrice: 160000, 
    stock: 45, 
    badge: 'Trinh thám', 
    icon: '🔍', 
    image: 'resources/images/books/Những Cuộc Phiêu Lưu Của Sherlock Holmes.png',
    bg: 'linear-gradient(135deg, #cfd9df 0%, #e2ebf0 100%)', 
    desc: 'Các vụ án kỳ bí và tài năng suy luận logic trác tuyệt của vị thám tử lừng danh nhất mọi thời đại.' 
  },
  { 
    id: 'S38', 
    title: 'Mật Mã Da Vinci', 
    author: 'Dan Brown', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 155000, 
    oldPrice: 185000, 
    stock: 34, 
    badge: 'Hot', 
    icon: '🗝️', 
    image: 'resources/images/books/Mật Mã Da Vinci.png',
    bg: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', 
    desc: 'Hành trình nghẹt thở giải mã bức tranh nàng Mona Lisa và bí mật ngàn năm của Chén Thánh.' 
  },
  { 
    id: 'S39', 
    title: 'Rừng Na Uy', 
    author: 'Haruki Murakami', 
    publisher: 'NXB Hội Nhà Văn', 
    category: 'Văn học', 
    price: 128000, 
    oldPrice: 150000, 
    stock: 38, 
    badge: 'Hot', 
    icon: '🌲', 
    image: 'resources/images/books/Rừng Na Uy.png',
    bg: 'linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)', 
    desc: 'Nỗi cô đơn, hoài niệm và những rung cảm sâu kín của tuổi trẻ Tokyo trong thập niên 1960.' 
  },
  { 
    id: 'S40', 
    title: 'Đại Gia Gatsby', 
    author: 'F. Scott Fitzgerald', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 95000, 
    oldPrice: 115000, 
    stock: 30, 
    badge: 'Kinh điển', 
    icon: '🍸', 
    image: 'resources/images/books/Đại Gia Gatsby.png',
    bg: 'linear-gradient(135deg, #fdcbf1 0%, #e6c875 100%)', 
    desc: 'Bức tranh tráng lệ nhưng u uất về Giấc Mơ Mỹ trong Kỷ Nguyên Nhạc Jazz hào nhoáng.' 
  },
  { 
    id: 'S41', 
    title: 'Ông Già Và Biển Cả', 
    author: 'Ernest Hemingway', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 75000, 
    oldPrice: 90000, 
    stock: 42, 
    badge: 'Nobel', 
    icon: '⛵', 
    image: 'resources/images/books/Ông Già Và Biển Cả.png',
    bg: 'linear-gradient(135deg, #a1c4fd 0%, #c2e9fb 100%)', 
    desc: 'Ý chí kiên cường và lòng quả cảm phi thường của con người trước sức mạnh dữ dội của biển khơi.' 
  },
  { 
    id: 'S42', 
    title: 'Đồi Gió Hú', 
    author: 'Emily Brontë', 
    publisher: 'NXB Văn Học', 
    category: 'Văn học', 
    price: 118000, 
    oldPrice: 140000, 
    stock: 26, 
    badge: 'Kinh điển', 
    icon: '🌪️', 
    image: 'resources/images/books/Đồi Gió Hú.png',
    bg: 'linear-gradient(135deg, #cfd9df 0%, #e2ebf0 100%)', 
    desc: 'Mối tình cuồng si, bi thương và đầy hận thù giữa Heathcliff và Catherine trên đồng cỏ hoang dại.' 
  },

  // --- KỸ NĂNG & PHÁT TRIỂN BẢN THÂN ---
  { 
    id: 'S04', 
    title: 'Đắc Nhân Tâm (Khổ Lớn)', 
    author: 'Dale Carnegie', 
    publisher: 'NXB Trẻ', 
    category: 'Kỹ năng', 
    price: 86000, 
    oldPrice: 105000, 
    stock: 50, 
    badge: 'Hot', 
    icon: '📗', 
    image: 'resources/images/books/Đắc Nhân Tâm.png',
    bg: 'linear-gradient(135deg, #e0c3fc 0%, #8ec5fc 100%)', 
    desc: 'Cuốn sách nghệ thuật thu phục lòng người và giao tiếp ứng xử bán chạy nhất mọi thời đại.' 
  },
  { 
    id: 'S11', 
    title: 'Thói Quen Nguyên Tử (Atomic Habits)', 
    author: 'James Clear', 
    publisher: 'NXB Thế Giới', 
    category: 'Kỹ năng', 
    price: 149000, 
    oldPrice: 189000, 
    stock: 65, 
    badge: 'Best Seller', 
    icon: '⚡', 
    image: 'resources/images/books/Thói Quen Nguyên Tử.png',
    bg: 'linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)', 
    desc: 'Phương pháp khoa học xây dựng thói quen tốt và loại bỏ thói quen xấu từng bước mỗi ngày.' 
  },
  { 
    id: 'S12', 
    title: 'Đi Tìm Lẽ Sống (Man\'s Search for Meaning)', 
    author: 'Viktor Frankl', 
    publisher: 'NXB Tổng Hợp TPHCM', 
    category: 'Kỹ năng', 
    price: 92000, 
    oldPrice: 110000, 
    stock: 42, 
    badge: 'Kinh điển', 
    icon: '🕊️', 
    image: 'resources/images/books/Đi Tìm Lẽ Sống.png',
    bg: 'linear-gradient(135deg, #ff9a9e 0%, #fecfef 100%)', 
    desc: 'Tìm kiếm ý nghĩa cuộc sống ngay cả giữa những bi kịch tột cùng nhất của kiếp nhân sinh.' 
  },
  { 
    id: 'S13', 
    title: 'Suối Nguồn (The Fountainhead)', 
    author: 'Ayn Rand', 
    publisher: 'NXB Trẻ', 
    category: 'Kỹ năng', 
    price: 198000, 
    oldPrice: 235000, 
    stock: 30, 
    badge: 'Đề cử', 
    icon: '🏛️', 
    image: 'resources/images/books/Suối Nguồn.png',
    bg: 'linear-gradient(135deg, #cfd9df 0%, #e2ebf0 100%)', 
    desc: 'Bản tuyên ngôn hùng hồn về chủ nghĩa cá nhân, tinh thần độc lập và sự kiên định với lý tưởng sáng tạo.' 
  },
  { 
    id: 'S14', 
    title: 'Tư Duy Nhanh Và Chậm (Thinking, Fast and Slow)', 
    author: 'Daniel Kahneman', 
    publisher: 'NXB Thế Giới', 
    category: 'Kỹ năng', 
    price: 185000, 
    oldPrice: 220000, 
    stock: 18, 
    badge: 'Đề cử', 
    icon: '🧠', 
    image: 'resources/images/books/Tư Duy Nhanh Và Chậm.png',
    bg: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', 
    desc: 'Tác phẩm đạt giải Nobel khám phá hai hệ thống chi phối cách con người tư duy và ra quyết định.' 
  },
  { 
    id: 'S26', 
    title: 'Tuổi Trẻ Đáng Giá Bao Nhiêu?', 
    author: 'Rosie Nguyễn', 
    publisher: 'NXB Hội Nhà Văn', 
    category: 'Kỹ năng', 
    price: 85000, 
    oldPrice: 99000, 
    stock: 45, 
    badge: 'Best Seller', 
    icon: '🌱', 
    image: 'resources/images/books/Tuổi Trẻ Đáng Giá Bao Nhiêu.png',
    bg: 'linear-gradient(135deg, #a8edea 0%, #fed6e3 100%)', 
    desc: 'Cuốn sách truyền cảm hứng sống, học tập và rèn luyện bản thân mạnh mẽ nhất dành cho các bạn trẻ.' 
  },
  { 
    id: 'S27', 
    title: 'Suy Tưởng (Meditations)', 
    author: 'Marcus Aurelius', 
    publisher: 'NXB Thế Giới', 
    category: 'Kỹ năng', 
    price: 110000, 
    oldPrice: 130000, 
    stock: 28, 
    badge: 'Triết học', 
    icon: '🏛️', 
    image: 'resources/images/books/Suy Tưởng.png',
    bg: 'linear-gradient(135deg, #fbc2eb 0%, #a6c1ee 100%)', 
    desc: 'Chiêm nghiệm sâu sắc của vị hoàng đế La Mã về tinh thần khắc kỷ, bình thản trước mọi nghịch cảnh.' 
  },

  // --- KINH TẾ & TÀI CHÍNH ---
  { 
    id: 'S15', 
    title: 'Từ Tốt Đến Vĩ Đại (Good to Great)', 
    author: 'Jim Collins', 
    publisher: 'NXB Trẻ', 
    category: 'Kinh tế', 
    price: 135000, 
    oldPrice: 160000, 
    stock: 35, 
    badge: 'Best Seller', 
    icon: '📈', 
    image: 'resources/images/books/Từ Tốt Đến Vĩ Đại.png',
    bg: 'linear-gradient(135deg, #f6d365 0%, #fda085 100%)', 
    desc: 'Nghiên cứu mang tính đột phá lý giải vì sao một số công ty đạt bước nhảy vọt phi thường còn số khác thì không.' 
  },
  { 
    id: 'S16', 
    title: 'Tâm Lý Học Về Tiền (The Psychology of Money)', 
    author: 'Morgan Housel', 
    publisher: 'NXB Dân Trí', 
    category: 'Kinh tế', 
    price: 138000, 
    oldPrice: 165000, 
    stock: 48, 
    badge: 'Hot', 
    icon: '💵', 
    image: 'resources/images/books/Tâm Lý Học Về Tiền.png',
    bg: 'linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%)', 
    desc: 'Những bài học vượt thời gian về sự giàu có, lòng tham và hạnh phúc trong quản lý tài chính cá nhân.' 
  },
  { 
    id: 'S28', 
    title: 'Nghĩ Giàu Và Làm Giàu (Think and Grow Rich)', 
    author: 'Napoleon Hill', 
    publisher: 'NXB Trẻ', 
    category: 'Kinh tế', 
    price: 99000, 
    oldPrice: 120000, 
    stock: 40, 
    badge: 'Kinh điển', 
    icon: '🏆', 
    image: 'resources/images/books/Nghĩ Giàu Làm Giàu.png',
    bg: 'linear-gradient(135deg, #f6d365 0%, #fda085 100%)', 
    desc: 'Triết lý làm giàu vĩ đại đúc kết từ 500 nhân vật kiệt xuất nhất thế giới.' 
  },

  // --- THIẾU NHI & TUỔI THƠ ---
  { 
    id: 'S03', 
    title: 'Hoàng Tử Bé', 
    author: 'Antoine de Saint-Exupéry', 
    publisher: 'NXB Kim Đồng', 
    category: 'Thiếu nhi', 
    price: 68000, 
    oldPrice: 85000, 
    stock: 45, 
    badge: 'Giảm 25%', 
    icon: '📙', 
    image: 'resources/images/books/Hoàng Tử Bé.png',
    bg: 'linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%)', 
    desc: 'Câu chuyện triết lý nhẹ nhàng sâu sắc về tình bạn, tình yêu và trách nhiệm từ tiểu hành tinh B612.' 
  },
  { 
    id: 'S20', 
    title: 'Dế Mèn Phiêu Lưu Ký', 
    author: 'Tô Hoài', 
    publisher: 'NXB Kim Đồng', 
    category: 'Thiếu nhi', 
    price: 65000, 
    oldPrice: 80000, 
    stock: 50, 
    badge: 'Kinh điển', 
    icon: '🦗', 
    image: 'resources/images/books/Dế Mèn Phiêu Lưu Ký.png',
    bg: 'linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%)', 
    desc: 'Kiệt tác văn học thiếu nhi Việt Nam kể về hành trình chu du bốn phương và bài học trưởng thành của Dế Mèn.' 
  },
  { 
    id: 'S19', 
    title: 'Totto-chan Bên Cửa Sổ', 
    author: 'Tetsuko Kuroyanagi', 
    publisher: 'NXB Kim Đồng', 
    category: 'Thiếu nhi', 
    price: 88000, 
    oldPrice: 105000, 
    stock: 35, 
    badge: 'Yêu thích', 
    icon: '🌸', 
    image: 'resources/images/books/Totto-chan Bên Cửa Sổ.png',
    bg: 'linear-gradient(135deg, #fbc2eb 0%, #a6c1ee 100%)', 
    desc: 'Phương pháp giáo dục diệu kỳ và ấm áp tình thương tại ngôi trường Tomoe với những toa tàu điện.' 
  },

  // --- LỊCH SỬ & KHOA HỌC ---
  { 
    id: 'S05', 
    title: 'Lược Sử Loài Người - Sapiens', 
    author: 'Yuval Noah Harari', 
    publisher: 'NXB Tri Thức', 
    category: 'Lịch sử', 
    price: 189000, 
    oldPrice: 220000, 
    stock: 25, 
    badge: 'Đề cử', 
    icon: '📕', 
    image: 'resources/images/books/Sapiens - Lược Sử Loài Người.png',
    bg: 'linear-gradient(135deg, #f093fb 0%, #f5576c 100%)', 
    desc: 'Cái nhìn toàn diện và sâu sắc về lịch sử tiến hóa và văn minh của loài người.' 
  },
  { 
    id: 'S22', 
    title: '1984', 
    author: 'George Orwell', 
    publisher: 'NXB Hội Nhà Văn', 
    category: 'Lịch sử', 
    price: 115000, 
    oldPrice: 135000, 
    stock: 22, 
    badge: 'Kinh điển', 
    icon: '👁️', 
    image: 'resources/images/books/1984.png',
    bg: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)', 
    desc: 'Kiệt tác phản địa đàng cảnh báo về sự tha hóa của quyền lực và tương lai bị giám sát toàn diện.' 
  },
  { 
    id: 'S23', 
    title: 'Vũ Trụ Trong Vỏ Hạt Dẻ', 
    author: 'Stephen Hawking', 
    publisher: 'NXB Trẻ', 
    category: 'Khoa học', 
    price: 145000, 
    oldPrice: 175000, 
    stock: 16, 
    badge: 'Khoa học', 
    icon: '🌌', 
    image: 'resources/images/books/Vũ Trụ Trong Vỏ Hạt Dẻ.png',
    bg: 'linear-gradient(135deg, #43e97b 0%, #38f9d7 100%)', 
    desc: 'Khám phá những bí ẩn kỳ diệu của vật lý lượng tử, hố đen và vũ trụ bao la.' 
  },
  { 
    id: 'S30', 
    title: 'Lược Sử Thời Gian', 
    author: 'Stephen Hawking', 
    publisher: 'NXB Trẻ', 
    category: 'Khoa học', 
    price: 125000, 
    oldPrice: 150000, 
    stock: 20, 
    badge: 'Khoa học', 
    icon: '⏳', 
    image: 'resources/images/books/Lược Sử Thời Gian.png',
    bg: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)', 
    desc: 'Kiệt tác khoa học giải thích nguồn gốc vụ nổ Big Bang và sự hình thành của vũ trụ.' 
  },

  // --- CÔNG NGHỆ & LẬP TRÌNH ---
  { 
    id: 'S06', 
    title: 'Lập Trình Hướng Đối Tượng Java', 
    author: 'Trần Minh Quân', 
    publisher: 'NXB Thông Tin & Truyền Thông', 
    category: 'Công nghệ', 
    price: 115000, 
    oldPrice: 130000, 
    stock: 30, 
    badge: 'Giáo trình', 
    icon: '📓', 
    image: '',
    bg: 'linear-gradient(135deg, #4facfe 0%, #00f2fe 100%)', 
    desc: 'Giáo trình lý thuyết và thực hành Java từ căn bản đến lập trình Web Servlet/JSP.' 
  },
  { 
    id: 'S24', 
    title: 'Clean Code - Mã Sạch', 
    author: 'Robert C. Martin', 
    publisher: 'NXB Thông Tin & Truyền Thông', 
    category: 'Công nghệ', 
    price: 210000, 
    oldPrice: 250000, 
    stock: 28, 
    badge: 'Must Read', 
    icon: '💻', 
    image: '',
    bg: 'linear-gradient(135deg, #30cfd0 0%, #330867 100%)', 
    desc: 'Cẩm nang kinh điển của mọi lập trình viên về nghệ thuật viết mã nguồn sạch, dễ đọc và bảo trì.' 
  },
  { 
    id: 'S25', 
    title: 'Thiết Kế Hệ Thống Quy Mô Lớn', 
    author: 'Alex Xu', 
    publisher: 'NXB Dân Trí', 
    category: 'Công nghệ', 
    price: 240000, 
    oldPrice: 280000, 
    stock: 20, 
    badge: 'Hot', 
    icon: '🏗️', 
    image: '',
    bg: 'linear-gradient(135deg, #b176ff 0%, #ff6b8b 100%)', 
    desc: 'Hướng dẫn từng bước thiết kế kiến trúc phân tán phục vụ hàng triệu người dùng trực tuyến.' 
  }
];

const INITIAL_CATEGORIES = {
  genres: [
    { code: 'TL01', name: 'Văn học', count: 68 },
    { code: 'TL02', name: 'Kinh tế', count: 45 },
    { code: 'TL03', name: 'Thiếu nhi', count: 52 },
    { code: 'TL04', name: 'Kỹ năng', count: 60 },
    { code: 'TL05', name: 'Công nghệ', count: 34 },
    { code: 'TL06', name: 'Lịch sử', count: 26 },
    { code: 'TL07', name: 'Khoa học', count: 18 }
  ],
  authors: [
    { code: 'TG01', name: 'José Mauro de Vasconcelos', count: 4 },
    { code: 'TG02', name: 'Paulo Coelho', count: 8 },
    { code: 'TG03', name: 'Dale Carnegie', count: 6 },
    { code: 'TG04', name: 'James Clear', count: 3 },
    { code: 'TG05', name: 'Nguyễn Nhật Ánh', count: 24 },
    { code: 'TG06', name: 'Yuval Noah Harari', count: 5 },
    { code: 'TG07', name: 'Robert T. Kiyosaki', count: 12 },
    { code: 'TG08', name: 'Robert C. Martin', count: 4 }
  ],
  publishers: [
    { code: 'NXB01', name: 'NXB Trẻ', count: 145 },
    { code: 'NXB02', name: 'NXB Kim Đồng', count: 110 },
    { code: 'NXB03', name: 'NXB Hội Nhà Văn', count: 58 },
    { code: 'NXB04', name: 'NXB Thế Giới', count: 72 },
    { code: 'NXB05', name: 'NXB Dân Trí', count: 40 },
    { code: 'NXB06', name: 'NXB Thông Tin & Truyền Thông', count: 35 }
  ]
};

const INITIAL_ORDERS = [
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
    shippingFee: 20000,
    subtotal: 335000,
    total: 355000,
    paymentMethod: 'COD',
    status: 'shipping',
    statusText: 'Đang giao'
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
    shippingFee: 20000,
    subtotal: 154000,
    total: 174000,
    paymentMethod: 'Chuyển khoản',
    status: 'pending',
    statusText: 'Chờ xử lý'
  }
];

// ====================== 2. STORAGE CONTROLLER ======================
const DB = {
  getBooks() {
    const SEED_VERSION = 'v5_real_book_covers_2026';
    const currentVer = localStorage.getItem('bs_seed_ver');
    const raw = localStorage.getItem('bs_books');
    
    if (!raw || currentVer !== SEED_VERSION) {
      let books = INITIAL_BOOKS;
      if (raw) {
        try {
          const oldBooks = JSON.parse(raw);
          const initialIds = new Set(INITIAL_BOOKS.map(b => b.id));
          const userCustomBooks = oldBooks.filter(b => !initialIds.has(b.id));
          books = [...INITIAL_BOOKS, ...userCustomBooks];
        } catch (e) {
          books = INITIAL_BOOKS;
        }
      }
      localStorage.setItem('bs_books', JSON.stringify(books));
      if (!localStorage.getItem('bs_categories')) {
        localStorage.setItem('bs_categories', JSON.stringify(INITIAL_CATEGORIES));
      }
      localStorage.setItem('bs_seed_ver', SEED_VERSION);
      return books;
    }
    return JSON.parse(raw);
  },
  saveBooks(books) {
    localStorage.setItem('bs_books', JSON.stringify(books));
  },
  getBookById(id) {
    return this.getBooks().find(b => b.id === id);
  },
  addBook(book) {
    const books = this.getBooks();
    books.unshift(book);
    this.saveBooks(books);
  },
  updateBook(updatedBook) {
    let books = this.getBooks();
    books = books.map(b => b.id === updatedBook.id ? { ...b, ...updatedBook } : b);
    this.saveBooks(books);
  },
  deleteBook(id) {
    let books = this.getBooks();
    books = books.filter(b => b.id !== id);
    this.saveBooks(books);
  },
  getCategories() {
    const raw = localStorage.getItem('bs_categories');
    if (!raw) {
      localStorage.setItem('bs_categories', JSON.stringify(INITIAL_CATEGORIES));
      return INITIAL_CATEGORIES;
    }
    return JSON.parse(raw);
  },
  saveCategories(cats) {
    localStorage.setItem('bs_categories', JSON.stringify(cats));
  },
  getCart() {
    const raw = localStorage.getItem('bs_cart');
    if (!raw) {
      localStorage.setItem('bs_cart', JSON.stringify([]));
      return [];
    }
    try {
      let cart = JSON.parse(raw);
      let changed = false;
      const allBooks = this.getBooks();
      cart.forEach(function(item) {
        var book = allBooks.find(function(b) { return b.id === item.id; });
        if (book && book.image && item.image !== book.image) {
          item.image = book.image;
          changed = true;
        }
      });
      if (changed) {
        localStorage.setItem('bs_cart', JSON.stringify(cart));
      }
      return cart;
    } catch (e) {
      return [];
    }
  },
  saveCart(cart) {
    localStorage.setItem('bs_cart', JSON.stringify(cart));
    this.updateCartBadge();
  },
  addToCart(bookId, qty = 1) {
    const book = this.getBookById(bookId);
    if (!book) return false;
    let cart = this.getCart();
    const existing = cart.find(item => item.id === bookId);
    if (existing) {
      existing.qty += qty;
      if (book.image) existing.image = book.image;
    } else {
      cart.push({
        id: book.id,
        title: book.title,
        price: book.price,
        qty: qty,
        icon: book.icon || '📖',
        image: book.image || ''
      });
    }
    this.saveCart(cart);
    return true;
  },
  updateCartQty(bookId, qty) {
    let cart = this.getCart();
    const item = cart.find(i => i.id === bookId);
    if (item) {
      item.qty = Math.max(1, qty);
      this.saveCart(cart);
    }
  },
  removeFromCart(bookId) {
    let cart = this.getCart();
    cart = cart.filter(i => i.id !== bookId);
    this.saveCart(cart);
  },
  clearCart() {
    this.saveCart([]);
  },
  getCartTotalCount() {
    const cart = this.getCart();
    return cart.reduce((sum, item) => sum + item.qty, 0);
  },
  updateCartBadge() {
    const badges = document.querySelectorAll('.cart-badge, #nav-cart-count');
    const totalCount = this.getCartTotalCount();
    badges.forEach(b => {
      b.innerText = totalCount;
    });
  },
  getOrders() {
    const raw = localStorage.getItem('bs_orders');
    if (!raw) {
      localStorage.setItem('bs_orders', JSON.stringify(INITIAL_ORDERS));
      return INITIAL_ORDERS;
    }
    return JSON.parse(raw);
  },
  saveOrders(orders) {
    localStorage.setItem('bs_orders', JSON.stringify(orders));
  },
  createOrder(orderData) {
    let orders = this.getOrders();
    const newId = '#' + (1000 + orders.length + 1);
    const newOrder = {
      id: newId,
      date: new Date().toLocaleDateString('vi-VN'),
      customer: orderData.customer,
      phone: orderData.phone,
      address: orderData.address,
      items: orderData.items,
      shippingFee: 20000,
      subtotal: orderData.subtotal,
      total: orderData.total,
      paymentMethod: orderData.paymentMethod || 'COD',
      status: 'pending',
      statusText: 'Chờ xử lý'
    };
    orders.unshift(newOrder);
    this.saveOrders(orders);
    this.clearCart();
    return newOrder;
  },
  updateOrderStatus(orderId, newStatus) {
    let orders = this.getOrders();
    const statusMap = {
      'pending': 'Chờ xử lý',
      'shipping': 'Đang giao',
      'done': 'Hoàn tất',
      'cancelled': 'Đã hủy'
    };
    orders = orders.map(o => {
      if (o.id === orderId) {
        return {
          ...o,
          status: newStatus,
          statusText: statusMap[newStatus] || newStatus
        };
      }
      return o;
    });
    this.saveOrders(orders);
  }
};

// ====================== 3. AUTHENTICATION & PHÂN QUYỀN ======================
const Auth = {
  getUser() {
    const raw = localStorage.getItem('bs_current_user');
    if (!raw) return null;
    try {
      return JSON.parse(raw);
    } catch (e) {
      return null;
    }
  },
  isLoggedIn() {
    return this.getUser() !== null;
  },
  getAppRoot() {
    const p = window.location.pathname.split('/');
    return '/' + (p[1] || 'DoAn-NHOM9');
  },
  getRegisteredUsers() {
    const raw = localStorage.getItem('bs_registered_users');
    if (!raw) {
      const initialUsers = [
        {
          username: 'admin',
          password: '123',
          fullname: 'Quản Trị Viên Hệ Thống',
          email: 'admin@bookstore.vn',
          phone: '0909888999',
          address: 'Trung Tâm Điều Hành BookStore',
          role: 'admin'
        },
        {
          username: 'nguyenvanan',
          password: '123',
          fullname: 'Nguyễn Văn An',
          email: 'an.nguyen@example.com',
          phone: '0987654321',
          address: '12 Nguyễn Huệ, Phường Bến Nghé, Quận 1, TP. Hồ Chí Minh',
          role: 'user'
        }
      ];
      localStorage.setItem('bs_registered_users', JSON.stringify(initialUsers));
      return initialUsers;
    }
    try {
      return JSON.parse(raw);
    } catch(e) {
      return [];
    }
  },
  saveRegisteredUsers(users) {
    localStorage.setItem('bs_registered_users', JSON.stringify(users));
  },
  register(userData) {
    const users = this.getRegisteredUsers();
    const u = (userData.username || '').trim().toLowerCase();
    const email = (userData.email || '').trim().toLowerCase();

    // Kiểm tra username trùng
    if (users.some(acc => acc.username.toLowerCase() === u)) {
      return { success: false, message: 'Tên đăng nhập đã có người sử dụng!', field: 'username' };
    }
    // Kiểm tra email trùng
    if (users.some(acc => acc.email.toLowerCase() === email)) {
      return { success: false, message: 'Email này đã được đăng ký tài khoản!', field: 'email' };
    }

    const newUser = {
      username: u,
      password: userData.password,
      fullname: userData.fullname || u,
      email: email,
      phone: userData.phone || '',
      address: userData.address || 'TP. Hồ Chí Minh',
      role: 'user'
    };

    users.push(newUser);
    this.saveRegisteredUsers(users);
    return { success: true, user: newUser };
  },
  login(username, password) {
    const u = (username || '').trim().toLowerCase();
    const p = (password || '').trim();

    if (!u) {
      return { success: false, message: 'Vui lòng nhập tên đăng nhập hoặc email!', field: 'username' };
    }
    if (!p) {
      return { success: false, message: 'Vui lòng nhập mật khẩu!', field: 'password' };
    }

    const users = this.getRegisteredUsers();
    const found = users.find(acc => acc.username.toLowerCase() === u || acc.email.toLowerCase() === u);

    // Bắt buộc phải đăng ký tài khoản trước
    if (!found) {
      return {
        success: false,
        message: 'Tài khoản chưa được đăng ký trong hệ thống! Vui lòng đăng ký tài khoản mới trước khi đăng nhập.',
        field: 'username'
      };
    }

    // Kiểm tra mật khẩu (hỗ trợ cả mật khẩu admin123, 123456, 123 cho admin)
    let passwordOk = found.password === p;
    if (found.role === 'admin' && (p === 'admin123' || p === '123456' || p === '123')) {
      passwordOk = true;
    }
    if (found.username === 'nguyenvanan' && (p === '123456' || p === '123')) {
      passwordOk = true;
    }

    if (!passwordOk) {
      return {
        success: false,
        message: 'Mật khẩu không chính xác! Vui lòng kiểm tra lại.',
        field: 'password'
      };
    }

    // Đăng nhập thành công -> lưu session hiện tại
    localStorage.setItem('bs_current_user', JSON.stringify(found));

    const params = new URLSearchParams(window.location.search);
    const redirect = params.get('redirect');
    let targetUrl = found.role === 'admin' ? (this.getAppRoot() + '/admin/quanlysach') : (this.getAppRoot() + '/trangchu');
    if (redirect === 'thanhtoan' && found.role !== 'admin') {
      targetUrl = this.getAppRoot() + '/thanhtoan';
    }

    return { success: true, user: found, role: found.role, redirect: targetUrl };
  },
  logout() {
    showModalConfirm('Bạn có chắc chắn muốn đăng xuất tài khoản?', function() {
      localStorage.removeItem('bs_current_user');
      window.location.href = Auth.getAppRoot() + '/login';
    }, null, { title: 'Đăng xuất tài khoản', confirmText: 'Đăng xuất', confirmDanger: true });
  },
  applyHeaderUI() {
    const path = window.location.pathname.toLowerCase();
    if (path.includes('/login') || path.includes('/register') || path.includes('/admin/')) {
      return;
    }

    const user = this.getUser();
    const root = this.getAppRoot();

    // 1. Dọn dẹp nút Đăng xuất rời và nút Trang Quản Trị rời ngoài header nếu có
    const oldLogout = document.getElementById('navLogoutBtn');
    if (oldLogout) oldLogout.remove();
    const oldAdmin = document.getElementById('navAdminPortalBtn');
    if (oldAdmin) oldAdmin.remove();

    // 2. Xóa hoàn toàn nav-menu (nút Trang chủ) vì người dùng chỉ cần bấm Logo để về trang chủ
    document.querySelectorAll('.nav-menu').forEach(el => el.remove());
    const brandLogo = document.querySelector('.brand-logo');
    if (brandLogo && !brandLogo.getAttribute('title')) {
      brandLogo.setAttribute('title', 'Về Trang Chủ BookStore');
    }

    // 3. Tìm hoặc bọc user-menu-btn vào wrapper dropdown
    let userBtn = document.querySelector('.user-menu-btn');
    if (!userBtn) return;

    let wrapper = userBtn.closest('.user-menu-wrapper');
    if (!wrapper) {
      wrapper = document.createElement('div');
      wrapper.className = 'user-menu-wrapper';
      userBtn.parentNode.insertBefore(wrapper, userBtn);
      wrapper.appendChild(userBtn);
    }
    wrapper.style.cssText = 'position: relative; display: inline-flex; align-items: center;';

    let dropdown = wrapper.querySelector('.user-dropdown-menu');
    if (!dropdown) {
      dropdown = document.createElement('div');
      dropdown.className = 'user-dropdown-menu';
      wrapper.appendChild(dropdown);
    }
    dropdown.style.cssText = 'position: absolute; top: calc(100% + 8px); right: 0; background: #ffffff; min-width: 220px; border-radius: 10px; box-shadow: 0 10px 25px -5px rgba(0,0,0,0.25), 0 8px 10px -6px rgba(0,0,0,0.1); border: 1px solid #e2e8f0; padding: 6px 0; display: none; flex-direction: column; z-index: 9999; text-align: left;';

    // Rê chuột vào hiện, rời chuột ra ẩn (Chống lỗi cache CSS)
    wrapper.onmouseenter = function() {
      if (Auth.isLoggedIn()) dropdown.style.display = 'flex';
    };
    wrapper.onmouseleave = function() {
      dropdown.style.display = 'none';
    };

    const userDisplay = userBtn.querySelector('span:last-child');
    const avatar = userBtn.querySelector('.avatar-sm');

    if (user) {
      const displayName = user.fullname ? user.fullname.split(' ').pop() : user.username;
      const avatarChar = user.role === 'admin' ? 'AD' : (user.fullname ? user.fullname.charAt(0) : 'U');

      userBtn.href = 'javascript:void(0)';
      if (userDisplay) userDisplay.innerText = 'Xin chào, ' + displayName + ' ▾';
      if (avatar) {
        avatar.style.display = 'inline-flex';
        avatar.innerText = avatarChar;
      }

      var itemBaseStyle = 'display: flex; align-items: center; gap: 10px; padding: 10px 18px; font-size: 13.5px; color: #334155; text-decoration: none; font-weight: 500; transition: background 0.15s;';
      var adminLinkHtml = user.role === 'admin' ? 
        '<a href="' + root + '/admin/thongke" style="' + itemBaseStyle + '" onmouseover="this.style.background=\'#f8fafc\'; this.style.color=\'#1f5f5b\'" onmouseout="this.style.background=\'transparent\'; this.style.color=\'#334155\'">' +
        '  <span style="font-size: 16px;">🛡️</span>' +
        '  <span>Trang Quản Trị</span>' +
        '</a>' : '';

      dropdown.innerHTML = 
        '<div style="padding: 10px 18px 12px; border-bottom: 1px solid #f1f5f9; margin-bottom: 4px;">' +
        '  <div style="font-size: 14px; font-weight: 700; color: #1e293b;">' + (user.fullname || user.username) + '</div>' +
        '  <div style="font-size: 11.5px; color: #1f5f5b; font-weight: 600; margin-top: 2px;">' + (user.role === 'admin' ? 'Quản trị viên' : 'Khách hàng') + '</div>' +
        '</div>' +
        '<a href="' + root + '/donhang" style="' + itemBaseStyle + '" onmouseover="this.style.background=\'#f8fafc\'; this.style.color=\'#1f5f5b\'" onmouseout="this.style.background=\'transparent\'; this.style.color=\'#334155\'">' +
        '  <span style="font-size: 16px;">📦</span>' +
        '  <span>Đơn hàng của tôi</span>' +
        '</a>' +
        '<a href="' + root + '/taikhoan" style="' + itemBaseStyle + '" onmouseover="this.style.background=\'#f8fafc\'; this.style.color=\'#1f5f5b\'" onmouseout="this.style.background=\'transparent\'; this.style.color=\'#334155\'">' +
        '  <span style="font-size: 16px;">👤</span>' +
        '  <span>Thông tin tài khoản</span>' +
        '</a>' +
        adminLinkHtml +
        '<a href="javascript:void(0)" onclick="Auth.logout()" style="' + itemBaseStyle + ' color: #b3412f; border-top: 1px solid #f1f5f9; margin-top: 4px; padding-top: 10px;" onmouseover="this.style.background=\'#fef2f2\'; this.style.color=\'#dc2626\'" onmouseout="this.style.background=\'transparent\'; this.style.color=\'#b3412f\'">' +
        '  <span style="font-size: 16px;">🚪</span>' +
        '  <span>Đăng xuất</span>' +
        '</a>';
    } else {
      userBtn.href = root + '/login';
      if (avatar) avatar.style.display = 'none';
      if (userDisplay) userDisplay.innerHTML = '👤 Đăng nhập';
      dropdown.innerHTML = '';
      dropdown.style.display = 'none';
    }
  }
};

// ====================== 4. UI HELPERS ======================
function formatMoney(amount) {
  return Number(amount).toLocaleString('vi-VN') + 'đ';
}

function showToast(message, type = 'success') {
  let toastContainer = document.getElementById('toast-container');
  if (!toastContainer) {
    toastContainer = document.createElement('div');
    toastContainer.id = 'toast-container';
    toastContainer.style.cssText = 'position: fixed; bottom: 24px; right: 24px; z-index: 9999; display: flex; flex-direction: column; gap: 10px;';
    document.body.appendChild(toastContainer);
  }

  const toast = document.createElement('div');
  const bg = type === 'success' ? '#059669' : (type === 'danger' ? '#b3412f' : '#1f5f5b');
  toast.style.cssText = 'background: ' + bg + '; color: #ffffff; padding: 12px 20px; border-radius: 8px; font-size: 13.5px; font-weight: 500; box-shadow: 0 4px 12px rgba(0,0,0,0.15); display: flex; align-items: center; gap: 8px; animation: fadeIn 0.3s ease;';
  toast.innerHTML = '<span>✔</span> <span>' + message + '</span>';
  toastContainer.appendChild(toast);

  setTimeout(function() {
    toast.style.opacity = '0';
    toast.style.transition = 'opacity 0.3s ease';
    setTimeout(function() { toast.remove(); }, 300);
  }, 2500);
}

function openModal(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) modal.classList.add('show');
}

function closeModal(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) modal.classList.remove('show');
}

// Custom Modal Popup (Thay thế hoàn toàn alert và confirm mặc định)
function showModalAlert(message, title = 'Thông báo', onOk = null) {
  let overlay = document.getElementById('appCustomModal');
  if (!overlay) {
    overlay = document.createElement('div');
    overlay.id = 'appCustomModal';
    document.body.appendChild(overlay);
  }
  overlay.innerHTML = `
    <div class="custom-modal-backdrop" onclick="closeAppModal()" style="position: fixed; inset: 0; background: rgba(15, 23, 42, 0.55); backdrop-filter: blur(4px); z-index: 100000; display: flex; align-items: center; justify-content: center; padding: 20px; animation: modalFadeIn 0.2s ease;">
      <div class="custom-modal-card" onclick="event.stopPropagation()" style="background: #ffffff; border-radius: 14px; max-width: 440px; width: 100%; padding: 24px; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.2), 0 8px 10px -6px rgba(0,0,0,0.1); border: 1px solid #e2e8f0; animation: modalPop 0.25s cubic-bezier(0.16, 1, 0.3, 1);">
        <div style="display: flex; gap: 14px; align-items: flex-start;">
          <div style="width: 42px; height: 42px; border-radius: 50%; background: #e6f0ef; color: #1f5f5b; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;">
            🔔
          </div>
          <div style="flex: 1;">
            <h3 style="margin: 0 0 8px; font-size: 17px; font-weight: 700; color: #1e293b;">${title}</h3>
            <div style="font-size: 14px; color: #475569; line-height: 1.6; white-space: pre-line;">${message}</div>
          </div>
        </div>
        <div style="margin-top: 22px; display: flex; justify-content: flex-end;">
          <button type="button" id="appModalOkBtn" class="btn" style="min-width: 100px; padding: 9px 20px; font-weight: 600;">
            Đồng ý
          </button>
        </div>
      </div>
    </div>
  `;
  document.getElementById('appModalOkBtn').onclick = function() {
    closeAppModal();
    if (typeof onOk === 'function') onOk();
  };
}

function showModalConfirm(message, onOk, onCancel = null, options = {}) {
  const title = options.title || 'Xác nhận';
  const confirmText = options.confirmText || 'Đồng ý';
  const cancelText = options.cancelText || 'Hủy bỏ';
  const isDanger = options.confirmDanger !== false;

  let overlay = document.getElementById('appCustomModal');
  if (!overlay) {
    overlay = document.createElement('div');
    overlay.id = 'appCustomModal';
    document.body.appendChild(overlay);
  }

  const iconBg = isDanger ? '#fee2e2' : '#e6f0ef';
  const iconColor = isDanger ? '#b91c1c' : '#1f5f5b';
  const icon = isDanger ? '🗑️' : '❓';
  const confirmBtnClass = isDanger ? 'btn d' : 'btn';

  overlay.innerHTML = `
    <div class="custom-modal-backdrop" style="position: fixed; inset: 0; background: rgba(15, 23, 42, 0.55); backdrop-filter: blur(4px); z-index: 100000; display: flex; align-items: center; justify-content: center; padding: 20px; animation: modalFadeIn 0.2s ease;">
      <div class="custom-modal-card" onclick="event.stopPropagation()" style="background: #ffffff; border-radius: 14px; max-width: 440px; width: 100%; padding: 24px; box-shadow: 0 20px 25px -5px rgba(0,0,0,0.2), 0 8px 10px -6px rgba(0,0,0,0.1); border: 1px solid #e2e8f0; animation: modalPop 0.25s cubic-bezier(0.16, 1, 0.3, 1);">
        <div style="display: flex; gap: 14px; align-items: flex-start;">
          <div style="width: 42px; height: 42px; border-radius: 50%; background: ${iconBg}; color: ${iconColor}; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;">
            ${icon}
          </div>
          <div style="flex: 1;">
            <h3 style="margin: 0 0 8px; font-size: 17px; font-weight: 700; color: #1e293b;">${title}</h3>
            <div style="font-size: 14px; color: #475569; line-height: 1.6; white-space: pre-line;">${message}</div>
          </div>
        </div>
        <div style="margin-top: 24px; display: flex; justify-content: flex-end; gap: 10px;">
          <button type="button" id="appModalCancelBtn" class="btn o" style="min-width: 90px; padding: 9px 18px; border-color: #cbd5e1; color: #475569;">
            ${cancelText}
          </button>
          <button type="button" id="appModalConfirmBtn" class="${confirmBtnClass}" style="min-width: 100px; padding: 9px 20px; font-weight: 600;">
            ${confirmText}
          </button>
        </div>
      </div>
    </div>
  `;

  document.getElementById('appModalCancelBtn').onclick = function() {
    closeAppModal();
    if (typeof onCancel === 'function') onCancel();
  };
  document.getElementById('appModalConfirmBtn').onclick = function() {
    closeAppModal();
    if (typeof onOk === 'function') onOk();
  };
}

function closeAppModal() {
  const overlay = document.getElementById('appCustomModal');
  if (overlay) overlay.innerHTML = '';
}

// Override window.alert để không bao giờ xuất hiện hộp thoại thô sơ của trình duyệt
window.alert = function(msg) {
  showModalAlert(msg);
};

window.addEventListener('click', function(e) {
  if (e.target.classList.contains('modal-overlay')) {
    e.target.classList.remove('show');
  }
});

// ====================== 5. PAGE RENDERERS ======================

// [TRANG CHỦ]
const HOME_PAGE_SIZE = 12;
let homeCurrentPage = 1;
let homeCurrentCategory = '';

function renderHomeBooks() {
  const container = document.getElementById('book-list');
  if (!container) return;
  const searchInput = document.getElementById('homeSearchInput');
  const search = searchInput ? searchInput.value.toLowerCase().trim() : '';
  const books = DB.getBooks();

  const filtered = books.filter(function(b) {
    const matchSearch = (b.title || '').toLowerCase().indexOf(search) !== -1 || (b.author || '').toLowerCase().indexOf(search) !== -1;
    const matchCat = homeCurrentCategory === '' || b.category === homeCurrentCategory;
    return matchSearch && matchCat;
  });

  const paginationContainer = document.getElementById('homePagination');

  if (filtered.length === 0) {
    container.innerHTML = '<div style="grid-column: 1/-1; text-align: center; padding: 40px; color: var(--mute);">Không tìm thấy tựa sách nào phù hợp với tìm kiếm của bạn.</div>';
    if (paginationContainer) paginationContainer.innerHTML = '';
    return;
  }

  // Phân trang: Tối đa 12 cuốn sang trang mới
  const totalPages = Math.ceil(filtered.length / HOME_PAGE_SIZE);
  if (homeCurrentPage > totalPages) homeCurrentPage = totalPages;
  if (homeCurrentPage < 1) homeCurrentPage = 1;

  const startIndex = (homeCurrentPage - 1) * HOME_PAGE_SIZE;
  const pageBooks = filtered.slice(startIndex, startIndex + HOME_PAGE_SIZE);

  const root = Auth.getAppRoot();
  container.innerHTML = pageBooks.map(function(b) {
    var badgeHtml = b.badge ? '<span class="book-badge">' + b.badge + '</span>' : '';
    var oldPriceHtml = b.oldPrice ? '<span class="book-old-price">' + formatMoney(b.oldPrice) + '</span>' : '';
    var imgUrl = getBookImageUrl(b.image);
    var coverContent = imgUrl ? 
      '<img src="' + imgUrl + '" alt="' + b.title + '" style="width: 100%; height: 100%; object-fit: cover;">' :
      '<span style="font-size: 38px;">' + (b.icon || '📖') + '</span>';

    return '<div class="book-card">' +
      '<a href="' + root + '/chitietsach?id=' + b.id + '" class="book-cover" style="background: ' + (b.bg || '#e2e8f0') + '; overflow: hidden;">' +
        badgeHtml +
        coverContent +
      '</a>' +
      '<a href="' + root + '/chitietsach?id=' + b.id + '" class="book-title" title="' + b.title + '">' + b.title + '</a>' +
      '<div class="book-author">Tác giả: ' + b.author + '</div>' +
      '<div class="book-price-row">' +
        '<span class="book-price">' + formatMoney(b.price) + '</span>' +
        oldPriceHtml +
      '</div>' +
      '<div style="display: flex; gap: 8px; margin-top: 6px;">' +
        '<button class="btn o" onclick="handleAddToCart(\'' + b.id + '\', \'' + (b.title || '').replace(/'/g, "\\'") + '\')" style="flex: 1; padding: 7px 4px; font-size: 12px; gap: 4px; white-space: nowrap;" title="Thêm vào giỏ">' +
          '<svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M11 9h2V6h3V4h-3V1h-2v3H8v2h3v3zm-4 9c-1.1 0-1.99.9-1.99 2S5.9 22 7 22s2-.9 2-2-.9-2-2-2zm10 0c-1.1 0-1.99.9-1.99 2s.89 2 1.99 2 2-.9 2-2-.9-2-2-2zm-9.83-3.25l.03-.12.9-1.63h7.45c.75 0 1.41-.41 1.75-1.03l3.86-7.01L19.42 4h-.01l-1.1 2-2.76 5H8.53l-.13-.27L6.16 6l-.95-2-.94-2H1v2h2l3.6 7.59-1.35 2.45c-.16.28-.25.61-.25.96 0 1.1.9 2 2 2h12v-2H7.42c-.13 0-.25-.11-.25-.25z"/></svg> ' +
          'Thêm vào giỏ' +
        '</button>' +
        '<button class="btn" onclick="handleBuyNowHome(\'' + b.id + '\')" style="flex: 1; padding: 7px 4px; font-size: 12px; font-weight: 700; gap: 4px; white-space: nowrap;" title="Mua ngay">' +
          '<svg width="14" height="14" viewBox="0 0 24 24" fill="currentColor"><path d="M7 2v11h3v9l7-12h-4l4-8z"/></svg> ' +
          'Mua ngay' +
        '</button>' +
      '</div>' +
    '</div>';
  }).join('');

  renderHomePagination(totalPages);
}

function renderHomePagination(totalPages) {
  const container = document.getElementById('homePagination');
  if (!container) return;

  if (totalPages <= 1) {
    container.innerHTML = '';
    return;
  }

  var btnBase = 'width: 38px; height: 38px; border-radius: 50%; font-size: 14px; font-weight: 600; display: inline-flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.15s ease; border: 1px solid #cbd5e1; background: #ffffff; color: #334155;';
  var btnActive = 'width: 38px; height: 38px; border-radius: 50%; font-size: 14px; font-weight: 700; display: inline-flex; align-items: center; justify-content: center; cursor: pointer; transition: all 0.15s ease; border: 1.5px solid #1f5f5b; background: #e6f0ef; color: #1f5f5b; box-shadow: 0 2px 6px rgba(31,95,91,0.15);';
  var btnDisabled = 'width: 38px; height: 38px; border-radius: 50%; font-size: 14px; font-weight: 600; display: inline-flex; align-items: center; justify-content: center; border: 1px solid #e2e8f0; background: #f8fafc; color: #94a3b8; opacity: 0.5; cursor: not-allowed;';

  var html = '';

  // Nút ‹ (Previous)
  if (homeCurrentPage > 1) {
    html += '<button type="button" onclick="changeHomePage(' + (homeCurrentPage - 1) + ')" style="' + btnBase + '" onmouseover="this.style.borderColor=\'#1f5f5b\'; this.style.color=\'#1f5f5b\'" onmouseout="this.style.borderColor=\'#cbd5e1\'; this.style.color=\'#334155\'">‹</button>';
  } else {
    html += '<button type="button" disabled style="' + btnDisabled + '">‹</button>';
  }

  // Các nút số trang
  for (var i = 1; i <= totalPages; i++) {
    if (i === homeCurrentPage) {
      html += '<button type="button" style="' + btnActive + '">' + i + '</button>';
    } else {
      html += '<button type="button" onclick="changeHomePage(' + i + ')" style="' + btnBase + '" onmouseover="this.style.borderColor=\'#1f5f5b\'; this.style.color=\'#1f5f5b\'" onmouseout="this.style.borderColor=\'#cbd5e1\'; this.style.color=\'#334155\'">' + i + '</button>';
    }
  }

  // Nút › (Next)
  if (homeCurrentPage < totalPages) {
    html += '<button type="button" onclick="changeHomePage(' + (homeCurrentPage + 1) + ')" style="' + btnBase + '" onmouseover="this.style.borderColor=\'#1f5f5b\'; this.style.color=\'#1f5f5b\'" onmouseout="this.style.borderColor=\'#cbd5e1\'; this.style.color=\'#334155\'">›</button>';
  } else {
    html += '<button type="button" disabled style="' + btnDisabled + '">›</button>';
  }

  container.innerHTML = html;
}

function changeHomePage(page) {
  homeCurrentPage = page;
  renderHomeBooks();
  var bookGrid = document.getElementById('book-list');
  if (bookGrid) {
    bookGrid.scrollIntoView({ behavior: 'smooth', block: 'start' });
  }
}

function filterCategory(cat, btn) {
  homeCurrentCategory = cat;
  homeCurrentPage = 1; // Luôn reset về trang 1 khi lọc
  document.querySelectorAll('#homeCategoryChips .chip').forEach(function(c) { c.classList.remove('on'); });
  if (btn) btn.classList.add('on');
  renderHomeBooks();
}

function handleAddToCart(bookId, title) {
  DB.addToCart(bookId, 1);
  showToast('Đã thêm cuốn "' + title + '" vào giỏ hàng!');
}

function handleBuyNowHome(bookId) {
  DB.addToCart(bookId, 1);
  if (!Auth.isLoggedIn()) {
    showModalAlert('Vui lòng đăng nhập tài khoản để tiến hành thanh toán và đặt hàng!', 'Yêu cầu đăng nhập', function() {
      window.location.href = Auth.getAppRoot() + '/login?redirect=thanhtoan';
    });
    return;
  }
  showToast('Đang chuyển đến trang thanh toán...');
  setTimeout(function() {
    window.location.href = Auth.getAppRoot() + '/thanhtoan';
  }, 250);
}

function renderHomeCategoryChips() {
  const container = document.getElementById('homeCategoryChips');
  if (!container) return;
  const cats = DB.getCategories();
  const genres = (cats && cats.genres) ? cats.genres : [];

  let html = '<button class="chip ' + (homeCurrentCategory === '' ? 'on' : '') + '" onclick="filterCategory(\'\', this)">Tất cả</button>';
  for (let i = 0; i < genres.length; i++) {
    const g = genres[i];
    const name = g.name || g;
    const isOn = homeCurrentCategory === name ? 'on' : '';
    html += '<button class="chip ' + isOn + '" onclick="filterCategory(\'' + name.replace(/'/g, "\\'") + '\', this)">' + name + '</button>';
  }
  container.innerHTML = html;
}

function initHomePage() {
  renderHomeCategoryChips();
  const searchInput = document.getElementById('homeSearchInput');
  if (searchInput) {
    searchInput.addEventListener('input', function() {
      homeCurrentPage = 1; // Reset về trang 1 khi tìm kiếm
      renderHomeBooks();
    });
  }
  renderHomeBooks();
}

// [GIỎ HÀNG]
function renderCart() {
  const tbody = document.getElementById('cartTableBody');
  if (!tbody) return;
  const cart = DB.getCart();

  if (cart.length === 0) {
    tbody.innerHTML = '<tr><td colspan="5" class="c mute" style="padding: 30px;">Giỏ hàng của bạn đang trống. Hãy quay lại Trang chủ để chọn sách nhé!</td></tr>';
    document.getElementById('cart-temp-total').innerText = '0đ';
    document.getElementById('cart-grand-total').innerText = '0đ';
    document.getElementById('cart-item-count').innerText = 'Giỏ hàng (0)';
    return;
  }

  var total = 0;
  tbody.innerHTML = cart.map(function(item) {
    var subtotal = item.price * item.qty;
    total += subtotal;
    var itemImg = item.image;
    if (!itemImg || itemImg.startsWith('http')) {
      var origBook = DB.getBookById(item.id);
      if (origBook && origBook.image) itemImg = origBook.image;
    }
    var imgUrl = getBookImageUrl(itemImg);
    var cartThumb = imgUrl ? 
      '<img src="' + imgUrl + '" alt="' + item.title + '" style="width: 100%; height: 100%; object-fit: cover;">' :
      '<span style="font-size: 22px;">' + (item.icon || '📖') + '</span>';

    return '<tr>' +
      '<td>' +
        '<div class="row">' +
          '<div style="width: 44px; height: 56px; border-radius: 4px; overflow: hidden; background: #e2e8f0; display: flex; align-items: center; justify-content: center;">' + cartThumb + '</div>' +
          '<div>' +
            '<div class="b" style="font-size: 14px;">' + item.title + '</div>' +
            '<div class="mute" style="font-size: 12px;">Mã: ' + item.id + '</div>' +
          '</div>' +
        '</div>' +
      '</td>' +
      '<td>' + formatMoney(item.price) + '</td>' +
      '<td style="text-align: center;">' +
        '<div class="qty-box">' +
          '<button type="button" class="qty-btn" onclick="changeQty(\'' + item.id + '\', -1)">–</button>' +
          '<input type="text" class="qty-val" value="' + item.qty + '" readonly>' +
          '<button type="button" class="qty-btn" onclick="changeQty(\'' + item.id + '\', 1)">+</button>' +
        '</div>' +
      '</td>' +
      '<td style="text-align: right; font-weight: 700; color: var(--ac);">' + formatMoney(subtotal) + '</td>' +
      '<td style="text-align: center;">' +
        '<button type="button" class="btn o btn-sm" onclick="removeItem(\'' + item.id + '\')" title="Xóa" style="color: var(--danger); border-color: transparent;">✕</button>' +
      '</td>' +
    '</tr>';
  }).join('');

  document.getElementById('cart-temp-total').innerText = formatMoney(total);
  document.getElementById('cart-grand-total').innerText = formatMoney(total);
  document.getElementById('cart-item-count').innerText = 'Có ' + cart.length + ' tựa sách trong giỏ (' + DB.getCartTotalCount() + ' cuốn)';
}

function changeQty(bookId, delta) {
  const cart = DB.getCart();
  const item = cart.find(function(i) { return i.id === bookId; });
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
  showModalConfirm('Bạn có chắc muốn xóa cuốn sách này khỏi giỏ hàng?', function() {
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
    showModalAlert('Vui lòng đăng nhập tài khoản để tiếp tục thanh toán và đặt hàng!', 'Yêu cầu đăng nhập', function() {
      window.location.href = Auth.getAppRoot() + '/login?redirect=thanhtoan';
    });
    return;
  }
  window.location.href = Auth.getAppRoot() + '/thanhtoan';
}

function initCartPage() {
  renderCart();
}

// Tự động kích hoạt badge và header khi DOM sẵn sàng
document.addEventListener('DOMContentLoaded', function() {
  DB.updateCartBadge();
  Auth.applyHeaderUI();
});
