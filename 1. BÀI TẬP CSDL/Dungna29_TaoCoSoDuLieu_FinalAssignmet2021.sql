-- Database Final Assignment Môn Cơ Sở Dữ liệu
DROP DATABASE Dungna_FPTShopV2;
CREATE DATABASE Dungna_FPTShopV2;
USE Dungna_FPTShopV2;


DROP TABLE IF EXISTS DongSanPham;
CREATE TABLE DongSanPham(
ID INT PRIMARY KEY IDENTITY, 
MaDSP VARCHAR(10),
TenDSP NVARCHAR(50) DEFAULT NULL,
IDTrangThai INT DEFAULT 0
);

DROP TABLE IF EXISTS KhachHang;
CREATE TABLE KhachHang(
ID INT PRIMARY KEY IDENTITY,
MaKH NVARCHAR(100) UNIQUE DEFAULT NULL,
TenKH NVARCHAR(100) DEFAULT NULL,
TenDemKH NVARCHAR(100) DEFAULT NULL,
HoKH NVARCHAR(100) DEFAULT NULL,
GioiTinh NVARCHAR(5) DEFAULT NULL,
NgaySinh DATE DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
Sdt VARCHAR(100) DEFAULT NULL,
ThanhPho NVARCHAR(100) DEFAULT NULL,
MaCty VARCHAR(50) DEFAULT NULL,
TenCty NVARCHAR(100) DEFAULT NULL,
Mst VARCHAR(100) DEFAULT NULL,
IDTrangThai INT DEFAULT 0
);

DROP TABLE IF EXISTS SanPham;
CREATE TABLE SanPham(
ID INT PRIMARY KEY IDENTITY,
MaSP VARCHAR(50) UNIQUE DEFAULT NULL,
TenSP VARCHAR(100) DEFAULT NULL,
ManHinh VARCHAR(100) DEFAULT NULL,
MotaSP NVARCHAR(255) DEFAULT NULL,
TrongLuongSP DECIMAL(20,0) DEFAULT 0,
GiaNhap DECIMAL(20,0) DEFAULT 0,
GiaBan DECIMAL(20,0) DEFAULT 0,
SoLuong INT DEFAULT 0,
IDDongSP INT DEFAULT 0,
IDThuongHieu INT DEFAULT 0,
IDTrangThai INT DEFAULT 0
);

DROP TABLE IF EXISTS HoaDon;
CREATE TABLE HoaDon(
ID INT PRIMARY KEY IDENTITY,
IDKhachHang INT DEFAULT 0,
IDNhanVien INT DEFAULT 0,
MaHD VARCHAR(100) DEFAULT NULL,
NgayTaoHD DATE DEFAULT NULL,
NgayThanhToanHD DATE DEFAULT NULL,
NgayShipHang DATE DEFAULT NULL,
NgayNhanHang DATE DEFAULT NULL,
DiachiGiaoHang NVARCHAR(255) DEFAULT NULL,
IDTrangThai INT DEFAULT 0
);

DROP TABLE IF EXISTS TrangThai;
CREATE TABLE TrangThai(
ID INT PRIMARY KEY IDENTITY,
TenTrangThai NVARCHAR(255) DEFAULT NULL
);

DROP TABLE IF EXISTS PhieuBaoHanh;
CREATE TABLE PhieuBaoHanh(
ID INT PRIMARY KEY IDENTITY,
MaPhieu VARCHAR(100) DEFAULT NULL,
IDSanPham INT DEFAULT 0,
IDHoaDon INT DEFAULT 0,
NgayBatDau DATE DEFAULT NULL,
NgayKetThuc DATE DEFAULT NULL,
MoTa NVARCHAR(255) DEFAULT NULL,
IMEI VARCHAR(255) DEFAULT NULL,
IDTrangThai INT DEFAULT 0
);

DROP TABLE IF EXISTS CuaHang;
CREATE TABLE CuaHang(
ID INT PRIMARY KEY IDENTITY,
MaCH VARCHAR(100) DEFAULT NULL,
TenCH NVARCHAR(100) DEFAULT NULL,
DiaChi NVARCHAR(255) DEFAULT NULL,
ThanhPho NVARCHAR(50) DEFAULT NULL,
QuocGia NVARCHAR(50) DEFAULT NULL,
IDTrangThai INT DEFAULT 0
);

DROP TABLE IF EXISTS ThuongHieu;
CREATE TABLE ThuongHieu(
ID INT PRIMARY KEY IDENTITY,
MaTH VARCHAR(100) DEFAULT NULL,
TenTH NVARCHAR(100) DEFAULT NULL,
Website VARCHAR(150) DEFAULT NULL,
IDTrangThai INT DEFAULT 0
);

DROP TABLE IF EXISTS NhanVien;
CREATE TABLE NhanVien(
ID INT PRIMARY KEY IDENTITY,
IDCuaHang INT DEFAULT 0,
MaNV VARCHAR(50) DEFAULT NULL,
TenNV NVARCHAR(50) DEFAULT NULL,
HoNV NVARCHAR(50) DEFAULT NULL,
TenDemNV NVARCHAR(50) DEFAULT NULL,
GioiTinh NVARCHAR(10) DEFAULT NULL,
DiaChi NVARCHAR(255) DEFAULT NULL,
LuongNV DECIMAL(20,0) DEFAULT 0,
Sdt VARCHAR(30) DEFAULT NULL,
Email VARCHAR(50) DEFAULT NULL,
IDChucVu INT DEFAULT 0,
IDTrangThai INT DEFAULT 0
);


DROP TABLE IF EXISTS HoaDonChiTiet;
CREATE TABLE HoaDonChiTiet(
IDHoaDon INT DEFAULT 0,
IDSanPham INT DEFAULT 0,
SoLuong int DEFAULT 0,
DonGia DECIMAL(20,0) DEFAULT 0,
PRIMARY KEY(IDHoaDon,IDSanPham),
CONSTRAINT FK1 FOREIGN KEY(IDHoaDon)REFERENCES HoaDon(ID),
CONSTRAINT FK2 FOREIGN KEY(IDSanPham) REFERENCES SanPHam(ID)
);

DROP TABLE IF EXISTS ChucVu;
CREATE TABLE ChucVu(
ID INT PRIMARY KEY IDENTITY,
MaChucVu VARCHAR(30) DEFAULT NULL,
TenChucVu NVARCHAR(30) DEFAULT NULL,
);

ALTER TABLE NhanVien
ADD CONSTRAINT FK_NhanVienChucVU
FOREIGN KEY(IDChucVu) REFERENCES ChucVu(ID);

ALTER TABLE NhanVien
ADD CONSTRAINT FK_NhanVienCuaHang
FOREIGN KEY(IDCuaHang) REFERENCES CuaHang(ID);

ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDonNhanVIen
FOREIGN KEY(IDNhanVien) REFERENCES NhanVien(ID);

ALTER TABLE HoaDon
ADD CONSTRAINT FK_HoaDonKhachHang
FOREIGN KEY(IDKhachHang) REFERENCES KhachHang(ID);

ALTER TABLE SanPham
ADD CONSTRAINT FK_SanPhamThuongHieu
FOREIGN KEY(IDThuongHieu) REFERENCES ThuongHieu(ID);

ALTER TABLE PhieuBaoHanh
ADD CONSTRAINT FK_BaoHanhSanPham
FOREIGN KEY(IDSanPham) REFERENCES SanPham(ID);

ALTER TABLE SanPham
ADD CONSTRAINT FK_SanPhamDongSanPHam
FOREIGN KEY(IDDongSP) REFERENCES DongSanPham(ID);

ALTER TABLE PhieuBaoHanh
ADD CONSTRAINT FK_BaoHanhHoaDon
FOREIGN KEY(IDHoaDOn) REFERENCES HoaDon(ID);

INSERT INTO ChucVu(MaChucVu,TenChucVu)
VALUES('TP', N'Trưởng Phòng'),
('PP', N'Phó Phòng'),
('BV', N'Bảo Vệ'),
('KT', N'Kế Toán'),
('TC', N'Tài Chính'),
('TCH', N'Trưởng Cửa Hàng'),
('NV', N'Nhân Viên');

DELETE FROM CuaHang
DBCC CHECKIDENT (CuaHang, RESEED, 0);
INSERT INTO CuaHang(MaCH,TenCH,DiaChi,ThanhPho,QuocGia,IDTrangThai)
VALUES('FPT1', N'FPT Cầu Giấy',N'Số 1 nguyễn văn huyên',N'Hà Nội',N'Việt Nam',1),
('FPT2', N'FPT Nguyễn Phong Sắc',N'Số 50 nguyễn phong sắc',N'Hà Nội',N'Việt Nam',1),
('FPT3', N'FPT Lạc Long Quân',N'Số 355 lạc long quân',N'Hà Nội',N'Việt Nam',1),
('FPT4', N'FPT Hoàn Kiếm',N'Số 7 hàng bạc',N'Hà Nội',N'Việt Nam',1),
('FPT5', N'FPT Đống Đa',N'Số 9 nguyễn lương bằng',N'Hà Nội',N'Việt Nam',1),
('FPT6', N'FPT Tây Hồ',N'Số 99 Yên phụ',N'Hà Nội',N'Việt Nam',1),
('FPT7', N'FPT Yên Phụ',N'Số 3 là nghi tàm',N'Hà Nội',N'Việt Nam',1);

DELETE FROM NhanVien;
DBCC NhanVien (NhanVien, RESEED, 0);
INSERT INTO NhanVien(IDCuaHang ,MaNV,TenNV,HoNV,TenDemNV,GioiTinh,DiaChi,LuongNV,Sdt,Email,IDChucVu,IDTrangThai)
VALUES('1','DungNA29',N'Dũng',N'Nguyễn',N'Anh','Nam',N'Số 1 ngõ 25 lạc long quân',8000000,'0916021821','DungNA29@gmail.com',1,1),
('1','LongNT',N'Long',N'Nguyễn',N'Thành','Nam',N'Số 1 ngõ 25 lạc long quân',8000000,'0865880778','LongNT@gmail.com',2,1),
('1','ThuDQ',N'Thụ',N'Đinh',N'Quang','Nam',N'Số 1 ngõ 25 lạc long quân',10000000,'0865880777','ThuDQ@gmail.com',2,1),
('2','MinhDQ',N'Minh',N'Đặng',N'Quang','Nam',N'Số 1 ngõ 25 lạc long quân',7000000,'0986021822','MinhDQ@gmail.com',1,1),
('2','ThienTH',N'Thiện',N'Trần',N'Hữu','Nam',N'Số 1 ngõ 25 lạc long quân',8000000,'0996021823','ThienTH@gmail.com',3,1),
('2','TienNH',N'Tiến',N'Nguyễn',N'Hoàng','Nam',N'Số 2 hàng bồ ',6000000,'0986021924','TienNH@gmail.com',4,1),
('2','DatLT',N'Đạt',N'Lê',N'Trọng','Nam',N'Số 2 ngõ 25 hàng bạc ',5000000,'0996822827','DatLT@gmail.com',7,1),
('2','SonTV',N'Sơn',N'Tân',N'Văn','Nam',N'Số 1 ngõ 25 lạc long quân',9000000,'0976028822','SonTV@gmail.com',7,1),
('2','LongNT',N'Long',N'Nguyễn',N'Thành','Nam',N'Số 1 ngõ 25 lạc long quân',11000000,'0996021823','LongNT@gmail.com',7,1),
('2','ThuDQ',N'Thụ',N'Đăng',N'Quang','Nam',N'Số 1 ngõ 25 lạc long quân',12000000,'0986021723','ThuDQ@gmail.com',7,1),
('3','TrangPT',N'Trang',N'Phạm',N'Thị',N'Nữ',N'Số 1 ngõ 25 lạc long quân',13000000,'0986025555','TrangPT@gmail.com',7,1),
('3','YenLH',N'Yến',N'Lê',N'Hải',N'Nữ',N'Số 1 ngõ 25 lạc long quân',14000000,'0986029999','YenLH@gmail.com',7,1),
('3','SonTT',N'Sơn',N'Trần',N'Thành','Nam',N'Số 1 ngõ 25 lạc long quân',1500000,'0986021111','SonTT@gmail.com',7,1),
('3','AnhNH',N'Anh',N'Nguyễn',N'Hoàng','Nam',N'Số 1 ngõ 25 lạc long quân',1100000,'0946022222','AnhNH@gmail.com',7,1),
('4','MaiTT',N'Mai',N'Trần',N'Thị',N'Nữ',N'Số 1 ngõ 25 lạc long quân',8000000,'0936023333','MaiTT@gmail.com',7,1),
('4','AnhLH',N'Anh',N'Lê',N'Hoàng','Nam',N'Số 1 ngõ 25 lạc long quân',8000000,'0936021444','AnhLH@gmail.com',7,1),
('5','DungNH',N'Dung',N'Nguyễn',N'Hoàng',N'Nữ',N'Số 1 ngõ 25 lạc long quân',7000000,'0926021234','DungNH@gmail.com',7,1),
('5','MinhNA',N'Minh',N'Nguyễn',N'Anh','Nam',N'Số 1 ngõ 25 lạc long quân',5000000,'0936026789','MinhNA@gmail.com',7,1),
('6','QuyNH',N'Quý',N'Nguyễn',N'Hữu','Nam',N'Số 1 ngõ 25 lạc long quân',7000000,'0926029876','QuyNH@gmail.com',7,1),
('6','LoanNT',N'Loan',N'Nguyễn',N'Thị',N'Nữ',N'Số 1 ngõ 25 lạc long quân',7000000,'0986021236','LoanNT@gmail.com',7,1),
('2','TrangPQ',N'Trang',N'Phạm',N'Quỳnh',N'Nữ',N'Số 1 ngõ 25 lạc long quân',6000000,'091602112','TrangPQ@gmail.com',7,1);

DELETE FROM ThuongHieu
DBCC CHECKIDENT (ThuongHieu, RESEED, 0);
INSERT INTO ThuongHieu(MaTH,TenTH,Website,IDTrangThai)
VALUES('TH01', N'ASUS',N'www.ASUS.com',1),
('TH02', N'DELL',N'www.DELL.com',1),
('TH03', N'AOC',N'www.AOC.com',1),
('TH04', N'MSI',N'www.MSI.com',1),
('TH05', N'BENQ',N'www.BENQ.com',1),
('TH06', N'DUCKY',N'www.DUCKY.com',1),
('TH07', N'RAZER',N'www.RAZER.com',1),
('TH08', N'HP',N'www.HP.com',1),
('TH09', N'LG',N'www.LG.com',1),
('TH10', N'SONY',N'www.SONY.com',1);


DELETE FROM TrangThai
DBCC CHECKIDENT (TrangThai, RESEED, 0);
INSERT INTO TrangThai(TenTrangThai)
VALUES(N'Hoạt Động'),
(N'Không Hoạt Động'),
(N'Tạm Khóa');


DELETE FROM DongSanPham
DBCC CHECKIDENT (DongSanPham, RESEED, 0);
INSERT INTO DongSanPham(MaDSP,TenDSP,IDTrangThai)
VALUES('DSP01',N'Máy trạm',1),
('DSP02',N'Máy chơi game',1),
('DSP03',N'Máy mỏng nhẹ',1),
('DSP04',N'Máy văn phòng',1),
('DSP05',N'Máy đồ họa',1),
('DSP06',N'Máy cao cấp',1),
('DSP06',N'Máy sinh viên',1);



DELETE FROM SanPham
DBCC CHECKIDENT (SanPham, RESEED, 0);
INSERT INTO SanPham(MaSP,TenSP,ManHinh,MotaSP,TrongLuongSP,GiaNhap,GiaBan,SoLuong,IDDongSP,IDThuongHieu,IDTrangThai)
VALUES(N'SP01',N'Laptop 3501','15 inch',N'N/A',4,15000000,19000000,100,1,2,1),
(N'SP02',N'Laptop 4600','17 inch',N'N/A',2,16000000,20000000,300,2,1,1),
(N'SP03',N'Laptop 3570','17 inch',N'N/A',2,17000000,20000000,400,3,2,1),
(N'SP04',N'Laptop 4587','17 inch',N'N/A',2,45000000,50000000,200,4,3,1),
(N'SP05',N'Laptop 4444','17 inch',N'N/A',2,45000000,55000000,200,5,4,1),
(N'SP06',N'Laptop 5555','17 inch',N'N/A',3,25000000,35000000,300,6,5,1),
(N'SP07',N'Laptop 6666','17 inch',N'N/A',3,25000000,35000000,200,7,6,1),
(N'SP08',N'Laptop 2222','17 inch',N'N/A',2,25000000,35000000,1000,1,7,1),
(N'SP09',N'Laptop 1111','17 inch',N'N/A',2,35000000,45000000,1000,2,8,1),
(N'SP010',N'Laptop 4234','15 inch',N'N/A',2,35000000,45000000,1000,3,9,1),
(N'SP011',N'Laptop 5578','15 inch',N'N/A',2,17000000,25000000,1000,4,10,1),
(N'SP012',N'Laptop 9982','15 inch',N'N/A',2,18000000,25000000,1000,5,10,1),
(N'SP013',N'Laptop 5562','15 inch',N'N/A',2,19000000,25000000,100,6,1,1),
(N'SP014',N'Laptop 7561','15 inch',N'N/A',2,18000000,27000000,100,7,2,1),
(N'SP015',N'Laptop 3245','13 inch',N'N/A',2,18000000,28000000,100,1,3,1),
(N'SP016',N'Laptop 2345','13 inch',N'N/A',2,18000000,29000000,100,1,4,1),
(N'SP017',N'Laptop S4324','13 inch',N'N/A',1,25000000,30000000,100,1,5,1),
(N'SP018',N'Laptop A5623','13 inch',N'N/A',1,25000000,30000000,100,2,6,1),
(N'SP019',N'Laptop A5555','13 inch',N'N/A',1,35000000,40000000,200,2,7,1),
(N'SP020',N'Laptop A3501','13 inch',N'N/A',1,35000000,45000000,300,2,8,1),
(N'SP021',N'Laptop C8926','13 inch',N'N/A',1,35000000,45000000,400,2,9,1),
(N'SP022',N'Laptop A9856','13 inch',N'N/A',1,35000000,45000000,500,3,10,1),
(N'SP023',N'Laptop Z5000','14 inch',N'N/A',1,45000000,55000000,600,3,10,1),
(N'SP024',N'Laptop A9000','14 inch',N'N/A',1,45000000,55000000,700,3,1,1),
(N'SP025',N'Laptop 9869','14 inch',N'N/A',1,45000000,55000000,800,4,1,1),
(N'SP026',N'Laptop N5501','14 inch',N'N/A',3,55000000,65000000,900,4,1,1),
(N'SP027',N'Laptop A3521','14 inch',N'N/A',3,65000000,75000000,100,4,2,1),
(N'SP028',N'Laptop P3101','14 inch',N'N/A',3,12000000,25000000,100,4,2,1),
(N'SP029',N'Laptop W3501','13 inch',N'N/A',3,13000000,25000000,100,4,2,1),
(N'SP030',N'Laptop K501','13 inch',N'N/A',3,18000000,25000000,900,5,2,1),
(N'SP031',N'Laptop L3501','14 inch',N'N/A',1,19000000,26000000,100,5,3,1),
(N'SP032',N'Laptop S7501','15 inch',N'N/A',2,18000000,28000000,100,5,3,1),
(N'SP033',N'Laptop Q3501','17 inch',N'N/A',1,16000000,27000000,100,5,1,1),
(N'SP034',N'Laptop S5559','17 inch',N'N/A',1,15000000,29000000,100,5,1,1),
(N'SP035',N'Laptop 73501','15 inch',N'N/A',3,17000000,28000000,100,1,1,1);


DELETE FROM KhachHang
DBCC CHECKIDENT (KhachHang, RESEED, 0);
INSERT INTO KhachHang(MaKH,TenKH,TenDemKH,HoKH,GioiTinh,NgaySinh,DiaChi,Sdt,ThanhPho,MaCty,TenCty,Mst,IDTrangThai)
VALUES('KH001',N'Dũng',N'Nguyễn',N'Anh','Nam','1989-11-15','N/A','0916021821',N'Hà Nội','N/A','N/A','N/A',1),
('KH002',N'Long',N'Nguyễn',N'Thành','Nam','1999-11-16','N/A','0865880778',N'Hà Nội','N/A','N/A','N/A',1),
('KH003',N'Thụ',N'Đinh',N'Quang','Nam','1997-11-17','N/A','0865880777',N'Hà Nội','N/A','N/A','N/A',1),
('KH004',N'Minh',N'Đặng',N'Quang','Nam','1988-11-18','N/A','0986021822',N'Hà Nội','N/A','N/A','N/A',1),
('KH005',N'Thiện',N'Trần',N'Hữu','Nam','1983-11-19','N/A','0996021823',N'Hà Nội','N/A','N/A','N/A',1),
('KH006',N'Tiến',N'Nguyễn',N'Hoàng','Nam','1956-11-20','N/A','0986021924',N'Hà Nội','N/A','N/A','N/A',1),
('KH007',N'Đạt',N'Lê',N'Trọng','Nam','1973-11-21','N/A','0996822827',N'Hà Nội','N/A','N/A','N/A',1),
('KH008',N'Sơn',N'Tân',N'Văn','Nam','1981-11-22','N/A','0976028822',N'Hà Nội','N/A','N/A','N/A',1),
('KH009',N'Long',N'Nguyễn',N'Thành','Nam','1982-11-23','N/A','0996021823',N'Hà Nội','N/A','N/A','N/A',1),
('KH0010',N'Thụ',N'Đăng',N'Quang','Nam','1983-11-23','N/A','0986021723',N'Hà Nội','N/A','N/A','N/A',1),
('KH0011',N'Trang',N'Phạm',N'Thị',N'Nữ','1982-11-13','N/A','0986025555',N'Hà Nội','N/A','N/A','N/A',1),
('KH0012',N'Yến',N'Lê',N'Hải',N'Nữ','1989-11-23','N/A','0986029999',N'Hà Nội','N/A','N/A','N/A',1),
('KH0013',N'Sơn',N'Trần',N'Thành','Nam','2000-11-23','N/A','0986021111',N'Hà Nội','N/A','N/A','N/A',1),
('KH0014',N'Anh',N'Nguyễn',N'Hoàng','Nam','2000-11-23','N/A','0946022222',N'Hà Nội','N/A','N/A','N/A',1),
('KH0015',N'Mai',N'Trần',N'Thị',N'Nữ','2000-11-03','N/A','0936023333',N'Hà Nội','N/A','N/A','N/A',1),
('KH0016',N'Anh',N'Lê',N'Hoàng','Nam','2000-11-05','N/A','0936021444',N'Hà Nội','N/A','N/A','N/A',1),
('KH0017',N'Dung',N'Nguyễn',N'Hoàng',N'Nữ','2001-09-23','N/A','0926021234',N'Hà Nội','N/A','N/A','N/A',1),
('KH0018',N'Minh',N'Nguyễn',N'Anh','Nam','2002-10-23','N/A','0936026789',N'Hà Nội','N/A','N/A','N/A',1),
('KH0019',N'Quý',N'Nguyễn',N'Hữu','Nam','2003-03-04','N/A','0926029876',N'Hà Nội','N/A','N/A','N/A',1),
('KH0020',N'Loan',N'Nguyễn',N'Thị',N'Nữ','2004-02-04','N/A','0986021236',N'Hà Nội','N/A','N/A','N/A',1),
('KH0021',N'Trang',N'Phạm',N'Quỳnh',N'Nữ','2002-01-05','N/A','091602112',N'Hà Nội','N/A','N/A','N/A',1);


DELETE FROM HoaDon
DBCC CHECKIDENT (HoaDon, RESEED, 0);
INSERT INTO HoaDon(IDKhachHang,IDNhanVien,MaHD,NgayTaoHD,NgayThanhToanHD,NgayShipHang,NgayNhanHang,DiachiGiaoHang,IDTrangThai)
VALUES(1,1,'HD001','2021-01-15','2021-01-15','2021-01-17','2021-01-28',N'Số 11/155 Nguyễn Văn Trỗi, Phường Mộ Lao',1),
(2,1,'HD002','2021-11-01','2021-11-01','2021-11-05','2021-11-28',N' Số 6, ngách 22, ngõ 395, đường Lạc Long Quân,',1),
(3,2,'HD003','2021-10-15','2021-10-15','2021-10-15','2021-10-19',N'Số 2A ngách 20 ngõ 110 Nguyễn Hoàng Tôn',1),
(4,3,'HD004','2021-09-15','2021-09-15','2021-09-15','2021-09-18',N'Số 10, Ngõ 25 Đường Tây Hồ, Phường Quảng An',1),
(5,4,'HD005','2021-07-15','2021-07-15','2021-07-15','2021-07-19',N'Số nhà 39A, Ngõ 603, Đường Lạc Long Quân, Phường Xuân La',1),
(6,5,'HD006','2021-07-15','2021-07-15','2021-07-15','2021-07-20',N'1 Xuân Diệu, Phường Quảng An, Quận Tây Hồ',1),
(7,6,'HD007','2021-06-15','2021-06-15','2021-06-15','2021-06-28',N'Số nhà 5c ngách 44 ngõ 218 Lạc Long Quân',1),
(8,2,'HD008','2021-06-15','2021-06-15','2021-06-15','2021-06-19',N'Số nhà 16A ngõ 105 Phú Xá, Phường Phú Thượng',1),
(9,2,'HD009','2021-05-15','2021-05-15','2021-05-15','2021-05-15',N'95 Vệ Hồ, Phường Xuân La',1),
(10,3,'HD0010','2021-04-15','2021-04-15','2021-04-15','2021-04-15',N'P504 tầng 5 tòa Viglacera, 676 Hoàng Hoa Thám',1),
(11,3,'HD0011','2021-01-15','2021-01-15','2021-01-15','2021-01-15',N'Số 2 ngõ 514/43 Thụy Khuê',1),
(12,3,'HD0012','2021-02-15','2021-02-15','2021-02-15','2021-02-15',N'Số 123, đường Trích Sài',1),
(13,3,'HD0013','2021-02-15','2021-02-15','2021-02-15','2021-02-15',N'Số 55 ngõ 514 Thụy Khuê',1),
(14,4,'HD0014','2021-02-15','2021-02-15','2021-02-15','2021-02-15',N'Số 8LK6A, Đường Nguyễn Văn Lộc',1),
(15,5,'HD0015','2021-02-15','2021-02-15','2021-02-15','2021-02-15',N'Thôn Đản Mỗ, Xã Uy Nỗ, Huyện Đông Anh',1),
(16,6,'HD0016','2021-02-15','2021-02-15','2021-02-15','2021-02-15',N'Số 88, Ngách 481/73, Đường Ngọc Lâm',1),
(17,6,'HD0017','2021-03-15','2021-03-15','2021-03-15','2021-03-15',N'Số nhà 299 Đường Vũ Xuân Thiều',1),
(18,6,'HD0018','2021-03-15','2021-03-15','2021-03-15','2021-03-15',N'Số nhà 25, ngõ 5 Đường Nguyễn Văn Cừ',1),
(19,6,'HD0019','2021-04-15','2021-04-15','2021-04-15','2021-04-15',N'Số 10, Tổ 13, Phường Thạch Bàn',1),
(20,7,'HD0020','2021-04-15','2021-04-15','2021-04-15','2021-04-15',N'Số 11 Ngõ 67 Nguyễn Văn Cừ',1),
(21,1,'HD0021','2021-05-15','2021-05-15','2021-05-15','2021-05-15',N'Nhà 3C Ngõ 155 Bồ Đề',1),
(2,1,'HD0022','2021-05-15','2021-05-15','2021-05-15','2021-05-15',N'NQ25-28, Khu đô thị sinh thái Vinhomes Riverside 2',1),
(2,3,'HD0023','2021-06-15','2021-06-15','2021-06-15','2021-06-15',N'Lô 16-1, Ngách 64/86, Tổ 1, Đường Thạch Bàn',1),
(2,3,'HD0024','2021-06-15','2021-06-15','2021-06-15','2021-06-15',N'Số 3, ngõ 14/29, phố Thạch Cầu',1),
(3,3,'HD0025','2021-08-15','2021-08-15','2021-08-15','2021-08-15',N'số 20, Khu C17, ngõ 264/63, đường Ngọc Thụy',1),
(3,1,'HD0026','2021-08-15','2021-08-15','2021-08-15','2021-08-15',N'Nhà số 14, ngách 26/18 ngõ Độc Lập, Phường Cự Khối',1),
(3,1,'HD0027','2021-08-15','2021-08-15','2021-08-15','2021-08-15',N'Số 54, Ngõ Thống Nhất, Đường Thống Nhất, Phường Cự Khối',1),
(3,1,'HD0028','2021-08-15','2021-08-15','2021-08-15','2021-08-15',N'Ngõ 24 Đường lý Sơn, Tổ 8',1);

DELETE FROM HoaDonChiTiet
DBCC CHECKIDENT (HoaDonChiTiet, RESEED, 0);
INSERT INTO HoaDonChiTiet(IDHoaDon,IDSanPham,SoLuong,DonGia)
VALUES(1,1,1,19000000),
(1,2,2,20000000),
(2,3,1,20000000),
(2,4,3,50000000),
(2,5,1,55000000),
(3,6,1,35000000),
(3,7,3,35000000),
(3,8,1,35000000),
(4,9,2,45000000),
(4,10,1,45000000),
(5,11,4,25000000),
(5,12,2,25000000),
(6,13,1,25000000),
(6,14,5,27000000),
(6,15,1,28000000),
(6,16,7,29000000),
(7,17,1,30000000),
(7,18,2,30000000),
(7,19,3,40000000),
(8,20,1,45000000),
(8,21,1,45000000),
(8,22,8,45000000),
(8,23,1,55000000),
(9,24,2,55000000),
(10,25,3,55000000),
(11,26,1,65000000),
(12,27,4,75000000),
(13,28,4,25000000),
(14,29,4,25000000),
(15,30,4,25000000),
(16,31,5,26000000),
(17,32,5,28000000),
(18,33,6,27000000),
(19,34,1,29000000),
(20,35,1,28000000),
(21,1,8,19000000),
(22,2,8,20000000),
(23,3,8,20000000),
(24,4,8,50000000),
(25,22,9,45000000),
(26,23,9,55000000),
(27,24,9,55000000),
(28,25,1,55000000);




