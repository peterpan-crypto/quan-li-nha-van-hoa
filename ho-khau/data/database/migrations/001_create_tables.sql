

-- Bảng HỘ KHẨU
CREATE TABLE IF NOT EXISTS ho_khau (
    ma_ho_khau VARCHAR(20) PRIMARY KEY,
    so_ho_khau VARCHAR(15) UNIQUE NOT NULL,
    dia_chi TEXT NOT NULL,
    khu_vuc VARCHAR(100),
    ngay_dang_ky DATE NOT NULL,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    trang_thai VARCHAR(20) DEFAULT 'ACTIVE' CHECK(trang_thai IN ('ACTIVE', 'INACTIVE')),
    ghi_chu TEXT
);

-- Bảng NHÂN KHẨU
CREATE TABLE IF NOT EXISTS nhan_khau (
    ma_nhan_khau VARCHAR(20) PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    bi_danh VARCHAR(50),
    gioi_tinh VARCHAR(10) NOT NULL CHECK(gioi_tinh IN ('Nam', 'Nữ')),
    ngay_sinh DATE NOT NULL,
    noi_sinh VARCHAR(200),
    nguyen_quan VARCHAR(200),
    dan_toc VARCHAR(50) DEFAULT 'Kinh',
    ton_giao VARCHAR(50),
    quoc_tich VARCHAR(50) DEFAULT 'Việt Nam',
    so_cccd VARCHAR(20) UNIQUE,
    nghe_nghiep VARCHAR(100),
    noi_lam_viec VARCHAR(200),
    ma_ho_khau VARCHAR(20) NOT NULL,
    quan_he_chu_ho VARCHAR(50) NOT NULL,
    trang_thai VARCHAR(20) DEFAULT 'THUONG_TRU' CHECK(trang_thai IN ('THUONG_TRU', 'TAM_TRU', 'TAM_VANG', 'DA_CHUYEN')),
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ma_ho_khau) REFERENCES ho_khau(ma_ho_khau)
);

-- Bảng TẠM TRÚ
CREATE TABLE IF NOT EXISTS tam_tru (
    ma_tam_tru VARCHAR(20) PRIMARY KEY,
    ma_nhan_khau VARCHAR(20) NOT NULL,
    dia_chi_tam_tru TEXT NOT NULL,
    tu_ngay DATE NOT NULL,
    den_ngay DATE NOT NULL,
    ly_do TEXT,
    trang_thai VARCHAR(20) DEFAULT 'DANG_TAM_TRU' CHECK(trang_thai IN ('DANG_TAM_TRU', 'DA_KET_THUC')),
    ngay_dang_ky TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nguoi_dang_ky VARCHAR(100),
    FOREIGN KEY (ma_nhan_khau) REFERENCES nhan_khau(ma_nhan_khau)
);

-- Bảng TẠM VẮNG
CREATE TABLE IF NOT EXISTS tam_vang (
    ma_tam_vang VARCHAR(20) PRIMARY KEY,
    ma_nhan_khau VARCHAR(20) NOT NULL,
    dia_chi_tam_vang TEXT NOT NULL,
    tu_ngay DATE NOT NULL,
    den_ngay DATE NOT NULL,
    ly_do TEXT,
    trang_thai VARCHAR(20) DEFAULT 'DANG_TAM_VANG' CHECK(trang_thai IN ('DANG_TAM_VANG', 'DA_KET_THUC')),
    ngay_dang_ky TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nguoi_dang_ky VARCHAR(100),
    FOREIGN KEY (ma_nhan_khau) REFERENCES nhan_khau(ma_nhan_khau)
);

-- Bảng TÁCH KHẨU
CREATE TABLE IF NOT EXISTS tach_khau (
    ma_tach_khau VARCHAR(20) PRIMARY KEY,
    ma_ho_khau_goc VARCHAR(20) NOT NULL,
    ma_ho_khau_moi VARCHAR(20) NOT NULL,
    ngay_tach DATE NOT NULL,
    ly_do TEXT,
    trang_thai VARCHAR(20) DEFAULT 'CHO_DUYET' CHECK(trang_thai IN ('CHO_DUYET', 'DA_DUYET', 'DA_HUY')),
    nguoi_duyet VARCHAR(100),
    ngay_duyet DATE,
    FOREIGN KEY (ma_ho_khau_goc) REFERENCES ho_khau(ma_ho_khau),
    FOREIGN KEY (ma_ho_khau_moi) REFERENCES ho_khau(ma_ho_khau)
);

-- Bảng CHUYỂN KHẨU
CREATE TABLE IF NOT EXISTS chuyen_khau (
    ma_chuyen_khau VARCHAR(20) PRIMARY KEY,
    ma_nhan_khau VARCHAR(20) NOT NULL,
    ma_ho_khau_cu VARCHAR(20) NOT NULL,
    ma_ho_khau_moi VARCHAR(20) NOT NULL,
    ngay_chuyen DATE NOT NULL,
    ly_do TEXT,
    trang_thai VARCHAR(20) DEFAULT 'CHO_DUYET' CHECK(trang_thai IN ('CHO_DUYET', 'DA_DUYET', 'DA_HUY')),
    nguoi_duyet VARCHAR(100),
    ngay_duyet DATE,
    FOREIGN KEY (ma_nhan_khau) REFERENCES nhan_khau(ma_nhan_khau),
    FOREIGN KEY (ma_ho_khau_cu) REFERENCES ho_khau(ma_ho_khau),
    FOREIGN KEY (ma_ho_khau_moi) REFERENCES ho_khau(ma_ho_khau)
);

-- Bảng NGƯỜI DÙNG
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    ho_ten VARCHAR(100) NOT NULL,
    email VARCHAR(100),
    role VARCHAR(20) DEFAULT 'can_bo' CHECK(role IN ('admin', 'can_bo', 'xem_only')),
    trang_thai VARCHAR(20) DEFAULT 'ACTIVE' CHECK(trang_thai IN ('ACTIVE', 'INACTIVE')),
    last_login TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Bảng LỊCH SỬ THAY ĐỔI
CREATE TABLE IF NOT EXISTS lich_su_thay_doi (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    bang VARCHAR(50) NOT NULL,
    ma_ban_ghi VARCHAR(20) NOT NULL,
    hanh_dong VARCHAR(10) NOT NULL CHECK(hanh_dong IN ('CREATE', 'UPDATE', 'DELETE')),
    du_lieu_cu TEXT,
    du_lieu_moi TEXT,
    nguoi_thuc_hien VARCHAR(100),
    thoi_gian TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
