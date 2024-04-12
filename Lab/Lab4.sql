CREATE DATABASE QLHV_22521270
USE QLHV_22521270
SET DATEFORMAT DMY 
--Phan I:
-- 1. Tao bang:
CREATE TABLE Khoa
(
	MAKhoa VARCHAR(4) PRIMARY KEY,
	TENKhoa VARCHAR(40),
	NGTLAP SMALLDATETIME,
	TRGKhoa CHAR(4)
)
GO
CREATE TABLE MonHoc
(
	MAMH VARCHAR(10) PRIMARY KEY,
	TENMH VARCHAR(40),
	TCLT TINYINT,
	TCTH TINYINT,
	MAKhoa VARCHAR(4) FOREIGN KEY REFERENCES Khoa(MAKhoa)
)
GO
CREATE TABLE DieuKien
(
	MAMH VARCHAR(10) FOREIGN KEY REFERENCES MonHoc(MAMH),
	MAMH_TRUOC VARCHAR(10) FOREIGN KEY REFERENCES MonHoc(MAMH),
	PRIMARY KEY (MAMH, MAMH_TRUOC)
)
GO
CREATE TABLE GiaoVien
(
	MAGV CHAR(4) PRIMARY KEY,
	HOTEN VARCHAR(40),
	HOCVI VARCHAR(10), 
	HOCHAM VARCHAR(10),
	GIOITINH VARCHAR(3),
	NGSINH SMALLDATETIME,
	NGVL SMALLDATETIME,
	HESO NUMERIC(4,2),
	MUCLUONG MONEY,
	MAKhoa VARCHAR(4)
)
GO
CREATE TABLE Lop
(
	MALop CHAR(3) PRIMARY KEY,
	TENLop VARCHAR(40),
	TRGLop CHAR(5),
	SISO TINYINT,
	MAGVCN CHAR(4)
)
GO
CREATE TABLE HocVien
(
	MAHV CHAR(5) PRIMARY KEY,
	HO VARCHAR(40),
	TEN VARCHAR(10),
	NGSINH SMALLDATETIME,
	GIOITINH VARCHAR(3),
	NOISINH VARCHAR(40),
	MALop CHAR(3)
)
GO
CREATE TABLE GiangDay
(
	MALop CHAR(3) FOREIGN KEY REFERENCES Lop(MALop),
	MAMH VARCHAR(10) FOREIGN KEY REFERENCES MonHoc(MAMH),
	MAGV CHAR(4) FOREIGN KEY REFERENCES GiaoVien(MAGV),
	HOCKY TINYINT,
	NAM SMALLINT,
	TUNGAY SMALLDATETIME, 
	DENNGAY SMALLDATETIME,
	PRIMARY KEY (MALop, MAMH)
)
GO
CREATE TABLE KetQuaThi
(
	MAHV CHAR(5) FOREIGN KEY REFERENCES HocVien(MAHV),
	MAMH VARCHAR(10) FOREIGN KEY REFERENCES MonHoc(MAMH),
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4,2),
	KQUA VARCHAR(10),
	PRIMARY KEY (MAHV, MAMH, LANTHI)
)

--Them Khoa ngoai:
ALTER TABLE GiaoVien
ADD CONSTRAINT FK_GiaoVien_Khoa
FOREIGN KEY (MAKhoa) REFERENCES Khoa(MAKhoa);
GO
ALTER TABLE Khoa
ADD CONSTRAINT FK_Khoa_GiaoVien
FOREIGN KEY (TRGKhoa) REFERENCES GiaoVien(MAGV);
GO
ALTER TABLE Lop
ADD CONSTRAINT FK_Lop_HocVien
FOREIGN KEY (TRGLop) REFERENCES HocVien(MAHV);
GO
ALTER TABLE Lop
ADD CONSTRAINT FK_Lop_GiaoVien 
FOREIGN KEY (MAGVCN) REFERENCES GiaoVien(MAGV);
GO
ALTER TABLE HocVien
ADD CONSTRAINT FK_HocVien_Lop
FOREIGN KEY (MALop) REFERENCES Lop(MALop);

--Them thuoc tinh cho HocVien:
ALTER TABLE HocVien
ADD GHICHU VARCHAR(100), DIEMTB FLOAT, XEPLOAI VARCHAR(10);

--Insert du lieu:
ALTER TABLE Lop NOCHECK CONSTRAINT FK_Lop_HocVien;
ALTER TABLE HocVien NOCHECK CONSTRAINT FK_HocVien_Lop;
ALTER TABLE Khoa NOCHECK CONSTRAINT FK_Khoa_GiaoVien;
ALTER TABLE GiaoVien NOCHECK CONSTRAINT FK_GiaoVien_Khoa;

INSERT INTO Khoa VALUES('KHMT', 'Khoa hoc may tinh', '7/6/2005', 'GV01')
INSERT INTO Khoa VALUES('HTTT', 'He thong thong tin', '7/6/2005', 'GV02')
INSERT INTO Khoa VALUES('CNPM', 'Cong nghe phan mem', '7/6/2005', 'GV04')
INSERT INTO Khoa VALUES('MTT', 'Mang va truyen thong', '20/10/2005', 'GV03')
INSERT INTO Khoa VALUES('KTMT', 'Ky thuat may tinh', '20/12/2005', 'Null')

INSERT INTO MonHoc VALUES('THDC', 'Tin hoc dai cuong', '4', '1', 'KHMT')
INSERT INTO MonHoc VALUES('CTRR', 'Cau truc roi rac', '5', '0', 'KHMT')
INSERT INTO MonHoc VALUES('CSDL', 'Co so du lieu', '3', '1', 'HTTT')
INSERT INTO MonHoc VALUES('CTDLGT', 'Cau truc du lieu va giai thuat', '3', '1', 'KHMT')
INSERT INTO MonHoc VALUES('PTTKTT', 'Phan tich thiet ke thuat toan', '3', '0', 'KHMT')
INSERT INTO MonHoc VALUES('DHMT', 'Do hoa may tinh', '3', '1', 'KHMT')
INSERT INTO MonHoc VALUES('KTMT', 'Kien truc may tinh', '3', '0', 'KTMT')
INSERT INTO MonHoc VALUES('TKCSDL', 'Thiet ke co so du lieu', '3', '1', 'HTTT')
INSERT INTO MonHoc VALUES('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', '4', '1', 'HTTT')
INSERT INTO MonHoc VALUES('HDH', 'He dieu hanh', '4', '0', 'KTMT')
INSERT INTO MonHoc VALUES('NMCNPM', 'Nhap mon cong nghe phan mem', '3', '0', 'CNPM')
INSERT INTO MonHoc VALUES('LTCFW', 'Lap trinh C for win', '3', '1', 'CNPM')
INSERT INTO MonHoc VALUES('LTHDT', 'Lap trinh huong doi tuong', '3', '1', 'CNPM')

INSERT INTO DieuKien VALUES('CSDL', 'CTRR')
INSERT INTO DieuKien VALUES('CSDL', 'CTDLGT')
INSERT INTO DieuKien VALUES('CTDLGT', 'THDC')
INSERT INTO DieuKien VALUES('PTTKTT', 'THDC')
INSERT INTO DieuKien VALUES('PTTKTT', 'CTDLGT')
INSERT INTO DieuKien VALUES('DHMT', 'THDC')
INSERT INTO DieuKien VALUES('LTHDT', 'THDC')
INSERT INTO DieuKien VALUES('PTTKHTTT', 'CSDL')

INSERT INTO GiaoVien VALUES('GV01', 'Ho Thanh Son', 'PTS', 'GS', 'Nam', '02/05/1950', '11/01/2004', '5', '2250000', 'KHMT')
INSERT INTO GiaoVien VALUES('GV02', 'Tran Tam Thanh', 'TS', 'PGS', 'Nam', '17/12/1965', '20/04/2004', '4.5', '2025000', 'HTTT')
INSERT INTO GiaoVien VALUES('GV03', 'Do Nghiem Phung', 'TS', 'GS', 'Nu', '01/08/1950', '23/09/2004', '4', '1800000', 'CNPM')
INSERT INTO GiaoVien VALUES('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '22/02/1961', '12/01/2005', '4.5', '2025000', 'KTMT')
INSERT INTO GiaoVien VALUES('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '12/03/1958', '12/01/2005', '3', '1350000', 'HTTT')
INSERT INTO GiaoVien VALUES('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '11/03/1953', '12/01/2005', '4.5', '2025000', 'KHMT')
INSERT INTO GiaoVien VALUES('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '23/11/1971', '01/03/2005', '4', '1800000', 'KHMT')
INSERT INTO GiaoVien VALUES('GV08', 'Le Thi Tran', 'KS', 'Null', 'Nu', '26/03/1974', '01/03/2005', '1.69', '760500', 'KHMT')
INSERT INTO GiaoVien VALUES('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '31/12/1966', '01/03/2005', '4', '1800000', 'HTTT')
INSERT INTO GiaoVien VALUES('GV10', 'Le Tran Anh Loan', 'KS', 'Null', 'Nu', '17/07/1972', '01/03/2005', '1.86', '837000', 'CNPM')
INSERT INTO GiaoVien VALUES('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '12/01/1980', '15/05/2005', '2.67', '1201500', 'MTT')
INSERT INTO GiaoVien VALUES('GV12', 'Tran Van Anh', 'CN', 'Null', 'Nu', '29/03/1981', '15/05/2005', '1.69', '760500', 'CNPM')
INSERT INTO GiaoVien VALUES('GV13', 'Nguyen Linh Dan', 'CN', 'Null', 'Nu', '23/05/1980', '15/05/2005', '1.69', '760500', 'KTMT')
INSERT INTO GiaoVien VALUES('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '30/11/1976', '15/05/2005', '3', '1350000', 'MTT')
INSERT INTO GiaoVien VALUES('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '04/05/1978', '15/05/2005', '3', '1350000', 'KHMT')

INSERT INTO Lop VALUES('K11', 'Lop 1 Khoa 1','K1108','11','GV07')
INSERT INTO Lop VALUES('K12', 'Lop 2 Khoa 1','K1205','12','GV09')
INSERT INTO Lop VALUES('K13', 'Lop 3 Khoa 1','K1305','12','GV14')

INSERT INTO HocVien(MAHV, HO, TEN, NGSINH, GIOITINH, NOISINH, MALop)
VALUES
	('K1101', 'Nguyen Van', 'A', '27/01/1986', 'Nam', 'TpHCM', 'K11'),
	('K1102', 'Tran Ngoc', 'Han', '14/03/1986', 'Nu', 'Kien Giang', 'K11'),
	('K1103', 'Ha Duy', 'Lap', '18/04/1986', 'Nam', 'Nghe An', 'K11'),
	('K1104', 'Tran Ngoc', 'Linh', '30/03/1986', 'Nu', 'Tay Ninh', 'K11'),
	('K1105', 'Tran Minh', 'Long', '27/02/1986', 'Nam', 'TpHCM', 'K11'),
	('K1106', 'Le Nhat', 'Minh', '24/01/1986', 'Nam', 'TpHCM', 'K11'),
	('K1107', 'Nguyen Nhu', 'Nhut', '27/01/1986', 'Nam', 'Ha Noi', 'K11'),
	('K1108', 'Nguyen Manh', 'Tam', '27/02/1986', 'Nam', 'Kien Giang', 'K11'),
	('K1109', 'Phan Thi Thanh', 'Tam', '27/01/1986', 'Nu', 'Vinh Long', 'K11'),
	('K1110', 'Le Hoai', 'Thuong', '05/02/1986', 'Nu', 'Can Tho', 'K11'),
	('K1111', 'Le Ha', 'Vinh', '25/12/1986', 'Nam', 'Vinh Long', 'K11'),
	('K1201', 'Nguyen Van', 'B', '11/02/1986', 'Nam', 'TpHCM', 'K12'),
	('K1202', 'Nguyen Thi Kim', 'Duyen', '18/01/1986', 'Nu', 'TpHCM', 'K12'),
	('K1203', 'Tran Thi Kim', 'Duyen', '17/09/1986', 'Nu', 'TpHCM', 'K12'),
	('K1204', 'Truong My', 'Hanh', '19/05/1986', 'Nu', 'Dong Nai', 'K12'),
	('K1205', 'Nguyen Thanh', 'Nam', '17/04/1986', 'Nam', 'TpHCM', 'K12'),
	('K1206', 'Nguyen Thi Truc', 'Thanh', '04/03/1986', 'Nu', 'Kien Giang', 'K12'),
	('K1207', 'Tran Thi Bich', 'Thuy', '08/02/1986', 'Nu', 'Nghe An', 'K12'),
	('K1208', 'Huynh Thi Kim', 'Trieu', '08/04/1986', 'Nu', 'Tay Ninh', 'K12'),
	('K1209', 'Pham Thanh', 'Trieu', '23/02/1986', 'Nam', 'TpHCM', 'K12'),
	('K1210', 'Ngo Thanh', 'Tuan', '14/02/1986', 'Nam', 'TpHCM', 'K12'),
	('K1211', 'Do Thi', 'Xuan', '09/03/1986', 'Nu', 'Ha Noi', 'K12'),
	('K1212', 'Le Thi Phi', 'Yen', '12/03/1986', 'Nu', 'TpHCM', 'K12'),
	('K1301', 'Nguyen Thi Kim', 'Cuc', '09/06/1986', 'Nu', 'Kien Giang', 'K13'),
	('K1302', 'Truong Thi My', 'Hien', '18/03/1986', 'Nu', 'Nghe An', 'K13'),
	('K1303', 'Le Duc', 'Hien', '21/03/1986', 'Nam', 'Tay Ninh', 'K13'),
	('K1304', 'Le Quang', 'Hien', '18/04/1986', 'Nam', 'TpHCM', 'K13'),
	('K1305', 'Le Thi', 'Huong', '27/03/1986', 'Nu', 'TpHCM', 'K13'),
	('K1306', 'Nguyen Thai', 'Huu', '30/03/1986', 'Nam', 'Ha Noi', 'K13'),
	('K1307', 'Tran Minh', 'Man', '28/05/1986', 'Nam', 'TpHCM', 'K13'),
	('K1308', 'Nguyen Hieu', 'Nghia', '08/04/1986', 'Nam', 'Kien Giang', 'K13'),
	('K1309', 'Nguyen Trung', 'Nghia', '18/01/1987', 'Nam', 'Nghe An', 'K13'),
	('K1310', 'Tran Thi Hong', 'Tham', '22/04/1986', 'Nu', 'Tay Ninh', 'K13'),
	('K1311', 'Tran Minh', 'Thuc', '04/04/1986', 'Nam', 'TpHCM', 'K13'),
	('K1312', 'Nguyen Thi Kim', 'Yen', '07/09/1986', 'Nu', 'TpHCM', 'K13')

INSERT INTO GiangDay VALUES('K11','THDC','GV07','1','2006','2/1/2006','12/5/2006')
INSERT INTO GiangDay VALUES('K12','THDC','GV06','1','2006','2/1/2006','12/5/2006')
INSERT INTO GiangDay VALUES('K13','THDC','GV15','1','2006','2/1/2006','12/5/2006')
INSERT INTO GiangDay VALUES('K11','CTRR','GV02','1','2006','9/1/2006','17/5/2006')
INSERT INTO GiangDay VALUES('K12','CTRR','GV02','1','2006','9/1/2006','17/5/2006')
INSERT INTO GiangDay VALUES('K13','CTRR','GV08','1','2006','9/1/2006','17/5/2006')
INSERT INTO GiangDay VALUES('K11','CSDL','GV05','2','2006','1/6/2006','15/7/2006')
INSERT INTO GiangDay VALUES('K12','CSDL','GV09','2','2006','1/6/2006','15/7/2006')
INSERT INTO GiangDay VALUES('K13','CTDLGT','GV15','2','2006','1/6/2006','15/7/2006')
INSERT INTO GiangDay VALUES('K13','CSDL','GV05','3','2006','1/8/2006','15/12/2006')
INSERT INTO GiangDay VALUES('K13','DHMT','GV07','3','2006','1/8/2006','15/12/2006')
INSERT INTO GiangDay VALUES('K11','CTDLGT','GV15','3','2006','1/8/2006','15/12/2006')
INSERT INTO GiangDay VALUES('K12','CTDLGT','GV15','3','2006','1/8/2006','15/12/2006')
INSERT INTO GiangDay VALUES('K11','HDH','GV04','1','2007','2/1/2007','18/2/2007')
INSERT INTO GiangDay VALUES('K12','HDH','GV04','1','2007','2/1/2007','20/3/2007')
INSERT INTO GiangDay VALUES('K11','DHMT','GV07','1','2007','18/2/2007','20/3/2007')

INSERT INTO KetQuaThi VALUES('K1101','CSDL','1','20/07/2006','10','Dat')
INSERT INTO KetQuaThi VALUES('K1101','CTDLGT','1','28/12/2006','9','Dat')
INSERT INTO KetQuaThi VALUES('K1101','THDC','1','20/05/2006','9','Dat')
INSERT INTO KetQuaThi VALUES('K1101','CTRR','1','13/05/2006','9.5','Dat')
INSERT INTO KetQuaThi VALUES('K1102','CSDL','1','20/07/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1102','CSDL','2','20/07/2006','4.25','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1102','CSDL','3','10/08/2006','4.5','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1102','CTDLGT','1','28/12/2006','4.5','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1102','CTDLGT','2','05/01/2007','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1102','CTDLGT','3','15/01/2007','6','Dat')
INSERT INTO KetQuaThi VALUES('K1102','THDC','1','20/05/2006','5','Dat')
INSERT INTO KetQuaThi VALUES('K1102','CTRR','1','13/05/2006','7','Dat')
INSERT INTO KetQuaThi VALUES('K1103','CSDL','1','20/07/2006','3.5','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1103','CSDL','2','27/07/2006','8.25','Dat')
INSERT INTO KetQuaThi VALUES('K1103','CTDLGT','1','28/12/2006','7','Dat')
INSERT INTO KetQuaThi VALUES('K1103','THDC','1','20/05/2006','8','Dat')
INSERT INTO KetQuaThi VALUES('K1103','CTRR','1','13/05/2006','6.5','Dat')
INSERT INTO KetQuaThi VALUES('K1104','CSDL','1','20/07/2006','3.75','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1104','CTDLGT','1','28/12/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1104','THDC','1','20/05/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1104','CTRR','1','13/05/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1104','CTRR','2','20/05/2006','3.5','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1104','CTRR','3','30/06/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1201','CSDL','1','20/07/2006','6','Dat')
INSERT INTO KetQuaThi VALUES('K1201','CTDLGT','1','28/12/2006','5','Dat')
INSERT INTO KetQuaThi VALUES('K1201','THDC','1','20/05/2006','8.5','Dat')
INSERT INTO KetQuaThi VALUES('K1201','CTRR','1','13/05/2006','9','Dat')
INSERT INTO KetQuaThi VALUES('K1202','CSDL','1','20/07/2006','8','Dat')
INSERT INTO KetQuaThi VALUES('K1202','CTDLGT','1','28/12/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1202','CTDLGT','2','05/01/2007','5','Dat')
INSERT INTO KetQuaThi VALUES('K1202','THDC','1','20/05/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1202','THDC','2','27/05/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1202','CTRR','1','13/05/2006','3','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1202','CTRR','2','20/05/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1202','CTRR','3','30/06/2006','6.25','Dat')
INSERT INTO KetQuaThi VALUES('K1203','CSDL','1','20/07/2006','9.25','Dat')
INSERT INTO KetQuaThi VALUES('K1203','CTDLGT','1','28/12/2006','9.5','Dat')
INSERT INTO KetQuaThi VALUES('K1203','THDC','1','20/05/2006','10','Dat')
INSERT INTO KetQuaThi VALUES('K1203','CTRR','1','13/05/2006','10','Dat')
INSERT INTO KetQuaThi VALUES('K1204','CSDL','1','20/07/2006','8.5','Dat')
INSERT INTO KetQuaThi VALUES('K1204','CTDLGT','1','28/12/2006','6.75','Dat')
INSERT INTO KetQuaThi VALUES('K1204','THDC','1','20/05/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1204','CTRR','1','13/05/2006','6','Dat')
INSERT INTO KetQuaThi VALUES('K1301','CSDL','1','20/12/2006','4.25','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1301','CTDLGT','1','25/07/2006','8','Dat')
INSERT INTO KetQuaThi VALUES('K1301','THDC','1','20/05/2006','7.75','Dat')
INSERT INTO KetQuaThi VALUES('K1301','CTRR','1','13/05/2006','8','Dat')
INSERT INTO KetQuaThi VALUES('K1302','CSDL','1','20/12/2006','6.75','Dat')
INSERT INTO KetQuaThi VALUES('K1302','CTDLGT','1','25/07/2006','5','Dat')
INSERT INTO KetQuaThi VALUES('K1302','THDC','1','20/05/2006','8','Dat')
INSERT INTO KetQuaThi VALUES('K1302','CTRR','1','13/05/2006','8.5','Dat')
INSERT INTO KetQuaThi VALUES('K1303','CSDL','1','20/12/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1303','CTDLGT','1','25/07/2006','4.5','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1303','CTDLGT','2','07/08/2006','4','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1303','CTDLGT','3','15/08/2006','4.25','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1303','THDC','1','20/05/2006','4.5','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1303','CTRR','1','13/05/2006','3.25','Khong Dat')
INSERT INTO KetQuaThi VALUES('K1303','CTRR','2','20/05/2006','5','Dat')
INSERT INTO KetQuaThi VALUES('K1304','CSDL','1','20/12/2006','7.75','Dat')
INSERT INTO KetQuaThi VALUES('K1304','CTDLGT','1','25/07/2006','9.75','Dat')
INSERT INTO KetQuaThi VALUES('K1304','THDC','1','20/05/2006','5.5','Dat')
INSERT INTO KetQuaThi VALUES('K1304','CTRR','1','13/05/2006','5','Dat')
INSERT INTO KetQuaThi VALUES('K1305','CSDL','1','20/12/2006','9.25','Dat')
INSERT INTO KetQuaThi VALUES('K1305','CTDLGT','1','25/07/2006','10','Dat')
INSERT INTO KetQuaThi VALUES('K1305','THDC','1','20/05/2006','8','Dat')
INSERT INTO KetQuaThi VALUES('K1305','CTRR','1','13/05/2006','10','Dat')

ALTER TABLE Lop CHECK CONSTRAINT FK_Lop_HocVien;
ALTER TABLE HocVien CHECK CONSTRAINT FK_HocVien_Lop;
ALTER TABLE Khoa CHECK CONSTRAINT FK_Khoa_GiaoVien;
ALTER TABLE GiaoVien CHECK CONSTRAINT FK_GiaoVien_Khoa;

--2: Mã h?c viên là m?t chu?i 5 ký t?, 3 ký t? ??u là mã l?p, 2 ký t? cu?i cùng là s? th? t? h?c viên trong l?p
CREATE TRIGGER CHECK_MAHV
ON HocVien
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @Result BIT = 0;
    DECLARE @STT VARCHAR(2);
    DECLARE @TempTable TABLE (MAHV VARCHAR(5), RowNum INT);
	DECLARE @MAHV VARCHAR(5);
    DECLARE @MALop VARCHAR(3);

    INSERT INTO @TempTable (MAHV, RowNum)
    SELECT MAHV, ROW_NUMBER() OVER (ORDER BY MAHV)
    FROM HocVien;

    SELECT @STT = CASE
                    WHEN RowNum < 10
                    THEN '0' + CAST(RowNum AS VARCHAR(2))
                    ELSE CAST(RowNum AS VARCHAR(2))
                  END
    FROM @TempTable
    WHERE MAHV = @MAHV;

    IF SUBSTRING(@MAHV, 1, 3) = LEFT(@MALop, 3) AND SUBSTRING(@MAHV, 4, 2) = @STT
    BEGIN
        SET @Result = 1;
    END

    SELECT @MAHV = MAHV, @MALop = MALop FROM INSERTED;

    IF NOT EXISTS 
	(
        SELECT *
        FROM HocVien
        WHERE @Result = 1
    )
    BEGIN
        RAISERROR('Mã h?c viên là m?t chu?i 5 ký t?, 3 ký t? ??u là mã l?p, 2 ký t? cu?i cùng là s? th? t? h?c viên trong l?p', 16, 1);
        ROLLBACK;
    END
END;

-- 3. Thu?c tính GIOITINH ch? có giá tr? là “Nam” ho?c “Nu”.
ALTER TABLE HocVien
ADD CONSTRAINT CHECK_GIOITINH_HV
CHECK (GIOITINH IN ('Nam', 'Nu'));

ALTER TABLE GiaoVien
ADD CONSTRAINT CHECK_GIOITINH_GV
CHECK (GIOITINH IN ('Nam', 'Nu'));

-- 4. ?i?m s? c?a m?t l?n thi có giá tr? t? 0 ??n 10 và c?n l?u ??n 2 s? l?.
ALTER TABLE KetQuaThi
ADD CONSTRAINT CHECK_DIEM_KQT
CHECK (DIEM >= 0 AND DIEM <= 10);

ALTER TABLE KetQuaThi
ALTER COLUMN DIEM NUMERIC(4, 2);

-- 5. K?t qu? thi là “Dat” n?u ?i?m t? 5 ??n 10 và “Khong dat” n?u ?i?m nh? h?n 5.
CREATE TRIGGER Check_KQTHI
ON KetQuaThi
FOR INSERT, UPDATE
AS
BEGIN
    UPDATE KetQuaThi
    SET KQUA = CASE
        WHEN KetQuaThi.DIEM >= 5 AND KetQuaThi.DIEM <= 10 THEN 'Dat'
        ELSE 'Khong dat'
    END
    FROM inserted
    WHERE KetQuaThi.MAHV = inserted.MAHV
      AND KetQuaThi.MAMH = inserted.MAMH
      AND KetQuaThi.LANTHI = inserted.LANTHI
      AND KetQuaThi.NGTHI = inserted.NGTHI;
END;

-- 6. H?c viên thi m?t môn t?i ?a 3 l?n.
CREATE TRIGGER Check_SoLuongThi
ON KetQuaThi
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM INSERTED
        WHERE LANTHI > 3
    )
    BEGIN
        RAISERROR('H?c viên ch? thi môn này t?i ?a 3 l?n.', 16, 1);
		ROLLBACK;
    END
END;

-- 7. H?c k? ch? có giá tr? t? 1 ??n 3.
ALTER TABLE GiangDay
ADD CONSTRAINT CHECK_HOCKY
CHECK (HOCKY BETWEEN 1 AND 3);

-- 8. H?c v? c?a giáo viên ch? có th? là “CN”, “KS”, “Ths”, ”TS”, ”PTS”.
ALTER TABLE GiaoVien
ADD CONSTRAINT CHECK_HOCVI
CHECK (HOCVI IN ('CN', 'KS', 'Ths', 'TS', 'PTS'));

-- 9. L?p tr??ng c?a m?t l?p ph?i là h?c viên c?a l?p ?ó.
CREATE TRIGGER CHECK_LopTRG
ON Lop
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @IsValidTrgLop BIT;

    SELECT @IsValidTrgLop = CASE
        WHEN TRGLop IS NULL THEN 1
        WHEN TRGLop NOT IN (SELECT MAHV FROM HocVien WHERE MALop = INSERTED.MALop) THEN 0
        ELSE 1
    END
    FROM INSERTED;

    IF @IsValidTrgLop = 0
    BEGIN
        RAISERROR('L?p tr??ng ph?i là h?c viên c?a l?p ?ó.', 16, 1);
        ROLLBACK;
    END
END;


-- 10. Tr??ng Khoa ph?i là giáo viên thu?c Khoa và có h?c v? “TS” ho?c “PTS”.
CREATE TRIGGER CHECK_TRGKhoa
ON Khoa
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    DECLARE @IsValidTrgKhoa BIT;

    SELECT @IsValidTrgKhoa = CASE
        WHEN EXISTS (
            SELECT 1
            FROM INSERTED AS i
            WHERE i.MAKhoa = Khoa.MAKhoa
                AND EXISTS (
                    SELECT 1
                    FROM GiaoVien AS gv
                    WHERE gv.MAGV = i.TRGKhoa
                        AND gv.MAKhoa = i.MAKhoa
                        AND gv.HOCVI IN ('TS', 'PTS')
                )
        ) THEN 1
        ELSE 0
    END
    FROM Khoa, INSERTED;

    IF @IsValidTrgKhoa = 0
    BEGIN
        RAISERROR('Tr??ng Khoa ph?i là giáo viên thu?c Khoa và có h?c v? TS ho?c PTS.', 16, 1);
        ROLLBACK;
    END
END;

-- 11. H?c viên ít nh?t là 18 tu?i.
ALTER TABLE HocVien
ADD CONSTRAINT CHECK_TUOI
CHECK (DATEDIFF(YEAR, NGSINH, GETDATE()) >= 18);

-- 12. Gi?ng d?y m?t môn h?c ngày b?t ??u (TUNGAY) ph?i nh? h?n ngày k?t thúc (DENNGAY)
ALTER TABLE GiangDay
ADD CONSTRAINT CHECK_NGAY_DAY_HOC
CHECK (TUNGAY < DENNGAY)


-- 13. Giáo viên khi vào làm ít nh?t là 22 tu?i.
ALTER TABLE GiaoVien
ADD CONSTRAINT CHECK_TUOI_GV
CHECK (DATEDIFF(YEAR, NGSINH, GETDATE()) >= 22)

-- 14. T?t c? các môn h?c ??u có s? tín ch? lý thuy?t và tín ch? th?c hành chênh l?ch nhau không quá 3.
UPDATE MonHoc
SET TCLT = 3, TCTH = 0
WHERE ABS(TCLT - TCTH) > 3;

ALTER TABLE MonHoc
ADD CONSTRAINT CHECK_TINCHI
CHECK (ABS(TCLT - TCTH) <=3)


-- 15. H?c viên ch? ???c thi m?t môn h?c nào ?ó khi l?p c?a h?c viên ?ã h?c xong môn h?c này.
CREATE TRIGGER tr_ChecKKetQuaThi
ON HocVien
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @ThiHocKy BIT;

    SELECT @ThiHocKy = CASE
        WHEN EXISTS 
		(
            SELECT *
            FROM INSERTED AS I
			JOIN Lop ON I.MALop = Lop.MALop
            JOIN GiangDay AS GD ON Lop.MALop = GD.MALop
            WHERE GD.DENNGAY <= GETDATE()
        ) 
		THEN 1
        ELSE 0
    END
    FROM INSERTED;

    IF @ThiHocKy = 0
    BEGIN
        RAISERROR('H?c viên ch? ???c thi môn h?c khi l?p ?ã h?c xong môn này.', 16, 1);
        ROLLBACK;
    END
END;


-- 16. M?i h?c k? c?a m?t n?m h?c, m?t l?p ch? ???c h?c t?i ?a 3 môn.
CREATE TRIGGER CheckTrgGiangDay
ON GiangDay
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @IsValidGiangDay BIT;

    SELECT @IsValidGiangDay = CASE
        WHEN EXISTS 
		(
            SELECT 1
            FROM INSERTED AS I
            JOIN 
			(
                SELECT MALop, HOCKY, NAM, COUNT(*) AS SoLuongMonHoc
                FROM GiangDay
                GROUP BY MALop, HOCKY, NAM
            ) AS GD ON I.MALop = GD.MALop
            WHERE GD.SoLuongMonHoc > 3
        ) THEN 0
        ELSE 1
    END
    FROM INSERTED;

    IF @IsValidGiangDay = 0
    BEGIN
        RAISERROR('M?i l?p ch? ???c h?c t?i ?a 3 môn trong m?t h?c k?.', 16, 1);
        ROLLBACK;
    END
END


-- 17. S? s? c?a m?t l?p b?ng v?i s? l??ng h?c viên thu?c l?p ?ó.
CREATE TRIGGER tr_ChecSiSo
ON HocVien
FOR INSERT, UPDATE
AS
BEGIN
	DECLARE @MAHV VARCHAR(5), @MALop VARCHAR(3)
	SELECT @MAHV = IST.MAHV, @MALop = IST.MALop
	FROM INSERTED IST

	UPDATE Lop
    SET SISO = 
	(
		SELECT COUNT(*)
        FROM HocVien
        JOIN Lop ON HocVien.MALop = Lop.MALop
		WHERE Lop.MALop = @MALop
	)
	WHERE Lop.MALop = @MALop
	PRINT('DA THAY DOI SI SO Lop')
END

CREATE TRIGGER tr_ChecSiSo_DELETE
ON HocVien
FOR DELETE
AS
BEGIN
	DECLARE @MAHV VARCHAR(5), @MALop VARCHAR(3)
	SELECT @MAHV = DLTED.MAHV, @MALop = DLTED.MALop
	FROM deleted DLTED

	UPDATE Lop
    SET SISO = 
	(
		SELECT COUNT(*)
        FROM HocVien
        JOIN Lop ON HocVien.MALop = Lop.MALop
		WHERE Lop.MALop = @MALop
	)
	WHERE Lop.MALop = @MALop

	PRINT('DA THAY DOI SI SO Lop')
END


-- 18. Trong quan h? DieuKien giá tr? c?a thu?c tính MAMH và MAMH_TRUOC trong cùng m?t b? 
-- không ???c gi?ng nhau (“A”,”A”) và c?ng không t?n t?i hai b? (“A”,”B”) và (“B”,”A”).
ALTER TABLE DieuKien
ADD CONSTRAINT UQ_MAMH_MAMH_TRUOC UNIQUE (MAMH, MAMH_TRUOC);

ALTER TABLE DieuKien
ADD CONSTRAINT CK_MAMH_MAMH_TRUOC_DIFF
CHECK (MAMH <> MAMH_TRUOC);


-- 19. Các giáo viên có cùng h?c v?, h?c hàm, h? s? l??ng thì m?c l??ng b?ng nhau.
CREATE TRIGGER tr_LuongGiaoVien
ON GiaoVien
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS 
	(
        SELECT *
        FROM INSERTED I
        JOIN GiaoVien GV ON I.HOCVI = GV.HOCVI
                           AND I.HOCHAM = GV.HOCHAM
                           AND I.HESO = GV.HESO
                           AND ISNULL(I.MUCLUONG, 0) <> ISNULL(GV.MUCLUONG, 0)
    )
    BEGIN
        RAISERROR('M?c l??ng c?a giáo viên cùng h?c v?, h?c hàm, và h? s? l??ng ph?i b?ng nhau.', 16, 1);
        ROLLBACK;
    END
END;


-- 20. H?c viên ch? ???c thi l?i (l?n thi >1) khi ?i?m c?a l?n thi tr??c ?ó d??i 5.
CREATE TRIGGER tr_LanThi
ON KetQuaThi
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS 
	(
       SELECT *
       FROM INSERTED I
       JOIN KetQuaThi KQ ON I.MAHV = KQ.MAHV AND I.MAMH = KQ.MAMH AND I.LANTHI = KQ.LANTHI - 1
	   WHERE KQ.DIEM >= 5
    )
    BEGIN
        RAISERROR('H?c viên ch? ???c thi l?i khi ?i?m c?a l?n thi tr??c ?ó d??i 5.', 16, 1);
        ROLLBACK;
    END
END


-- 21. Ngày thi c?a l?n thi sau ph?i l?n h?n ngày thi c?a l?n thi tr??c (cùng h?c viên, cùng môn h?c).
CREATE TRIGGER CheckNgayThi
ON KetQuaThi
FOR INSERT, UPDATE
AS
BEGIN
    IF EXISTS 
	(
        SELECT *
        FROM INSERTED I
        JOIN KetQuaThi KQ ON I.MAHV =KQ.MAHV
                           AND I.MAMH = KQ.MAMH
                           AND I.LANTHI = KQ.LANTHI - 1
                           AND I.NGTHI <= KQ.NGTHI
    )
    BEGIN
        RAISERROR('Ngày thi c?a l?n thi sau ph?i l?n h?n ngày thi c?a l?n thi tr??c.', 16, 1);
        ROLLBACK;
    END
END;

-- 22. H?c viên ch? ???c thi nh?ng môn mà l?p c?a h?c viên ?ó ?ã h?c xong.
CREATE TRIGGER tr_ChecKKetQuaThi
ON HocVien
FOR INSERT, UPDATE
AS
BEGIN
    DECLARE @ThiHocKy BIT;

    SELECT @ThiHocKy = CASE
        WHEN EXISTS 
		(
            SELECT *
            FROM INSERTED AS I
			JOIN Lop ON I.MALop = Lop.MALop
            JOIN GiangDay AS GD ON Lop.MALop = GD.MALop
            WHERE GD.DENNGAY <= GETDATE()
        ) 
		THEN 1
        ELSE 0
    END
    FROM INSERTED;

    IF @ThiHocKy = 0
    BEGIN
        RAISERROR('H?c viên ch? ???c thi môn h?c khi l?p ?ã h?c xong môn này.', 16, 1);
        ROLLBACK;
    END
END;

-- 24. Giáo viên ch? ???c phân công d?y nh?ng môn thu?c Khoa giáo viên ?ó ph? trách.
CREATE TRIGGER CheckKhoaGV
ON GiangDay
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS 
	(
        SELECT *
        FROM INSERTED I
        JOIN GiaoVien GV ON I.MAGV = GV.MAGV
        JOIN MonHoc MH ON I.MAMH = MH.MAMH
        WHERE GV.MAKhoa <> MH.MAKhoa
    )
    BEGIN
        RAISERROR('Giáo viên ch? ???c phân công d?y nh?ng môn thu?c Khoa giáo viên ?ó ph? trách.', 16, 1);
        ROLLBACK;
    END
END
