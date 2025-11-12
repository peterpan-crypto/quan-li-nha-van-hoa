# Quản lý Nhà Văn Hóa - Skeleton

Cấu trúc dự án và file placeholder để phân công công việc. Các file ở dạng placeholder, chưa có logic thực thi.

Cấu trúc:

- ho-khau/
  - data/ho_khau.json
  - src/them_bos/them.py
  - src/chuyen/chuyen.py
  - src/tra_cuu/tra_cuu.py
  - docs/

- nha-van-hoa/
  - data/lich.json
  - src/lich/lich.py
  - src/nguoi/nguoi.py
  - src/tai_san/tai_san.py
  - docs/

- web/
  - ho_khau.html
  - nha_van_hoa.html
  - style.css
  - script.js

- app.py
- requirements.txt
- .gitignore

Hướng dẫn tiếp theo:
- Mỗi file trong `src/` cần triển khai logic riêng.
- Lập kế hoạch phân công: ai làm module nào, deadline, API contract.
- Viết tests cho các module sau khi có logic.
 
Team TODO (gợi ý phân công):

- Frontend (1 người):
  - Tạo form CRUD cho `ho_khau` và UI đặt lịch cho `nha-van-hoa`.
  - Viết `web/script.js` để gọi API và render kết quả.

- Backend - Ho Khau (1 người):
  - Implement CRUD trong `ho-khau/src` và lưu data vào `data/ho_khau.json` hoặc DB.
  - Viết tests.

- Backend - Nha Van Hoa (1 người):
  - Implement booking, resources, users trong `nha-van-hoa/src`.
  - Xử lý conflict detection cho lịch.

- DevOps / QA (1 người):
  - Viết scripts khởi tạo venv, cài dependencies, chạy server.
  - Thiết lập pytest và chạy CI (nếu có).

Next steps I can do for you:
- Tạo API stubs trong `app.py` cho các endpoints chính.
- Tạo OpenAPI spec (yaml) làm contract.
- Thêm pytest skeleton và một test ví dụ.
