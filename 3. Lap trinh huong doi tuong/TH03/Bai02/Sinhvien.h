#pragma once
#include"Nguoi.h"
#include"Hocsinh.h"
class Sinhvien :public Hocsinh
{
protected:
	int Nambatdauhoc;
	int MSSV;
	string Hedaotao;
	string Nganhdaotao;
public:
	void Nhap();
	void Xuat();
};

