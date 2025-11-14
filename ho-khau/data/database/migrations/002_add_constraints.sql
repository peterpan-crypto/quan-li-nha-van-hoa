-- =============================================
-- THÊM RÀNG BUỘC, INDEXES VÀ TRIGGERS
-- File: 002_add_constraints.sql
-- =============================================

-- 1. TẠO INDEXES CHO HIỆU NĂNG TÌM KIẾM

-- Indexes cho bảng HỘ KHẨU
CREATE INDEX IF NOT EXISTS idx_ho_khau_so_hk ON ho_khau(so_ho_khau);
CREATE INDEX IF NOT EXISTS idx_ho_khau_dia_chi ON ho_khau(dia_chi);
CREATE INDEX IF NOT EXISTS idx_ho_khau_khu_vuc ON ho_khau(khu_vuc);
CREATE INDEX IF NOT EXISTS idx_ho_khau_trang_thai ON ho_khau(trang_thai);
CREATE INDEX IF NOT EXISTS idx_ho_khau_ngay_dang_ky ON ho_khau(ngay_dang_ky);

-- Indexes cho bảng NHÂN KHẨU
CREATE INDEX IF NOT EXISTS idx_nhan_khau_ho_ten ON nhan_khau(ho_ten);
CREATE INDEX IF NOT EXISTS idx_nhan_khau_cccd ON nhan_khau(so_cccd);
CREATE INDEX IF NOT EXISTS idx_nhan_khau_ma_ho_khau ON nhan_khau(ma_ho_khau);
CREATE INDEX IF NOT EXISTS idx_nhan_khau_ngay_sinh ON nhan_khau(ngay_sinh);
CREATE INDEX IF NOT EXISTS idx_nhan_khau_trang_thai ON nhan_khau(trang_thai);
CREATE INDEX IF NOT EXISTS idx_nhan_khau_gioi_tinh ON nhan_khau(gioi_tinh);
CREATE INDEX IF NOT EXISTS idx_nhan_khau_quan_he ON nhan_khau(quan_he_chu_ho);

-- Indexes cho bảng TẠM TRÚ
CREATE INDEX IF NOT EXISTS idx_tam_tru_ma_nhan_khau ON tam_tru(ma_nhan_khau);
CREATE INDEX IF NOT EXISTS idx_tam_tru_tu_ngay ON tam_tru(tu_ngay);
CREATE INDEX IF NOT EXISTS idx_tam_tru_den_ngay ON tam_tru(den_ngay);
CREATE INDEX IF NOT EXISTS idx_tam_tru_trang_thai ON tam_tru(trang_thai);
CREATE INDEX IF NOT EXISTS idx_tam_tru_ngay_dang_ky ON tam_tru(ngay_dang_ky);

-- Indexes cho bảng TẠM VẮNG
CREATE INDEX IF NOT EXISTS idx_tam_vang_ma_nhan_khau ON tam_vang(ma_nhan_khau);
CREATE INDEX IF NOT EXISTS idx_tam_vang_tu_ngay ON tam_vang(tu_ngay);
CREATE INDEX IF NOT EXISTS idx_tam_vang_den_ngay ON tam_vang(den_ngay);
CREATE INDEX IF NOT EXISTS idx_tam_vang_trang_thai ON tam_vang(trang_thai);

-- Indexes cho bảng TÁCH KHẨU
CREATE INDEX IF NOT EXISTS idx_tach_khau_ho_goc ON tach_khau(ma_ho_khau_goc);
CREATE INDEX IF NOT EXISTS idx_tach_khau_ho_moi ON tach_khau(ma_ho_khau_moi);
CREATE INDEX IF NOT EXISTS idx_tach_khau_trang_thai ON tach_khau(trang_thai);
CREATE INDEX IF NOT EXISTS idx_tach_khau_ngay_tach ON tach_khau(ngay_tach);

-- Indexes cho bảng CHUYỂN KHẨU
CREATE INDEX IF NOT EXISTS idx_chuyen_khau_ma_nhan_khau ON chuyen_khau(ma_nhan_khau);
CREATE INDEX IF NOT EXISTS idx_chuyen_khau_ho_cu ON chuyen_khau(ma_ho_khau_cu);
CREATE INDEX IF NOT EXISTS idx_chuyen_khau_ho_moi ON chuyen_khau(ma_ho_khau_moi);
CREATE INDEX IF NOT EXISTS idx_chuyen_khau_trang_thai ON chuyen_khau(trang_thai);
CREATE INDEX IF NOT EXISTS idx_chuyen_khau_ngay_chuyen ON chuyen_khau(ngay_chuyen);

-- Indexes cho bảng USERS
CREATE INDEX IF NOT EXISTS idx_users_username ON users(username);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);
CREATE INDEX IF NOT EXISTS idx_users_trang_thai ON users(trang_thai);
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Indexes cho bảng LỊCH SỬ THAY ĐỔI
CREATE INDEX IF NOT EXISTS idx_lich_su_bang ON lich_su_thay_doi(bang);
CREATE INDEX IF NOT EXISTS idx_lich_su_ma_ban_ghi ON lich_su_thay_doi(ma_ban_ghi);
CREATE INDEX IF NOT EXISTS idx_lich_su_hanh_dong ON lich_su_thay_doi(hanh_dong);
CREATE INDEX IF NOT EXISTS idx_lich_su_thoi_gian ON lich_su_thay_doi(thoi_gian);

-- 2. TẠO TRIGGERS CHO TÍNH TOÀN VẸN DỮ LIỆU

-- Trigger tự động cập nhật ngày cập nhật cho NHÂN KHẨU
CREATE TRIGGER IF NOT EXISTS trg_nhan_khau_before_update
BEFORE UPDATE ON nhan_khau
FOR EACH ROW
BEGIN
    UPDATE nhan_khau SET ngay_cap_nhat = CURRENT_TIMESTAMP 
    WHERE ma_nhan_khau = NEW.ma_nhan_khau;
END;

-- Trigger tự động cập nhật ngày cập nhật cho HỘ KHẨU
CREATE TRIGGER IF NOT EXISTS trg_ho_khau_before_update
BEFORE UPDATE ON ho_khau
FOR EACH ROW
BEGIN
    UPDATE ho_khau SET ngay_cap_nhat = CURRENT_TIMESTAMP 
    WHERE ma_ho_khau = NEW.ma_ho_khau;
END;

-- Trigger tự động cập nhật ngày cập nhật cho USERS
CREATE TRIGGER IF NOT EXISTS trg_users_before_update
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
    UPDATE users SET updated_at = CURRENT_TIMESTAMP 
    WHERE id = NEW.id;
END;

-- 3. TRIGGERS GHI LOG LỊCH SỬ THAY ĐỔI

-- Trigger ghi log khi THÊM MỚI nhân khẩu
CREATE TRIGGER IF NOT EXISTS trg_log_nhan_khau_insert
AFTER INSERT ON nhan_khau
FOR EACH ROW
BEGIN
    INSERT INTO lich_su_thay_doi (bang, ma_ban_ghi, hanh_dong, du_lieu_moi, nguoi_thuc_hien)
    VALUES ('nhan_khau', NEW.ma_nhan_khau, 'CREATE', 
            json_object(
                'ho_ten', NEW.ho_ten,
                'ma_ho_khau', NEW.ma_ho_khau, 
                'so_cccd', NEW.so_cccd,
                'trang_thai', NEW.trang_thai,
                'quan_he_chu_ho', NEW.quan_he_chu_ho
            ),
            'system');
END;

-- Trigger ghi log khi CẬP NHẬT nhân khẩu
CREATE TRIGGER IF NOT EXISTS trg_log_nhan_khau_update
AFTER UPDATE ON nhan_khau
FOR EACH ROW
BEGIN
    INSERT INTO lich_su_thay_doi (bang, ma_ban_ghi, hanh_dong, du_lieu_cu, du_lieu_moi, nguoi_thuc_hien)
    VALUES ('nhan_khau', NEW.ma_nhan_khau, 'UPDATE', 
            json_object(
                'ho_ten', OLD.ho_ten,
                'ma_ho_khau', OLD.ma_ho_khau,
                'so_cccd', OLD.so_cccd,
                'trang_thai', OLD.trang_thai,
                'quan_he_chu_ho', OLD.quan_he_chu_ho
            ),
            json_object(
                'ho_ten', NEW.ho_ten,
                'ma_ho_khau', NEW.ma_ho_khau,
                'so_cccd', NEW.so_cccd,
                'trang_thai', NEW.trang_thai,
                'quan_he_chu_ho', NEW.quan_he_chu_ho
            ),
            'system');
END;

-- Trigger ghi log khi XÓA nhân khẩu
CREATE TRIGGER IF NOT EXISTS trg_log_nhan_khau_delete
AFTER DELETE ON nhan_khau
FOR EACH ROW
BEGIN
    INSERT INTO lich_su_thay_doi (bang, ma_ban_ghi, hanh_dong, du_lieu_cu, nguoi_thuc_hien)
    VALUES ('nhan_khau', OLD.ma_nhan_khau, 'DELETE', 
            json_object(
                'ho_ten', OLD.ho_ten,
                'ma_ho_khau', OLD.ma_ho_khau,
                'so_cccd', OLD.so_cccd,
                'trang_thai', OLD.trang_thai
            ),
            'system');
END;

-- Trigger ghi log khi THÊM MỚI hộ khẩu
CREATE TRIGGER IF NOT EXISTS trg_log_ho_khau_insert
AFTER INSERT ON ho_khau
FOR EACH ROW
BEGIN
    INSERT INTO lich_su_thay_doi (bang, ma_ban_ghi, hanh_dong, du_lieu_moi, nguoi_thuc_hien)
    VALUES ('ho_khau', NEW.ma_ho_khau, 'CREATE', 
            json_object(
                'so_ho_khau', NEW.so_ho_khau,
                'dia_chi', NEW.dia_chi,
                'trang_thai', NEW.trang_thai
            ),
            'system');
END;

-- Trigger ghi log khi CẬP NHẬT hộ khẩu
CREATE TRIGGER IF NOT EXISTS trg_log_ho_khau_update
AFTER UPDATE ON ho_khau
FOR EACH ROW
BEGIN
    INSERT INTO lich_su_thay_doi (bang, ma_ban_ghi, hanh_dong, du_lieu_cu, du_lieu_moi, nguoi_thuc_hien)
    VALUES ('ho_khau', NEW.ma_ho_khau, 'UPDATE', 
            json_object(
                'so_ho_khau', OLD.so_ho_khau,
                'dia_chi', OLD.dia_chi,
                'trang_thai', OLD.trang_thai
            ),
            json_object(
                'so_ho_khau', NEW.so_ho_khau,
                'dia_chi', NEW.dia_chi,
                'trang_thai', NEW.trang_thai
            ),
            'system');
END;

-- 4. TRIGGERS KIỂM TRA RÀNG BUỘC NGHIỆP VỤ

-- Trigger đảm bảo mỗi hộ chỉ có 1 chủ hộ
CREATE TRIGGER IF NOT EXISTS trg_check_chu_ho_duy_nhat
BEFORE INSERT ON nhan_khau
FOR EACH ROW
WHEN NEW.quan_he_chu_ho = 'Chủ hộ'
BEGIN
    SELECT CASE
        WHEN EXISTS (
            SELECT 1 FROM nhan_khau 
            WHERE ma_ho_khau = NEW.ma_ho_khau 
            AND quan_he_chu_ho = 'Chủ hộ'
            AND ma_nhan_khau != NEW.ma_nhan_khau
        ) THEN
            RAISE(ABORT, 'Mỗi hộ khẩu chỉ được có một chủ hộ')
    END;
END;

-- Trigger kiểm tra tuổi chủ hộ (ít nhất 18 tuổi)
CREATE TRIGGER IF NOT EXISTS trg_check_tuoi_chu_ho
BEFORE INSERT ON nhan_khau
FOR EACH ROW
WHEN NEW.quan_he_chu_ho = 'Chủ hộ'
BEGIN
    SELECT CASE
        WHEN (julianday('now') - julianday(NEW.ngay_sinh)) / 365.25 < 18 THEN
            RAISE(ABORT, 'Chủ hộ phải từ 18 tuổi trở lên')
    END;
END;

-- Trigger kiểm tra không cho xóa hộ khẩu khi còn nhân khẩu
CREATE TRIGGER IF NOT EXISTS trg_prevent_delete_ho_khau
BEFORE DELETE ON ho_khau
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN EXISTS (SELECT 1 FROM nhan_khau WHERE ma_ho_khau = OLD.ma_ho_khau) THEN
            RAISE(ABORT, 'Không thể xóa hộ khẩu khi còn nhân khẩu')
    END;
END;

-- Trigger kiểm tra tạm trú không chồng chéo thời gian
CREATE TRIGGER IF NOT EXISTS trg_check_tam_tru_overlap
BEFORE INSERT ON tam_tru
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN EXISTS (
            SELECT 1 FROM tam_tru 
            WHERE ma_nhan_khau = NEW.ma_nhan_khau 
            AND trang_thai = 'DANG_TAM_TRU'
            AND (
                (NEW.tu_ngay BETWEEN tu_ngay AND den_ngay) OR
                (NEW.den_ngay BETWEEN tu_ngay AND den_ngay) OR
                (NEW.tu_ngay <= tu_ngay AND NEW.den_ngay >= den_ngay)
            )
        ) THEN
            RAISE(ABORT, 'Nhân khẩu đang có tạm trú chồng chéo thời gian')
    END;
END;

-- Trigger kiểm tra tạm vắng không chồng chéo thời gian
CREATE TRIGGER IF NOT EXISTS trg_check_tam_vang_overlap
BEFORE INSERT ON tam_vang
FOR EACH ROW
BEGIN
    SELECT CASE
        WHEN EXISTS (
            SELECT 1 FROM tam_vang 
            WHERE ma_nhan_khau = NEW.ma_nhan_khau 
            AND trang_thai = 'DANG_TAM_VANG'
            AND (
                (NEW.tu_ngay BETWEEN tu_ngay AND den_ngay) OR
                (NEW.den_ngay BETWEEN tu_ngay AND den_ngay) OR
                (NEW.tu_ngay <= tu_ngay AND NEW.den_ngay >= den_ngay)
            )
        ) THEN
            RAISE(ABORT, 'Nhân khẩu đang có tạm vắng chồng chéo thời gian')
    END;
END;

-- 5. TẠO VIEWS CHO BÁO CÁO

-- View thống kê hộ khẩu chi tiết
CREATE VIEW IF NOT EXISTS vw_thong_ke_ho_khau AS
SELECT 
    hk.ma_ho_khau,
    hk.so_ho_khau,
    hk.dia_chi,
    hk.khu_vuc,
    hk.ngay_dang_ky,
    (SELECT ho_ten FROM nhan_khau WHERE ma_ho_khau = hk.ma_ho_khau AND quan_he_chu_ho = 'Chủ hộ' LIMIT 1) as chu_ho,
    COUNT(nk.ma_nhan_khau) as so_thanh_vien,
    SUM(CASE WHEN nk.gioi_tinh = 'Nam' THEN 1 ELSE 0 END) as so_nam,
    SUM(CASE WHEN nk.gioi_tinh = 'Nữ' THEN 1 ELSE 0 END) as so_nu,
    SUM(CASE WHEN nk.trang_thai = 'TAM_TRU' THEN 1 ELSE 0 END) as dang_tam_tru,
    SUM(CASE WHEN nk.trang_thai = 'TAM_VANG' THEN 1 ELSE 0 END) as dang_tam_vang
FROM ho_khau hk
LEFT JOIN nhan_khau nk ON hk.ma_ho_khau = nk.ma_ho_khau
WHERE hk.trang_thai = 'ACTIVE'
GROUP BY hk.ma_ho_khau;

-- View nhân khẩu chi tiết với thông tin hộ
CREATE VIEW IF NOT EXISTS vw_nhan_khau_chi_tiet AS
SELECT 
    nk.ma_nhan_khau,
    nk.ho_ten,
    nk.gioi_tinh,
    nk.ngay_sinh,
    CAST((julianday('now') - julianday(nk.ngay_sinh)) / 365.25 AS INTEGER) as tuoi,
    nk.so_cccd,
    nk.nghe_nghiep,
    nk.ma_ho_khau,
    hk.so_ho_khau,
    hk.dia_chi,
    nk.quan_he_chu_ho,
    nk.trang_thai,
    CASE 
        WHEN nk.trang_thai = 'TAM_TRU' THEN (SELECT dia_chi_tam_tru FROM tam_tru WHERE ma_nhan_khau = nk.ma_nhan_khau AND trang_thai = 'DANG_TAM_TRU' LIMIT 1)
        WHEN nk.trang_thai = 'TAM_VANG' THEN (SELECT dia_chi_tam_vang FROM tam_vang WHERE ma_nhan_khau = nk.ma_nhan_khau AND trang_thai = 'DANG_TAM_VANG' LIMIT 1)
        ELSE hk.dia_chi
    END as dia_chi_hien_tai
FROM nhan_khau nk
JOIN ho_khau hk ON nk.ma_ho_khau = hk.ma_ho_khau;

-- View thống kê biến động
CREATE VIEW IF NOT EXISTS vw_thong_ke_bien_dong AS
SELECT 
    'TACH_KHAU' as loai_bien_dong,
    COUNT(*) as so_luong,
    SUM(CASE WHEN trang_thai = 'CHO_DUYET' THEN 1 ELSE 0 END) as cho_duyet,
    SUM(CASE WHEN trang_thai = 'DA_DUYET' THEN 1 ELSE 0 END) as da_duyet
FROM tach_khau
UNION ALL
SELECT 
    'CHUYEN_KHAU' as loai_bien_dong,
    COUNT(*) as so_luong,
    SUM(CASE WHEN trang_thai = 'CHO_DUYET' THEN 1 ELSE 0 END) as cho_duyet,
    SUM(CASE WHEN trang_thai = 'DA_DUYET' THEN 1 ELSE 0 END) as da_duyet
FROM chuyen_khau
UNION ALL
SELECT 
    'TAM_TRU' as loai_bien_dong,
    COUNT(*) as so_luong,
    SUM(CASE WHEN trang_thai = 'DANG_TAM_TRU' THEN 1 ELSE 0 END) as dang_hoat_dong,
    0 as da_duyet
FROM tam_tru
UNION ALL
SELECT 
    'TAM_VANG' as loai_bien_dong,
    COUNT(*) as so_luong,
    SUM(CASE WHEN trang_thai = 'DANG_TAM_VANG' THEN 1 ELSE 0 END) as dang_hoat_dong,
    0 as da_duyet
FROM tam_vang;

-- 6. GHI LOG HOÀN THÀNH MIGRATION

INSERT INTO lich_su_thay_doi (bang, ma_ban_ghi, hanh_dong, du_lieu_moi, nguoi_thuc_hien)
VALUES ('system', 'migration', 'CREATE', 
        json_object(
            'migration_file', '002_add_constraints.sql',
            'description', 'Thêm indexes, triggers và views',
            'executed_at', datetime('now')
        ),
        'system');

-- =============================================
-- KẾT THÚC FILE MIGRATION
-- =============================================

.print "✅ Đã thêm thành công constraints, indexes và triggers"
.print "📊 Đã tạo các views cho báo cáo:"
.print "   - vw_thong_ke_ho_khau"
.print "   - vw_nhan_khau_chi_tiet" 
.print "   - vw_thong_ke_bien_dong"
.print "🔔 Các triggers đã được kích hoạt để ghi log tự động"
