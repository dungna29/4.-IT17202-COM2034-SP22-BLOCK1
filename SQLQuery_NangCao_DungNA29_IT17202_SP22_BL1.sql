-- SQLQuery_NangCao_DungNA29_IT17202_SP22_BL1
-- Các phím tắt cơ bản:
-- Ctrl + /: Dùng comment code
-- F5: Dùng để chạy câu lệnh SQL

-- Sử dụng SQL: 
-- Chạy câu lệnh SQL đang được chọn (Ctrl + E)
-- Chuyển câu lệnh đang chọn thành chữ hoa, chữ thường (Ctrl + Shift + U, Ctrl + Shift + L)
-- Comment và bỏ comment dòng lệnh ( Ctrl + K + C; Ctrl + K + U)

-- Bài 1 Tạo biến bằng lệnh Declare trong SQL SERVER
-- 1.1 Để khai báo biến thì các bạn sử dụng từ khóa Declare với cú pháp như sau:
-- DECLARE @var_name data_type;
-- @var_name là tên của biến, luôn luôn bắt đầu bằng ký tự @
-- data_type là kiểu dữ liệu của biến
-- Ví dụ:
DECLARE @YEAR AS INT

DECLARE @NAME AS NVARCHAR,
        @YEAR_OF_BIRTH AS INT

-- 1.2 Gán giá trị cho biến
-- SQL Server để gán giá trị thì bạn sử dụng từ khóa SET và toán tử = với cú pháp sau
-- SET @var_name = value
SET @YEAR = 2022;
SELECT @YEAR;

-- 1.2 Truy xuất giá trị của biến SELECT @<Tên biến> 
DECLARE @ChieuDai INT, @ChieuRong INT, @DienTich INT
SET @ChieuDai = 6
SET @ChieuRong = 2
SET @DienTich = @ChieuDai*@ChieuRong
SELECT @DienTich

-- 1.3 Lưu trữ câu truy vấn vào biến
DECLARE @KhoaLonNhat INT
SET @KhoaLonNhat = (SELECT MAX(IdNhanVien) FROM nhanvien)
-- SELECT @KhoaLonNhat
PRINT N'Nhân viên có khóa chính lớn nhất: ' 
+ CONVERT(VARCHAR(5),@KhoaLonNhat)
-- Bài tập ví dụ: Lấy ra sản phẩm có trọng lượng bé 
-- nhất gán cho 1 Biến và in biến đó ra

-- 1.4 Biến Bảng 
DECLARE @SP_TABLE TABLE (CODE NVARCHAR(20), TSP NVARCHAR(50))
-- Chè dữ liệu vào biến bảng
INSERT INTO @SP_TABLE
SELECT MaSanPHam,TenSP
FROM sanpham
WHERE TenSP LIKE 'Dell%'

SELECT * FROM @SP_TABLE
-- Hoặc truy cập đến từng trường
SELECT TSP FROM @SP_TABLE

-- 1.5  CHÈN DỮ LIỆU VÀO BIẾN BẢNG
DECLARE @SanPhamFPOLY TABLE (ID int,TenSP NVARCHAR(50),QuocGia NVARCHAR(20))
-- Chèn dữ liệu vào bảng
INSERT INTO @SanPhamFPOLY VALUES(1,N'BPHONE 5','VN')
-- Truy xuất dữ liệu
SELECT * FROM @SanPhamFPOLY

-- 1.6 Sửa dữ liệu vào biến bảng
DECLARE @SanPhamFPOLY_Update TABLE (ID int,TenSP NVARCHAR(50),QuocGia NVARCHAR(20))
INSERT INTO @SanPhamFPOLY_Update VALUES(1,N'BPHONE 5','VN')-- Thêm data
SELECT * FROM @SanPhamFPOLY_Update
UPDATE @SanPhamFPOLY_Update
SET QuocGia = N'Việt Nam'
WHERE ID = 1
SELECT * FROM @SanPhamFPOLY_Update