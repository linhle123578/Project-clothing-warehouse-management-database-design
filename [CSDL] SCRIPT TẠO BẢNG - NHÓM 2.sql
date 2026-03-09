ALTER TABLE quan_ao ADD CONSTRAINT fk_1 FOREIGN KEY (makho) REFERENCES kho(makho)
 ALTER TABLE quan_ao ADD CONSTRAINT fk_2 FOREIGN KEY (manhacungcap) REFERENCES nha_cung_cap(manhacungcap)
 ALTER TABLE quan_ao ADD CONSTRAINT fk_3 FOREIGN KEY (maloaiqa) REFERENCES loai_quan_ao(maloaiqa)
 ALTER TABLE phieu_nhap ADD CONSTRAINT fk_4 FOREIGN KEY (manhanvien) REFERENCES nhan_vien(manv)
 ALTER TABLE phieu_nhap ADD CONSTRAINT fk_5 FOREIGN KEY (manhacungcap) REFERENCES nha_cung_cap(manhacungcap)
 ALTER TABLE phieu_nhap ADD CONSTRAINT fk_6 FOREIGN KEY (makho) REFERENCES kho(makho)
 ALTER TABLE chi_tiet_pn ADD CONSTRAINT fk_7 FOREIGN KEY (maphieunhap) REFERENCES phieu_nhap(maphieunhap)
 ALTER TABLE chi_tiet_pn ADD CONSTRAINT fk_8 FOREIGN KEY (maquanao) REFERENCES quan_ao(maquanao)
 ALTER TABLE kho ADD CONSTRAINT fk_9 FOREIGN KEY (manvtruong) REFERENCES nhan_vien(manv)
 ALTER TABLE nhan_vien ADD CONSTRAINT fk_10 FOREIGN KEY (makho) REFERENCES kho(makho)
 ALTER TABLE phieu_xuat ADD CONSTRAINT fk_11 FOREIGN KEY (manv) REFERENCES nhan_vien(manv)
 ALTER TABLE phieu_xuat ADD CONSTRAINT fk_12 FOREIGN KEY (makh) REFERENCES khach_hang(makh)
 ALTER TABLE phieu_xuat ADD CONSTRAINT fk_13 FOREIGN KEY (makho) REFERENCES kho(makho)
 ALTER TABLE chi_tiet_px ADD CONSTRAINT fk_14 FOREIGN KEY (maphieuxuat) REFERENCES phieu_xuat(maphieuxuat)
 ALTER TABLE chi_tiet_px ADD CONSTRAINT fk_15 FOREIGN KEY (maquanao) REFERENCES quan_ao(maquanao)
 ALTER TABLE phieu_tra_hang ADD CONSTRAINT fk_16 FOREIGN KEY (manv) REFERENCES nhan_vien(manv)
 ALTER TABLE phieu_tra_hang ADD CONSTRAINT fk_17 FOREIGN KEY (makh) REFERENCES khach_hang(makh)
 ALTER TABLE phieu_tra_hang ADD CONSTRAINT fk_18 FOREIGN KEY (makho) REFERENCES kho(makho)
 ALTER TABLE chi_tiet_pt ADD CONSTRAINT fk_19 FOREIGN KEY (maphieutra) REFERENCES phieu_tra_hang(maphieutra)
 ALTER TABLE chi_tiet_pt ADD CONSTRAINT fk_20 FOREIGN KEY (maquanao) REFERENCES quan_ao(maquanao)

 --Truy vấn nhân viên là quản lý kho và tên kho cụ thể
 select nhan_vien.honv + ' ' + nhan_vien.tennv as Ho_ten, nhan_vien.vaitro, kho.tenkho
 from nhan_vien join kho on nhan_vien.makho = kho.makho
 where vaitro = N'Quản lý'
 
 -- Truy vấn quần áo theo mã - tên - loại quần áo và nhà cung cấp và kho
 select distinct quan_ao.maquanao, quan_ao.tenquanao, loai_quan_ao.loaiqa, nha_cung_cap.tennhacungcap, kho.tenkho
 from quan_ao join loai_quan_ao on quan_ao.maloaiqa = loai_quan_ao.maloaiqa 
 join nha_cung_cap on quan_ao.manhacungcap = nha_cung_cap.manhacungcap
 join kho on quan_ao.makho = kho.makho
 order by quan_ao.tenquanao
 
 -- Truy vấn tổng số lượng và số tiền của khách hàng đã mua trong phiếu xuất
 select khach_hang.makh, phieu_xuat.maphieuxuat, sum(chi_tiet_px.soluong) as tongsl, sum(chi_tiet_px.thanhtien) as tongtien
 from khach_hang join phieu_xuat on khach_hang.makh = phieu_xuat.makh join chi_tiet_px on chi_tiet_px.maphieuxuat = phieu_xuat.maphieuxuat
 group by khach_hang.makh, phieu_xuat.maphieuxuat

 --Truy vấn những khách hàng trả hàng với số lượng lớn hơn 2 trở lên
 select khach_hang.makh, khach_hang.tenkh, phieu_tra_hang.maphieutra, sum(chi_tiet_pt.soluong) as tongsotra
 from khach_hang join phieu_tra_hang on khach_hang.makh = phieu_tra_hang.makh 
 join chi_tiet_pt on phieu_tra_hang.maphieutra = chi_tiet_pt.maphieutra
 group by khach_hang.makh, khach_hang.tenkh, phieu_tra_hang.maphieutra
 having sum(chi_tiet_pt.soluong) > 2
 
 -- Truy vấn nhà cung cấp nào cung cấp nhiều hàng nhất và đưa ra số tiền
 select phieu_nhap.manhacungcap, nha_cung_cap.tennhacungcap, sum(chi_tiet_pn.soluong) as tongSL, sum(chi_tiet_pn.thanhtien) as tongTien
 from nha_cung_cap join phieu_nhap on nha_cung_cap.manhacungcap = phieu_nhap.manhacungcap 
 join chi_tiet_pn on chi_tiet_pn.maphieunhap = phieu_nhap.maphieunhap
 group by phieu_nhap.manhacungcap, nha_cung_cap.tennhacungcap
 having SUM(chi_tiet_pn.soluong) = (select MAX(tongSL) from (
 select SUM(chi_tiet_pn.soluong) as tongSL
 from nha_cung_cap join phieu_nhap on nha_cung_cap.manhacungcap = phieu_nhap.manhacungcap 
 join chi_tiet_pn on chi_tiet_pn.maphieunhap = phieu_nhap.maphieunhap
 group by phieu_nhap.manhacungcap) as subquery)

 -- Truy vấn danh sách loại áo ở kho A
 select loai_quan_ao.loaiqa, quan_ao.tenquanao
 from loai_quan_ao join quan_ao on loai_quan_ao.maloaiqa = quan_ao.maloaiqa
 where loai_quan_ao.loaiqa like N'Áo%' and quan_ao.makho in (
 select makho 
 from kho 
 where kho.tenkho = N'Kho A')


 -- Ràng buộc 21: Giá gốc phải lớn hơn 0--
CREATE TRIGGER trg_CheckGiaBan ON QUAN_AO
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @GiaGoc FLOAT;
    SELECT @GiaGoc = giagoc FROM inserted;

    IF @GiaGoc <= 0
    BEGIN
        PRINT (N'Giá bán phải lớn hơn 0.');
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Ràng buộc 22: Số lượng tồn kho phải lớn hơn hoặc bằng 0--
CREATE TRIGGER trg_CheckSoLuongTonKho ON QUAN_AO
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @SoLuongTonKho INT;
    SELECT @SoLuongTonKho = soluongtonkho FROM inserted;

    IF @SoLuongTonKho < 0
    BEGIN
        PRINT (N'Số lượng tồn kho phải lớn hơn hoặc bằng 0.');
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Ràng buộc 23: Số lượng phải lớn hơn 0--
CREATE TRIGGER trg_CheckSoLuong
ON CHI_TIET_PN
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @SoLuong INT;
    SELECT @SoLuong = soluong FROM inserted;

    IF @SoLuong <= 0
    BEGIN
        PRINT (N'Số lượng phải lớn hơn 0.');
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Ràng buộc 24: Đơn giá phải lớn hơn 0--
CREATE TRIGGER trg_CheckDonGia
ON CHI_TIET_PN
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @DonGia FLOAT;
    SELECT @DonGia = dongia FROM inserted;

    IF @DonGia <= 0
    BEGIN
        PRINT 'Đơn giá phải lớn hơn 0.';
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Ràng buộc 25: Số điện thoại phải là giá trị số--
CREATE TRIGGER trg_CheckSoDienThoai_NhaCungCap
ON NHA_CUNG_CAP
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @SoDienThoai NVARCHAR;
    SELECT @SoDienThoai = sodienthoai FROM inserted;

    IF @SoDienThoai NOT LIKE '%[^0-9]%'
    BEGIN
        PRINT 'Số điện thoại của nhà cung cấp phải là giá trị số.';
        ROLLBACK TRANSACTION;
    END
END;
GO

CREATE TRIGGER trg_CheckSoDienThoai_KhachHang
ON KHACH_HANG
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @SoDienThoai NVARCHAR;
    SELECT @SoDienThoai = sdt FROM inserted;

    IF @SoDienThoai NOT LIKE '%[^0-9]%'
    BEGIN
        PRINT (N'Số điện thoại của khách hàng phải là giá trị số.');
        ROLLBACK TRANSACTION;
    END
END;
GO

 ---Ràng buộc 26: Thuộc tính email của bảng NHA_CUNG_CAP phải có dạng email hợp lệ--
 CREATE TRIGGER tr_ValidEmail ON nha_cung_cap
 AFTER INSERT, UPDATE 
 AS
 DECLARE @email varchar(100);
 SELECT @email = email
 from inserted
 IF @email NOT LIKE '%_@__%.__%'
 BEGIN 
	PRINT (N'Định dạng email không hợp lệ');
	ROLLBACK TRANSACTION
 END

 ---Ràng buộc 27: Thuộc tính email của bảng NHA_CUNG_CAP không được có giá trị trùng với các NHA_CUNG_CAP khác--
 CREATE TRIGGER tr_UniqueEmail ON nha_cung_cap
 AFTER INSERT, UPDATE
 AS
 DECLARE @email varchar(100), @manhacungcap varchar(6);
 SELECT @email = email , @manhacungcap = manhacungcap
 FROM inserted
 IF EXISTS (
	SELECT 1
	FROM nha_cung_cap
	WHERE email= @email
	AND manhacungcap <> @manhacungcap)
BEGIN 
	PRINT (N'Email đã tồn tại ở nhà cung cấp khác');
	ROLLBACK TRANSACTION
END

---Ràng buộc 28: Thuộc tính vaitro của bảng NHAN_VIEN chỉ nhận giá trị ‘Quản lý kho’, ‘Nhập hàng’, ‘Xuất hàng’, ‘Xử lý đổi trả hàng’--
CREATE TRIGGER tr_VaitroNV ON nhan_vien
AFTER INSERT, UPDATE 
AS 
DECLARE @vaitro nvarchar(10); 
SELECT @vaitro= vaitro
FROM inserted
IF @vaitro NOT IN (N'Quản lý', N'Nhập hàng', N'Xuất hàng', N'Trả hàng')
BEGIN 
	PRINT (N'Vai trò không hợp lệ');
	ROLLBACK TRANSACTION
END

-- Ràng buộc 29: Nhân viên trưởng của kho phải làm việc tại kho đó--
CREATE TRIGGER trg_CheckNhanVienTruong ON KHO
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @MaKho INT, @MaNhanVienTruong INT, @MaKhoNhanVienTruong INT;
    SELECT @MaKho = makho, @MaNhanVienTruong = manvtruong FROM inserted;
    
    SELECT @MaKhoNhanVienTruong = makho FROM NHAN_VIEN WHERE manv = @MaNhanVienTruong;

    IF @MaKho <> @MaKhoNhanVienTruong
    BEGIN
        PRINT (N'Nhân viên trưởng của kho phải làm việc tại kho đó.');
        ROLLBACK TRANSACTION;
    END
END;
GO

-- Ràng buộc 30: Số lượng xuất phải bé hơn hoặc bằng số lượng tồn kho--
CREATE TRIGGER trg_CheckSoLuongXuat
ON CHI_TIET_PX
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @SoLuongXuat INT, @SoLuongTonKho INT, @MaQuanAo INT;
    SELECT @SoLuongXuat = soluong, @MaQuanAo = maquanao FROM inserted;

    SELECT @SoLuongTonKho = soluongtonkho FROM QUAN_AO WHERE maquanao = @MaQuanAo;

    IF @SoLuongXuat > @SoLuongTonKho
    BEGIN
        PRINT (N'Số lượng xuất phải nhỏ hơn hoặc bằng số lượng tồn kho.');
        ROLLBACK TRANSACTION;
    END
END;
GO

---Ràng buộc 31: Mỗi phiếu nhập phải do nhân viên thuộc kho đó thực hiện---
CREATE TRIGGER tr_PN_NVkho ON phieu_nhap
AFTER INSERT, UPDATE 
AS
DECLARE @manhanvien varchar(5), @makho varchar(6);
SELECT @manhanvien = manhanvien, @makho = makho
FROM inserted
IF NOT EXISTS (
	SELECT 1
	FROM nhan_vien
	WHERE manv = @manhanvien
	AND makho= @makho )
BEGIN
	PRINT(N'Nhân viên phải thuộc kho thực hiện phiếu nhập');
	ROLLBACK TRANSACTION
END

---Ràng buộc 32: Đơn giá gốc của mỗi quần áo phải bằng đơn giá được nhập vào---
CREATE TRIGGER tr_QuanAo_GiaGoc ON chi_tiet_pn
AFTER INSERT, UPDATE
AS
DECLARE @maquanao varchar(5), @dongia int;
SELECT @maquanao = maquanao, @dongia = dongia
FROM inserted
IF NOT EXISTS (
    SELECT 1 
    FROM quan_ao 
    WHERE maquanao = @maquanao 
      AND giagoc = @dongia
)
BEGIN
    PRINT(N'Đơn giá gốc phải bằng đơn giá nhập');
    ROLLBACK TRANSACTION
END

--- Ràng buộc 34: Trên cùng một mã khách hàng, số lượng quần áo trả phải nhỏ hơn hoặc bằng số lượng quần áo xuất---
CREATE TRIGGER tr_SLPT ON chi_tiet_pt
AFTER INSERT, UPDATE
AS 
DECLARE @maphieutra varchar(5), @maquanao varchar(5), @soluong_tra int;
SELECT @maphieutra = maphieutra, @maquanao = maquanao, @soluong_tra = soluong
FROM inserted
DECLARE @makh varchar(5), @soluong_xuat int;
SELECT @makh = makh 
	FROM phieu_tra_hang 
	WHERE maphieutra = @maphieutra;
IF @soluong_tra > (
	SELECT SUM(chi_tiet_px.soluong)
	FROM phieu_xuat
	JOIN chi_tiet_px ON phieu_xuat.maphieuxuat=chi_tiet_px.maphieuxuat
	WHERE phieu_xuat.makh = @makh
	AND chi_tiet_px.maquanao= @maquanao
	) 
BEGIN 
	PRINT(N'Số lượng trả hàng vượt quá số lượng xuất');
	ROLLBACK TRANSACTION
END
