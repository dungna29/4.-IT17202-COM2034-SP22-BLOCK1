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
SET @KhoaLonNhat = (SELECT MAX(IdNhanVien)
FROM nhanvien)
-- SELECT @KhoaLonNhat
PRINT N'Nhân viên có khóa chính lớn nhất: ' 
+ CONVERT(VARCHAR(5),@KhoaLonNhat)
-- Bài tập ví dụ: Lấy ra sản phẩm có trọng lượng bé 
-- nhất gán cho 1 Biến và in biến đó ra

-- 1.4 Biến Bảng 
DECLARE @SP_TABLE TABLE (CODE NVARCHAR(20),
    TSP NVARCHAR(50))
-- Chè dữ liệu vào biến bảng
INSERT INTO @SP_TABLE
SELECT MaSanPHam, TenSP
FROM sanpham
WHERE TenSP LIKE 'Dell%'

SELECT *
FROM @SP_TABLE
-- Hoặc truy cập đến từng trường
SELECT TSP
FROM @SP_TABLE

-- 1.5  CHÈN DỮ LIỆU VÀO BIẾN BẢNG
DECLARE @SanPhamFPOLY TABLE (ID int,
    TenSP NVARCHAR(50),
    QuocGia NVARCHAR(20))
-- Chèn dữ liệu vào bảng
INSERT INTO @SanPhamFPOLY
VALUES(1, N'BPHONE 5', 'VN')
-- Truy xuất dữ liệu
SELECT *
FROM @SanPhamFPOLY

-- 1.6 Sửa dữ liệu vào biến bảng
DECLARE @SanPhamFPOLY_Update TABLE (ID int,
    TenSP NVARCHAR(50),
    QuocGia NVARCHAR(20))
INSERT INTO @SanPhamFPOLY_Update
VALUES(1, N'BPHONE 5', 'VN')-- Thêm data
SELECT *
FROM @SanPhamFPOLY_Update
UPDATE @SanPhamFPOLY_Update
SET QuocGia = N'Việt Nam'
WHERE ID = 1
SELECT *
FROM @SanPhamFPOLY_Update

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
    SELECT MaNhanVien, TenNV, LuongNV
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
SELECT CONVERT(int,15.6)
-- 15
SELECT CONVERT(float,'9.9')
SELECT CONVERT(datetime,'2022-01-15')

-- Các định dạng trong convert 101,102.........các tham số định dạng https://www.mssqltips.com/sqlservertip/1145/date-and-time-conversions-using-sql-server/
SELECT CONVERT(varchar,'01/15/2021',101)
-- mm/dd/yyyy
SELECT CONVERT(datetime,'2022.01.15',102)
--yyy.mm.dd
SELECT CONVERT(datetime,'15/01/2022',103)
--dd/mm/yyyy

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
SELECT ASIN(1) as [ASIN(1)], ACOS(1) as [ACOS(1)], ATAN(1) as [ATAN(1)];

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
INSERT INTO @Names1_Table
VALUES(N'Nguyễn Tiến Hùng'),
    (N'Nguyễn Hữu Khoa')
SELECT Fullname,
    LEN(Fullname) AS N'Độ Dài Chuỗi',
    CHARINDEX(' ',Fullname) AS 'CHARINDEX',
    LEFT(Fullname,CHARINDEX(' ',Fullname)-1) AS N'Họ',
    RIGHT(Fullname,LEN(Fullname)-CHARINDEX(' ',Fullname)) AS N'Tên'
FROM @Names1_Table
-- Bài tập: Truyền vào 1 tên bất kỳ có thể phân tách được hết các thành phần bên trong tên
-- Ví dụ: Bùi thế mạnh thì ra 3 cột BÙI - THẾ - Mạnh

-- Cách 2: 
DECLARE @Names1_Table TABLE (Fullname NVARCHAR(MAX))
INSERT INTO @Names1_Table
VALUES(N'Nguyễn Tiến Hùng'),
    (N'Nguyễn Hữu Khoa')
SELECT Fullname,
    PARSENAME(REPLACE(Fullname,' ','.'),3) AS N'Họ',
    PARSENAME(REPLACE(Fullname,' ','.'),2) AS N'Tên Đệm',
    PARSENAME(REPLACE(Fullname,' ','.'),1) AS N'Tên'
FROM @Names1_Table
--Cách 3:
DECLARE @Names1_Table11 TABLE (TenNV NVARCHAR(MAX))
INSERT INTO @Names1_Table11
VALUES(N'Nguyễn Văn Chương'),
    (N'Tô Ngọc Hùng')
SELECT TenNV AS N'TÊN ĐẦY ĐỦ',
    LEFT(TenNV, CHARINDEX(' ', TenNV) -1) AS N'HỌ',
    RTRIM(LTRIM(REPLACE(REPLACE(TenNV,SUBSTRING(TenNV , 1, CHARINDEX(' ', TenNV) - 1),''),REVERSE( LEFT( REVERSE(TenNV), CHARINDEX(' ', REVERSE(TenNV))-1 ) ),'')))as N'TÊN ĐỆM',
    RIGHT(TenNV, CHARINDEX(' ', TenNV)) AS N'TÊN'
FROM @Names1_Table11

-- 2.3 Charindex Trả về vị trí được tìm thấy của một chuỗi trong chuỗi chỉ định, 
-- ngoài ra có thể kiểm tra từ vị trí mong  muốn
-- CHARINDEX ( string1, string2 ,[  start_location ] ) = 1 số nguyên
SELECT CHARINDEX('Poly','FPT POLYTECHNIC')
SELECT CHARINDEX('Poly','FPT POLYTECHNIC',6)

-- 2.4 Substring Cắt chuỗi bắt đầu từ vị trí và độ dài muốn lấy 
-- SUBSTRING(string,start,length)
SELECT SUBSTRING('FPT POLYTECHNIC',5,LEN('FPT POLYTECHNIC'))
SELECT SUBSTRING('FPT POLYTECHNIC',5,8)-- 5 là điểm bắt đầu và lấy 8 ký tự sau 5

-- 2.5 Replace Hàm thay thế chuỗi theo giá trị cần thay thế và cần thay thế
-- REPLACE(search,find,replace)
SELECT REPLACE('0912-345-678','-','')
SELECT REPLACE(N'NGUYỄN HOÀNG TIẾN',N'TIẾN',N'DŨNG')

/* 2.6 
REVERSE(string) Đảo ngược chuỗi truyền vào
LOWER(string)	Biến tất cả chuỗi truyền vào thành chữ thường
UPPER(string)	Biến tất cả chuỗi truyền vào thành chữ hoa
SPACE(integer)	Đếm số lượng khoảng trắng trong chuỗi. 
*/
SELECT LOWER('SQL SERVER 2022')
SELECT UPPER('sql server 2023')
SELECT REVERSE('sql server 2023')
SELECT N'HOÀNG' + ' ' + N'TIẾN'
SELECT N'HOÀNG' + SPACE(5) + N'TIẾN'

-- 2.7 Các hàm ngày tháng năm
SELECT GETDATE()
SELECT CONVERT(date,GETDATE())
SELECT CONVERT(time,GETDATE())

SELECT YEAR(GETDATE()) AS YEAR,
    MONTH(GETDATE()) AS MONTH,
    DAY(GETDATE()) AS DAY

-- DATENAME: truy cập tới các thành phần liên quan ngày tháng
SELECT DATENAME(YEAR,GETDATE()) AS YEAR,
    DATENAME(MONTH,GETDATE()) AS MONTH,
    DATENAME(DAY,GETDATE()) AS DAY,
    DATENAME(WEEK,GETDATE()) AS WEEK,
    DATENAME(DAYOFYEAR,GETDATE()) AS DAYOFYEAR,
    DATENAME(WEEKDAY,GETDATE()) AS WEEKDAY
-- Truyền thử ngày sinh của mình vào
DECLARE @NGAY_SINH_CUA_TOI DATE
SET @NGAY_SINH_CUA_TOI = '1980-07-27'
SELECT DATENAME(YEAR,@NGAY_SINH_CUA_TOI) AS YEAR,
    DATENAME(MONTH,@NGAY_SINH_CUA_TOI) AS MONTH,
    DATENAME(DAY,@NGAY_SINH_CUA_TOI) AS DAY,
    DATENAME(WEEK,@NGAY_SINH_CUA_TOI) AS WEEK,
    DATENAME(DAYOFYEAR,@NGAY_SINH_CUA_TOI) AS DAYOFYEAR,
    DATENAME(WEEKDAY,@NGAY_SINH_CUA_TOI) AS WEEKDAY

-- 2.8 Câu điều kiện IF ELSE trong SQL
/* Lệnh if sẽ kiểm tra một biểu thức có đúng  hay không, nếu đúng thì thực thi nội dung bên trong của IF, nếu sai thì bỏ qua.
IF BIỂU THỨC   
BEGIN
    { statement_block }
END		  */
IF 1=1
BEGIN
    PRINT N'ĐÚNG'
END
ELSE
BEGIN
    PRINT N'SAI'
END

IF 1=3
    PRINT N'ĐÚNG'
ELSE
    PRINT N'SAI'

-- Viết 1 chương trình tính điểm Qua môn  
DECLARE @DiemGPA_COM2034 FLOAT
SET @DiemGPA_COM2034 = 4.9
IF @DiemGPA_COM2034<5
PRINT N'CHÚC MỪNG BẠN VỪA MẤT 700K'
ELSE
PRINT N'CHÚC MỪNG BẠN ĐÃ QUA MÔN'


DECLARE @DiemGPA_COM20341 FLOAT
SET @DiemGPA_COM20341 = 8.9
IF @DiemGPA_COM20341<5
BEGIN
    PRINT N'CHÚC MỪNG BẠN VỪA MẤT 700K'
END
ELSE
BEGIN
    PRINT N'CHÚC MỪNG BẠN ĐÃ QUA MÔN'
    IF @DiemGPA_COM20341<8
    BEGIN
        PRINT N'BẠN ĐẠT LOẠI KHÁ'
    END
    ELSE 
    BEGIN
        PRINT N'BẠN ĐẠT LOẠI ONG VÀNG'
    END
END

/* 2.9 IF EXISTS
IF EXISTS (CaulenhSELECT)
Cau_lenhl | Khoi_lenhl
[ELSE
Cau_lenh2 | Khoi_lenh2] 
*/
-- Kiểm tra xem trong bảng nhân viên có nhân viên nào lương lớn hơn 50tr ko?
IF EXISTS(
    SELECT *
FROM nhanvien
WHERE LuongNV >= 5000000)
    BEGIN
    PRINT N'Có danh sách nhân viên lương > 50tr'
    SELECT *
    FROM nhanvien
    WHERE LuongNV >= 5000000
END
ELSE
BEGIN
    PRINT N'KHÔNG Có danh sách nhân viên lương > 50tr'
END

/*
 3.0 Hàm IIF () trả về một giá trị nếu một điều kiện là TRUE hoặc một giá trị khác nếu một điều kiện là FALSE.
IIF(condition, value_if_true, value_if_false)
*/
SELECT IIF(1000>900,N'ĐÚNG RỒI',N'SAI RỒI')

SELECT MaNhanVien, TenNV,
    IIF(IdCuaHang=1,N'NV thuộc cửa hàng 1',IIF(IdCuaHang=2,N'NV Thuộc CH2',N'Không biết'))
FROM nhanvien

/*
3.1 Câu lệnh CASE đi qua các điều kiện và trả về một giá trị khi điều kiện đầu tiên được đáp ứng (như câu lệnh IF-THEN-ELSE). 
Vì vậy, một khi một điều kiện là đúng, nó sẽ ngừng đọc và trả về kết quả. 
Nếu không có điều kiện nào đúng, nó sẽ trả về giá trị trong mệnh đề ELSE.
Nếu không có phần ELSE và không có điều kiện nào đúng, nó sẽ trả về NULL.
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    WHEN conditionN THEN resultN
    ELSE result
END;
*/
SELECT TenNV = 
CASE GioiTinh
WHEN 'Nam' THEN 'Mr. ' + TenNV
WHEN N'Nữ' THEN 'Ms. ' + TenNV
ELSE N'Không xác định ' + TenNV
END
FROM nhanvien
-- Viết cách khác
SELECT TenNV = 
CASE 
WHEN GioiTinh = 'Nam' THEN 'Mr. ' + TenNV
WHEN GioiTinh = N'Nữ' THEN 'Ms. ' + TenNV
ELSE N'Không xác định ' + TenNV
END
FROM nhanvien
-- Tạo ra 1 cột tính thuế cho nhân viên ở cửa hàng
-- Lương mà 0 đến 300k thì 1 mức thuế 5%, 300k đến 600k mức thuế 8%, 6 đến 10tr 10%
-- các trường hợp còn lại là 30% thuế.
SELECT MaNhanVien, TenNV, LuongNV,
    Thue = (CASE
WHEN LuongNV BETWEEN 0 AND 300000 THEN LuongNV*0.05
WHEN LuongNV BETWEEN 300000 AND 600000 THEN LuongNV*0.08
WHEN LuongNV BETWEEN 6000000 AND 10000000 THEN LuongNV*0.1
ELSE LuongNV*0.3
END)
FROM nhanvien

/*Vòng lặp WHILE (WHILE LOOP) được sử dụng nếu bạn muốn 
chạy lặp đi lặp lại một đoạn mã khi điều kiện cho trước trả về giá trị là TRUE.*/
DECLARE @DEM INT = 0
WHILE @DEM < 5
BEGIN
    SET @DEM = @DEM + 1
    PRINT N'MÔN CSDL NÂNG CAO QUAN TRỌNG PHẢI CHỊU KHÓ CODE'
    PRINT N'Lần thứ ' + CONVERT(varchar,@DEM,1)
END
PRINT N'THỰC RA CŨNG KHÔNG KHÓ NHỈ'

/*Lệnh Break (Ngắt vòng lặp)*/
/* Lệnh Continue: Thực hiện bước lặp tiếp theo bỏ qua các lệnh trong */
DECLARE @DEM1 INT = 0
WHILE @DEM1 < 10
BEGIN
    IF @DEM1 = 5
    BEGIN
        SET @DEM1 = @DEM1 + 1
        CONTINUE
    END
    SET @DEM1 = @DEM1 + 1
    PRINT N'MÔN CSDL NÂNG CAO QUAN TRỌNG PHẢI CHỊU KHÓ CODE'
    PRINT N'Lần thứ ' + CONVERT(varchar,@DEM1,1)
END
PRINT N'THỰC RA CŨNG KHÔNG KHÓ NHỈ'

/* 3.2 Try...Catch 
SQLServer Transact-SQL cung cấp cơ chế kiểm soát lỗi bằng TRY … CATCH
như trong các ngôn ngữ lập trình phổ dụng hiện nay (Java, C, PHP, C#).
Một số hàm ERROR thường dùng
_
ERROR_NUMBER() : Trả về mã số của lỗi dưới dạng số
ERROR_MESSAGE() Trả lại thông báo lỗi dưới hình thức văn bản 
ERROR_SEVERITY() Trả lại mức độ nghiêm trọng của lỗi kiểu int
ERROR_STATE() Trả lại trạng thái của lỗi dưới dạng số
ERROR_LINE() : Trả lại vị trí dòng lệnh đã phát sinh ra lỗi
ERROR_PROCEDURE() Trả về tên thủ tục/Trigger gây ra lỗi
*/
BEGIN TRY
    SELECT 1 + 'STRING'
END TRY
BEGIN CATCH
    SELECT
    ERROR_NUMBER() AS N'Trả về mã số của lỗi dưới dạng số',
    ERROR_MESSAGE() AS N'Trả lại thông báo lỗi dưới hình thức văn bản'
END CATCH

BEGIN TRY
INSERT INTO chucvu
    (MaChucVu,TenChucVu)
VALUES
    ('AAA', '1.5')
END TRY
BEGIN CATCH
    PRINT N'BẠN ƠI KHÔNG INSERT ĐƯỢC RỒI'
    PRINT N'THÔNG BÁO: ' +  CONVERT(varchar,ERROR_NUMBER(),1)
    PRINT N'THÔNG BÁO: ' +  ERROR_MESSAGE()
END CATCH
/* 3.3 RAISERROR
*/
-- Có dùng RAISE...
BEGIN TRY
INSERT INTO chucvu
    (IdChucVu,MaChucVu,TenChucVu)
VALUES
    (1, 'AAA', '1.5')
END TRY
BEGIN CATCH
    DECLARE @erERROR_SEVERITY INT,@erERROR_MESSAGE VARCHAR(MAX),@erERROR_STATE INT
    SELECT
    @erERROR_SEVERITY = ERROR_SEVERITY(),
    @erERROR_MESSAGE = ERROR_MESSAGE(),
    @erERROR_STATE = ERROR_STATE()
    RAISERROR(@erERROR_MESSAGE,@erERROR_SEVERITY,@erERROR_STATE)
END CATCH
-- Cách không dùng
BEGIN TRY
    INSERT INTO chucvu
    (IdChucVu,MaChucVu,TenChucVu)
VALUES(1, 'AA', N'Hoàng')   
END TRY
BEGIN CATCH
   DECLARE @ErMESSAGE1 VARCHAR(MAX), @ErSEVERITY1 INT, @ErSTATE1 INT
   SELECT
    @ErMESSAGE1 = ERROR_MESSAGE(),
    @ErSEVERITY1 = ERROR_SEVERITY(),
    @ErSTATE1 = ERROR_STATE()
   PRINT N'Thông báo: ' + @ErMESSAGE1 + ' | ' + CONVERT(VARCHAR,@ErSEVERITY1,1) +
   ' | ' + CONVERT(VARCHAR, @ErSTATE1,1)   
END CATCH

-- 3.4 Ý nghĩa của Replicate
DECLARE @ten1234 NVARCHAR(50)
SET @ten1234 = REPLICATE(N'Á',5)--Lặp lại số lần với String truyền vào
PRINT @ten1234

/* TỔNG KẾT STORE PROCEDURE :
 -- Là lưu trữ một tập hợp các câu lệnh đi kèm trong CSDL cho phép tái sử dụng khi cần
 -- Hỗ trợ các ứng dụng tương tác nhanh và chính xác
 -- Cho phép thực thi nhanh hơn cách viết từng câu lệnh SQL
 -- Stored procedure có thể làm giảm bớt vấn đề kẹt đường truyền mạng, dữ liệu được gởi theo gói.
 -- Stored procedure có thể sử dụng trong vấn đề bảo mật, phân quyền
 -- Có 2 loại Store Procedure chính: System stored	procedures và User stored procedures   
 
 -- Cấu trúc của Store Procedure bao hồm:
	➢Inputs: nhận các tham số đầu vào khi cần
	➢Execution: kết hợp giữa các yêu cầu nghiệp vụ với các lệnh
	lập trình như IF..ELSE, WHILE...
	➢Outputs: trả ra các đơn giá trị (số, chuỗi…) hoặc một tập kết quả.
 
 --Cú pháp:
 CREATE hoặc ALTER(Để cập nhật nếu đã tồn tại tên SP) PROC <Tên STORE PROCEDURE> <Tham số truyền vào nếu có>
 AS
 BEGIN
  <BODY CODE>
 END
 ĐỂ GỌI SP dùng EXEC hoặc EXECUTE
SPs chia làm 2 loại:
System stored procedures: Thủ tục mà những người sử dụng chỉ có quyền thực hiện, không được phép thay đổi.	
User stored procedures: Thủ tục do người sử dụng tạo và thực hiện.
 -- SYSTEM STORED PROCEDURES
 Là những stored procedure chứa trong Master Database, thường bắt đầu bằng tiếp đầu ngữ	 sp_
 Chủ yếu dùng trong việc quản lý cơ sở dữ liệu(administration) và bảo mật (security).
❑Ví dụ: sp_helptext <tên của đối tượng> : để lấy định nghĩa của đối tượng (thông số tên đối
tượng truyền vào) trong Database
 */

--  Ví dự cơ bản:
-- Create là khi tạo mới còn khi cần chỉnh sửa lại câu lệnh bên trong của store thì dùng Alter
GO
ALTER PROCEDURE SP_LayDanhSachNhanVien
AS
SELECT *
FROM nhanvien
WHERE LuongNV > 2000000

-- Cách gõ PROC sẽ ngắn gọn hơn cách gõ trên
GO
ALTER PROC SP_LayDanhSachNamBaoHanh2022
AS
SELECT *
FROM sanpham
WHERE NamBaoHanh = 2034
-- Muốn thực thi Store PROC thì dùng câu lệnh Excute
EXECUTE SP_LayDanhSachNhanVien
EXEC SP_LayDanhSachNamBaoHanh2022

-- TRIỂN KHAI STORE PROC NÂNG CAO - GIÚP QUA MÔN, HỌC JAVA3, DỰN ÁN 1 hoặc 2
-- Ví dụ 1: Truyền tham số vào cho Store PROC
GO
CREATE PROC SP_CheckSP_By_NBH_TrongLuong
    (@NBH NUMERIC(4,0),
    @tl float)
AS
SELECT *
FROM sanpham
WHERE NamBaoHanh = @NBH AND TrongLuongSP > @tl

EXEC SP_CheckSP_By_NBH_TrongLuong @NBH = 2034,@tl =3.0

-- Ví dụ 2: Viết CRUD cho bảng
GO
ALTER PROC SP_CRUD_DongSP
    (@id integer,
    @maDSP NVARCHAR(100),
    @tenDSP NVARCHAR(100),
    @web NVARCHAR(200),
    @SType varchar(30))
AS
BEGIN
    IF (@SType = 'SELECT')
    BEGIN
        SELECT *
        FROM dongsanpham
    END
    IF (@SType = 'INSERT')
    BEGIN
        INSERT INTO dongsanpham
            (MaDongSanPham,TenDongSanPham,WebsiteDongSanPham)
        VALUES(@maDSP, @tenDSP, @web)
    END
    IF (@SType = 'DELETE')
    BEGIN
        DELETE FROM dongsanpham WHERE IdDongSanPham = @id
    END
    ELSE IF (@SType = 'UPDATE')
    BEGIN
        UPDATE dongsanpham SET
        MaDongSanPham = @maDSP,
        TenDongSanPham = @tenDSP,
        WebsiteDongSanPham = @web
        Where IdDongSanPham = @id
    END
END
-- Các bạn viết 1 store proc cho bảng cửa hàng CRUD đầy đủ như ví dụ. 15h55 Hết giờ!

EXEC SP_CRUD_DongSP @id = 0,@maDSP = 'FPOLY',
@tenDSP = 'POLYTECHNIC',@web = 'www.fpoly.edu',@SType = 'INSERT'
EXEC SP_CRUD_DongSP @id = 0,@maDSP = '',
@tenDSP = '',@web = '',@SType = 'SELECT'

DECLARE @myid uniqueidentifier = NEWID();
SELECT CONVERT(CHAR(255), @myid) AS 'char';  


/*
 3.5 Trigger trong SQL
❑Trigger là một dạng đặc biệt của thủ tục lưu trữ  (store procedure), được thực thi một cách tự động khi có sự thay đổi dữ liệu (do tác động của
câu lệnh INSERT, UPDATE, DELETE) trên một bảng nào đó.
❑Không thể gọi thực hiện trực tiếp Trigger bằng lệnh EXECUTE.
❑Trigger là một stored procedure không có tham số.
❑Trigger được lưu trữ trong DB Server và thường hay được dùng để kiểm tra ràng buộc toàn vẹn dữ liệu
-- Các Trigger DDL và DML có cách sử dụng khác nhau và được	thực thi với các sự kiện cơ sở dữ liệu khác nhau.
   1. Trigger DDL
		- Các Trigger DDL thực thi các thủ tục lưu trữ trên câu lệnh CREATE, ALTER va DROP
		- Các Trigger DDL được sử dụng để kiểm tra và kiểm soát các hoạt động của cơ sở dữ liệu
		- Các Trigger DDL chỉ hoạt động sau khi bảng hoặc khung nhìn được sửa đổi
		- Các Trigger DDL được định nghĩa ở mức cơ sở liệu hoặc máy chủ
   2. Trigger DML
		- Các Trigger DML thực thi trên các câu lệnh INSERT, UPDATE và DELETE
		- Các Trigger DML được sử dụng để thực thi các quy tắc NGHIỆP VỤ khi dữ liệu được sửa đổi trong bảng hoặc khung hình
		- Các Trigger DML thực thi trong hoặc sau khi dữ liệu được sửa đổi.
		- Các Triigger DML được định nghĩa ở mức cơ sở dữ liệu	 
*/

/* TRIGGER DML 
❑Các trigger DML được thực thi khi sự kiện DML	xảy ra trong các bảng hoặc VIEW.
❑Trigger DML này bao gồm các câu lệnh INSERT, UPDATE và DELETE.
❑Các trigger DML gồm ba loại chính:Trigger	INSERT, Trigger UPDATE, Trigger DELETE
Sinh ra Các bảng Inserted và Deleted
❖Các trigger DML sử dụng hai loại bảng đặc biệt để sửa đổi dữ liệu trong cơ sở dữ liệu.
❖Các bảng tạm thời lưu trữ dữ liệu ban đầu cũng như	 dữ liệu đã sửa đổi. Những bảng này gồm Inserted và	Deleted.
❖Bảng Inserted:chứa bản sao các bản ghi được sửa đổi với hoạt động INSERT và UPDATE trên bảng trigger.
Hoạt động INSERT và UPDATE sẽ tiến hành chèn các bản ghi mới vào bảng Inserted và bảng trigger.
❖Bảng Deleted:chứa bản sao của các bản ghi được sửa đổi với hoạt động DELETE và UPDATE trên bảng trigger
*/

 /*
 Trigger INSERT
❖Trigger INSERT được thực thi khi một bản ghi mới được chèn vào bảng
❖Trigger INSERT đảm bảo rằng giá trị đang được nhập	phù hợp với các ràng buộc được định nghĩa trên bảng đó.
❖Bảng Inserted và Deleted về khía cạnh vật lý chúng không tồn tại trong cơ sở dữ liệu
❖Trigger INSERT được tạo ra bằng cách sử dụng từ  khóa INSERT trong câu lệnh CREATE TRIGGER và ALTER TRIGGER.
 
CREATE TRIGGER Tên_trigger ON Tên_Bảng
FOR {DELETE, INSERT, UPDATE}
AS
BEGIN
	Câu lệnh T-SQL
END 
❖tên_trigger: chỉ ra tên của trigger do người dùng tự đặt
❖Tên bảng: chỉ ra bảng mà trên đó trigger DML được tạo ra
(bảng trigger).
❖FOR : hoạt động thao tác dữ liệu.
❖Câu lệnh sql: chỉ ra các câu lệnh SQL được thực thi trong
trigger DML
 */

-- Ví dụ về Trigger
GO
ALTER TRIGGER TG_Insert_CheckLuongNV ON nhanvien 
FOR INSERT
AS
BEGIN
    IF(SELECT LuongNV
    FROM inserted) < 50000
    BEGIN
        PRINT N'Tiền lương tối thiểu khi insert vào phải lớn hơn 50k'
        ROLLBACK TRANSACTION
    END
END 

INSERT INTO nhanvien
    (MaNhanVien,TenHoNV,TenDemNV,TenNV,GioiTinh,NgaySinh,DiaChi,
    LuongNV,SoDienThoai,Email,IdCuaHang,IdChucVu,IdGuiBaoCao)
VALUES('NV999', N'Nguyễn', N'Huy', N'Quyết', 'Nam', '1989-11-03', 'BG' , 51000,
        '0582905832', 'quyetnhph10608@fpt.edu.vn', 1, 1, 1)

/*
 Trigger UPDATE
❖Trigger UPDATE sao chép bản ghi gốc vào bảng  Deleted và bản ghi mới vào bảng Inserted
❖Nếu các giá trị mới là hợp lệ thì bản ghi từ bảng Inserted sẽ được sao chép vào bảng dữ liệu
❖Trigger UPDATE được tạo ra bằng cách sử dụng từ khóa UPDATE trong câu lệnh CREATE TRIGGER và ALTER TRIGGER.
❖Cú pháp tương tự trigger insert
 
CREATE TRIGGER Tên_trigger ON Tên_Bảng
FOR {DELETE, INSERT, UPDATE}
AS
BEGIN
	Câu lệnh TSQL
END  
 */

GO
CREATE TRIGGER TG_Update_CheckLuongNV ON nhanvien 
FOR UPDATE
AS
BEGIN
    IF(SELECT LuongNV
    FROM inserted) < 50000
    BEGIN
        PRINT N'Tiền lương tối thiểu khi update vào phải lớn hơn 50k'
        ROLLBACK TRANSACTION
    END
END 

UPDATE nhanvien SET LuongNV = 510000 WHERE MaNhanVien = 'NV01'

-- Ví dụ: Xóa id hóa đơn
GO
CREATE TRIGGER TG_XoaIdHoaDon ON hoadon
INSTEAD OF DELETE
AS
BEGIN
    DELETE FROM hoadonchitiet Where IdHoaDon IN (SELECT IdHoaDon
    FROM deleted)
    DELETE FROM hoadon Where IdHoaDon IN (SELECT IdHoaDon
    FROM deleted)
END

DELETE FROM hoadonchitiet Where IdHoaDon = 2;
DELETE FROM hoadon Where IdHoaDon = 2;

/*
HÀM NGƯỜI DÙNG TỰ ĐỊNH NGHĨA
❑Là một đối tượng CSDL chứa các câu lệnh SQL,
được biên dịch sẵn và lưu trữ trong CSDL.
❑Thực hiện một hành động như các tính toán
phức tạp và trả về kết quả là một giá trị.
❑Giá trị trả về có thể là:
	❖Giá trị vô hướng
	❖Một bảng
SO SÁNH HÀM VỚI THỦ TỤC
❑Tương tự như Stored Procedure
❖Là một đối tượng CSDL chứa các câu lệnh SQL, được
biên dịch sẵn và lưu trữ trong CSDL.
❑Khác với Stored Procedure
➢Các hàm luôn phải trả về một giá trị, sử dụng câu lệnh
RETURN
➢Hàm không có tham số đầu ra
➢Không được chứa các câu lệnh INSERT, UPDATE, DELETE
một bảng hoặc view đang tồn tại trong CSDL
➢Có thể tạo bảng, bảng tạm, biến bảng và thực hiện các câu
lệnh INSERT, UPDATE, DELETE trên các bảng, bảng tạm,
biến bảng vừa tạo trong thân hàm
Hàm giá trị vô hướng: Trả về giá trị đơn của mọi kiểu dữ liệu
Hàm giá trị bảng đơn giản: Trả về bảng, là kết quả của một câu SELECT đơn.
Hàm giá trị bảng nhiều câu lệnh: Trả về bảng là kêt quả của nhiều câu lệnh
*/
-- Ví dụ 1: VIết 1 hàm tính tuổi người dùng khi họ nhập năm sinh
GO
CREATE FUNCTION F_TinhTuoi(@NS int)
RETURNS INT -- PHẢI SỬ DỤNG RETURNS để định nghĩa kiểu dữ liệu của hàm
AS 
BEGIN
    RETURN YEAR(GETDATE()) - @NS
END
GO
-- Khi gọi hàm bắt buộc bổ sung dbo. thì mới gọi đc hàm
PRINT dbo.F_TinhTuoi(2002) 

-- Ví dụ 2: Tạo 1 hàm đếm số nhân viên có trong công ty F_TongSoNhanVien
GO
CREATE FUNCTION F_TongSoNhanVien()
RETURNS INT -- PHẢI SỬ DỤNG RETURNS để định nghĩa kiểu dữ liệu của hàm
AS 
BEGIN
    RETURN (SELECT COUNT(MaNhanVien)
    FROM nhanvien)
END
GO
PRINT dbo.F_TongSoNhanVien() 
-- Ví dụ 2: Tạo 1 hàm đếm số nhân viên theo giới tính, giới tính là nham số truyền vào
-- F_DemSoNhanVienByGioiTinh

GO
CREATE FUNCTION F_DemSoNhanVienByGioiTinh(@gt NVARCHAR(10))
RETURNS INT
AS 
BEGIN
    RETURN (SELECT COUNT(MaNhanVien)
    FROM nhanvien
    WHERE GioiTinh = @gt)
END
GO
PRINT N'Tổng nhân viên theo giới tính: ' + CONVERT(VARCHAR, dbo.F_DemSoNhanVienByGioiTinh(N'Nam'))


-- TẠO RA 1 HÀM TRẢ VỀ 1 BẢNG
GO
CREATE FUNCTION F_GetAllNV()
RETURNS TABLE
AS RETURN SELECT *
FROM nhanvien
GO
-- Khi mà hàm trả ra 1 bảng thì sẽ sử dụng select
SELECT *
FROM dbo.F_GetAllNV()

--  Ví dụ cuối hàm: Hàm trả ra giá trị đa câu lệnh
GO
CREATE FUNCTION F_GetLstNV_ByGT(@gt NVARCHAR(10))
RETURNS @TBL_NhanVien TABLE(TenNV NVARCHAR(100),
    MaNV NVARCHAR(100),
    GT NVARCHAR(100))
AS
BEGIN
    IF(@gt IS NULL)
    BEGIN
        INSERT INTO @TBL_NhanVien
            (TenNV,MaNV,GT)
        SELECT TenNV, MaNhanVien, GioiTinh
        FROM nhanvien
    END
    ELSE
    BEGIN
        INSERT INTO @TBL_NhanVien
            (TenNV,MaNV,GT)
        SELECT TenNV, MaNhanVien, GioiTinh
        FROM nhanvien
        WHERE GioiTinh = @gt
    END
    RETURN
END
GO

SELECT * FROM dbo.F_GetLstNV_ByGT(N'Nam')
/* Xóa/Sửa Nội Dung của một hàm chỉ cần dùng DROP/ALTER*/

/*
VIEW là gì:
❑Che dấu và bảo mật dữ liệu
❖Không cho phép người dùng xem toàn bộ dữ liệu
chứa trong các bảng.
❖Bằng cách chỉ định các cột trong View, các dữ liệu
quan trọng chứa trong một số cột của bảng có thể
được che dấu
❑Hiển thị dữ liệu một cách tùy biến
❖Với mỗi người dùng khác nhau, có thể tạo các View
khác nhau phù hợp với nhu cầu xem thông tin của
từng người dùng

❑Lưu trữ câu lệnh truy vấn phức tạp và thường
xuyên sử dụng.
❑Thực thi nhanh hơn các câu lệnh truy vấn do đã
được biên dịch sẵn
❑Đảm bảo tính toàn vẹn dữ liệu
❖Khi sử dụng View để cập nhật dữ liệu trong các bảng
cơ sở, SQL Server sẽ tự động kiểm tra các ràng buộc
toàn vẹn trên các bản

❑Tên view không được trùng với tên bảng hoặc
view đã tồn tại
❑Câu lệnh SELECT tạo VIEW
❖Không được chứa mệnh đề INTO, hoặc ORDER BY trừ
khi chứa từ khóa TOP
❑Đặt tên cột
❖Cột chứa giá trị được tính toán từ nhiều cột khác phải
được đặt tên
❖Nếu cột không được đặt tên, tên cột sẽ được mặc
định giống tên cột của bảng cơ sở
*/

GO
CREATE VIEW View_DSNVNu
AS
SELECT * FROM nhanvien WHERE GioiTinh = N'Nữ'

-- muốn xem view thì tiến select view như làm việc với bảng