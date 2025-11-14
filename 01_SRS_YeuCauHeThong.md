# PHẦN 1 – TÀI LIỆU ĐẶC TẢ YÊU CẦU PHẦN MỀM (SRS)
## HỆ THỐNG QUẢN LÝ HỘ KHẨU – NHÂN KHẨU

---

## 1. Giới thiệu

### 1.1 Mục tiêu
Hệ thống Quản lý Hộ khẩu – Nhân khẩu giúp cán bộ quản lý dân cư:
- Quản lý thông tin hộ khẩu và nhân khẩu trong từng hộ.
- Theo dõi quá trình tạm trú, tạm vắng, điều chỉnh nhân khẩu.
- Giảm tải thủ tục giấy tờ, hạn chế sai sót khi nhập dữ liệu.
- Trích xuất báo cáo nhanh chóng và chính xác.

### 1.2 Phạm vi
Hệ thống phục vụ:
- Cán bộ công an xã/phường.
- Cán bộ quản lý dân cư.
- Người dân cần tra cứu thông tin (tùy hệ thống).

### 1.3 Đối tượng sử dụng
- **Admin** – quản lý toàn bộ hệ thống.
- **Cán bộ quản lý (CBQL)** – quản lý hộ khẩu/nhân khẩu.
- **Công dân** – tra cứu (nếu mở rộng).

---

## 2. Tổng quan hệ thống
Hệ thống cho phép:
- Tạo mới hộ khẩu, thêm nhân khẩu vào hộ.
- Quản lý trạng thái nhân khẩu: thường trú, tạm trú, tạm vắng.
- Chuyển nhân khẩu giữa các hộ.
- Lưu lịch sử thay đổi hộ khẩu.
- Tìm kiếm và thống kê theo nhiều tiêu chí.

---

## 3. Yêu cầu chức năng

### 3.1 Danh sách Use Case cấp 1
1. UC01 – Quản lý Hộ khẩu  
2. UC02 – Quản lý Nhân khẩu  
3. UC03 – Quản lý Tạm trú  
4. UC04 – Quản lý Tạm vắng  
5. UC05 – Chuyển nhân khẩu  
6. UC06 – Tra cứu  
7. UC07 – Thống kê – báo cáo  
8. UC08 – Quản trị hệ thống  

(Chi tiết phân rã ở file 02.)

---

## 4. Yêu cầu phi chức năng

### 4.1 Hiệu năng
- Xử lý 1000 bản ghi/s trên cơ sở dữ liệu.
- Phản hồi giao diện < 2 giây.

### 4.2 Bảo mật
- Mã hóa mật khẩu theo bcrypt.
- Phân quyền theo vai trò.
- Lưu log lịch sử thao tác.

### 4.3 Tính khả dụng
- Hệ thống chạy 24/7.
- Backup dữ liệu hằng ngày.

### 4.4 Tính mở rộng
- Cho phép mở rộng thành hệ thống quản lý dân cư cấp tỉnh.

---

## 5. Ràng buộc nghiệp vụ
- Mỗi hộ khẩu phải có một **chủ hộ**.
- Một cá nhân chỉ có **một hộ khẩu thường trú** duy nhất.
- Tách hộ cần sự phê duyệt của cán bộ.
- Mọi thay đổi nhân khẩu đều được ghi vào **Lịch sử thay đổi**.
