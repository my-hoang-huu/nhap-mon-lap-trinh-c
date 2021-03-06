﻿Z--BAI TAP 1
--USE MASTER
SET DATEFORMAT DMY
create database QuanLyBanHang
go
use QuanLyBanHang
go
--I. Ngon ngu dinh nghia du lieu
--1. Tạo các quan hệ và khai báo các khóa chính, khóa ngoại của quan hệ.
create table KHACHHANG
(
MAKH char(4) not null,
HOTEN varchar(40),
DCHI varchar(50),
SODT varchar(20),
NGSINH smalldatetime,
NGDK smalldatetime,
DOANHSO money
)
go
alter table KHACHHANG
add constraint PK_KHACHHANG
primary key (MAKH)
go
create table NHANVIEN 
(
MANV char(4) primary key,
HOTEN varchar(40),
SODT varchar(20),
NGVL smalldatetime
)
create table SANPHAM
(
MASP char(4) primary key,
TENSP varchar(40),
DVT varchar(20),
NUOCSX varchar(40),
GIA money
)
create table HOADON 
(
SOHD int primary key,
NGHD smalldatetime,
MAKH char(4),
MANV char(4),
TRIGIA money
)
create table CTHD
(
SOHD int foreign key references HOADON(SOHD),
MASP char(4) foreign key references SANPHAM(MASP),
SL int, 
constraint PK_CTHD primary key (SOHD, MASP)
)
-- Khoa ngoai cho bang hoa don
ALTER TABLE HOADON ADD CONSTRAINT fk01_HD FOREIGN KEY(MAKH) REFERENCES KHACHHANG(MAKH) 
ALTER TABLE HOADON ADD CONSTRAINT fk02_HD FOREIGN KEY(MANV) REFERENCES NHANVIEN(MANV) 

----------------
-- 2.	Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM.

ALTER TABLE SANPHAM ADD GHICHU VARCHAR(20)

--3.	Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.

ALTER TABLE KHACHHANG ADD LOAIKH TINYINT

--4.	Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100).

ALTER TABLE SANPHAM ALTER COLUMN GHICHU VARCHAR(100)

--5.	Xóa thuộc tính GHICHU trong quan hệ SANPHAM.

ALTER TABLE SANPHAM DROP COLUMN GHICHU 

--6.	Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: “Vang lai”, “Thuong xuyen”, “Vip”, …

ALTER TABLE KHACHHANG ALTER COLUMN LOAIKH VARCHAR(40)

--7.	Đơn vị tính của sản phẩm chỉ có thể là (“cay”,”hop”,”cai”,”quyen”,”chuc”)
ALTER TABLE SANPHAM ADD CONSTRAINT CK_DVT CHECK (DVT IN('cay','hop','cai','quyen','chuc'))
-- Cach 2:
--ALTER TABLE SANPHAM ADD CONSTRAINT CK_DVT CHECK (DVT = 'cay' or DVT = 'hop' or DVT ='cai' or DVT ='quyen' or DVT ='chuc')

--8.	Giá bán của sản phẩm từ 500 đồng trở lên.

ALTER TABLE SANPHAM ADD CONSTRAINT CK_GIA CHECK (GIA >= 500)

--9.	Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
ALTER TABLE CTHD ADD CONSTRAINT CT_SOLUONG CHECK (SL>=1)
--ALTER TABLE CTHD
--ADD CONSTRAINT CK_MASP
--CHECK MASP 
--10.	Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó.
ALTER TABLE KHACHHANG ADD CONSTRAINT CK_KHACHHANG CHECK(NGDK>NGSINH)
--11.	Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).
--12.	Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.

--13.	Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn.

--14.	Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.

--15.	Doanh số của một khách hàng là tổng trị giá các hóa đơn mà khách hàng thành viên đó đã mua.
-- Buoi 2: nhap du lieu
-- II.Ngôn ngữ thao tác dữ liệu (Data Manipulation Language):
--1.	Nhập dữ liệu cho các quan hệ trên.
--KHACHHHANG
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH01','Nguyen Van A','731 Tran Hung Dao, Q5, TPHCM','08823451','22/10/1960','22/07/2006','13060000')
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH02','Tran Ngoc Han','23/5 Nguyen Trai, Q5, TPHCM','0908256478','3/4/1974','30/07/2006','280000')
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH03','Tran Ngoc Linh','45 Nguyen Canh Chan, Q1, TPHCM','0938776266','12/6/1980','05/08/2006','3860000')
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH04','Tran Minh Long','50/34 Le Dai Hanh, Q10, TPHCM','0917325476','9/3/1965','02/10/2006','250000')
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH05','Le Nhat Minh','34 Truong Dinh, Q3, TPHCM','08246108','10/3/1950','28/10/2006','21000')
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH06','Le Hoai Thuong','227 Nguyen Van Cu, Q5, TPHCM','08631738','31/12/1981','24/11/2006','915000')
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH07','Nguyen Van Tam','32/3 Tran Binh Trong, Q5, TPHCM','0916783565','6/4/1971','01/12/2006','12500')
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH08','Phan Thi Thanh','45/2 An Duong Vuong, Q5, TPHCM','0938435756','10/1/1971','13/12/2006','365000')
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH09','Le Ha Vinh','873 Le Hong Phong, Q5, TPHCM','08654763','3/9/1979','14/01/2006','70000')
INSERT INTO KHACHHANG (MAKH,HOTEN,DCHI,SODT,NGSINH,NGDK,DOANHSO) VALUES ('KH10','Ha Duy Lap','34/34B Nguyen Trai, Q1, TPHCM','08768904','2/5/1983','16/01/2006','67500')

--NHANVIEN
INSERT INTO NHANVIEN(MANV,HOTEN,SODT,NGVL) VALUES ('NV01','Nguyen Nhu Nhut','0927345678','14/4/2006')
INSERT INTO NHANVIEN(MANV,HOTEN,SODT,NGVL) VALUES ('NV02','Le Thi Phi Yen','0987567390','21/4/2006')
INSERT INTO NHANVIEN(MANV,HOTEN,SODT,NGVL) VALUES ('NV03','Nguyen Van B','0997047382','27/4/2006')
INSERT INTO NHANVIEN(MANV,HOTEN,SODT,NGVL) VALUES ('NV04','Ngo Thanh Tuan','0913758498','24/6/2006')
INSERT INTO NHANVIEN(MANV,HOTEN,SODT,NGVL) VALUES ('NV05','Nguyen Thi Truc Thanh','0918590387','20/7/2006')

--SANPHAM
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('BC01','But Chi','cay','Singapore',3000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('BC02','But Chi','cay','Singapore',5000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('BC03','But Chi','cay','Viet Nam',3500)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('BC04','But Chi','hop','Viet Nam',30000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('BB01','But Bi','cay','Viet Nam',5000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('BB02','But Bi','cay','Trung Quoc',7000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('BB03','But Bi','hop','Thai Lan',100000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('TV01','Tap 100 giay mong','quyen','Trung Quoc',2500)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('TV02','Tap 200 giay mong','quyen','Trung Quoc',4500)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('TV03','Tap 100 giay tot','quyen','Viet Nam',3000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('TV04','Tap 200 giay tot','quyen','Viet Nam',5500)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('TV05','Tap 100 trang','chuc','Viet Nam',23000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('TV06','Tap 100 trang','chuc','Viet Nam',53000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('TV07','Tap 100 trang','chuc','Trung Quoc',34000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST01','So tay 500 trang','quyen','Trung Quoc',40000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST02','So tay loai 1','quyen','Viet Nam',55000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST03','So tay loai 2','quyen','Viet Nam',51000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST04','So tay','quyen','Viet Nam',55000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST05','So tay mong','quyen','Viet Nam',20000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST06','Phan viet bang','hop','Viet Nam',5000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST07','Phan khong bui','hop','Viet Nam',7000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST08','Bong bang','cai','Viet Nam',1000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST09','But long','cay','Viet Nam',5000)
INSERT INTO SANPHAM (MASP,TENSP,DVT,NUOCSX,GIA) VALUES ('ST10','But long','cay','Trung Quoc',7000)

--HOADON
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1001,'23/07/2006','KH01','NV01',320000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1002,'12/08/2006','KH01','NV02',840000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1003,'23/08/2006','KH02','NV01',100000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1004,'01/09/2006','KH02','NV01',180000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1005,'20/10/2006','KH01','NV02',3800000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1006,'16/10/2006','KH01','NV03',2430000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1007,'28/10/2006','KH03','NV03',510000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1008,'28/10/2006','KH01','NV03',440000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1009,'28/10/2006','KH03','NV04',200000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1010,'01/11/2006','KH01','NV01',5200000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1011,'04/11/2006','KH04','NV03',250000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1012,'20/11/2006','KH05','NV03',21000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1013,'12/12/2006','KH06','NV01',5000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1014,'31/12/2006','KH03','NV02',3150000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1015,'01/01/2007','KH06','NV01',910000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1016,'01/01/2007','KH07','NV02',12500)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1017,'02/01/2007','KH08','NV03',35000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1018,'13/01/2007','KH08','NV03',330000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1019,'13/01/2007','KH01','NV03',30000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1020,'14/01/2007','KH09','NV04',70000)
INSERT INTO HOADON (SOHD,NGHD,MAKH,MANV,TRIGIA) VALUES (1021,'16/01/2007','KH10','NV03',67500)
INSERT INTO HOADON (SOHD,NGHD,MANV,TRIGIA) VALUES (1022,'16/01/2007','NV03',7000)
INSERT INTO HOADON (SOHD,NGHD,MANV,TRIGIA) VALUES (1023,'17/01/2007','NV01',330000)

--CTHD
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1001,'TV02',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1001,'ST01',5)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1001,'BC01',5)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1001,'BC02',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1001,'ST08',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1002,'BC04',20)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1002,'BB01',20)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1002,'BB02',20)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1003,'BB03',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1004,'TV01',20)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1004,'TV02',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1004,'TV03',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1004,'TV04',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1005,'TV05',50)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1005,'TV06',50)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1006,'TV07',20)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1006,'ST01',30)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1006,'ST02',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1007,'ST03',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1008,'ST04',8)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1009,'ST05',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1010,'TV07',50)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1010,'ST07',50)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1010,'ST08',100)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1010,'ST04',50)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1010,'TV03',100)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1011,'ST06',50)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1012,'ST07',3)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1013,'ST08',5)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1014,'BC02',80)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1014,'BB02',100)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1014,'BC04',60)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1014,'BB01',50)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1015,'BB02',30)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1015,'BB03',7)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1016,'TV01',5)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1017,'TV02',1)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1017,'TV03',1)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1017,'TV04',5)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1018,'ST04',6)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1019,'ST05',1)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1019,'ST06',2)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1020,'ST07',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1021,'ST08',5)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1021,'TV01',7)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1021,'TV02',10)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1022,'ST07',1)
INSERT INTO CTHD (SOHD,MASP,SL) VALUES (1023,'ST04',6)

---------------
-- Buoi 3
-- (II.)
--2.	Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.

SELECT * INTO SANPHAM1 FROM SANPHAM
SELECT * INTO KHACHHANG1 FROM KHACHHANG

--3.	Cập nhật giá tăng 5% đối với những sản phẩm do “Thai Lan” sản xuất (cho quan hệ SANPHAM1)

UPDATE SANPHAM1 SET GIA = GIA*1.05 WHERE NUOCSX = 'Thai Lan'

--4.	Cập nhật giá giảm 5% đối với những sản phẩm do “Trung Quoc” sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1).

UPDATE SANPHAM1 SET GIA = GIA*0.95 WHERE (NUOCSX = 'Trung Quoc') AND (GIA <= 10000) 

--5.	Cập nhật giá trị LOAIKH là “Vip” đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1).

UPDATE KHACHHANG1 SET LOAIKH = 'Vip' WHERE ((NGDK < '1/1/2007') AND (DOANHSO >= 10000000)) OR ((NGDK >= '1/1/2007')  AND (DOANHSO >= 2000000)) 


-----------------
-- Buổi 4

select MASP,TENSP, NUOCSX from SANPHAM where NUOCSX='Trung Quoc'

select MASP,TENSP, NUOCSX from SANPHAM
Where NUOCSX ='Trung Quoc' and (GIA >= 2000 and GIA <= 3000)

select MASP,TENSP,NUOCSX from SANPHAM
WHERE (NUOCSX = 'Viet Nam')


SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 's%'

SELECT * FROM HOADON WHERE MAKH = NULL

SELECT MANV, HOTEN AS 'HO VA TEN'
FROM NHANVIEN

SELECT * FROM SANPHAM ORDER BY NUOCSX DESC, GIA ASC

--III. Ngôn ngữ truy vấn dữ liệu có cấu trúc:
--1.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT MASP, TENSP, NUOCSX
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
--2.	In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP, TENSP, DVT
FROM SANPHAM
WHERE DVT ='cay' or DVT ='Quyen'
--3.	In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%01'
--4.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP, GIA, NUOCSX
FROM SANPHAM
WHERE GIA >= 30000 AND GIA<=40000
--5.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP, GIA, NUOCSX
FROM SANPHAM
WHERE GIA >= 30000 AND GIA<=40000 AND (NUOCSX='TRUNG QUOC' OR NUOCSX='THAI LAN')
--6.	In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD, TRIGIA, NGHD
FROM HOADON
WHERE NGHD = '1/1/2007' OR NGHD = '2/1/2007'
--7.	In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD, NGHD, TRIGIA
FROM HOADON
WHERE MONTH(NGHD) = 1 AND YEAR(NGHD) = 2007 ORDER BY NGHD ASC, TRIGIA DESC
----8.	In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
--SELECT MAKH, HOTEN
--FROM KHACHHANG
--WHERE 
--9.	In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SELECT SOHD, TRIGIA
FROM HOADON
WHERE NGHD = '28/10/2006'
AND MANV = (
SELECT MANV
FROM NHANVIEN
WHERE HOTEN = 'Nguyen Van B')
--10.	In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
-- Đã làm phía dưới
--11.	Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT SOHD, MASP
FROM CTHD
WHERE MASP IN ('BB01', 'BB02')
--12.	Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD, MASP, SL
FROM CTHD
WHERE MASP IN ('BB01', 'BB02') AND SL BETWEEN 10 AND 20 /*(SL>=10 AND SL <=20)*/

------------ Buổi 5 

select KHACHHANG.MAKH,HOTEN, NGHD
from KHACHHANG inner join HOADON 
on KHACHHANG.MAKH=HOADON.MAKH
where nghd='1/1/2007'

Select sohd, hoten
From HOADON left join KHACHHANG 
on HOADON.makh=KHACHHANG.makh

SELECT COUNT(MAKH)
FROM HOADON

Select sohd, hoten
From HOADON ,KHACHHANG
where HOADON.makh = KHACHHANG.makh

-- QLBH phần III câu 8,9,10, 19 tới 25, 31 tới 38
--1.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất.
SELECT MASP, TENSP, NUOCSX
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC'
--2.	In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là “cay”, ”quyen”.
SELECT MASP, TENSP, DVT
FROM SANPHAM
WHERE DVT = 'CAY' OR DVT ='QUYEN'
--3.	In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là “B” và kết thúc là “01”.
SELECT MASP,TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%01'
--4.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quốc” sản xuất có giá từ 30.000 đến 40.000.
--5.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” hoặc “Thai Lan” sản xuất có giá từ 30.000 đến 40.000.
--6.	In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
--7.	In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
--8.	In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT KH.MAKH, HOTEN, NGHD
FROM HOADON HD JOIN KHACHHANG KH
ON KH.MAKH = HD.MAKH
WHERE NGHD ='1/1/2007'
--9.	In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên “Nguyen Van B” lập trong ngày 28/10/2006.
SELECT SOHD, TRIGIA, HOTEN, NGHD
FROM HOADON HD JOIN NHANVIEN NV
ON HD.MANV = NV.MANV
WHERE HOTEN = 'Nguyen Van B' AND NGHD ='28/10/2006'
--10.	In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên “Nguyen Van A” mua trong tháng 10/2006.
SELECT SP.MASP, TENSP, HOTEN, NGHD
FROM (KHACHHANG KH JOIN HOADON HD ON KH.MAKH = HD.MAKH) JOIN (SANPHAM SP JOIN CTHD ON SP.MASP = CTHD.MASP)
ON HD.SOHD = CTHD.SOHD
WHERE HOTEN = 'Nguyen Van A' AND MONTH(NGHD) = 10 AND YEAR(NGHD) =2006
--11.	Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”.
SELECT SOHD, MASP, SL
FROM CTHD
WHERE MASP = 'BB01' OR MASP = 'BB02'
--12.	Tìm các số hóa đơn đã mua sản phẩm có mã số “BB01” hoặc “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD, MASP, SL
FROM CTHD
WHERE (MASP = 'BB01' OR MASP = 'BB02') AND (SL BETWEEN 10 AND 20)
--13.	Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số “BB01” và “BB02”, mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD, SL
FROM CTHD
WHERE MASP = 'BB01' AND (SL BETWEEN 10 AND 20)
INTERSECT
SELECT SOHD, SL
FROM CTHD
WHERE MASP = 'BB02' AND (SL BETWEEN 10 AND 20)
--------Không thể select masp ở bài tập trên vì sẽ xung đột điều kiện hai vế: mã hóa đơn không thể cùng là bb01 và bb02.------
--14.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT MASP, TENSP, NUOCSX
FROM SANPHAM 
WHERE NUOCSX = 'TRUNG QUOC'
UNION
SELECT SP.MASP, TENSP, NUOCSX
FROM SANPHAM SP JOIN CTHD CT ON SP.MASP = CT.MASP JOIN HOADON HD
ON HD.SOHD = CT.SOHD
WHERE NGHD = '1/1/2007'
--GROUP BY SP.MASP, TENSP
--15.	In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT MASP, TENSP
FROM SANPHAM 
WHERE MASP NOT IN (SELECT MASP FROM CTHD)
--16.	In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM 
WHERE MASP NOT IN ( 
SELECT SP.MASP
FROM SANPHAM SP JOIN CTHD CT ON SP.MASP = CT.MASP JOIN HOADON HD
ON HD.SOHD = CT.SOHD
WHERE YEAR(NGHD) = 2006)
--17.	In ra danh sách các sản phẩm (MASP,TENSP) do “Trung Quoc” sản xuất không bán được trong năm 2006.
SELECT MASP, TENSP, NUOCSX
FROM SANPHAM 
WHERE NUOCSX ='TRUNG QUOC' AND MASP NOT IN ( 
SELECT SP.MASP
FROM SANPHAM SP JOIN CTHD CT ON SP.MASP = CT.MASP JOIN HOADON HD
ON HD.SOHD = CT.SOHD
WHERE YEAR(NGHD) = 2006)
--18.	Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.

SELECT *
FROM HOADON
WHERE NOT EXISTS (-- Sản phẩm từ Singapore mà hóa đơn không mua:
		SELECT MASP
		FROM SANPHAM
		WHERE NUOCSX ='SINGAPORE' AND MASP NOT IN ( -- Sản phẩm từ Singapore mà hóa đơn đã mua
					SELECT CTHD.MASP 
					FROM SANPHAM JOIN CTHD ON SANPHAM.MASP = CTHD.MASP
					WHERE NUOCSX ='SINGAPORE' AND CTHD.SOHD = HOADON.SOHD))
--19.	Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(SOHD)SOHOADON
FROM HOADON
WHERE MAKH IS NULL
--20.	Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT (DISTINCT MASP) [SO SAN PHAM]
FROM HOADON HD JOIN CTHD ON HD.SOHD = CTHD.SOHD
WHERE YEAR(NGHD) = 2006
--21.	Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(TRIGIA) MAX_GIA, MIN(TRIGIA) MIN_GIA
FROM HOADON
--22.	Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) AVG_TRIGIA
FROM HOADON
WHERE YEAR(NGHD) = 2006
--23.	Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA) SUM_TRIGIA
FROM HOADON
WHERE YEAR(NGHD) = 2006
--24.	Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT SOHD
FROM HOADON
WHERE YEAR(NGHD) = 2006 AND TRIGIA = (SELECT MAX(TRIGIA) FROM HOADON)

SELECT TOP 1 WITH TIES SOHD
FROM HOADON
WHERE YEAR(NGHD) = 2006 
ORDER BY TRIGIA DESC
--25.	Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT HOTEN, TRIGIA, NGHD
FROM HOADON HD JOIN KHACHHANG KH 
ON HD.MAKH = KH.MAKH
WHERE YEAR(NGHD) = 2006 AND TRIGIA = (SELECT MAX(TRIGIA) FROM HOADON)
--26.	In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 WITH TIES MAKH, HOTEN, DOANHSO
FROM KHACHHANG  
ORDER BY DOANHSO DESC
--27.	In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE GIA IN(
SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)
--28.	In ra danh sách các sản phẩm (MASP, TENSP) do “Thai Lan” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE NUOCSX= 'THAI LAN'AND GIA IN(
SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)

SELECT DISTINCT TOP 3 WITH TIES MASP, TENSP, GIA
FROM SANPHAM
WHERE NUOCSX= 'THAI LAN'
ORDER BY GIA DESC


SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE GIA IN(
SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)

SELECT TOP 3 WITH TIES MASP, TENSP, GIA
FROM SANPHAM
ORDER BY GIA DESC

--29.	In ra danh sách các sản phẩm (MASP, TENSP) do “Trung Quoc” sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do “Trung Quoc” sản xuất).
SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE NUOCSX= 'TRUNG QUOC'AND GIA IN(
SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
WHERE NUOCSX ='TRUNG QUOC'
ORDER BY GIA DESC)

--30.	* In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).

SELECT TOP 3 RANK() OVER (order by kh.DOANHSO DESC), HOTEN
FROM KHACHHANG kh

--31.	Tính tổng số sản phẩm do “Trung Quoc” sản xuất.
SELECT COUNT(MASP) [SAN PHAM TRUNG QUOC]
FROM SANPHAM
WHERE NUOCSX = 'TRUNG QUOC'
--32.	Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX, COUNT(MASP) COUNT_SP
FROM SANPHAM
GROUP BY NUOCSX
--33.	Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NUOCSX, TENSP, MAX(GIA) MAX_GIA, MIN(GIA) MIN_GIA, AVG(GIA) AVG_GIA
FROM SANPHAM 
GROUP BY NUOCSX, TENSP
--34.	Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD NGAY, SUM(TRIGIA) [DOANH THU]
FROM HOADON
GROUP BY NGHD
--35.	Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT SP.MASP, TENSP, SUM(SL) [TONGSOLUONG]
FROM (CTHD JOIN HOADON HD ON CTHD.SOHD = HD.SOHD) JOIN SANPHAM SP
ON CTHD.MASP = SP.MASP
WHERE YEAR(NGHD) = 2006 AND MONTH(NGHD) = 10
GROUP BY SP.MASP, TENSP
--36.	Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD) THANG, SUM(TRIGIA) [DOANH THU]
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
--37.	Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT SOHD, COUNT(DISTINCT MASP) [SO SAN PHAM]
FROM CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) >= 4
--38.	Tìm hóa đơn có mua 3 sản phẩm do “Viet Nam” sản xuất (3 sản phẩm khác nhau).
SELECT SOHD, COUNT(DISTINCT CT.MASP) [SO SAN PHAM]
FROM CTHD CT JOIN SANPHAM SP
ON CT.MASP = SP.MASP
WHERE NUOCSX = 'Viet Nam'
GROUP BY SOHD
HAVING COUNT(DISTINCT CT.MASP) >= 3

-- Buổi 12 

select distinct sohd 
from CTHD where masp='BB01' and sohd IN
(select sohd from CTHD where masp='BB02')

select distinct sohd 
from CTHD where masp='BB01' and sohd NOT IN
(select sohd from CTHD where masp='BB02')

SELECT sohd
FROM cthd
WHERE masp='BB01'
INTERSECT
SELECT sohd
FROM cthd
WHERE masp='BB02'

SELECT sohd
FROM cthd
WHERE masp='BB02'
EXCEPT
SELECT sohd
FROM cthd
WHERE masp='BB01'

--39.	Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất. 
SELECT MAKH, HOTEN
FROM KHACHHANG
WHERE MAKH= 
(
SELECT TOP 1 MAKH
FROM HOADON
GROUP BY MAKH
ORDER BY COUNT(DISTINCT SOHD) DESC)

SELECT TOP 1 WITH TIES H.MAKH, HOTEN
FROM KHACHHANG K, HOADON H
WHERE K.MAKH = H.MAKH
GROUP BY H.MAKH, HOTEN
ORDER BY COUNT(DISTINCT SOHD) DESC
--40.	Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT MONTH(NGHD) THANG, SUM(TRIGIA) 
DOANHSO
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
ORDER BY DOANHSO DESC
--41.	Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
--Cách 0
SELECT TOP 1 WITH TIES MASP
FROM CTHD
WHERE SOHD IN (SELECT SOHD FROM HOADON WHERE YEAR(NGHD) = 2006)
GROUP BY MASP
ORDER BY SUM(SL) ASC
--Cach 1
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP = (
SELECT TOP 1 MASP
FROM CTHD
WHERE SOHD IN (SELECT SOHD FROM HOADON WHERE YEAR(NGHD) = 2006)
GROUP BY MASP
ORDER BY SUM(SL) ASC)

--Cach 2
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP = (
SELECT TOP 1 MASP
FROM CTHD CT JOIN HOADON HD
ON CT.SOHD = HD.SOHD
WHERE YEAR(NGHD) = 2006
GROUP BY MASP
ORDER BY SUM(SL) ASC)
--42.	Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT NUOCSX, COUNT (DISTINCT GIA) SOSANPHAM
FROM SANPHAM
GROUP BY NUOCSX
HAVING COUNT (DISTINCT GIA) >= 3
ORDER BY COUNT (DISTINCT GIA) DESC
--43.	*Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
-- cách 1 
SELECT MASP, TENSP, B.NUOCSX
FROM 
(SELECT MAX(GIA) GIACAONHAT, NUOCSX
FROM SANPHAM
GROUP BY NUOCSX) AS B JOIN SANPHAM SP
ON B.GIACAONHAT = SP.GIA AND B.NUOCSX = SP.NUOCSX
WHERE B.NUOCSX = SP.NUOCSX

--cách 1

SELECT MASP, TENSP, B.NUOCSX
FROM 
(SELECT MAX(GIA) GIACAONHAT, NUOCSX
FROM SANPHAM
GROUP BY NUOCSX) AS B JOIN SANPHAM SP
ON B.NUOCSX = SP.NUOCSX
WHERE B.GIACAONHAT = SP.GIA
--- Cách 2
SELECT sp1.NUOCSX, sp1.MASP, sp1.TENSP
FROM SANPHAM sp1
WHERE sp1.GIA in
(
    SELECT max(sp.GIA)
    FROM SANPHAM sp
    WHERE sp1.NUOCSX = sp.NUOCSX
)
--- Cách 3 cô chỉ
SELECT MASP, TENSP, GIA, NUOCSX FROM SANPHAM SP1 WHERE GIA =
(SELECT MAX(GIA) FROM SANPHAM SP2 WHERE SP1.NUOCSX = SP2.NUOCSX GROUP BY NUOCSX) 

SELECT *
FROM SANPHAM

SELECT sp1.NUOCSX, sp1.MASP, sp1.TENSP
FROM SANPHAM sp1
WHERE sp1.GIA in
(
    SELECT MAX(GIA)	
    FROM SANPHAM sp
    WHERE sp1.NUOCSX = sp.NUOCSX
)

SELECT MAX(SP1.GIA)
FROM SANPHAM SP1, SANPHAM SP2
WHERE SP1.NUOCSX = SP2.NUOCSX
GROUP BY SP1.NUOCSX

SELECT *
FROM SANPHAM


sp1.GIA in
(
    SELECT MAX(GIA)	
    FROM SANPHAM sp
    WHERE sp1.NUOCSX = sp.NUOCSX
)

SELECT MAX(GIA) FROM SANPHAM  GROUP BY NUOCSX


-- làm lại
--1.	In ra danh sách các sản phẩm (MASP,TENSP) do 'Trung Quoc' sản xuất.
SELECT MASP,TENSP, NUOCSX
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
--2.	In ra danh sách các sản phẩm (MASP, TENSP) có đơn vị tính là 'cay', 'quyen'.
SELECT MASP, TENSP, DVT
FROM SANPHAM
WHERE DVT IN ('cay', 'quyen')
--3.	In ra danh sách các sản phẩm (MASP,TENSP) có mã sản phẩm bắt đầu là 'B' và kết thúc là '01'.
SELECT MASP,TENSP
FROM SANPHAM
WHERE MASP LIKE 'B%01'
--4.	In ra danh sách các sản phẩm (MASP,TENSP) do 'Trung Quoc' sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP, GIA, NUOCSX
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND GIA BETWEEN 30000 AND 40000
--5.	In ra danh sách các sản phẩm (MASP,TENSP) do 'Trung Quoc' hoặc 'Thai Lan' sản xuất có giá từ 30.000 đến 40.000.
SELECT MASP, TENSP, GIA, NUOCSX
FROM SANPHAM
WHERE NUOCSX IN ('Trung Quoc','Thai Lan') AND GIA BETWEEN 30000 AND 40000
--6.	In ra các số hóa đơn, trị giá hóa đơn bán ra trong ngày 1/1/2007 và ngày 2/1/2007.
SELECT SOHD, TRIGIA, NGHD
FROM HOADON
WHERE NGHD IN ('1/1/2007', '2/1/2007')
--7.	In ra các số hóa đơn, trị giá hóa đơn trong tháng 1/2007, sắp xếp theo ngày (tăng dần) và trị giá của hóa đơn (giảm dần).
SELECT SOHD, TRIGIA, NGHD
FROM HOADON
WHERE MONTH(NGHD) = 1 AND YEAR(NGHD)= 2007 
ORDER BY NGHD ASC, TRIGIA DESC
--8.	In ra danh sách các khách hàng (MAKH, HOTEN) đã mua hàng trong ngày 1/1/2007.
SELECT K.MAKH, HOTEN
FROM KHACHHANG K, HOADON H
WHERE K.MAKH = H.MAKH AND NGHD = '1/1/2007'
--9.	In ra số hóa đơn, trị giá các hóa đơn do nhân viên có tên 'Nguyen Van B' lập trong ngày 28/10/2006.
SELECT SOHD, TRIGIA
FROM NHANVIEN N, HOADON H
WHERE N.MANV = H.MANV AND HOTEN = 'Nguyen Van B' AND NGHD = '28/10/2006'
--10.	In ra danh sách các sản phẩm (MASP,TENSP) được khách hàng có tên 'Nguyen Van A' mua trong tháng 10/2006.
SELECT S.MASP,TENSP, NGHD, K.HOTEN 'HO TEN KHACH HANG'
FROM SANPHAM S, CTHD C, HOADON H, KHACHHANG K
WHERE S.MASP = C.MASP AND C.SOHD = H.SOHD AND H.MAKH = K.MAKH
AND K.HOTEN = 'Nguyen Van A' AND YEAR(NGHD)= 2006 AND MONTH(NGHD) = 10
--11.	Tìm các số hóa đơn đã mua sản phẩm có mã số 'BB01' hoặc 'BB02'.
SELECT SOHD, MASP	
FROM CTHD
WHERE MASP IN ('BB01' , 'BB02')
--12.	Tìm các số hóa đơn đã mua sản phẩm có mã số 'BB01' hoặc 'BB02', mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD, MASP	
FROM CTHD
WHERE MASP IN ('BB01' , 'BB02') AND SL BETWEEN 10 AND 20
--13.	Tìm các số hóa đơn mua cùng lúc 2 sản phẩm có mã số 'BB01' và 'BB02', mỗi sản phẩm mua với số lượng từ 10 đến 20.
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB01' AND SL BETWEEN 10 AND 20
INTERSECT
SELECT SOHD
FROM CTHD
WHERE MASP = 'BB02' AND SL BETWEEN 10 AND 20
--14.	In ra danh sách các sản phẩm (MASP,TENSP) do 'Trung Quoc' sản xuất hoặc các sản phẩm được bán ra trong ngày 1/1/2007.
SELECT DISTINCT S.MASP, TENSP
FROM SANPHAM S, CTHD C, HOADON H
WHERE S.MASP = C.MASP AND C.SOHD = H.SOHD
AND NGHD = '1/1/2007' OR NUOCSX = 'Trung Quoc'
--15.	In ra danh sách các sản phẩm (MASP,TENSP) không bán được.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP NOT IN(
SELECT MASP
FROM CTHD)
--16.	In ra danh sách các sản phẩm (MASP,TENSP) không bán được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE MASP NOT IN(
SELECT MASP
FROM HOADON H, CTHD C
WHERE H.SOHD = C.SOHD AND YEAR(NGHD)=2006)
--17.	In ra danh sách các sản phẩm (MASP,TENSP) do 'Trung Quoc' sản xuất không bán được trong năm 2006.
SELECT MASP, TENSP
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND MASP NOT IN(
SELECT MASP
FROM HOADON H, CTHD C
WHERE H.SOHD = C.SOHD AND YEAR(NGHD)=2006)
--18.	Tìm số hóa đơn đã mua tất cả các sản phẩm do Singapore sản xuất.
--19.	Có bao nhiêu hóa đơn không phải của khách hàng đăng ký thành viên mua?
SELECT COUNT(SOHD) 'SO HOA DON'
FROM HOADON
WHERE MAKH IS NOT NULL
--20.	Có bao nhiêu sản phẩm khác nhau được bán ra trong năm 2006.
SELECT COUNT(DISTINCT MASP)
FROM HOADON H, CTHD C
WHERE H.SOHD = C.SOHD AND YEAR(NGHD)=2006
--21.	Cho biết trị giá hóa đơn cao nhất, thấp nhất là bao nhiêu ?
SELECT MAX(TRIGIA) 'GIA LON NHAT', MIN(TRIGIA) 'GIA NHO NHAT'
FROM HOADON
--22.	Trị giá trung bình của tất cả các hóa đơn được bán ra trong năm 2006 là bao nhiêu?
SELECT AVG(TRIGIA) 'TRI GIA TRUNG BINH'
FROM HOADON
--23.	Tính doanh thu bán hàng trong năm 2006.
SELECT SUM(TRIGIA) 'DOANH THU 2006'
FROM HOADON
WHERE YEAR(NGHD) = 2006
--24.	Tìm số hóa đơn có trị giá cao nhất trong năm 2006.
SELECT TOP 1 WITH TIES SOHD, TRIGIA
FROM HOADON
WHERE YEAR(NGHD) = 2006
ORDER BY TRIGIA DESC
--25.	Tìm họ tên khách hàng đã mua hóa đơn có trị giá cao nhất trong năm 2006.
SELECT TOP 1 WITH TIES HOTEN, TRIGIA
FROM KHACHHANG K, HOADON H
WHERE K.MAKH = H.MAKH AND YEAR(NGHD) = 2006
ORDER BY TRIGIA DESC
--26.	In ra danh sách 3 khách hàng (MAKH, HOTEN) có doanh số cao nhất.
SELECT TOP 3 MAKH, HOTEN, DOANHSO
FROM KHACHHANG
ORDER BY DOANHSO DESC
--27.	In ra danh sách các sản phẩm (MASP, TENSP) có giá bán bằng 1 trong 3 mức giá cao nhất.
SELECT MASP, TENSP, GIA
FROM SANPHAM
WHERE GIA IN(
SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)
--28.	In ra danh sách các sản phẩm (MASP, TENSP) do 'Thai Lan' sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của tất cả các sản phẩm).
SELECT MASP, TENSP, NUOCSX, GIA
FROM SANPHAM
WHERE NUOCSX = 'Thai Lan' AND  GIA IN(
SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
ORDER BY GIA DESC)
--29.	In ra danh sách các sản phẩm (MASP, TENSP) do 'Trung Quoc' sản xuất có giá bằng 1 trong 3 mức giá cao nhất (của sản phẩm do 'Trung Quoc' sản xuất).
SELECT MASP, TENSP, NUOCSX, GIA
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc' AND GIA IN(
SELECT DISTINCT TOP 3 GIA
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
ORDER BY GIA DESC)
--30.	* In ra danh sách 3 khách hàng có doanh số cao nhất (sắp xếp theo kiểu xếp hạng).
SELECT TOP 3 RANK() OVER (ORDER BY K.DOANHSO DESC) 'XEP HANG', MAKH, HOTEN
FROM KHACHHANG K
--31.	Tính tổng số sản phẩm do 'Trung Quoc' sản xuất.
SELECT COUNT(MASP)
FROM SANPHAM
WHERE NUOCSX = 'Trung Quoc'
--32.	Tính tổng số sản phẩm của từng nước sản xuất.
SELECT NUOCSX, COUNT(MASP)
FROM SANPHAM
GROUP BY NUOCSX
--33.	Với từng nước sản xuất, tìm giá bán cao nhất, thấp nhất, trung bình của các sản phẩm.
SELECT NUOCSX, MAX(GIA) MAX_GIA, MIN(GIA) MIN_GIA, AVG(GIA) 'GIA TRUNG BINH'
FROM SANPHAM
GROUP BY NUOCSX
--34.	Tính doanh thu bán hàng mỗi ngày.
SELECT NGHD, SUM(TRIGIA) DOANHTHU
FROM HOADON
GROUP BY NGHD
--35.	Tính tổng số lượng của từng sản phẩm bán ra trong tháng 10/2006.
SELECT MASP, SUM(SL) 'TONG SO LUONG'
FROM HOADON H, CTHD C
WHERE H.SOHD = C.SOHD AND YEAR(NGHD) = 2006 AND MONTH(NGHD) = 10
GROUP BY MASP
--36.	Tính doanh thu bán hàng của từng tháng trong năm 2006.
SELECT MONTH(NGHD) THANG, SUM(TRIGIA)
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY MONTH(NGHD)
--37.	Tìm hóa đơn có mua ít nhất 4 sản phẩm khác nhau.
SELECT SOHD, COUNT(DISTINCT MASP) 'SO SAN PHAM KHAC NHAU'
FROM CTHD
GROUP BY SOHD
HAVING COUNT(DISTINCT MASP) >= 4
--38.	Tìm hóa đơn có mua 3 sản phẩm do 'Viet Nam' sản xuất (3 sản phẩm khác nhau).
SELECT SOHD, NUOCSX, COUNT(DISTINCT C.MASP)
FROM CTHD C, SANPHAM S
WHERE C.MASP = S.MASP AND NUOCSX = 'Viet Nam'
GROUP BY SOHD, NUOCSX
HAVING COUNT(DISTINCT C.MASP) = 2 
--39.	Tìm khách hàng (MAKH, HOTEN) có số lần mua hàng nhiều nhất. 
SELECT TOP 1 WITH TIES K.MAKH, HOTEN, COUNT(SOHD) 'SO LAN MUA HANG'
FROM HOADON H, KHACHHANG K
WHERE H.MAKH = K.MAKH
GROUP BY K.MAKH, HOTEN
ORDER BY COUNT(SOHD) DESC





--40.	Tháng mấy trong năm 2006, doanh số bán hàng cao nhất ?
SELECT TOP 1 WITH TIES MONTH(NGHD) THANG , SUM(TRIGIA) DOANHSO
FROM HOADON
WHERE YEAR(NGHD) = 2006
GROUP BY YEAR(NGHD), MONTH(NGHD)
ORDER BY SUM(TRIGIA) DESC
--41.	Tìm sản phẩm (MASP, TENSP) có tổng số lượng bán ra thấp nhất trong năm 2006.
SELECT TOP 1 WITH TIES C.MASP, TENSP, SUM(SL) 'TONG SO LUONG'
FROM CTHD C, SANPHAM S, HOADON H
WHERE C.MASP = S.MASP AND C.SOHD = H.SOHD AND YEAR(NGHD) = 2006
GROUP BY C.MASP, TENSP 
ORDER BY SUM(SL) ASC
--42.	Tìm nước sản xuất sản xuất ít nhất 3 sản phẩm có giá bán khác nhau.
SELECT NUOCSX, COUNT(DISTINCT GIA) 'SO SAN PHAM'
FROM SANPHAM
GROUP BY NUOCSX
HAVING COUNT(DISTINCT GIA) >= 3
--43.	*Mỗi nước sản xuất, tìm sản phẩm (MASP,TENSP) có giá bán cao nhất.
SELECT MASP, TENSP, GIA, NUOCSX
FROM SANPHAM A
WHERE GIA = (
SELECT MAX(GIA) 
FROM SANPHAM B
WHERE B.NUOCSX = A.NUOCSX
GROUP BY NUOCSX
)


--I. Ngôn ngữ định nghĩa dữ liệu (Data Definition Language):
--1.	Tạo các quan hệ và khai báo các khóa chính, khóa ngoại của quan hệ.
--2.	Thêm vào thuộc tính GHICHU có kiểu dữ liệu varchar(20) cho quan hệ SANPHAM.
--3.	Thêm vào thuộc tính LOAIKH có kiểu dữ liệu là tinyint cho quan hệ KHACHHANG.
--4.	Sửa kiểu dữ liệu của thuộc tính GHICHU trong quan hệ SANPHAM thành varchar(100).
--5.	Xóa thuộc tính GHICHU trong quan hệ SANPHAM.
--6.	Làm thế nào để thuộc tính LOAIKH trong quan hệ KHACHHANG có thể lưu các giá trị là: 'Vang lai', 'Thuong xuyen', 'Vip', …
--7.	Đơn vị tính của sản phẩm chỉ có thể là ('cay','hop','cai','quyen','chuc')
--8.	Giá bán của sản phẩm từ 500 đồng trở lên.
--9.	Mỗi lần mua hàng, khách hàng phải mua ít nhất 1 sản phẩm.
--10.	Ngày khách hàng đăng ký là khách hàng thành viên phải lớn hơn ngày sinh của người đó.
--11.	Ngày mua hàng (NGHD) của một khách hàng thành viên sẽ lớn hơn hoặc bằng ngày khách hàng đó đăng ký thành viên (NGDK).
--12.	Ngày bán hàng (NGHD) của một nhân viên phải lớn hơn hoặc bằng ngày nhân viên đó vào làm.
--13.	Mỗi một hóa đơn phải có ít nhất một chi tiết hóa đơn.
--14.	Trị giá của một hóa đơn là tổng thành tiền (số lượng*đơn giá) của các chi tiết thuộc hóa đơn đó.
--15.	Doanh số của một khách hàng là tổng trị giá các hóa đơn mà khách hàng thành viên đó đã mua.

--II. Ngôn ngữ thao tác dữ liệu (Data Manipulation Language):
--1.	Nhập dữ liệu cho các quan hệ trên.
--2.	Tạo quan hệ SANPHAM1 chứa toàn bộ dữ liệu của quan hệ SANPHAM. Tạo quan hệ KHACHHANG1 chứa toàn bộ dữ liệu của quan hệ KHACHHANG.
--3.	Cập nhật giá tăng 5% đối với những sản phẩm do 'Thai Lan' sản xuất (cho quan hệ SANPHAM1)
--4.	Cập nhật giá giảm 5% đối với những sản phẩm do 'Trung Quoc' sản xuất có giá từ 10.000 trở xuống (cho quan hệ SANPHAM1).
--5.	Cập nhật giá trị LOAIKH là 'Vip' đối với những khách hàng đăng ký thành viên trước ngày 1/1/2007 có doanh số từ 10.000.000 trở lên hoặc khách hàng đăng ký thành viên từ 1/1/2007 trở về sau có doanh số từ 2.000.000 trở lên (cho quan hệ KHACHHANG1).
