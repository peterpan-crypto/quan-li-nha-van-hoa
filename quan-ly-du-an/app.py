"""
Flask server placeholder for running local app.
"""
from flask import Flask, send_from_directory, jsonify
import os

app = Flask(__name__, static_folder='web')

@app.route('/')
def index():
    return send_from_directory('web', 'ho_khau.html')

@app.route('/api/health')
def health():
    return jsonify({'status': 'ok'})

if __name__ == '__main__':
    app.run(debug=True)

# TODOs - API and project tasks:
# - Thiết kế API endpoints cho ho_khau và nha-van-hoa (GET/POST/PUT/DELETE)
# - Tách module dịch vụ (service layer) để gọi các hàm trong ho-khau/src và nha-van-hoa/src
# - Thêm CORS nếu frontend sẽ gọi server từ domain khác
# - Thêm script chạy dev (venv + pip install -r requirements.txt)
# - Viết tests cho API (pytest + test client)
