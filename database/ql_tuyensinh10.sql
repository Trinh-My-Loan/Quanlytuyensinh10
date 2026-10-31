-- Tạo database tương thích mọi phiên bản MySQL cũ
CREATE DATABASE IF NOT EXISTS ql_tuyensinh10 CHARACTER SET utf8 COLLATE utf8_general_ci;
USE ql_tuyensinh10;

-- Tạo bảng users quản lý tài khoản và phân quyền
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    hoten VARCHAR(100) NOT NULL,
    role ENUM('thisinh', 'canbo', 'thuky', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Thêm dữ liệu mẫu cho các vai trò để test đăng nhập
INSERT INTO users (username, password, hoten, role) VALUES
('myloan', '123456', 'Trịnh Mỹ Loan', 'canbo'),
('hieunghia', '123456', 'Lê Hiếu Nghĩa', 'thuky'),
('thuytrang', '123456', 'Nguyễn Thùy Trang', 'thisinh'),
('ngocluong', '123456', 'Nguyễn Ngọc Lương', 'admin');