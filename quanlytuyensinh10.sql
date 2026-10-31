-- CSDL QUAN LY DANG KY NGUYEN VONG TUYEN SINH LOP 10
-- Pham vi: dia ban TP.HCM cu; ten phuong/xa theo sap xep 2025.
-- Du lieu truong: danh sach cong khai tham khao danh sach THPT TP.HCM 2026.
-- Luu y: dia_chi_so_nha de NULL neu nguon tham khao chi xac dinh duoc phuong/xa.
-- Import bang phpMyAdmin > chon tab SQL > dan TOAN BO file nay.
SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;
DROP DATABASE IF EXISTS quanlytuyensinh10;
CREATE DATABASE quanlytuyensinh10 CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE quanlytuyensinh10;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE phuong_xa (
 id_phuong_xa INT AUTO_INCREMENT PRIMARY KEY,
 ten_phuong_xa VARCHAR(120) NOT NULL UNIQUE,
 loai_don_vi ENUM('Phường','Xã') NOT NULL
) ENGINE=InnoDB;

CREATE TABLE truong_thpt (
 id_truong INT AUTO_INCREMENT PRIMARY KEY,
 ma_truong VARCHAR(20) NOT NULL UNIQUE,
 ten_truong VARCHAR(200) NOT NULL,
 dia_chi_so_nha VARCHAR(255) NULL,
 id_phuong_xa INT NOT NULL,
 loai_hinh ENUM('Công lập') NOT NULL DEFAULT 'Công lập',
 duoc_tuyen_sinh_lop10 TINYINT(1) NOT NULL DEFAULT 1,
 trang_thai TINYINT(1) NOT NULL DEFAULT 1,
 ghi_chu VARCHAR(255) NULL,
 CONSTRAINT fk_truong_phuong FOREIGN KEY (id_phuong_xa) REFERENCES phuong_xa(id_phuong_xa),
 INDEX idx_truong_phuong (id_phuong_xa, duoc_tuyen_sinh_lop10)
) ENGINE=InnoDB;

CREATE TABLE thi_sinh (
 id_thi_sinh INT AUTO_INCREMENT PRIMARY KEY,
 ma_thi_sinh VARCHAR(30) NOT NULL UNIQUE,
 ho_ten VARCHAR(150) NOT NULL,
 ngay_sinh DATE NULL,
 gioi_tinh ENUM('Nam','Nữ','Khác') NULL,
 email VARCHAR(150) NULL,
 so_dien_thoai VARCHAR(20) NULL,
 dia_chi VARCHAR(255) NULL,
 id_phuong_xa INT NULL,
 mat_khau VARCHAR(255) NULL,
 ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (id_phuong_xa) REFERENCES phuong_xa(id_phuong_xa)
) ENGINE=InnoDB;

CREATE TABLE dot_tuyen_sinh (
 id_dot INT AUTO_INCREMENT PRIMARY KEY,
 ten_dot VARCHAR(150) NOT NULL,
 nam_hoc VARCHAR(20) NOT NULL,
 ngay_bat_dau DATETIME NULL,
 ngay_ket_thuc DATETIME NULL,
 trang_thai ENUM('Chưa mở','Đang mở','Đã đóng') NOT NULL DEFAULT 'Chưa mở'
) ENGINE=InnoDB;

CREATE TABLE dang_ky_nguyen_vong (
 id_dang_ky INT AUTO_INCREMENT PRIMARY KEY,
 id_thi_sinh INT NOT NULL,
 id_dot INT NOT NULL,
 ngay_dang_ky DATETIME NULL,
 ngay_cap_nhat DATETIME NULL,
 trang_thai ENUM('Nháp','Đã nộp','Đã xác nhận','Đã hủy') NOT NULL DEFAULT 'Nháp',
 UNIQUE KEY uq_thi_sinh_dot (id_thi_sinh,id_dot),
 FOREIGN KEY (id_thi_sinh) REFERENCES thi_sinh(id_thi_sinh),
 FOREIGN KEY (id_dot) REFERENCES dot_tuyen_sinh(id_dot)
) ENGINE=InnoDB;

CREATE TABLE chi_tiet_nguyen_vong (
 id_chi_tiet INT AUTO_INCREMENT PRIMARY KEY,
 id_dang_ky INT NOT NULL,
 thu_tu_nguyen_vong TINYINT NOT NULL,
 id_phuong_xa INT NOT NULL,
 id_truong INT NOT NULL,
 UNIQUE KEY uq_thu_tu (id_dang_ky,thu_tu_nguyen_vong),
 UNIQUE KEY uq_truong (id_dang_ky,id_truong),
 CHECK (thu_tu_nguyen_vong BETWEEN 1 AND 3),
 FOREIGN KEY (id_dang_ky) REFERENCES dang_ky_nguyen_vong(id_dang_ky) ON DELETE CASCADE,
 FOREIGN KEY (id_phuong_xa) REFERENCES phuong_xa(id_phuong_xa),
 FOREIGN KEY (id_truong) REFERENCES truong_thpt(id_truong)
) ENGINE=InnoDB;

INSERT INTO phuong_xa (ten_phuong_xa,loai_don_vi) VALUES
('Phường An Hội Đông','Phường'),
('Phường An Lạc','Phường'),
('Phường An Nhơn','Phường'),
('Phường Bình Hưng Hòa','Phường'),
('Phường Bình Lợi Trung','Phường'),
('Phường Bình Phú','Phường'),
('Phường Bình Thới','Phường'),
('Phường Bình Tiên','Phường'),
('Phường Bình Trưng','Phường'),
('Phường Bình Trị Đông','Phường'),
('Phường Bình Tân','Phường'),
('Phường Bình Đông','Phường'),
('Phường Bến Thành','Phường'),
('Phường Chánh Hưng','Phường'),
('Phường Chợ Lớn','Phường'),
('Phường Cầu Ông Lãnh','Phường'),
('Phường Diên Hồng','Phường'),
('Phường Gia Định','Phường'),
('Phường Hiệp Bình','Phường'),
('Phường Hòa Bình','Phường'),
('Phường Hòa Hưng','Phường'),
('Phường Hạnh Thông','Phường'),
('Phường Linh Xuân','Phường'),
('Phường Long Bình','Phường'),
('Phường Long Trường','Phường'),
('Phường Minh Phụng','Phường'),
('Phường Phú Lâm','Phường'),
('Phường Phú Nhuận','Phường'),
('Phường Phú Thọ Hòa','Phường'),
('Phường Phú Định','Phường'),
('Phường Phước Long','Phường'),
('Phường Sài Gòn','Phường'),
('Phường Tam Bình','Phường'),
('Phường Thông Tây Hội','Phường'),
('Phường Thạnh Mỹ Tây','Phường'),
('Phường Thủ Đức','Phường'),
('Phường Tân Bình','Phường'),
('Phường Tân Hòa','Phường'),
('Phường Tân Hưng','Phường'),
('Phường Tân Mỹ','Phường'),
('Phường Tân Sơn Nhì','Phường'),
('Phường Tân Sơn Nhất','Phường'),
('Phường Tân Thới Hiệp','Phường'),
('Phường Tân Định','Phường'),
('Phường Tây Thạnh','Phường'),
('Phường Tăng Nhơn Phú','Phường'),
('Phường Vườn Lài','Phường'),
('Phường Xuân Hòa','Phường'),
('Phường Xóm Chiếu','Phường'),
('Phường Đông Hưng Thuận','Phường'),
('Phường Đức Nhuận','Phường'),
('Xã An Nhơn Tây','Xã'),
('Xã Bà Điểm','Xã'),
('Xã Bình Chánh','Xã'),
('Xã Bình Hưng','Xã'),
('Xã Bình Khánh','Xã'),
('Xã Bình Lợi','Xã'),
('Xã Cần Giờ','Xã'),
('Xã Củ Chi','Xã'),
('Xã Hiệp Phước','Xã'),
('Xã Hóc Môn','Xã'),
('Xã Nhà Bè','Xã'),
('Xã Phú Hòa Đông','Xã'),
('Xã Thái Mỹ','Xã'),
('Xã Tân An Hội','Xã'),
('Xã Tân Nhựt','Xã'),
('Xã Tân Vĩnh Lộc','Xã'),
('Xã Xuân Thới Sơn','Xã'),
('Xã Đông Thạnh','Xã');

INSERT INTO truong_thpt (ma_truong,ten_truong,id_phuong_xa,ghi_chu) VALUES
('HCM001','THPT Trưng Vương',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Sài Gòn'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM002','THPT Năng khiếu TDTT',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Định'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM003','THPT Ten Lơ Man',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bến Thành'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM004','THPT Bùi Thị Xuân',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bến Thành'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM005','THPT Lương Thế Vinh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Cầu Ông Lãnh'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM006','THPT Nguyễn Thị Minh Khai',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Xuân Hòa'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM007','THPT Marie Curie',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Xuân Hòa'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM008','THPT Nguyễn Thị Diệu',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Xuân Hòa'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM009','THPT Nguyễn Trãi',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Xóm Chiếu'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM010','THPT Nguyễn Hữu Thọ',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Xóm Chiếu'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM011','THPT Trần Hữu Trang',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Chợ Lớn'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM012','THPT Phạm Phú Thứ',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Tiên'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM013','THPT Nguyễn Tất Thành',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Phú'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM014','THPT Mạc Đĩnh Chi',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Phú Lâm'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM015','THPT Nam Sài Gòn',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Mỹ'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM016','THPT Tân Phong',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Hưng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM017','THPT Lê Thánh Tôn',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Hưng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM018','THPT Lương Văn Can',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Chánh Hưng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM019','THPT Ngô Gia Tự',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Phú Định'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM020','PT Năng khiếu TDTT Nguyễn Thị Định',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Phú Định'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM021','THPT Võ Văn Kiệt',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Phú Định'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM022','THPT Tạ Quang Bửu',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Đông'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM023','THPT Nguyễn Văn Linh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Đông'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM024','THPT Diên Hồng',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Diên Hồng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM025','THPT Sương Nguyệt Anh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Vườn Lài'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM026','THPT Nguyễn An Ninh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Vườn Lài'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM027','THPT Nguyễn Khuyến',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Hòa Hưng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM028','THPT Nguyễn Du',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Hòa Hưng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM029','THPT Nam Kỳ Khởi Nghĩa',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Minh Phụng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM030','THPT Nguyễn Hiền',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Thới'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM031','THPT Trần Quang Khải',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Hòa Bình'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM032','THPT Trường Chinh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Đông Hưng Thuận'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM033','THPT Võ Trường Toản',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Thới Hiệp'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM034','THPT An Lạc',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường An Lạc'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM035','THPT Hoàng Thế Thiện',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường An Lạc'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM036','THPT Bình Tân',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Tân'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM037','THPT Vĩnh Lộc',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Tân'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM038','THPT Nguyễn Hữu Cảnh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Trị Đông'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM039','THPT Bình Hưng Hòa',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Hưng Hòa'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM040','THPT Hoàng Hoa Thám',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Gia Định'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM041','THPT Võ Thị Sáu',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Gia Định'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM042','THPT Phan Đăng Lưu',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Lợi Trung'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM043','THPT Trần Văn Giàu',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Lợi Trung'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM044','THPT Gia Định',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Thạnh Mỹ Tây'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM045','THPT Gò Vấp',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Hạnh Thông'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM046','THPT Trần Hưng Đạo',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường An Nhơn'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM047','THPT Nguyễn Trung Trực',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường An Hội Đông'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM048','THPT Nguyễn Công Trứ',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Thông Tây Hội'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM049','THPT Phú Nhuận',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Đức Nhuận'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM050','THPT Hàn Thuyên',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Phú Nhuận'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM051','THPT Nguyễn Thượng Hiền',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Sơn Nhất'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM052','THPT Nguyễn Thái Bình',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Hòa'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM053','THPT Nguyễn Chí Thanh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Bình'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM054','THPT Tây Thạnh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tây Thạnh'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM055','THPT Tân Bình',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Sơn Nhì'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM056','THPT Lê Trọng Tấn',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tân Sơn Nhì'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM057','THPT Trần Phú',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Phú Thọ Hòa'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM058','THPT Hiệp Bình',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Hiệp Bình'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM059','THPT Thủ Đức',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Thủ Đức'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM060','THPT Nguyễn Hữu Huân',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Thủ Đức'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM061','THPT Tam Phú',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tam Bình'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM062','THPT Bình Chiểu',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tam Bình'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM063','THPT Linh Trung',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Linh Xuân'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM064','THPT Đào Sơn Tây',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Linh Xuân'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM065','THPT Dương Văn Thì',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Tăng Nhơn Phú'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM066','THPT Nguyễn Huệ',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Long Bình'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM067','THPT Nguyễn Văn Tăng',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Long Bình'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM068','THPT Long Trường',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Long Trường'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM069','THPT Thủ Thiêm',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Trưng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM070','THPT Giồng Ông Tố',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Bình Trưng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM071','THPT Phước Long',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Phường Phước Long'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM072','THPT Vĩnh Lộc B',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Tân Vĩnh Lộc'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM073','THPT Lê Minh Xuân',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Bình Lợi'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM074','THPT Năng khiếu TDTT Huyện Bình Chánh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Bình Lợi'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM075','THPT Tân Túc',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Tân Nhựt'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM076','THPT Bình Chánh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Bình Chánh'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM077','THPT Phong Phú',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Bình Hưng'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM078','THPT An Nghĩa',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Bình Khánh'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM079','THPT Bình Khánh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Bình Khánh'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM080','THPT Cần Thạnh',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Cần Giờ'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM081','THPT Tân Thông Hội',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Củ Chi'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM082','THPT Củ Chi',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Tân An Hội'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM083','THPT Quang Trung',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Thái Mỹ'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM084','THPT Trung Lập',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Thái Mỹ'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM085','THPT An Nhơn Tây',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã An Nhơn Tây'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM086','THPT Trung Phú',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Phú Hòa Đông'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM087','THPT Phú Hòa',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Phú Hòa Đông'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM088','THPT Nguyễn Hữu Tiến',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Đông Thạnh'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM089','THPT Lý Thường Kiệt',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Đông Thạnh'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM090','THPT Hồ Thị Bi',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Hóc Môn'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM091','THPT Phạm Văn Sáng',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Xuân Thới Sơn'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM092','THPT Nguyễn Văn Cừ',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Bà Điểm'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM093','THPT Dương Văn Dương',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Nhà Bè'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc'),
('HCM094','THPT Long Thới',(SELECT id_phuong_xa FROM phuong_xa WHERE ten_phuong_xa='Xã Hiệp Phước'),'Phuong/xa theo danh sach dia ban sau sap xep 2025; can doi chieu lai dia chi chi tiet truoc khi van hanh chinh thuc');

INSERT INTO dot_tuyen_sinh (ten_dot,nam_hoc,ngay_bat_dau,ngay_ket_thuc,trang_thai)
VALUES ('Tuyển sinh vào lớp 10 công lập','2026-2027',NULL,NULL,'Chưa mở');

-- Tuong thich MySQL cu: ngay_dang_ky va ngay_cap_nhat duoc cap nhat bang NOW() tu PHP khi them/sua ho so.
-- Tai khoan/thi sinh mau de kiem tra (khong phai du lieu hoc sinh that)
INSERT INTO thi_sinh (ma_thi_sinh,ho_ten,ngay_sinh,gioi_tinh,email,so_dien_thoai,dia_chi)
VALUES ('TS_DEMO_001','Nguyễn Văn An','2011-05-10','Nam','demo@example.com','0900000000','Địa chỉ mẫu');

-- Ho so mau de kiem tra; co the xoa 2 dong mau nay khi dung that
INSERT INTO dang_ky_nguyen_vong (id_thi_sinh,id_dot,ngay_dang_ky,ngay_cap_nhat,trang_thai)
VALUES (1,1,NOW(),NOW(),'Nháp');

-- Mau NV1, NV2, NV3: de trong de nguoi dung tu dang ky.
-- Truy van loc truong theo phuong/xa:
-- SELECT id_truong,ten_truong FROM truong_thpt
-- WHERE id_phuong_xa=? AND duoc_tuyen_sinh_lop10=1 AND trang_thai=1
-- ORDER BY ten_truong;
