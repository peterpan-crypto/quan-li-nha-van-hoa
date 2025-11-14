-- =============================
-- 001_create_tables.sql
-- Tạo cấu trúc CSDL cho hệ thống
-- =============================

-- Bảng Hộ khẩu
CREATE TABLE IF NOT EXISTS HoKhau (
    ma_ho TEXT PRIMARY KEY,
    chu_ho TEXT NOT NULL,
    dia_chi TEXT NOT NULL,
    so_tv INTEGER DEFAULT 1
);

-- Bảng Nhân khẩu
CREATE TABLE IF NOT EXISTS NhanKhau (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ho_ten TEXT NOT NULL,
    ngay_sinh TEXT,
    gioi_tinh TEXT,
    nghe_nghiep TEXT,
    so_cccd TEXT UNIQUE,
    ma_ho TEXT,
    FOREIGN KEY (ma_ho) REFERENCES HoKhau(ma_ho)
);

-- Bảng Tài khoản
CREATE TABLE IF NOT EXISTS NguoiDung (
    username TEXT PRIMARY KEY,
    password TEXT NOT NULL,
    role TEXT CHECK(role IN ('admin','canbo')) NOT NULL
);

-- Tạm trú – tạm vắng
CREATE TABLE IF NOT EXISTS TamTruTamVang (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_nhankhau INTEGER,
    loai TEXT CHECK(loai IN ('tam_tru','tam_vang')),
    tu_ngay TEXT,
    den_ngay TEXT,
    ghi_chu TEXT,
    FOREIGN KEY (id_nhankhau) REFERENCES NhanKhau(id)
);
