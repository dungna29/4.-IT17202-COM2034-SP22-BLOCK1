CREATE DATABASE DungNA_ShopFPT;
GO
USE DungNA_ShopFPT;
GO
DROP TABLE IF EXISTS cuahang_fpt;
CREATE TABLE cuahang_fpt(
IdCuaHang INT PRIMARY KEY IDENTITY,
MaCH NVARCHAR(100) UNIQUE DEFAULT NULL,
TenCH NVARCHAR(100) DEFAULT NULL,
SoLuongNV INT DEFAULT 0,
DiaChi1 NVARCHAR(100) DEFAULT NULL,
DiaChi2 NVARCHAR(100) DEFAULT NULL,
ThanhPho NVARCHAR(100) DEFAULT NULL,
QuocGia NVARCHAR(100) DEFAULT NULL
);
DROP TABLE IF EXISTS dongsanpham;
CREATE TABLE dongsanpham(
IdDongSanPham INT PRIMARY KEY IDENTITY,
MaDongSanPham NVARCHAR(100) UNIQUE DEFAULT NULL,
TenDongSanPham NVARCHAR(100) DEFAULT NULL,
WebsiteDongSanPham NVARCHAR(200) DEFAULT NULL
);
DROP TABLE IF EXISTS nhanvien;
CREATE TABLE nhanvien(
IdNhanVien INT PRIMARY KEY IDENTITY,
MaNhanVien NVARCHAR(100) UNIQUE DEFAULT NULL,
TenHoNV NVARCHAR(100) DEFAULT NULL,
TenDemNV NVARCHAR(100) DEFAULT NULL,
TenNV NVARCHAR(100) DEFAULT NULL,
GioiTinh NVARCHAR(100) DEFAULT NULL,
NgaySinh Date DEFAULT NULL,
DiaChi NVARCHAR(100) DEFAULT NULL,
LuongNV DECIMAL(20,0),
SoDienThoai NVARCHAR(100) UNIQUE NULL DEFAULT NULL,
Email NVARCHAR(100) UNIQUE NULL DEFAULT NULL,
IdCuaHang INT NOT NULL,
IdChucVu INT NOT NULL,
IdGuiBaoCao INT DEFAULT 0
);
DROP TABLE IF EXISTS chucvu;
CREATE TABLE chucvu(
IdChucVu  INT PRIMARY KEY IDENTITY,
 MaChucVu NVARCHAR(100) UNIQUE DEFAULT NULL,
TenChucVu NVARCHAR(100) DEFAULT NULL
);
DROP TABLE IF EXISTS khachhang;
CREATE TABLE khachhang(
IdKhachHang INT PRIMARY KEY IDENTITY,
MaKhachHang NVARCHAR(100) UNIQUE DEFAULT NULL,
TenHoKH NVARCHAR(100) DEFAULT NULL,
TenDemKH NVARCHAR(100) DEFAULT NULL,
TenKH NVARCHAR(100) DEFAULT NULL,
NgaySinh Date DEFAULT NULL,
SoDienThoai NVARCHAR(100) UNIQUE DEFAULT NULL,
DiaChi1 NVARCHAR(100) DEFAULT NULL,
DiaChi2 NVARCHAR(100) DEFAULT NULL,
GioiTinh NVARCHAR(100) DEFAULT NULL,
ThanhPho NVARCHAR(100) DEFAULT NULL
);
DROP TABLE IF EXISTS sanpham;
CREATE TABLE sanpham(
IdSanPham INT PRIMARY KEY IDENTITY,
MaSanPHam NVARCHAR(100) UNIQUE DEFAULT NULL,
TenSP  NVARCHAR(100) DEFAULT NULL,
NamBaoHanh NUMERIC(4),
TrongLuongSP FLOAT DEFAULT NULL,
MoTaSP NVARCHAR(100) DEFAULT NULL,
SoLuongSanPhamTon INT DEFAULT NULL,
GiaNhapSP DECIMAL(20,0) DEFAULT NULL,
GiaBanSP DECIMAL(20,0) DEFAULT NULL,
IdDongSanPham INT NOT NULL
);
DROP TABLE IF EXISTS hoadon;
CREATE TABLE hoadon(
IdHoaDon INT PRIMARY KEY IDENTITY,
MaHoaDon NVARCHAR(100) UNIQUE DEFAULT NULL,
NgayMuaSP DATE DEFAULT NULL,
NgayTaoHoaDon DATE DEFAULT NULL,
NgayShipHang DATE DEFAULT NULL,
TinhTrangHoaDon  BIT DEFAULT NULL,
IdKhachHang INT NOT NULL,
IdNhanVien INT  NOT NULL
);
CREATE TABLE hoadonchitiet(
IdHoaDon INT NOT NULL,
IdSanPham INT NOT NULL ,
SoLuongDatHang INT DEFAULT NULL,
Gia1SanPham DECIMAL(20,0) DEFAULT NULL,
STTHoaDon INT DEFAULT NULL,
PRIMARY KEY(IdHoaDon,IdSanPham),
CONSTRAINT FK1 FOREIGN KEY(IdHoaDon)REFERENCES hoadon(IdHoaDon),
CONSTRAINT FK2 FOREIGN KEY(IdSanPham) REFERENCES sanpham(IdSanPham)
);

ALTER TABLE nhanvien
ADD CONSTRAINT FK_NhanVienChucDanh
FOREIGN KEY(IdChucVu) REFERENCES chucvu(IdChucVu);

ALTER TABLE nhanvien
ADD CONSTRAINT FK_NhanVienCuaHang
FOREIGN KEY(IdCuaHang) REFERENCES cuahang_fpt(IdCuaHang);

ALTER TABLE nhanvien
 ADD CONSTRAINT FK_GuiBaoCaoNhanVien
FOREIGN KEY(IdGuiBaoCao) REFERENCES nhanvien(IdNhanVien);

ALTER TABLE hoadon
ADD CONSTRAINT FK_HoaDonKhachHang
FOREIGN KEY(IdKhachHang) REFERENCES khachhang(IdKhachHang);

ALTER TABLE hoadon
ADD CONSTRAINT FK_HoaDonNhanVien
FOREIGN KEY(IdNhanVien) REFERENCES nhanvien(IdNhanVien);

ALTER TABLE sanpham
ADD CONSTRAINT FK_SanPhamDongSanPham
FOREIGN KEY(IdDongSanPham) REFERENCES dongsanpham(IdDongSanPham);

DBCC CHECKIDENT (cuahang_fp, 1, 1);
INSERT INTO cuahang_fpt(MaCH,TenCH,SoLuongNV,DiaChi1,DiaChi2,ThanhPho,QuocGia)
VALUES('CH001', N'Lê Văn Quyết', 10 , N'Ngõ 34 âu cơ', null, N'Hà Nội', N'Việt Nam'),
('CH002', N'Lê Hoàng Ngọc', 6,N'Số 5 hoàng quốc việt', null, N'Bắc Giang', N'Việt Nam'),
('CH003',N'Nguyễn Văn Quyết', 7 ,N'Ngõ 34 lạc long quân',null,N'Hà Nội',N'Việt Nam'),
('CH004',N'Lê Việt Hoàng', 20,N'số 236 trần thánh tông',null,N'Đà Nẵng',N'Việt Nam'),
('CH005',N'Trần Văn Luyện',8,N'Số 140 đường láng',null,N'Bắc Giang',N'Việt Nam'),
('CH006',N'Võ Văn Quốc',9,N'Ngõ 134 cầu diễn',null,N'Sài Gòn',N'Việt Nam'),
('CH007', N'Võ Minh Châu',6,N'Số 400 yên phụ',null,N'Hà Nội',N'Việt Nam'),
('CH008',N'Hoàng Văn Việt',9,N'Số 234 xuân phương',null,N'Sài Gòn',N'Việt Nam'),
('CH009',N'Nguyễn Ích Quốc',11,N'Số 100 phạm văn đồng',null,N'Sài Gòn',N'Việt Nam'),
('CH010',N'Lê Hoàng hữu',16,N'Số 209 âu cơ',null,N'Hà Nội',N'Việt Nam');

DBCC CHECKIDENT (dongsanpham, 1, 1);
INSERT INTO dongsanpham(MaDongSanPham,TenDongSanPham,WebsiteDongSanPham)
	VALUES('DSP001','Macbook','Apple.com'),
	('DSP002','Sony','Sony.com'),
	('DSP003','Msi','Mis.com'),
	('DSP004','Acer','Acer.com'),
	('DSP005','Asus','Asus.com'),
	('DSP006','HP','Hp.com'),
	('DSP007','Lenovo','Lenovo.com'),
	('DSP008','ThinkPad','ThinkPad.com'),
	('DSP009','Dell','Dell.com'),
	('DSP010','LG','LG.com');
    
    
INSERT INTO chucvu(MaChucVu,TenChucVu)
VALUES ('TP',N'Trưởng Phòng'),
		('PP',N'Phó Phòng'),
        ('NV',N'Nhân Viên');
        
INSERT INTO KhachHang (MaKhachHang,TenHoKH,TenDemKH,TenKH,NgaySinh,SoDienThoai, DiaChi1,DiaChi2,GioiTinh,ThanhPho)
VALUES ('KH0001',N'Hoàng',N'Quốc',N'Việt','1987-12-03','0766031933',N'Hoàng Quốc Việt',N'101 Xã Đàn',N'Nam',N'Vũng Tàu'),
       ('KH0002',N'Lạc', N'Long',N' Quân','1988-1-02','0816035927',N'12 Thụy Khuê',N'36 Hàng Đào',N'Nam',N'Hà Nội'),
       ('KH0003',N'Xuân',N'Văn',N'Diệu','1982-4-01','0716038928',N'36 Hàng Đào',N'1 Phương Mai',N'Nam',N'Hà Nôi'),
       ('KH0004',N'Đặng',N'Trần',N'Côn','1983-5-02',' 0616639780',N'1 Phương Mai','36 Hàng Đào','Nam','Hà Nội'),
       ('KH0005',N'Phúc',N'Thị', N'Long','1984-6-04',' 0616639900','91 Hoàng Văn Thái','6 Hàng Đào','Nữ','Hồ Chí Minh'),
       ('KH0006' ,N'Nguyễn',N'Thanh',N'Lam','1984-8-19',' 0616637991',N'15 Lê Duẩn',N'136 Hàng Đào',N'Nữ',N'Nam Định'),
       ('KH0007',N'Nguyễn',N'Tuấn', N'Hưng','1985-8-20',' 0616638991',N'156 Phương Mai',N'360 Hàng Đào',N'Nam',N'Hà Nội'),
       ('KH0008',N'Phạm',N'Thanh',N'Bình','1986-9-30',' 0616631991',N'14 Phương Mai',N'3 Hàng Đào',N'Nữ',N'Hà Nội'),
       ('KH0009',N'Nguyễn',N'Trung',N'Huy','1987-10-16',' 0616630991',N'114 Phương Mai',N'69 Hàng Đào',N'Nam',N'Hà Nội'),
       ('KH0010',N'Triệu', N'Việt', N'Vương','1988-11-18',' 0616656991',N'151 Phương Mai',N'365 Hàng Đào',N'Nam',N'Hà Nội');
       
       
INSERT INTO sanpham (MaSanPHam,TenSP,NamBaoHanh,TrongLuongSP,MoTaSP,SoLuongSanPhamTon,GiaNhapSP,GiaBanSP,IdDongSanPham)
VALUES ('H0001','Dell Vostro',2025,2.2,' 300GB SSD',1,18000000,19000000,1),
	   ('H0002','Dell Inspiron',2026,3.1,' 256GB SSD',2,20000000,21000000,2),
       ('H0003','Asus TUF Gaming A15',2027,2.3,' 350GB SSD',3,17000000,18000000,3),
       ('H0004','Asus ROG Strix ',2028,2.4,'360GB SSD',4,16000000,17000000,4),
       ('H0005','Asus ZenBook',2029,2.7,'370GB SSD',5,13000000,14000000,5),
       ('H0006','Acer Nitro',2030,2.5,' 400GB SSD',6,24000000,24500000,6),
       ('H0007','Acer Aspire',2031,3,'450GB SSD',7,25000000,26000000,7),
       ('H0008','Acer Predator',2032,3.2,'500GB SSD',8,270000000,275000000,8),
       ('H0009','Dell Gaming',2033,3.3,' 550GB SSD',9,29000000,30000000,9),
       ('H00010','Acer Swift',2035,3.5,'139GB SSD',10,32000000,32500000,10),
       ('H00011','Asus Vivobook',2036,3.4,'136GB SSD',11,32000000,32600000,1),
       ('H00012','Asus Zephyrus',2037,3.6,'140GB SSD',12,32000000,32700000,1),
       ('H00013','Lenovo Thinkpad',2038,3.7,'225GB SSD',13,33000000,34000000,3),
       ('H00014','HP Folio',2039,3.8,'226GB SSD',14,34000000,34500000,4),
       ('H00015','Dell Latitude',2040,3.9,'321GB SSD',15,35000000,35500000,6),
       ('H00016','HP Elitebook',2034,4,'322GB SSD',16,36000000,36500000,4),
       ('H00017','Sony Vaio',2034,4.1,'333GB SSD',17,37000000,37500000,8),
       ('H00018','Toshiba Tecra',2034,4.2,'335GB SSD',18,39000000,40000000,2),
       ('H00019','Dell Precision',2034,4.3,'336GB SSD',19,40000000,41000000,2),
       ('H00020',' HP Probook',2034,4.4,'337GB SSD',20,44000000,45000000,5),
       ('H00021','MSI Gaming',2034,4.5,'420GB SSD',21,45000000,46000000,5),
       ('H00022','Lenovo IdeaPad',2034,4.6,'421GB SSD',22,46000000,47000000,8),
       ('H00023','MSI Alpha',2034,4.7,'422GB SSD',23,48000000,49000000,5),
       ('H00024','HP Gaming Pavilion',2034,4.8,'423GB SSD',24,32000000,32500000,3),
       ('H00025','Lenovo Legion',2034,4.9,'424GB SSD',25,32000000,32500000,3),
       ('H00026','Apple Macbook Air 13',2034,5,'425GB SSD',26,32000000,32500000,1),
       ('H00027','Macbook Pro 15 Touchbar',2034,5.1,'520GB SSD',27,31000000,32500000,9),
       ('H00028','Macbook Air MREE2',2034,5.2,'521GB SSD',28,31000000,32500000,6),
       ('H00029','Macbook Pro 16',2034,5.3,'522GB SSD',29,31000000,32500000,5),
	   ('H00030','Microsoft Surface Pro 7',2034,5.4,'523GB SSD',30,31000000,32500000,3);

INSERT INTO nhanvien (MaNhanVien,TenHoNV,TenDemNV,TenNV,GioiTinh,NgaySinh,DiaChi,LuongNV,SoDienThoai,Email,IdCuaHang,IdChucVu,IdGuiBaoCao)
VALUES('NV01',N'Nguyễn',N'Huy',N'Quyết','Nam', '1989-11-03','Bắc Giang' ,8000000,'0582805832','quyetnhph10607@fpt.edu.vn',1,1,NULL),
('NV02',N'Đào','Quang','Huy','Nam', '1989-11-05','Bắc Giang','5000000','0327492081','huydqph11816@fpt.edu.vn',2,1,NULL),
('NV03',N'Nguyễn','Anh',N'Dũ+ng','Nam','1998-11-06','Hà Nội','10000000','0116031909','dungnhph19607@fpt.edu.vn',1,3,NULL),
('NV04',N'Vũ','Linh','Chi',N'Nữ','1992-11-07','Hà Nội','4000000','0189031909','chivlph19007@fpt.edu.vn',1,1,NULL),
('NV05',N'Đào','Duy','Anh','Nam','1965-11-08','Hà Nội','6000000','0786031909','anhddph18607@fpt.edu.vn',2,3,NULL),
('NV06',N'Nguyễn Thị',N'Mỹ ',N'Mỹ',N'Nữ','1965-11-09','Bắc Giang','7000000','0289031909','mynttph18907@fpt.edu.vn',9,1,NULL),
('NV07',N'Trần','Xuân',N'Trường','Nam','1961-10-10','Hà Nội','3000000','0567031909','truongtxph17607@fpt.edu.vn',10,2,NULL),
('NV08',N'Phùng',N'Văn',N'Hưng','Nam','1989-10-11','Hà Nội','4000000','0896031909','hungpvph19797@fpt.edu.vn',1,2,NULL),
('NV09',N'Nguyễn Thị','Thanh',N'Phương',N'Nữ','1989-11-13','Hà Nội','6000000','0676031909','phuongnttph19607@fpt.edu.vn',7,2,NULL),
('NV10',N'Lê',N'Văn',N'Quyết','Nam','2000-11-23','Hà Nội','8000000','0456031909','quyetlv19607@fpt.edu.vn',6,2,NULL),
('NV11',N'Trần',N'Văn','Duy','Nam','1982-11-04','Hà Nội','8000000','0895931909','duytvph19607@fpt.edu.vn',4,3,NULL),
('NV12',N'Nguyễn',N'Thế','Anh','Nam','1981-10-05','Hà Nội','8000000','0486031909','anhntph19607@fpt.edu.vn',1,3,NULL),
('NV13',N'Lê','Minh',N'Ngọc','Nam','1981-10-10','Hà Nội','5000000','0206031909','ngoclmph19607@fpt.edu.vn',1,1,NULL),
('NV14',N'Phạm','Minh',N'Chính',N'Nam','1981-10-07','Bắc Giang','6000000','0296031909','chinhpmph19607@fpt.edu.vn',1,1,NULL),
('NV15',N'Nguyễn Thị','Thu',N'Hiền',N'Nữ','1981-11-08','HCM','7000000','0566031909','dph19607@fpt.edu.vn',1,1,NULL),
('NV16',N'Nguyễn',N'Anh',N'Tuấn','Nam','1981-11-03','Hà Nội','5000000','0196031909','tuannaph18907@fpt.edu.vn',1,3,NULL),
('NV17',N'Nguyễn Hoàng','Quang','Linh',N'Nữ','1981-10-09','Hà Nội','6000000','0906031909','linhnhqph19607@fpt.edu.vn',1,1,NULL),
('NV18',N'Trinh',N'Hồng','Hải','Nam','1981-12-13','Hà Nội','4000000','0278031909','haith19607@fpt.edu.vn',1,2,NULL),
('NV19',N'Nguyễn',N'Hồng',N'Quân','Nam','1981-10-15','Hà Nội','5000000','0186031909','tuannaph16607@fpt.edu.vn',1,2,NULL),
('NV20',N'Đỗ',N'Quỳnh','Anh','Nam','1983-11-03','HCM','7000000','0178031909','anhdqph19607@fpt.edu.vn',6,2,NULL),
('NV21',N'Hoàng',N'Quốc',N'Bảo',N'Nam','1983-10-03','Hà Nội','8000000','0216031909','viethqbph19607@fpt.edu.vn',5,3,NULL),
('NV22',N'Nguyễn','Anh',N'Tuấn','Nam','1983-10-03','HCM','5000000','0195031909','tuannaph19607@fpt.edu.vn',4,3,NULL),
('NV23',N'Bùi',N'Trí','Trung','Nam','1983-10-03','Hà Nội','6000000','0192031909','trungbttph19607@fpt.edu.vn',2,2,NULL),
('NV24',N'Cao',N'Tuấn',N'Linh','Nam','1983-10-03','Hà Nội','4000000','0368031909','linhctph19607@fpt.edu.vn',2,2,NULL),
('NV25',N'Nguyễn',N'Thị',N'Hồng',N'Nữ','1983-10-03','Hà Nội','5000000','0127431909','hongntph19607@fpt.edu.vn',3,3,NULL),
('NV26',N'Nguyễn Thị',N'Bích',N'Hường',N'Nữ','1989-10-03','HCM','6000000','0235431909','huongntbph19607@fpt.edu.vn',9,2,NULL),
('NV27',N'Phùng Thị',N'Hồng',N'Nhung',N'Nữ','1989-10-03','Hà Nội','7000000','0958331909','nhungpthph19607@fpt.edu.vn',7,2,NULL),
('NV28',N'Nguyễn',N'Văn',N'Tài',N'Nam','1989-10-03','Hà Nội','4000000','0124031909','tainvph19607@fpt.edu.vn',5,1,NULL),
('NV29',N'Lê',N'Công',N'Vinh',N'Nam','1989-06-03','Hà Nội','5000000','0376031909','vinhlcph19607@fpt.edu.vn',9,1,NULL),
('NV30',N'Nguyễn',N'Thị',N'Dịu',N'Nữ','1989-05-03','Hà Nội','8000000','0352031909','diuntph19607@fpt.edu.vn',3,1,NULL);





	

INSERT INTO hoadon(MaHoaDon,NgayMuaSP,NgayTaoHoaDon,NgayShipHang,TinhTrangHoaDon,IdKhachHang,IdNhanVien)
VALUES ('HĐ001','2010-01-02','2010-01-02',NULL,1,1,1),
		('HĐ002','2019-01-20','2019-01-20','2019-01-22',1,2,2),
        ('HĐ003','2019-01-22','2019-01-22',NULL,1,3,3),
        ('HĐ004','2020-04-27','2020-04-27','2020-04-28',1,1,1),
        ('HĐ005','2019-04-03','2019-04-03','2019-04-04',1,5,5),
		('HĐ006','2020-04-02','2019-04-02','2020-04-28',1,6,6),
        ('HĐ007','2019-06-05','2019-06-06','2019-06-07',1,7,7),
        ('HĐ008','2020-04-15','2020-04-15','2019-04-28',1,8,7),
        ('HĐ009','2019-07-27','2019-07-27','2019-07-28',1,9,2),
        ('HĐ010','2019-08-18','2019-08-18','2019-08-18',1,10,6),
        ('HĐ011','2019-09-19','2019-09-19','2019-09-20',1,1,6),
        ('HĐ012','2019-10-11','2019-10-11','2019-11-13',1,2,2),
        ('HĐ013','2019-11-12','2019-11-12','2019-11-13',1,3,7),
        ('HĐ014','2019-12-13','2019-12-13','2019-12-14',1,4,11),
        ('HĐ015','2020-01-02','2020-01-02','2020-01-03',1,5,12),
        ('HĐ016','2020-02-26','2020-02-26','2020-02-27',1,6,13),
        ('HĐ017','2020-03-27','2020-03-27','2020-03-28',1,7,15),
		('HĐ018','2020-03-12','2020-03-12','2020-03-13',1,8,16),
		('HĐ019','2020-03-06','2020-03-06','2020-03-07',1,9,20),
		('HĐ020','2020-03-07','2020-03-06','2020-03-07',1,10,23),
		('HĐ021','2020-03-09','2020-03-09','2020-03-10',1,1,24),
		('HĐ022','2020-03-10','2020-03-10','2020-03-12',1,2,30),
		('HĐ023','2020-03-11','2020-03-11','2020-03-12',1,3,12),
		('HĐ024','2020-03-12','2020-03-12','2020-03-13',1,4,29),
		('HĐ025','2020-03-14','2020-03-14','2020-03-15',1,5,19),
		('HĐ026','2020-03-17','2020-03-17','2020-03-18',1,6,9),
		('HĐ027','2020-03-18','2020-03-18','2020-03-19',1,7,8),
		('HĐ028','2020-03-19','2020-03-19','2020-03-20',1,8,11),
		('HĐ029','2020-03-20','2020-03-20','2020-03-21',1,9,10),
		('HĐ030','2020-03-21','2020-03-21','2020-03-22',1,10,11),
		('HĐ031','2020-03-22','2020-03-22','2020-03-23',1,1,12);
      

INSERT INTO hoadonchitiet(IdHoaDon,IdSanPham,SoLuongDatHang,Gia1SanPham,STTHoaDon)
VALUES (1,2,3,19000000,1),
		(2,1,4,21000000,2),
        (3,3,7,18000000,3),
        (4,4,9,17000000,4),
        (5,7,10,14000000,5),
        (6,8,1,24500000,6),
        (7,9,3,26000000,7),
        (8,4,2,275000000,8),
        (9,2,9,30000000,9),
        (10,11,7,32500000,10),
        (11,14,4,32600000,11),
        (13,15,6,34000000,12),
        (11,6,7,32600000,13),
        (12,7,8,32700000,14),
        (14,8,5,34500000,15),
        (15,15,3,35600000,15),
		(16,16,2,36500000,16),
		(17,17,3,37500000,17),
		(18,18,5,40000000,18),
		(19,19,2,41000000,19),
		(20,20,3,45000000,20),
		(21,21,4,46000000,21),
		(22,22,5,47000000,22),
		(23,23,6,36500000,23),
		(24,24,8,49000000,24),
		(25,25,2,32500000,25),
		(26,26,9,32500000,26),
		(27,27,6,32500000,27),
		(28,28,7,32500000,28),
		(29,29,1,32500000,29),
		(30,30,3,32500000,30);
        


      
      

