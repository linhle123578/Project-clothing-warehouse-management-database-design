create database DO_AN
go
CREATE TABLE loai_quan_ao(
 maloaiqa varchar(5) primary key,
 loaiqa nvarchar(50),
)

CREATE TABLE quan_ao (
 maquanao varchar(5)primary key,
 tenquanao nvarchar (50),
 donvitinh nvarchar(50),
 giagoc int,
 soluongtonkho int,
 maloaiqa varchar(5),
 manhacungcap varchar(6),
 makho varchar(6),
)

CREATE TABLE phieu_nhap(
 maphieunhap varchar(5)primary key,
 ngaynhap date,
 manhanvien varchar(5),
 manhacungcap varchar(6),
 makho varchar(6),
)

CREATE TABLE chi_tiet_pn (
 maphieunhap varchar(5),
 maquanao varchar(5),
 soluong int,
 dongia int,
 thanhtien int,
 primary key(maphieunhap,maquanao)
)

CREATE TABLE nha_cung_cap (
 manhacungcap varchar(6) primary key,
 tennhacungcap nvarchar(100),
 diachincc nvarchar(150),
 sodienthoai char(10),
 email varchar(100) NOT NULL,
 )

 CREATE TABLE nhan_vien(
  manv varchar(5)primary key,
  honv nvarchar(20),
  tennv nvarchar(20),
  ngaysinh date,
  noisinh nvarchar(20),
  vaitro nvarchar(10),
  makho varchar(6),
 )

 CREATE TABLE kho(
  makho varchar(6) primary key,
  tenkho nvarchar(50),
  diachi nvarchar(150),
  manvtruong varchar(5) NOT NULL,
 )

 CREATE TABLE khach_hang (
  makh varchar(5) primary key,
  tenkh nvarchar(50),
  diachikh nvarchar(150),
  sdt char(10),
 )

 CREATE TABLE phieu_xuat(
  maphieuxuat varchar(5) primary key,
  ngayxuat date,
  manv varchar(5),
  makh varchar (5),
  makho varchar(6),
 )

 CREATE TABLE chi_tiet_px(
  maphieuxuat varchar(5),
  maquanao varchar(5),
  soluong int,
  dongia int,
  thanhtien int,
  primary key(maphieuxuat, maquanao)
 )

 CREATE TABLE phieu_tra_hang(
  maphieutra varchar(5)primary key,
  ngaytra date,
  makho varchar(6),
  manv varchar(5),
  makh varchar(5),
 )

 CREATE TABLE chi_tiet_pt(
  maphieutra varchar(5),
  maquanao varchar(5),
  soluong int,
  lydo nvarchar(150),
  primary key (maphieutra, maquanao)
 )

 INSERT INTO loai_quan_ao (maloaiqa, loaiqa)
 VALUES 
    ('QA001', N'Áo thun'),
    ('QA002', N'Áo sơ mi'),
    ('QA003', N'Quần jean'),
    ('QA004', N'Quần tây'),
    ('QA005', N'Váy ngắn'),
    ('QA006', N'Đầm dự tiệc'),
    ('QA007', N'Áo khoác'),
    ('QA008', N'Quần short'),
    ('QA009', N'Đồ thể thao'),
    ('QA010', N'Áo len');

	INSERT INTO nha_cung_cap (manhacungcap, tennhacungcap, diachincc, sodienthoai, email)
    VALUES
    ('NCC001', N'Công ty TNHH Thời Trang Việt', N'123 Đường Lê Lợi, Quận 1, TP.HCM', '0901234567', N'info@thoitrangviet.vn'),
    ('NCC002', N'Công ty CP May Mặc Hà Nội', N'456 Phố Huế, Quận Hai Bà Trưng, Hà Nội', '0912345678', N'contact@maymachanoi.vn'),
    ('NCC003', N'Công ty TNHH Thời Trang Quốc Tế', N'789 Đường Nguyễn Trãi, Quận Thanh Xuân, Hà Nội', '0923456789', N'sales@thoitrangqt.vn'),
    ('NCC004', N'Công ty TNHH May Phương Nam', N'321 Đường Lê Văn Sỹ, Quận 3, TP.HCM', '0934567890', N'support@mayphuongnam.vn'),
    ('NCC005', N'Công ty CP Thời Trang Cao Cấp', N'654 Đường Điện Biên Phủ, Quận Bình Thạnh, TP.HCM', '0945678901', N'luxuryfashion@caocap.vn');

	INSERT INTO kho (makho, tenkho, diachi, manvtruong)
    VALUES
    ('KHO001', N'Kho A', N'12/14 Trường Chinh, Quận Tân Bình, TP.HCM', 'NV001'),
    ('KHO002', N'Kho B', N'457/65 Hai Bà Trưng, Quận 1, TP.HCM', 'NV004'),
    ('KHO003', N'Kho C', N'165/21 Phạm Ngũ Lão, Quận 1, TP.HCM', 'NV006'),
    ('KHO004', N'Kho D', N'321 Đường Lý Thường Kiệt, Quận Tân Bình, TP.HCM', 'NV016'),
    ('KHO005', N'Kho E', N'654 Đường 3 tháng 2, Quận 10, TP.HCM', 'NV017');
	
	INSERT INTO nhan_vien (manv, honv, tennv, ngaysinh, noisinh, vaitro, makho)
    VALUES
    ('NV001', N'Nguyễn', N'Văn An', '1990-05-10', N'Hà Nội', N'Quản lý', 'KHO001'),
    ('NV002', N'Trần', N'Thị Bích', '1992-08-15', N'Hải Phòng', N'Xuất hàng', 'KHO002'),
    ('NV003', N'Lê', N'Hoàng Nam', '1988-03-22', N'Đà Nẵng', N'Nhập hàng', 'KHO003'),
    ('NV004', N'Phạm', N'Minh Thư', '1995-11-30', N'TP.HCM', N'Quản lý', 'KHO002'),
    ('NV005', N'Hoàng', N'Thị Lan', '1993-07-18', N'Huế', N'Trả hàng', 'KHO002'),
    ('NV006', N'Ngô', N'Huy Hoàng', '1985-04-12', N'Hà Nội', N'Quản lý', 'KHO003'),
    ('NV007', N'Vũ', N'Thanh Huyền', '1994-06-09', N'Nam Định', N'Xuất hàng', 'KHO001'),
    ('NV008', N'Đỗ', N'Quốc Bảo', '1990-12-21', N'Hà Tĩnh', N'Trả hàng', 'KHO002'),
    ('NV009', N'Phan', N'Thu Trang', '1996-02-17', N'Quảng Ninh', N'Trả hàng', 'KHO003'),
    ('NV010', N'Bùi', N'Đức Duy', '1991-08-25', N'Hải Dương', N'Nhập hàng', 'KHO001'),
    ('NV011', N'Nguyễn', N'Mai Anh', '1993-10-15', N'Ninh Bình', N'Nhập hàng', 'KHO002'),
    ('NV012', N'Trần', N'Thành Công', '1987-09-30', N'Thái Bình', N'Xuất hàng', 'KHO003'),
    ('NV013', N'Lê', N'Thanh Tú', '1995-01-05', N'Thanh Hóa', N'Trả hàng', 'KHO001'),
    ('NV014', N'Phạm', N'Thùy Linh', '1992-03-12', N'Hà Nội', N'Nhập hàng', 'KHO002'),
    ('NV015', N'Hoàng', N'Văn Sơn', '1990-07-07', N'Quảng Nam', N'Xuất hàng', 'KHO003'),
	('NV016', N'Nguyễn', N'Hồng Sơn', '1990-07-08', N'Quảng Ngãi', N'Quản lý', 'KHO004'),
	('NV017', N'Hoàng', N'Văn Thanh', '1990-09-07', N'Đồng Nai', N'Quản lý', 'KHO005'),
	('NV018', N'Nguyễn', N'Hoàng Long', '1995-05-20', N'Hà Nội', N'Nhập hàng', 'KHO004'),
    ('NV019', N'Lê', N'Thu Hương', '1992-10-15', N'Nam Định', N'Xuất hàng', 'KHO004'),
    ('NV020', N'Trần', N'Văn Tài', '1990-08-25', N'Hà Nam', N'Trả hàng', 'KHO004'),
    ('NV021', N'Phạm', N'Thanh Bình', '1994-03-12', N'Hải Phòng', N'Nhập hàng', 'KHO005'),
    ('NV022', N'Hoàng', N'Thị Ngọc', '1991-06-22', N'Quảng Ninh', N'Xuất hàng', 'KHO005'),
    ('NV023', N'Ngô', N'Đức Anh', '1996-12-30', N'Thái Bình', N'Trả hàng', 'KHO005'),
    ('NV024', N'Vũ', N'Thảo Trang', '1993-07-18', N'Đà Nẵng', N'Nhập hàng', 'KHO001'),
    ('NV025', N'Đỗ', N'Mạnh Hùng', '1995-02-10', N'Huế', N'Xuất hàng', 'KHO002'),
    ('NV026', N'Nguyễn', N'Thị Hoa', '1992-11-05', N'Quảng Nam', N'Trả hàng', 'KHO003');

	INSERT INTO khach_hang (makh, tenkh, diachikh, sdt)
    VALUES
    ('KH001', N'Công ty TNHH Co.opmart', N'789 Đường Điện Biên Phủ, Quận Bình Thạnh, TP.HCM', '0923456789'),
    ('KH002', N'Công ty CP Big C Việt Nam', N'321 Đường Võ Văn Kiệt, Quận 5, TP.HCM', '0934567890'),
    ('KH003', N'Công ty TNHH Lotte Mart', N'654 Đường Trần Hưng Đạo, Quận 10, TP.HCM', '0945678901'),
    ('KH004', N'Công ty CP AEON Việt Nam', N'987 Đường Phạm Văn Đồng, Quận Thủ Đức, TP.HCM', '0956789012'),
    ('KH005', N'Công ty TNHH Satrafoods', N'111 Đường Lê Văn Sỹ, Quận Phú Nhuận, TP.HCM', '0967890123'),
    ('KH006', N'Công ty TNHH Thời Trang Ivy Moda', N'12 Đường Nguyễn Đình Chiểu, Quận 1, TP.HCM', '0902123456'),
    ('KH007', N'Công ty CP Thời Trang Elise', N'34 Đường Hai Bà Trưng, Quận 3, TP.HCM', '0913234567'),
    ('KH008', N'Công ty CP Thời Trang Việt (Viettien)', N'56 Đường Nguyễn Văn Trỗi, Quận Phú Nhuận, TP.HCM', '0924345678'),
    ('KH009', N'Công ty TNHH Hoàng Phúc Quốc Tế', N'78 Đường Trần Quang Khải, Quận 1, TP.HCM', '0935456789'),
    ('KH010', N'Công ty TNHH Canifa', N'90 Đường Cách Mạng Tháng 8, Quận 10, TP.HCM', '0946567890'),
    ('KH011', N'Công ty CP Thời Trang Juno', N'123 Đường Phan Đăng Lưu, Quận Bình Thạnh, TP.HCM', '0957678901'),
    ('KH012', N'Công ty TNHH Yody Việt Nam', N'234 Đường Võ Thị Sáu, Quận 3, TP.HCM', '0968789012'),
    ('KH013', N'Công ty TNHH Thời Trang Canali', N'345 Đường Nguyễn Trãi, Quận 5, TP.HCM', '0979890123'),
    ('KH014', N'Công ty TNHH Giordano Việt Nam', N'456 Đường Lê Văn Sỹ, Quận Tân Bình, TP.HCM', '0980901234'),
    ('KH015', 'Công ty CP Owen', '567 Đường Quang Trung, Quận Gò Vấp, TP.HCM', '0991012345');

    INSERT INTO quan_ao (maquanao, tenquanao, donvitinh, giagoc, soluongtonkho, maloaiqa, manhacungcap, makho)
    VALUES
    ('HH001', N'Áo thun nam', N'Chiếc', 120000, 50, 'QA001', 'NCC001', 'KHO001'),
    ('HH002', N'Áo thun nữ', N'Chiếc', 100000, 40, 'QA001', 'NCC002', 'KHO004'),
    ('HH003', N'Áo sơ mi trắng', N'Chiếc', 150000, 60, 'QA002', 'NCC003', 'KHO001'),
    ('HH004', N'Áo sơ mi caro', N'Chiếc', 170000, 30, 'QA002', 'NCC004', 'KHO002'),
    ('HH005', N'Quần jean xanh', N'Chiếc', 250000, 70, 'QA003', 'NCC005', 'KHO004'),
    ('HH006', N'Quần jean đen', N'Chiếc', 270000, 50, 'QA003', 'NCC001', 'KHO001'),
    ('HH007', N'Quần tây đen', N'Chiếc', 300000, 40, 'QA004', 'NCC002', 'KHO003'),
    ('HH008', N'Quần tây xanh', N'Chiếc', 320000, 25, 'QA004', 'NCC003', 'KHO002'),
    ('HH009', N'Váy ngắn xòe', N'Chiếc', 200000, 35, 'QA005', 'NCC004', 'KHO001'),
    ('HH010', N'Váy ngắn ôm', N'Chiếc', 220000, 20, 'QA005', 'NCC005', 'KHO002'),
    ('HH011', N'Đầm dự tiệc ren', N'Chiếc', 500000, 15, 'QA006', 'NCC001', 'KHO004'),
    ('HH012', N'Đầm dự tiệc lụa', N'Chiếc', 700000, 10, 'QA006', 'NCC002', 'KHO001'),
    ('HH013', N'Áo khoác da', N'Chiếc', 800000, 20, 'QA007', 'NCC003', 'KHO002'),
    ('HH014', N'Áo khoác jeans', N'Chiếc', 600000, 25, 'QA007', 'NCC004', 'KHO005'),
    ('HH015', N'Quần short nam', N'Chiếc', 150000, 50, 'QA008', 'NCC005', 'KHO001'),
    ('HH016', N'Quần short nữ', N'Chiếc', 130000, 45, 'QA008', 'NCC001', 'KHO002'),
    ('HH017', N'Bộ đồ thể thao nam', N'Bộ', 400000, 30, 'QA009', 'NCC002', 'KHO003'),
    ('HH018', N'Bộ đồ thể thao nữ', N'Bộ', 380000, 25, 'QA009', 'NCC003', 'KHO001'),
    ('HH019', N'Áo len nam', N'Chiếc', 250000, 40, 'QA010', 'NCC004', 'KHO002'),
    ('HH020', N'Áo len nữ', N'Chiếc', 230000, 35, 'QA010', 'NCC005', 'KHO003'),
    ('HH021', N'Áo sơ mi cổ tàu', N'Chiếc', 180000, 50, 'QA002', 'NCC001', 'KHO001'),
    ('HH022', N'Quần jean rách gối', N'Chiếc', 290000, 40, 'QA003', 'NCC002', 'KHO005'),
    ('HH023', N'Váy maxi dài', N'Chiếc', 300000, 20, 'QA005', 'NCC003', 'KHO003'),
    ('HH024', N'Đầm dự tiệc cao cấp', N'Chiếc', 900000, 8, 'QA006', 'NCC004', 'KHO001'),
    ('HH025', N'Áo khoác dạ', N'Chiếc', 1000000, 12, 'QA007', 'NCC005', 'KHO005'),
    ('HH026', N'Quần short bò', N'Chiếc', 180000, 30, 'QA008', 'NCC001', 'KHO003'),
    ('HH027', N'Áo thun cổ tròn', N'Chiếc', 110000, 60, 'QA001', 'NCC002', 'KHO001'),
    ('HH028', N'Áo sơ mi cổ chữ V', N'Chiếc', 200000, 45, 'QA002', 'NCC003', 'KHO002'),
    ('HH029', N'Quần jogger', N'Chiếc', 320000, 25, 'QA003', 'NCC004', 'KHO003'),
    ('HH030', N'Bộ đồ thể thao trẻ em', N'Bộ', 350000, 20, 'QA009', 'NCC005', 'KHO001');

	INSERT INTO phieu_nhap (maphieunhap, ngaynhap, manhanvien, manhacungcap, makho)
    VALUES
    ('PN001', '2024-11-01', 'NV010', 'NCC001', 'KHO001'),
    ('PN002', '2024-11-02', 'NV018', 'NCC002', 'KHO004'),
    ('PN003', '2024-11-03', 'NV024', 'NCC003', 'KHO001'),
    ('PN004', '2024-11-04', 'NV011', 'NCC004', 'KHO002'),
    ('PN005', '2024-11-05', 'NV018', 'NCC005', 'KHO004');

	INSERT INTO chi_tiet_pn (maphieunhap, maquanao, soluong, dongia, thanhtien)
    VALUES
    ('PN001', 'HH001', 10, 50000, 500000),
    ('PN001', 'HH002', 15, 30000, 450000),
    ('PN002', 'HH001', 5, 50000, 250000),
    ('PN002', 'HH005', 8, 35000, 280000),
    ('PN003', 'HH002', 12, 30000, 360000),
    ('PN003', 'HH003', 10, 20000, 200000),
    ('PN003', 'HH006', 25, 25000, 625000),
    ('PN004', 'HH004', 15, 40000, 600000),
    ('PN004', 'HH007', 30, 45000, 1350000),
    ('PN004', 'HH008', 20, 50000, 1000000),
    ('PN005', 'HH009', 12, 60000, 720000);
	
	INSERT INTO phieu_xuat (maphieuxuat, ngayxuat, manv, makh, makho)
    VALUES
    ('PX001', '2024-11-10', 'NV007', 'KH010', 'KHO001'),
    ('PX002', '2024-11-11', 'NV002', 'KH002', 'KHO002'),
    ('PX003', '2024-11-12', 'NV015', 'KH015', 'KHO003'),
    ('PX004', '2024-11-13', 'NV015', 'KH004', 'KHO003'),
    ('PX005', '2024-11-14', 'NV019', 'KH005', 'KHO004');
	
	INSERT INTO chi_tiet_px (maphieuxuat, maquanao, soluong, dongia, thanhtien)
    VALUES
    ('PX001', 'HH001', 5, 120000, 600000),
    ('PX001', 'HH003', 10, 150000, 1500000),
    ('PX001', 'HH009', 8, 200000, 1600000),
    ('PX002', 'HH004', 7, 170000, 1190000),
    ('PX002', 'HH010', 5, 220000, 1100000),
    ('PX003', 'HH007', 9, 300000, 2700000),
    ('PX004', 'HH017', 10, 400000, 4000000),
    ('PX005', 'HH011', 5, 500000, 2500000);

 INSERT INTO phieu_tra_hang (maphieutra, ngaytra, makho, manv, makh)
 VALUES
    ('PT001', '2024-11-15', 'KHO001', 'NV013', 'KH010'),
    ('PT002', '2024-11-16', 'KHO004', 'NV020', 'KH005');

 INSERT INTO chi_tiet_pt (maphieutra, maquanao, soluong, lydo)
 VALUES
    ('PT001', 'HH001', 2, N'Sản phẩm bị lỗi'),
    ('PT001', 'HH003', 1, N'Sản phẩm không đúng yêu cầu'),
    ('PT002', 'HH011', 2, N'Chất lượng không đạt yêu cầu');

 