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

-- 1.7 Begin và End
/* T-SQL tổ chức theo từng khối lệnh
   Một khối lệnh có thể lồng bên trong một khối lệnh khác
   Một khối lệnh bắt đầu bởi BEGIN và kết thúc bởi
   END, bên trong khối lệnh có nhiều lệnh, và các
   lệnh ngăn cách nhau bởi dấu chấm phẩy	
   BEGIN
    { sql_statement | statement_block}
   END
*/
BEGIN
    SELECT MaNhanVien,TenNV,LuongNV
    FROM nhanvien
    WHERE LuongNV > 100000000

    IF @@ROWCOUNT = 0
    PRINT N'Không có nhân viên nào có mức lương như vậy'
    ELSE
    PRINT N'Có dữ liệu khi truy vấn'
END
-- 1.8 Begin và End lồng nhau
BEGIN
    DECLARE @TenDem NVARCHAR(MAX)
    SELECT TOP 1
    @TenDem = TenDemNV
    FROM nhanvien
    WHERE TenDemNV = N'Minh'
    ORDER BY TenDemNV ASC

    IF @@ROWCOUNT <> 0
    BEGIN
        PRINT N'Tìm thấy người đầu tiên có tên: ' + @TenDem
    END
    ELSE
    BEGIN
        PRINT N'Không tìm thấy nhân viên nào có tên như vậy'
    END
END
-- 1.9 CAST ÉP KIỂU DỮ LIỆU
-- Hàm CAST trong SQL Server chuyển đổi một biểu thức từ một kiểu dữ liệu này sang kiểu dữ liệu khác. 
-- Nếu chuyển đổi không thành công, CAST sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CAST(bieuthuc AS kieudulieu [(do_dai)])
SELECT CAST(42.15 AS INT)-- = 42
SELECT CAST(13.5 AS FLOAT)
SELECT CAST(13.5 AS varchar)
SELECT CAST(13.5 AS varchar(5))
SELECT CAST('13.5' AS FLOAT)
SELECT CAST('2022-01-15' AS DATETIME)

-- 2.0 CONVERT 
-- Hàm CONVERT trong SQL Server cho phép bạn có thể chuyển đổi một biểu thức nào đó sang một kiểu dữ liệu 
-- bất kỳ mong muốn nhưng có thể theo một định dạng nào đó (đặc biệt đối với kiểu dữ liệu ngày). 
-- Nếu chuyển đổi không thành công, CONVERT sẽ báo lỗi, ngược lại nó sẽ trả về giá trị chuyển đổi tương ứng.
-- CONVERT(kieudulieu(do_dai), bieuthuc, dinh_dang)
-- dinh_dang (không bắt buộc): là một con số chỉ định việc định dạng cho việc chuyển đổi dữ liệu từ dạng ngày sang dạng chuỗi.
SELECT CONVERT(int,15.6) -- 15
SELECT CONVERT(float,'9.9')
SELECT CONVERT(datetime,'2022-01-15')

-- Các định dạng trong convert 101,102.........các tham số định dạng https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/
SELECT CONVERT(varchar,'01/15/2021',101) -- mm/dd/yyyy
SELECT CONVERT(datetime,'2022.01.15',102) --yyy.mm.dd
SELECT CONVERT(datetime,'15/01/2022',103) --dd/mm/yyyy

-- Ví dụ: Hiển thị danh sách ngày sinh của nhân viên 
SELECT NgaySinh,
CAST(NgaySinh AS varchar) AS 'Ngày sinh 1',
CONVERT(varchar,NgaySinh,101) AS 'Ngày sinh 2',
CONVERT(varchar,NgaySinh,102) AS 'Ngày sinh 3',
CONVERT(varchar,NgaySinh,103) AS 'Ngày sinh 4'
FROM nhanvien

-- 2.1 Các hàm toán học Các hàm toán học (Math) được dùng để thực hiện các phép toán số học trên các giá trị. 
-- Các hàm toán học này áp dụng cho cả SQL SERVER và MySQL.
-- 1. ABS() Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
-- Hàm ABS() dùng để lấy giá trị tuyệt đối của một số hoặc biểu thức.
SELECT ABS(-3)
-- 2. CEILING()
-- Hàm CEILING() dùng để lấy giá trị cận trên của một số hoặc biểu thức, tức là lấy giá trị số nguyên nhỏ nhất nhưng lớn hơn số hoặc biểu thức tương ứng.
-- CEILING(num_expr)
SELECT CEILING(3.1)
-- 3. FLOOR()
-- Ngược với CEILING(), hàm FLOOR() dùng để lấy cận dưới của một số hoặc một biểu thức, tức là lấy giá trị số nguyên lớn nhất nhưng nhỏ hơn số hoặc biểu thức tướng ứng.
-- FLOOR(num_expr)
SELECT FLOOR(9.9)
-- 4. POWER()
-- POWER() dùng để tính luỹ thừa của một số hoặc biểu thức.
-- POWER(num_expr,luỹ_thừa)
SELECT POWER(3,2)
-- 5. ROUND()
-- Hàm ROUND() dùng để làm tròn một số hay biểu thức.
-- ROUND(num_expr,độ_chính_xác)
SELECT ROUND(9.123456,2)-- = 9.123500
-- 6. SIGN()
-- Hàm SIGN() dùng để lấy dấu của một số hay biểu thức. Hàm trả về +1 nếu số hoặc biểu thức có giá trị dương (>0),
-- -1 nếu số hoặc biểu thức có giá trị âm (<0) và trả về 0 nếu số hoặc biểu thức có giá trị =0.
SELECT SIGN(-99)
SELECT SIGN(100-50)
-- 7. SQRT()
-- Hàm SQRT() dùng để tính căn bậc hai của một số hoặc biểu thức, giá trị trả về của hàm là số có kiểu float.
-- Nếu số hay biểu thức có giá trị âm (<0) thì hàm SQRT() sẽ trả về NULL đối với MySQL, trả về lỗi đối với SQL SERVER.
-- SQRT(float_expr)
SELECT SQRT(9)
SELECT SQRT(9-5)
-- 8. SQUARE()
-- Hàm này dùng để tính bình phương của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT SQUARE(9)
-- 9. LOG()
-- Dùng để tính logarit cơ số E của một số, trả về kiểu float. Ví dụ:
SELECT LOG(9) AS N'Logarit cơ số E của 9'
-- 10. EXP()
-- Hàm này dùng để tính luỹ thừa cơ số E của một số, giá trị trả về có kiểu float. Ví dụ:
SELECT EXP(2)
-- 11. PI()
-- Hàm này trả về số PI = 3.14159265358979.
SELECT PI()
-- 12. ASIN(), ACOS(), ATAN()
-- Các hàm này dùng để tính góc (theo đơn vị radial) của một giá trị. Lưu ý là giá trị hợp lệ đối với 
-- ASIN() và ACOS() phải nằm trong đoạn [-1,1], nếu không sẽ phát sinh lỗi khi thực thi câu lệnh. Ví dụ:
SELECT ASIN(1) as [ASIN(1)],ACOS(1) as [ACOS(1)],ATAN(1) as [ATAN(1)];

-- 2.2 Các hàm xử lý chuỗi làm việc với kiểu chuỗi
/*
 LEN(string)  Trả về số lượng ký tự trong chuỗi, tính cả ký tự trắng đầu chuỗi
 LTRIM(string) Loại bỏ khoảng trắng bên trái
 RTRIM(string)  Loại bỏ khoảng trắng bên phải
 LEFT(string,length) Cắt chuỗi theo vị trí chỉ định từ trái
 RIGHT(string,legnth) Cắt chuỗi theo vị trí chỉ định từ phải
 TRIM(string) Cắt chuỗi 2 đầu nhưng từ bản SQL 2017 trở lên mới hoạt động
*/
SELECT LEN('SQL SERVER')--=10 ký tự bao gồm cả space
SELECT LTRIM(' SQL SERVER')
SELECT RTRIM(' SQL SERVER ')
SELECT RTRIM(LTRIM(' SQL SERVER '))
/*Nếu chuỗi gồm hai hay nhiều thành phần, bạn có thể phân
tách chuỗi thành những thành phần độc lập.
Sử dụng hàm CHARINDEX để định vị những ký tự phân tách.
Sau đó, dùng hàm LEFT, RIGHT, SUBSTRING và LEN để trích ra
những thành phần độc lập*/
DECLARE @Names1_Table TABLE (Fullname NVARCHAR(MAX))
INSERT INTO @Names1_Table VALUES(N'Nguyễn Tiến Hùng'),(N'Nguyễn Hữu Khoa')
SELECT Fullname,
LEN(Fullname) AS N'Độ Dài Chuỗi',
CHARINDEX(' ',Fullname) AS 'CHARINDEX',
LEFT(Fullname,CHARINDEX(' ',Fullname)-1) AS N'Họ',
RIGHT(Fullname,LEN(Fullname)-CHARINDEX(' ',Fullname)) AS N'Tên'
FROM @Names1_Table
-- Bài tập: Truyền vào 1 tên bất kỳ có thể phân tách được hết các thành phần bên trong tên
-- Ví dụ: Bùi thế mạnh thì ra 3 cột BÙI - THẾ - Mạnh